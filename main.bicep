targetScope = 'subscription'

param appServicePlan object
param webApp object
param resGroup object

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resGroup.name
  location: deployment().location
  tags: resGroup.tags
}


module appPlan 'br/CoreModules:appserviceplan:v1.0' = {
  scope: rg
  name: appServicePlan.name
  params: {
    appServicePlanNameParam: appServicePlan.name
    appServicePlanSkuParam: appServicePlan.sku
    environmentParam: resGroup.tags.Environment
    appServiceKindParam: appServicePlan.kind
  }
}

module app 'br/CoreModules:web-app:v1.0' = {
  scope: rg
  name: webApp.name
  params: {
    appServicePlanIdParam: appPlan.outputs.aspId
    environmentParam: resGroup.tags.Environment
    linuxFxVersionParam: webApp.linuxFxVersion
    webAppNameParam: webApp.name
  }
}