param appServicePlan object
param webApp object
param sqlServer object
param sqlDB object
param keyVault object
param secretNameKeyVault string = 'secretPasswordSql'

// conditional deployment. Use 'new' for deployment and 'existing' to skip deployment
@allowed([
  'new'
  'existing'
])
param newOrExisting string = 'new'

// Key Vault for storing sensitive data like database password
resource kv 'Microsoft.KeyVault/vaults@2022-11-01' existing = {
  name: keyVault.name
  scope: resourceGroup(keyVault.resourceGroup)
} 

// module alias used for Bicep registry path with latest tag version
module appServicePlanModule 'br/CoreModules:appserviceplan:latest' = if (newOrExisting == 'new') {
  name: appServicePlan.name
  params: {
    appServicePlanNameParam: appServicePlan.name
    appServicePlanSkuNameParam: appServicePlan.sku.name
    appServicePlanSkuTierParam: appServicePlan.sku.tier
    appServiceKindParam: appServicePlan.kind
  }
}
// module alias used for Bicep registry path with latest tag version
module webAppModule 'br/CoreModules:webapp:latest' = if (newOrExisting == 'new') {
  name: webApp.name
  params: {
    appServicePlanIdParam: appServicePlanModule.outputs.aspId
    linuxFxVersionParam: webApp.linuxFxVersion
    webAppNameParam: webApp.name
  }
}
// module alias used for Bicep registry path with latest tag version
module sqlDBserverModule 'br/CoreModules:sqldatabase:latest' = if (newOrExisting == 'new') {
  name: sqlServer.name
  params: {
    serverNameParam: sqlServer.name
    administratorLoginParam: sqlServer.administratorLogin
    administratorLoginPasswordParam: kv.getSecret(secretNameKeyVault)
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

