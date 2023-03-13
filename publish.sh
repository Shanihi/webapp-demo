#!/bin/bash
CURRENTDATE=$(date +%Y%m%d%H%M%S)
VERSION="1.0_$CURRENTDATE"
ACRNAME="shanBicepContainerRegistry"


echo "Publish App Service Plan $VERSION"
az bicep publish -f ./modules/appServicePlan.bicep -t br:ACRNAME.azurecr.io/appserviceplan:$VERSION

echo "Publish SQL Database $VERSION"
az bicep publish -f ./modules/sqlDatabase.bicep -t br:ACRNAME.azurecr.io/sqldatabase:$VERSION

echo "Publish Web App $VERSION"
az bicep publish -f ./modules/webApp.bicep -t br:ACRNAME.azurecr.io/webapp:$VERSION
