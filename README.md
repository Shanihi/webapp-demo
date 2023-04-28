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
First an Azure Container Registry needs to be created in the Azure portal. If you already have an ACR, you can use that one. Make sure to change the registry path in the bicepconfig.json file to the path of your ACR. 

### Azure Key Vault
Secondly we need an Azure Key Vault to store sensistive data such as the password of the administrator login password of the database server. Make sure to change the parameters in
the parameters.dev.json to the name of your Key Vault and resourcegroup. In the Azure portal you can add a secret by clicking 'Secrets' -> 'Generate/Import' and add your password in the secret value box. The name given to your secret will be stored in the 'secretName' parameter of the parameters.dev.json file as a reference to the secret in the Key Vault.

## Parameters
After creating the two items yourself, it's important to change the parameters in the parameters.dev.json file to your own preference. If you don't
want to create certain Azure resources, you can change the module parameters in the main.bicep to existing instead of new. Because of the conditional deployment, certain resources will
not be deployed if you pass the 'existing' parameter. In the workflows you need to change the parameters that are used, suchh as the resource group name. 

## Secrets
To store the secrets, we need to create a Role Based Access Control (RBAC). With the following command you can create a RBAC:
```
az ad sp create-for-rbac --name "{Example name}" --role contributor  --scopes /subscriptions/{Azure subscription}/resourceGroups/{Name resource group}  --sdk-auth
```
There will be a JSON output shown that you need to copy. In the GitHub portal you need to go to Settings -> Secret and variables -> Actions and store the JSON output in a variable. 
An example name would be AZURE_CREDENTIALS_CLIENT which you will use in your GitHub workflow YML files. Make sure the parameter matches with the given one in your GIthub account, otherwise you will not be able to authenticate. M

## First run
There are two reusable GitHub workflows created, one for deployment and one for publishing the Bicep templates to the ACR. In the first run, the deployment workflow will fail because the ACR is still empty.
You can disable this specific workflow in GitHub and first run the publishing workflow to publish the Bicep templates to the ACR. After the templates are stored in the ACR, we can start the deployment workflow. 

### Publishing reusable Bicep templates to the ACR using GitHub reusable workflows
For publishing to the ACR, there will be two tags added. One is a version tag which you can configure yourself in the metadata.json file. With a new major or minor change, you can increment the values in this file. Furthermore there will always be a latest tag added to a new publishment, so you always have one up to date reference. If you need to use the Bicep template of a specific version, you can change the path of the specific module in the main.bicep file from 'latest' to the specific tag version that you need. The tag number is made of out of the numbers from the metadata.json with a GitHub runner number added. 

### Deploying Azure resources using GitHub reusable workflows
After changing the parameters to your preference, you need to change the resource group in the deployment workflow to your own resource groups. The Azure resources will be deployed to a development and production environment. With a push to GitHub you can start the automated deployment process. If you wish to change the trigger of the workflow, you can change the 'on' trigger in the deployBicepWorkflow.yml file. 

Congratulations! After configuring these steps, you have fully automated workflows which you can use to deploy your Azure resources and publish your reusable Bicep templates!
