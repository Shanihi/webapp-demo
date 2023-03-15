#!/bin/bash
az deployment sub create --template-file ./main.bicep --parameters './parameters.dev.json' --location westeurope --output jsonc

#deploy ACR. Assign ACR name and SKU  
cd registries
az deployment group create -g demo-app-service-rg --template-file acr.bicep --parameters acrName=shanBicepContainerRegistry acrSku=Basic