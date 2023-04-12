param appServicePlanIdParam string

param linuxFxVersionParam string
param webAppNameParam string

@description('Provide a location for the registry.')
param location string = resourceGroup().location


@description('Provide name for your Web Application, suffixing the environmentParam defined in the main.bicep template.')
var webAppName = 'webapp-${uniqueString(webAppNameParam)}'


resource webApp 'Microsoft.Web/sites@2021-01-01' = {
  name: webAppName
  location: location
  properties: {
    siteConfig: {
      appSettings: []
      linuxFxVersion: linuxFxVersionParam
    }
    serverFarmId: appServicePlanIdParam
  }
}
