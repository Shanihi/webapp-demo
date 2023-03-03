targetScope = 'subscription'

param appServicePlan object
param webApp object
param resGroup object
param sqlServer object
param sqlDB object

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resGroup.name
  location: deployment().location
  tags: resGroup.tags
}


module appServicePlanModule 'br/CoreModules:appserviceplan:v1.0' = {
  scope: rg
  name: appServicePlan.name
  params: {
    appServicePlanNameParam: appServicePlan.name
    appServicePlanSkuParam: appServicePlan.sku
    environmentParam: resGroup.tags.Environment
    appServiceKindParam: appServicePlan.kind
  }
}

module webAppModule 'br/CoreModules:web-app:v1.0' = {
  scope: rg
  name: webApp.name
  params: {
    appServicePlanIdParam: appServicePlanModule.outputs.aspId
    environmentParam: resGroup.tags.Environment
    linuxFxVersionParam: webApp.linuxFxVersion
    webAppNameParam: webApp.name
  }
}

module sqlDBserverModule 'br/CoreModules:sql-database-server:v1.0' = {
  scope: rg
  name: sqlDB.name
  params: {
    sqlDBNameParam: sqlDB.name
    environmentParam: resGroup.tags.Environment
    appServicePlanSkuParam: appServicePlan.sku
    serverNameParam: sqlServer.name
    administratorLoginParam: sqlServer.administratorLogin
    administratorLoginPasswordParam: sqlServer.administratorLoginPassword
  }
}