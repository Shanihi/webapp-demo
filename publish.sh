#!/bin/bash
CURRENTDATE=$(date +%Y%m%d%H%M%S)
VERSION="1.0_$CURRENTDATE"


echo "Publish App Service Plan $VERSION"
az bicep publish -f ./modules/appServicePlan.bicep -t br:avanadeBicepContainerRegistry.azurecr.io/appserviceplan:$VERSION
az bicep publish -f ./modules/appServicePlan.bicep -t br:avanadeBicepContainerRegistry.azurecr.io/appserviceplan:latest

echo "Publish SQL Database $VERSION"
az bicep publish -f ./modules/sqlDatabase.bicep -t br:avanadeBicepContainerRegistry.azurecr.io/sqldatabase:$VERSION
az bicep publish -f ./modules/sqlDatabase.bicep -t br:avanadeBicepContainerRegistry.azurecr.io/sqldatabase:latest

echo "Publish Web App $VERSION"
az bicep publish -f ./modules/webApp.bicep -t br:avanadeBicepContainerRegistry.azurecr.io/webapp:$VERSION
az bicep publish -f ./modules/webApp.bicep -t br:avanadeBicepContainerRegistry.azurecr.io/webapp:latest



