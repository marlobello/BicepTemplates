@description('Array of Azure resource Ids. For example - /subscriptions/00000000-0000-0000-0000-0000-00000000')
@minLength(1)
param targetResourceId string

@description('the full resource id of the action group that will be triggered when the alert fires')
param actionGroupId string = '/subscriptions/0bcdddd7-c81d-4da5-972e-a724a62bde47/resourceGroups/shared-actiongroups-rg/providers/microsoft.insights/actiongroups/SendToServiceNow'

resource serviceHealthAlertRule 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'servicehealth-alertrule'
  location: 'global'
  properties: {
    description: 'Service Health alert'
    scopes: [
      targetResourceId
    ]
    enabled: true
    condition: {
      allOf: [
          {
            field: 'category'
            equals: 'ServiceHealth'
          }
      ]
    }
    actions: {
        actionGroups: [
          {
            actionGroupId: actionGroupId
            webhookProperties: {}
          }
        ]
      }
  }
}

resource resourceHealthAlertRule 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'resourcehealth-alertrule'
  location: 'global'
  properties: {
    description: 'Resource Health alert'
    scopes: [
      targetResourceId
    ]
    enabled: true
    condition: {
      allOf: [
          {
            field: 'category'
            equals: 'ResourceHealth'
          }
          {
            anyOf: [
                {
                    field: 'properties.currentHealthStatus'
                    equals: 'Degraded'
                }
                {
                    field: 'properties.currentHealthStatus'
                    equals: 'Unavailable'
                }
            ]
        }
        {
            anyOf: [
                {
                    field: 'status'
                    equals: 'Active'
                }
                {
                    field: 'status'
                    equals: 'In Progress'
                }
                {
                    field: 'status'
                    equals: 'Updated'
                }
            ]
        }
      ]
    }
    actions: {
        actionGroups: [
          {
            actionGroupId: actionGroupId
            webhookProperties: {}
          }
        ]
      }
  }
}

resource kvDeleteAlertRule 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'kv-delete-alertrule'
  location: 'global'
  properties: {
    description: 'KeyVault delete alert'
    scopes: [
      targetResourceId
    ]
    enabled: true
    condition: {
      allOf: [
          {
            field: 'category'
            equals: 'Administrative'
          }
          {
            field: 'operationName'
            equals: 'Microsoft.KeyVault/vaults/delete'
          }
      ]
    }
    actions: {
        actionGroups: [
          {
            actionGroupId: actionGroupId
            webhookProperties: {}
          }
        ]
      }
  }
}

resource backupVaultDeleteAlertRule 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'buv-delete-alertrule'
  location: 'global'
  properties: {
    description: 'Backup Vault delete alert'
    scopes: [
      targetResourceId
    ]
    enabled: true
    condition: {
      allOf: [
          {
            field: 'category'
            equals: 'Administrative'
          }
          {
            field: 'status'
            equals: 'Succeeded'
          }
          {
            anyOf: [
              {
                field: 'operationName'
                equals: 'Microsoft.DataProtection/backupVaults/delete'
              }
              {
                field: 'operationName'
                equals: 'Microsoft.DataProtection/backupVaults/backupPolicies/delete'
              }
              {
                field: 'operationName'
                equals: 'Microsoft.DataProtection/backupVaults/backupInstances/delete'
              }
              {
                field: 'operationName'
                equals: 'Microsoft.DataProtection/backupVaults/backupResourceGuardProxies/delete'
              }
            ]
          }
      ]
    }
    actions: {
        actionGroups: [
          {
            actionGroupId: actionGroupId
            webhookProperties: {}
          }
        ]
      }
  }
}

resource nsgModificationAlertRule 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'nsg-modification-alertrule'
  location: 'global'
  properties: {
    description: 'NSG modification alert'
    scopes: [
      targetResourceId
    ]
    enabled: true
    condition: {
      allOf: [
          {
            field: 'category'
            equals: 'Administrative'
          }
          {
            field: 'status'
            equals: 'Succeeded'
          }
          {
            anyOf: [
              {
                field: 'operationName'
                equals: 'Microsoft.Network/networkSecurityGroups/securityRules/write'
              }
              {
                field: 'operationName'
                equals: 'Microsoft.Network/networkSecurityGroups/securityRules/delete'
              }
              {
                field: 'operationName'
                equals: 'Microsoft.Network/networkSecurityGroups/delete'
              }
            ]
          }
      ]
    }
    actions: {
        actionGroups: [
          {
            actionGroupId: actionGroupId
            webhookProperties: {}
          }
        ]
      }
  }
}

resource sqlFwModificationAlertRule 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'sql-fw-modification-alertrule'
  location: 'global'
  properties: {
    description: 'SQL Firewall modification alert'
    scopes: [
      targetResourceId
    ]
    enabled: true
    condition: {
      allOf: [
          {
            field: 'category'
            equals: 'Administrative'
          }
          {
            field: 'status'
            equals: 'Succeeded'
          }
          {
            anyOf: [
              {
                field: 'operationName'
                equals: 'Microsoft.Sql/servers/firewallRules/write'
              }
              {
                field: 'operationName'
                equals: 'Microsoft.Sql/servers/firewallRules/delete'
              }
            ]
          }
      ]
    }
    actions: {
        actionGroups: [
          {
            actionGroupId: actionGroupId
            webhookProperties: {}
          }
        ]
      }
  }
}
