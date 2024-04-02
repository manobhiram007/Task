**<h1>CI/CD Pipelines for Infrastructure Provisioning with Terraform</h1>**
**<h3>Objective:</h3>**
The objective of this project is to set up Continuous Integration (CI) and Continuous Deployment (CD) pipelines using Azure Pipelines for provisioning infrastructure across multiple environments (Dev, QA, Preprod, and Prod) using Terraform. The infrastructure includes Virtual Machines (VMs), Key Vault, and Storage Accounts.

**<h3>FILES:</h3>**
**<h5>env.tf:</h5>**
Defines the Terraform modules for provisioning infrastructure across different environments.
**<h5>main.tf:</h5>** 
Defines the Azure resources (Resource Group, Virtual Network, Subnet, Network Interface, Virtual Machine, Key Vault, Storage Account) using Terraform.
**<h5>variables.tf:</h5>** 
Defines variables used in the Terraform configuration for customization of resource names, locations, sizes, etc.
**<h5>azure-pipeline.yml:</h5>** 
Azure Pipelines YAML file for setting up CI/CD pipelines to deploy infrastructure changes automatically.
**<h3>TERRAFORM CONFIGURATION:</h3>**
The Terraform configuration (env.tf, main.tf, variables.tf) defines the infrastructure resources to be provisioned across the different environments. It includes modules for creating Virtual Machines, Virtual Networks, Subnets, Network Interfaces, Key Vaults, and Storage Accounts. Customize the variables in variables.tf according to your requirements.

**<h3>CI/CD PIPELINE:</h3>**
The pipeline.yml file contains the Azure Pipelines YAML configuration for setting up CI/CD pipelines. It defines a pipeline trigger on the main branch and specifies stages for deploying infrastructure changes to the Dev, QA, Preprod, and Prod environments using Terraform.

**<h3>Getting Started:</h3>**
To get started with deploying the infrastructure using Terraform and Azure Pipelines:

Ensure you have access to an Azure DevOps organization and have configured Azure service principals for authentication.
Update the variables in variables.tf with the desired values for your environment.
Configure the Azure Pipelines YAML file (pipeline.yml) with the necessary variables for authentication and environment-specific settings.
Commit and push your changes to the repository to trigger the CI/CD pipeline.
**<h3>DEPENDENCIES:</h3>**
Azure DevOps organization with permissions to create and manage pipelines.
Azure service principal with appropriate permissions for provisioning Azure resources.
Terraform installed on the build agent for executing Terraform commands.
FEEDBACK:
Feedback and contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.

**<h2>Results:</h2>**
![Example Image](Deployed.png)
![Example Image](dev.png)
![Example Image](prod.png)
![Example Image](qa.png)
![Example Image](staging.png)

