targetScope = 'subscription'

@description('Array of actions for the role definition')
param actions array = [
  'Microsoft.EventHub/*'
 'Microsoft.Storage/storageAccounts/blobServices/containers/delete'
                    'Microsoft.Storage/storageAccounts/blobServices/containers/read'
                    'Microsoft.Storage/storageAccounts/blobServices/containers/write'
                    'Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action'
                    'Microsoft.Authorization/*/read'
                    'Microsoft.Insights/alertRules/*'
                    'Microsoft.Resources/deployments/*'
                    'Microsoft.Resources/subscriptions/resourceGroups/read'
                    'Microsoft.Support/*'
                    'Microsoft.KeyVault/checkNameAvailability/read'
                    'Microsoft.KeyVault/deletedVaults/read'
                    'Microsoft.KeyVault/locations/*/read'
                    'Microsoft.KeyVault/vaults/*/read'
                    'Microsoft.KeyVault/operations/read'
                    'Microsoft.DocumentDB/*/read'
                    'Microsoft.DocumentDB/databaseAccounts/readonlykeys/action'
                    'Microsoft.Insights/MetricDefinitions/read'
                    'Microsoft.Insights/Metrics/read'
                    'Microsoft.Resources/subscriptions/resourceGroups/read'
]

param dataActions array = [
  'Microsoft.Devices/IotHubs/*/read'
  'Microsoft.Devices/IotHubs/fileUpload/notifications/action'
  'Microsoft.EventHub/*'
  'Microsoft.KeyVault/vaults/*'
  'Microsoft.Dashboard/grafana/ActAsGrafanaViewer/action'
]

@description('Array of notActions for the role definition')
param notActions array = []

@description('Friendly name of the role definition')
param roleName string = 'Custom Role - Backend Engineer'

@description('Detailed descrpition of the role definition')
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
