targetScope = 'subscription'

@description('Array of actions for the role definition')
param actions array = [
  'Microsoft.EventHub/*'
 'Microsoft.Storage/storageAccounts/blobServices/containers/delete'
                    'Microsoft.Storage/storageAccounts/blobServices/containers/read'
                    'Microsoft.Storage/storageAccounts/blobServices/containers/write'
                    'Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action'
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
      }
    ]
    assignableScopes: [
      subscription().id
    ]
  }
}
