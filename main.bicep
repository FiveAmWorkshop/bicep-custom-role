targetScope = 'subscription'

@description('Array of actions for the role definition')
param actions array = [
                    'Microsoft.Authorization/*/read'
                    'Microsoft.CognitiveServices/*'
                    'Microsoft.ContainerRegistry/registries/pull/read'
                    'Microsoft.ContainerRegistry/registries/push/write'
                    'Microsoft.DBForPostgreSql/*/read'
                    'Microsoft.Databricks/*/read'
                    'Microsoft.DocumentDB/*/read'
                    'Microsoft.DocumentDB/databaseAccounts/readonlykeys/action'
                    'Microsoft.EventHub/*'
                    'Microsoft.Features/features/read'
                    'Microsoft.Features/providers/features/read'
                    'Microsoft.Features/providers/features/register/action'
                    'Microsoft.Insights/MetricDefinitions/read'
                    'Microsoft.Insights/Metrics/read'
                    'Microsoft.Insights/alertRules/*'
                    'Microsoft.Insights/diagnosticSettings/*'
                    'Microsoft.Insights/logDefinitions/read'
                    'Microsoft.KeyVault/checkNameAvailability/read'
                    'Microsoft.KeyVault/deletedVaults/read'
                    'Microsoft.KeyVault/locations/*/read'
                    'Microsoft.KeyVault/operations/read'
                    'Microsoft.KeyVault/vaults/*/read'
                    'Microsoft.ResourceHealth/availabilityStatuses/read'
                    'Microsoft.Resources/deployments/*'
                    'Microsoft.Resources/deployments/operations/read'
                    'Microsoft.Resources/subscriptions/operationresults/read'
                    'Microsoft.Resources/subscriptions/read'
                    'Microsoft.Resources/subscriptions/resourceGroups/read'
                    'Microsoft.Resources/subscriptions/resourcegroups/deployments/*'
                    'Microsoft.Storage/storageAccounts/blobServices/containers/delete'
                    'Microsoft.Storage/storageAccounts/blobServices/containers/read'
                    'Microsoft.Storage/storageAccounts/blobServices/containers/write'
                    'Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action'
                    'Microsoft.Support/*'
                    'Microsoft.Synapse/*'
                    'Microsoft.Web/serverFarms/*/read'
                    'Microsoft.Web/sites/*/read'
	

]

param dataActions array = [
  'Microsoft.Dashboard/grafana/ActAsGrafanaViewer/action'
  'Microsoft.Devices/IotHubs/*/read'
  'Microsoft.Devices/IotHubs/fileUpload/notifications/action'
  'Microsoft.EventHub/*'
  'Microsoft.KeyVault/vaults/*'
]

@description('Array of notActions for the role definition')
param notActions array = []

@description('Friendly name of the role definition')
param roleName string = 'Custom Role - Backend Engineer'

@description('Detailed description of the role definition')
param roleDescription string = 'Custom role to show a notional backend engineer'

var roleDefName = guid(subscription().id, string(actions), string(notActions))

resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: roleDefName
  properties: {
    roleName: roleName
    description: roleDescription
    type: 'customRole'
    permissions: [
      {
        actions: actions
        notActions: notActions
        dataActions: dataActions
      }
    ]
    assignableScopes: [
      subscription().id
    ]
  }
}
