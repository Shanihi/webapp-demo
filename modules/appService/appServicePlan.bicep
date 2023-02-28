param appServicePlanNameParam string
param appServicePlanSkuParam object
param environmentParam string

var appServicePlanName = '${appServicePlanNameParam}-${environmentParam}'
var location = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: appServicePlanSkuParam
}

output aspId string = appServicePlan.id