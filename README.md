# Terraform
A new Terraform Repo

 
 
# Azure Infrastuction creating tool





## Usage


Clone the repository to your local machine or environment:


git clone https://github.com/bubblize/Terraform.git

you need to make a new file called terraform.tfvars and past in your public key.

you can generate a ssl key with this command:
ssh-keygen -t rsa -b 4096 -f
 make sure your in the folder where you can create the file.

 then copy the public key like this formate: 

 ssh_public_key = "Public Key"

 store then it in the file called terraform.tfvars
 

 then you type the command.



terraform plan -out=tfplan
terraform apply "tfplan"

you should then have a working Azure Infrastuction with 2 VM sql and a web page running flask with a loadbalancer. 











<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="terraform.tfvars file"></a> 

- <a name="public ssl key"></a> 





<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
