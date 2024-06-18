@description('Array of Azure resource Ids. For example - /subscriptions/00000000-0000-0000-0000-0000-00000000')
@minLength(1)
param targetResourceId array

@description('Azure region in which target resources to be monitored are in (without spaces). For example: EastUS')
param targetResourceRegion string

@description('the full resource id of the action group that will be triggered when the alert fires')
param actionGroupId string = '/subscriptions/0bcdddd7-c81d-4da5-972e-a724a62bde47/resourceGroups/shared-actiongroups-rg/providers/microsoft.insights/actiongroups/SendToServiceNow'

resource sqlAvailMetricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'sql-avail-${targetResourceRegion}-alertrule'
  location: 'global'
  properties: {
    description: 'Alert rule for SQL availability across all subscriptions'
    scopes: targetResourceId
    targetResourceType: 'Microsoft.Sql/servers/databases'
    targetResourceRegion: targetResourceRegion
    severity: 3
    enabled: true
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: '1st criterion'
          metricName: 'availability'
          operator: 'LessThan'
          threshold: 97
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}

resource sqlCpuMetricAlert2 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'sql-cpu-${targetResourceRegion}-alertrule'
  location: 'global'
  properties: {
    description: 'Alert rule for SQL CPU across all subscriptions'
    scopes: targetResourceId
    targetResourceType: 'Microsoft.Sql/servers/databases'
    targetResourceRegion: targetResourceRegion
    severity: 3
    enabled: true
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: '1st criterion'
          metricName: 'app_cpu_percent'
          operator: 'GreaterThan'
          threshold: 90
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}

resource sqlMemMetricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'sql-mem-${targetResourceRegion}-alertrule'
  location: 'global'
  properties: {
    description: 'Alert rule for SQL memory across all subscriptions'
    scopes: targetResourceId
    targetResourceType: 'Microsoft.Sql/servers/databases'
    targetResourceRegion: targetResourceRegion
    severity: 3
    enabled: true
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: '1st criterion'
          metricName: 'app_memory_percent'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}

resource siteRecoveryBackupMetricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'srv-backuphealth-${targetResourceRegion}-alertrule'
  location: 'global'
  properties: {
    description: 'Alert rule for site recovery vault backups across all subscriptions'
    scopes: targetResourceId
    targetResourceType: 'Microsoft.RecoveryServices/vaults'
    targetResourceRegion: targetResourceRegion
    severity: 3
    enabled: true
    evaluationFrequency: 'PT1H'
    windowSize: 'P1D'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: '1st criterion'
          metricName: 'BackupHealthEvent'
          operator: 'GreaterThan'
          threshold: 0
          timeAggregation: 'Count'
          dimensions: [
            {
              name: 'dataSourceURL'
              operator: 'Include'
              values: [
                '*'
              ]
            }
          ]
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}

resource vmCpuMetricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'vm-cpu-${targetResourceRegion}-alertrule'
  location: 'global'
  properties: {
    description: 'Alert rule for vm cpu utilization across all subscriptions'
    scopes: targetResourceId
    targetResourceType: 'Microsoft.Compute/virtualMachines'
    targetResourceRegion: targetResourceRegion
    severity: 3
    enabled: true
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: '1st criterion'
          metricName: 'Percentage CPU'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}
