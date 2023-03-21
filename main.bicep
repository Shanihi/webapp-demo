targetScope = 'resourceGroup'

param appServicePlan object
param webApp object
param resGroup object
param sqlServer object
param sqlDB object
output subscriptionOutput object = subscription()

@description('Provide a location for the registry.')
param deploymentLocation string = deployment().location

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  scope: subscription()
  name: resGroup.name
  location: deploymentLocation
  tags: resGroup.tags
}


module appServicePlanModule 'br/CoreModules:appserviceplan:1.0_20230320093853' = {
  scope: rg
  name: appServicePlan.name
  params: {
    appServicePlanNameParam: appServicePlan.name
    appServicePlanSkuNameParam: appServicePlan.sku.name
    appServicePlanSkuTierParam: appServicePlan.sku.tier
    environmentParam: resGroup.tags.Environment
    appServiceKindParam: appServicePlan.kind
  }
}

module webAppModule 'br/CoreModules:webapp:1.0_20230320093853' = {
  scope: rg
  name: webApp.name
  params: {
    appServicePlanIdParam: appServicePlanModule.outputs.aspId
    environmentParam: resGroup.tags.Environment
    linuxFxVersionParam: webApp.linuxFxVersion
    webAppNameParam: webApp.name
  }
}

module sqlDBserverModule 'br/CoreModules:sqldatabase:1.0_20230320093853' = {
  scope: rg
  name: sqlServer.name
  params: {
    environmentParam: resGroup.tags.Environment

    serverNameParam: sqlServer.name
    administratorLoginParam: sqlServer.administratorLogin
    administratorLoginPasswordParam: sqlServer.administratorLoginPassword
    serverVersionParam: sqlServer.version
    federatedClientIdParam: sqlServer.federatedClientId
    minimalTlsVersionPeram: sqlServer.minimalTlsVersion
    primaryUserAssignedIdentityIdParam: sqlServer.primaryUserAssignedIdentityId
    publicNetworkAccessParam: sqlServer.publicNetworkAccess
    restrictOutboundNetworkAccessParam: sqlServer.restrictOutboundNetworkAccess

    sqlDBNameParam: sqlDB.sku.name
    skuTierParam: sqlDB.sku.tier
    skuSizeMBParam: sqlDB.sku.size
    skuCapacityParam: sqlDB.sku.capacity
    skuFamilyParam: sqlDB.sku.family
    sqlAutoPauseDelayParam: sqlDB.autoPauseDelay
    sqlCatalogCollationParam: sqlDB.catalogCollation
    sqlCollationParam: sqlDB.collation
    sqlDBCreateModeParam: sqlDB.createMode
    sqlElasticPoolIdParam: sqlDB.elasticPoolId
    sqlFederatedClientIdParam: sqlDB.federatedClientId
    sqlHighAvailabilityReplicaCountParam: sqlDB.highAvailabilityReplicaCount
    sqlIsLedgerOnParam: sqlDB.isLedgerOn
    sqlLicenseTypeParam: sqlDB.licenseType
    sqlLongTermRetentionBackupResourceIdParam: sqlDB.longTermRetentionBackupResourceId
    sqlMaintenanceConfigurationIdParam: sqlDB.maintenanceConfigurationId
    sqlMaxSizeBytesParam: sqlDB.maxSizeBytes
    sqlMinCapacityParam: sqlDB.minCapacity
    sqlPreferredEnclaveTypeParam: sqlDB.preferredEnclaveType
    sqlReadScaleParam: sqlDB.readScale
    sqlRecoverableDatabaseIdParam: sqlDB.recoverableDatabaseId
    sqlRecoveryServicesRecoveryPointIdParam: sqlDB.recoveryServicesRecoveryPointId
    sqlRequestedBackupStorageRedundancyParam: sqlDB.requestedBackupStorageRedundancy
    sqlRestorableDroppedDatabaseIdParam: sqlDB.restorableDroppedDatabaseId
    sqlRestorePointInTimeParam: sqlDB.restorePointInTime
    sqlSampleNameParam: sqlDB.sampleName 
    sqlSecondaryTypeParam: sqlDB.secondaryType
    sqlSourceDatabaseDeletionDateParam: sqlDB.sourceDatabaseDeletionDate
    sqlSourceDatabaseIdParam: sqlDB.sourceDatabaseId
    sqlSourceResourceIdParam: sqlDB.sourceResourceId
    sqlZoneRedundantParam: sqlDB.zoneRedundant
    sqlDBFirewallNameParam: sqlDB.firewall.name
    sqlStartIpAddressParam: sqlDB.firewall.startIpAddress
    sqlEndIpAddressParam: sqlDB.firewall.endIpAddress
  }
}
