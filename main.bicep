targetScope = 'subscription'

param appServicePlan object
param webApp object
param resGroup object

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resGroup.name
  location: deployment().location
  tags: resGroup.tags
}

module appPlan 'modules/appService/appServicePlan.bicep' = {
  scope: rg
  name: appServicePlan.name
  params: {
    appServicePlanNameParam: appServicePlan.name
    appServicePlanSkuParam: appServicePlan.sku
    environmentParam: resGroup.tags.Environment
  }
}

module app 'modules/webApp/webApp.bicep' = {
  scope: rg
  name: webApp.name
  params: {
    appServicePlanIdParam: appPlan.outputs.aspId
    environmentParam: resGroup.tags.Environment
    linuxFxVersionParam: webApp.linuxFxVersion
    webAppNameParam: webApp.name
  }
}