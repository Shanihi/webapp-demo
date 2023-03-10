#!/bin/bash

CURRENTDATE=$(date +%Y%m%d%H%M%S)

VERSION="1.0_$CURRENTDATE"

ACRNAME="shanBicepContainerRegistry"



echo "Publish App Service Plan $VERSION"

az acr repository delete --name $ACRNAME --repository appserviceplan:latest --yes

az bicep publish -f ./modules/appServicePlan.bicep -t br:shanBicepContainerRegistry.azurecr.io/appserviceplan:$VERSION

az bicep publish -f ./modules/appServicePlan.bicep -t br:shanBicepContainerRegistry.azurecr.io/appserviceplan:latest

echo "Publish SQL Database $VERSION"

az acr repository delete --name $ACRNAME --repository sqldatabase:latest --yes

az bicep publish -f ./modules/sqlDatabase.bicep -t br:shanBicepContainerRegistry.azurecr.io/sqldatabase:$VERSION

az bicep publish -f ./modules/sqlDatabase.bicep -t br:shanBicepContainerRegistry.azurecr.io/sqldatabase:latest

echo "Publish Web App $VERSION"

az acr repository delete --name $ACRNAME --repository webapp:latest --yes

az bicep publish -f ./modules/webApp.bicep -t br:shanBicepContainerRegistry.azurecr.io/webapp:$VERSION

az bicep publish -f ./modules/webApp.bicep -t br:shanBicepContainerRegistry.azurecr.io/webapp:latest