var location = resourceGroup().location
var storageAccountName = 'st${uniqueString(resourceGroup().id)}'
var appServicePlanName = 'asp${uniqueString(resourceGroup().id)}'
var functionAppName = 'queuefunc${uniqueString(resourceGroup().id)}'
var httpFunctionAppName = 'httpfunc${uniqueString(resourceGroup().id)}'
var cosmosAccountName = 'cosmos${uniqueString(resourceGroup().id)}'
var applicationInsightsName = 'app${uniqueString(resourceGroup().id)}'

// Create a storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

// Create a storage queue named 'orderqueue'
resource storageQueue 'Microsoft.Storage/storageAccounts/queueServices/queues@2022-09-01' = {
  name: '${storageAccount.name}/default/orderqueue'
  properties: {}
  dependsOn: [
    storageAccount
  ]
}

// Create the App Service Plan (Basic B1)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

// Create Application Insights
resource applicationInsight 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  tags: {
    'hidden-link:${resourceId('Microsoft.Web/sites', functionAppName)}': 'Resource'
  }
  properties: {
    Application_Type: 'web'
  }
  kind: 'web'
}

// Create the First Function App (Python)
resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'python|3.11'
      appSettings: [
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageAccount.id, '2022-05-01').keys[0].value};EndpointSuffix=core.windows.net'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference(resourceId('Microsoft.Insights/components', applicationInsightsName), '2020-02-02').InstrumentationKey
        }
        {
          name: 'COSMOS_DB_CONNECTION_STRING'
          value: 'AccountEndpoint=https://${cosmosAccountName}.documents.azure.com:443/;AccountKey=${listKeys(resourceId('Microsoft.DocumentDB/databaseAccounts', cosmosAccountName), '2021-07-01-preview').primaryMasterKey}'
        }
        {
          name: 'OTEL_SERVICE_NAME'
          value: 'OrderProcessingFunction'
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
      ]
      cors: {
        allowedOrigins: [
          'https://portal.azure.com'
        ]
      }
    }
  }
}

// Create the Second Function App (HTTP Trigger)
resource httpFunctionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: httpFunctionAppName
  location: location
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'python|3.11'
      appSettings: [
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageAccount.id, '2022-05-01').keys[0].value};EndpointSuffix=core.windows.net'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference(resourceId('Microsoft.Insights/components', applicationInsightsName), '2020-02-02').InstrumentationKey
        }
        {
          name: 'OTEL_SERVICE_NAME'
          value: 'HTTPOrderPlacementFunction'
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
      ]
      cors: {
        allowedOrigins: [
          'https://portal.azure.com'
        ]
      }
    }
  }
}

// Cosmos DB account (Core API / NoSQL) in serverless mode
resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2021-07-01-preview' = {
  name: cosmosAccountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    createMode: 'Default'
    databaseAccountOfferType: 'Standard'
    capabilities: [
      {
        name: 'EnableServerless'
      }
    ]
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
  }
}

// Create a SQL database (NoSQL / Core API) in the Cosmos DB account
resource cosmosDbDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-07-01-preview' = {
  name: '${cosmosAccount.name}/OrdersDB'
  properties: {
    resource: {
      id: 'OrdersDB'
    }
    options: {}
  }
  dependsOn: [
    cosmosAccount
  ]
}

// Create a container within the SQL database
resource cosmosDbContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-07-01-preview' = {
  name: '${cosmosDbDatabase.name}/Orders'
  properties: {
    resource: {
      id: 'Orders'
      partitionKey: {
        paths: [
          '/PartitionKey'
        ]
        kind: 'Hash'
      }
    }
    options: {}
  }
  dependsOn: [
    cosmosDbDatabase
  ]
}
