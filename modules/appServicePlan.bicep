param appServicePlanNameParam string
param appServicePlanSkuNameParam string
param appServicePlanSkuTierParam string
param appServiceKindParam string

@description('Provide a location for the app servcice plan.')
param location string = resourceGroup().location

@description('Provide name for App Service Plan, suffixing the environmentParam defined in the main.bicep template.')
var appServicePlanName = 'appserviceplan-${uniqueString(appServicePlanNameParam)}'

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
