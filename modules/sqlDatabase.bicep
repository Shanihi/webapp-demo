param serverNameParam string
param administratorLoginParam string
param serverVersionParam string
param federatedClientIdParam string
param minimalTlsVersionPeram string
param primaryUserAssignedIdentityIdParam string
param publicNetworkAccessParam string
param restrictOutboundNetworkAccessParam string

@description('Azure database for MySQL pricing tier')
@allowed([
  'Basic'
  'GeneralPurpose'
  'MemoryOptimized'
])
param skuTierParam string 

@description('Azure database for MySQL compute capacity in vCores (2,4,8,16,32)')
param skuCapacityParam int

@description('Azure database for MySQL sku family')
param skuFamilyParam string 

@description('Azure database for MySQL Sku Size ')
param skuSizeMBParam string 

param sqlDBCreateModeParam string

@description('Provide a location for the registry.')
param location string = resourceGroup().location

param sqlAutoPauseDelayParam int
param sqlCatalogCollationParam string
param sqlCollationParam string
param sqlDBNameParam string
param sqlElasticPoolIdParam string
param sqlFederatedClientIdParam string
param sqlHighAvailabilityReplicaCountParam int
param sqlIsLedgerOnParam bool
param sqlLicenseTypeParam string
param sqlLongTermRetentionBackupResourceIdParam string
param sqlMaintenanceConfigurationIdParam string
param sqlMaxSizeBytesParam int
param sqlMinCapacityParam int
param sqlPreferredEnclaveTypeParam string
param sqlReadScaleParam string
param sqlRecoverableDatabaseIdParam string
param sqlRecoveryServicesRecoveryPointIdParam string
param sqlRequestedBackupStorageRedundancyParam string
param sqlRestorableDroppedDatabaseIdParam string
param sqlRestorePointInTimeParam string
param sqlSampleNameParam string
param sqlSecondaryTypeParam string
param sqlSourceDatabaseDeletionDateParam string
param sqlSourceDatabaseIdParam string
param sqlSourceResourceIdParam string
param sqlZoneRedundantParam bool

@secure()
param administratorLoginPasswordParam string

param sqlDBFirewallNameParam string
param sqlStartIpAddressParam string
param sqlEndIpAddressParam string

@description('Provide unique name for sql DB server name')
var serverName = string('${serverNameParam}-${uniqueString(resourceGroup().id)}')

@description('Provide name for sql DB, suffixing server name with sql DB name ')
var sqlDBName = string('${sqlDBNameParam}-${uniqueString(resourceGroup().id)}')

@description('Provide name for sql DB, suffixing server name with sql DB name ')
var sqlDBFirewallName = string('${sqlDBFirewallNameParam}-${uniqueString(resourceGroup().id)}')

var basicSqlProperties =  {
    autoPauseDelay: sqlAutoPauseDelayParam
    catalogCollation: sqlCatalogCollationParam
    collation: sqlCollationParam
    createMode: sqlDBCreateModeParam
    highAvailabilityReplicaCount: sqlHighAvailabilityReplicaCountParam
    isLedgerOn: sqlIsLedgerOnParam
    licenseType: sqlLicenseTypeParam
    maxSizeBytes: sqlMaxSizeBytesParam
    minCapacity: sqlMinCapacityParam
    readScale: sqlReadScaleParam
    requestedBackupStorageRedundancy: sqlRequestedBackupStorageRedundancyParam
    sampleName: sqlSampleNameParam
    zoneRedundant: sqlZoneRedundantParam
  }

  var generalSqlProperties =  {
    autoPauseDelay: sqlAutoPauseDelayParam
    catalogCollation: sqlCatalogCollationParam
    collation: sqlCollationParam
    createMode: sqlDBCreateModeParam
    elasticPoolId: sqlElasticPoolIdParam
    federatedClientId: sqlFederatedClientIdParam
    highAvailabilityReplicaCount: sqlHighAvailabilityReplicaCountParam
    isLedgerOn: sqlIsLedgerOnParam
    licenseType: sqlLicenseTypeParam
    longTermRetentionBackupResourceId: sqlLongTermRetentionBackupResourceIdParam
    maintenanceConfigurationId: sqlMaintenanceConfigurationIdParam
    maxSizeBytes: sqlMaxSizeBytesParam
    minCapacity: sqlMinCapacityParam
    preferredEnclaveType: sqlPreferredEnclaveTypeParam
    readScale: sqlReadScaleParam
    recoverableDatabaseId: sqlRecoverableDatabaseIdParam
    recoveryServicesRecoveryPointId: sqlRecoveryServicesRecoveryPointIdParam
    requestedBackupStorageRedundancy: sqlRequestedBackupStorageRedundancyParam
    restorableDroppedDatabaseId: sqlRestorableDroppedDatabaseIdParam
    restorePointInTime: sqlRestorePointInTimeParam
    sampleName: sqlSampleNameParam
    secondaryType: sqlSecondaryTypeParam
    sourceDatabaseDeletionDate: sqlSourceDatabaseDeletionDateParam
    sourceDatabaseId: sqlSourceDatabaseIdParam
    sourceResourceId: sqlSourceResourceIdParam
    zoneRedundant: sqlZoneRedundantParam
  }

   var memorySqlProperties =  {
    autoPauseDelay: sqlAutoPauseDelayParam
    catalogCollation: sqlCatalogCollationParam
    collation: sqlCollationParam
    createMode: sqlDBCreateModeParam
    elasticPoolId: sqlElasticPoolIdParam
    federatedClientId: sqlFederatedClientIdParam
    highAvailabilityReplicaCount: sqlHighAvailabilityReplicaCountParam
    isLedgerOn: sqlIsLedgerOnParam
    licenseType: sqlLicenseTypeParam
    longTermRetentionBackupResourceId: sqlLongTermRetentionBackupResourceIdParam
    maintenanceConfigurationId: sqlMaintenanceConfigurationIdParam
    maxSizeBytes: sqlMaxSizeBytesParam
    minCapacity: sqlMinCapacityParam
    preferredEnclaveType: sqlPreferredEnclaveTypeParam
    readScale: sqlReadScaleParam
    recoverableDatabaseId: sqlRecoverableDatabaseIdParam
    recoveryServicesRecoveryPointId: sqlRecoveryServicesRecoveryPointIdParam
    requestedBackupStorageRedundancy: sqlRequestedBackupStorageRedundancyParam
    restorableDroppedDatabaseId: sqlRestorableDroppedDatabaseIdParam
    restorePointInTime: sqlRestorePointInTimeParam
    sampleName: sqlSampleNameParam
    secondaryType: sqlSecondaryTypeParam
    sourceDatabaseDeletionDate: sqlSourceDatabaseDeletionDateParam
    sourceDatabaseId: sqlSourceDatabaseIdParam
    sourceResourceId: sqlSourceResourceIdParam
    zoneRedundant: sqlZoneRedundantParam
  }

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  

  properties: {
    administratorLogin: administratorLoginParam
    administratorLoginPassword: administratorLoginPasswordParam
    version: serverVersionParam

    federatedClientId: federatedClientIdParam
    minimalTlsVersion: minimalTlsVersionPeram
    primaryUserAssignedIdentityId: primaryUserAssignedIdentityIdParam
    publicNetworkAccess: publicNetworkAccessParam
    restrictOutboundNetworkAccess: restrictOutboundNetworkAccessParam
  }
    
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location

  sku: {
      name: sqlDBNameParam
      tier: skuTierParam
      size: skuSizeMBParam
      capacity: skuCapacityParam
      family: skuFamilyParam
  }
  properties: (skuTierParam == 'Basic') ? basicSqlProperties : (skuTierParam == 'GeneralPurpose') ? generalSqlProperties : memorySqlProperties
}

resource databaseServerFirewall 'Microsoft.Sql/servers/firewallRules@2021-11-01-preview' = {
  name: sqlDBFirewallName
  parent: sqlServer
  properties: {
    startIpAddress: sqlStartIpAddressParam
    endIpAddress: sqlEndIpAddressParam
  }
}