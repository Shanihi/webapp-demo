param appServicePlan object
param webApp object
param sqlServer object
param sqlDB object
param environmentParam string


module appServicePlanModule 'br/CoreModules:appserviceplan:1.0_20230320093853' = {
  name: appServicePlan.name
  params: {
    appServicePlanNameParam: appServicePlan.name
    appServicePlanSkuNameParam: appServicePlan.sku.name
    appServicePlanSkuTierParam: appServicePlan.sku.tier
    environmentParam: environmentParam
    appServiceKindParam: appServicePlan.kind
  }
}

module webAppModule 'br/CoreModules:webapp:1.0_20230320093853' = {
  name: webApp.name
  params: {
    appServicePlanIdParam: appServicePlanModule.outputs.aspId
    environmentParam: environmentParam
    linuxFxVersionParam: webApp.linuxFxVersion
    webAppNameParam: webApp.name
  }
}

module sqlDBserverModule 'br/CoreModules:sqldatabase:1.0_20230320093853' = {
  name: sqlServer.name
  params: {
    environmentParam: environmentParam

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
