param appServicePlanNameParam string
param appServicePlanSkuParam object
param appServiceKindParam string
param environmentParam string
@description('Provide a location for the registry.')
param location string = resourceGroup().location


@description('Provide name for App Service Plan, suffixing the environmentParam defined in the main.bicep template.')
var appServicePlanName = '${appServicePlanNameParam}-${environmentParam}'


resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  kind: appServiceKindParam
  properties: {
    reserved: true
  }
  sku: appServicePlanSkuParam
}

output aspId string = appServicePlan.id
