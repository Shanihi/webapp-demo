# Automate deployments of Azure resources with GitHub reusable workflows, Bicep and Azure Container Registry
This project is a Proof of Concept made by Shan Hu as a final thesis graduation product for the Amsterdam University of Applied Sciences. This product contains 
reusable Bicep templates for the deployment of Azure resources. The Azure resources included are:

* Web App 
* App Service Plan
* SQL Database and server

The deployment of these Azure resources is automated through GitHub reusable workflows. There are GitHub reusable workflows created for the deployment of the Azure resource and
for the publishment of Bicep templates to the Azure Container Registry. 

## Setup
First you need to fork the project to your own repository. After forking, you need to create two items yourself in the Azure portal. 

### Azure Container Registry
First an Azure Container Registry needs to be created in the Azure portal. If you already have an ACR, you can use that one. Make sure to change the registry path in the bicepconfig.json file
to the path of your ACR. 

### Azure Key Vault
Secondly we need an Azure Key Vault to store sensistive data such as the password of the administrator login password of the database server. Make sure to change the parameters in
the parameters.dev.json to the name of your Key Vault and resourcegroup. 

## Parameters
After creating the two items yourself, it's important to change the parameters in the parameters.dev.json file to your own preference. If you don't
want to create certain Azure resources, you can change the module parameters in the main.bicep to existing instead of new. Because of the conditional deploymeny, certain resources will
not be deployed if you pass the 'existing' parameter. In the workflows you need to change the parameters that are used, suchh as the resource group name. 

## Secrets
To store the secrets, we need to create a Role Based Access Control (RBAC). With the following command you can create a RBAC:
```
az ad sp create-for-rbac --name "{Example name}" --role contributor  --scopes /subscriptions/{Azure subscription}/resourceGroups/{Name resource group}  --sdk-auth
```
There will be a JSON output shown that you need to copy. In the GitHub portal you need to go to Settings -> Secret and variables -> Actions and store the JSON output in a variable. 
An example name would be AZURE_CREDENTIALS_CLIENT which you will use in your GitHub workflow YML files. Make sure the parameter matches with the given one in your GIthub account, otherwise you will not
be able to authenticate. 

## First run
There are two reusable GitHub workflows created, one for deployment and one for publishing the Bicep templates to the ACR. In the first run, the deployment workflow will fail because the ACR is still empty.
You can disable this specific workflow in GitHub and first run the publishing workflow to publish the Bicep templates to the ACR. After the templates are stored in the ACR, we can start the deployment workflow. 

