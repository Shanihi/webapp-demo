param environmentParam string

param serverNameParam string
param administratorLoginParam string
param serverVersionParam string
param federatedClientIdParam string
param keyIdParam string
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
param SkuSizeMBParam string 

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
var serverName = 'sql-${uniqueString(serverNameParam)}-${resourceGroup().id}-${environmentParam}'

@description('Provide name for sql DB, suffixing server name with sql DB name ')
var sqlDBName = '${sqlDBNameParam}-${environmentParam}'

@description('Provide name for sql DB, suffixing server name with sql DB name ')
var sqlDBFirewallName = '${sqlDBFirewallNameParam}-${environmentParam}'


resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location

  properties: {
    administratorLogin: administratorLoginParam
    administratorLoginPassword: administratorLoginPasswordParam
    version: serverVersionParam

    federatedClientId: federatedClientIdParam
    keyId: keyIdParam
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
      size: SkuSizeMBParam
      capacity: skuCapacityParam
      family: skuFamilyParam
  }
  properties: {
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
}

resource databaseServerFirewall 'Microsoft.Sql/servers/firewallRules@2021-11-01-preview' = {
  name: sqlDBFirewallName
  parent: sqlServer
  properties: {
    startIpAddress: sqlStartIpAddressParam
    endIpAddress: sqlEndIpAddressParam
  }
}


