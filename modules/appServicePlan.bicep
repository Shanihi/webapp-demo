param appServicePlanNameParam string
param appServicePlanSkuNameParam string
param appServicePlanSkuTierParam string
param appServiceKindParam string

@allowed([
  'dev'
  'prod'
])
param environmentName string

@description('Provide a location for the registry.')
param location string = resourceGroup().location


@description('Provide name for App Service Plan, suffixing the environmentParam defined in the main.bicep template.')
var appServicePlanName = '${uniqueString(appServicePlanNameParam)}-${environmentName}'



resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  kind: appServiceKindParam
  properties: {
    reserved: true
  }
 sku: {
      name: appServicePlanSkuNameParam
      tier: appServicePlanSkuTierParam

  }
}

output aspId string = appServicePlan.id
