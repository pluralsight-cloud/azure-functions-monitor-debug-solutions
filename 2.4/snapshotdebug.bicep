var location = resourceGroup().location
var storageAccountName = 'st${uniqueString(resourceGroup().id)}'
var appServicePlanName = 'aspwin${uniqueString(resourceGroup().id)}'
var functionAppName = 'funcnet${uniqueString(resourceGroup().id)}'
var applicationInsightsName = 'app${uniqueString(resourceGroup().id)}'

// Storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

// Windows‑based App Service Plan (Basic B1)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
  }
  kind: 'windows'
}

// Application Insights (linked to the Function App)
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

// ASP.NET 8 (in‑process) Function App running on Windows
resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageAccount.id, '2022-05-01').keys[0].value};EndpointSuffix=core.windows.net'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference(resourceId('Microsoft.Insights/components', applicationInsightsName), '2020-02-02').InstrumentationKey
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
