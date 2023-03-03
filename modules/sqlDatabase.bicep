param sqlDBNameParam string
param environmentParam string
param appServicePlanSkuParam object
param serverNameParam string
param administratorLoginParam string

@secure()
param administratorLoginPasswordParam string


@description('Provide unique name for sql DB server name')
var serverName = 'sql-${uniqueString(serverNameParam)}-${resourceGroup().id}-${environmentParam}'

@description('Provide name for sql DB, suffixing server name with sql DB name ')
var sqlDBName = '${sqlDBNameParam}-${environmentParam}'

@description('Provide a location for the registry.')
var location = resourceGroup().location


resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLoginParam
    administratorLoginPassword: administratorLoginPasswordParam
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: appServicePlanSkuParam
}


