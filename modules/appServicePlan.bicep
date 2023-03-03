param appServicePlanNameParam string
param appServicePlanSkuParam object
param appServiceKindParam string
param environmentParam string

@description('Provide name for App Service Plan, suffixing the environmentParam defined in the main.bicep template.')
var appServicePlanName = '${appServicePlanNameParam}-${environmentParam}'

@description('Provide a location for the registry.')
var location = resourceGroup().location

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
