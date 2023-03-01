param appServicePlanIdParam string
param environmentParam string
param linuxFxVersionParam string
param webAppNameParam string

var webAppName = '${webAppNameParam}-${environmentParam}'
var location = resourceGroup().location

resource webApp 'Microsoft.Web/sites@2021-01-01' = {
  name: webAppName
  location: location
  tags: {}
  properties: {
    siteConfig: {
      appSettings: []
      linuxFxVersion: linuxFxVersionParam
    }
    serverFarmId: appServicePlanIdParam
  }
}
