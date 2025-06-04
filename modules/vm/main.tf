terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Linux Virtual Machine 1 - MySQL DB
resource "azurerm_linux_virtual_machine" "sql_vm_1" {
  name                = "sql-vm-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface_ids = [var.nic_ids[0]]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOT
#!/bin/bash
sudo apt update
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql
EOT
  )
}

# Linux Virtual Machine 2 - MySQL DB
resource "azurerm_linux_virtual_machine" "sql_vm_2" {
  name                = "sql-vm-2"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface_ids = [var.nic_ids[1]]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOT
#!/bin/bash
sudo apt update
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql
EOT
  )
}

# Linux Virtual Machine 3 - Python web app
resource "azurerm_linux_virtual_machine" "web_vm_1" {
  name                = "web-vm-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface_ids = [var.nic_ids[2]]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOT
#!/bin/bash
# Update and install dependencies
sudo apt update
sudo apt install -y python3 python3-pip

# Install Flask
pip3 install flask

# Create a simple Flask application
cat <<EOF > /home/azureuser/app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
  return "Hello, Azure! This is a Python web application."

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=80)
EOF

# Run the Flask application
nohup python3 /home/azureuser/app.py &
EOT
  )
}
