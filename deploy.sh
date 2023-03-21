#!/bin/bash
echo "Deploying your resources"
az deployment group create --resource-group voorbeeld-resourcegroup --template-file ./main.bicep --parameters './parameters.dev.json' --output jsonc

#deploy ACR. Assign ACR name and SKU  
cd registries
echo "Deploying your Azure Container Registry"
az deployment group create --resource-group voorbeeld-resourcegroup --template-file acr.bicep --parameters acrName=shanBicepContainerRegistry1 acrSku=Basic
