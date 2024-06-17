using 'generic-metric-alertrule.bicep'

param alertName = 'srv-backuphealth-eastus-alertrule'
param alertDescription = 'Alert rule for site recovery vault backups across all subscriptions'
param targetResourceType = 'Microsoft.RecoveryServices/vaults'
param metricName = 'BackupHealthEvent'
param targetResourceRegion = 'eastus'

param targetResourceId = [
  '/subscriptions/4b9e0820-996e-403d-8872-12683a5c3729'
  '/subscriptions/0bcdddd7-c81d-4da5-972e-a724a62bde47'
]

param isEnabled = true
param alertSeverity = 3
param operator = 'GreaterThan'
param threshold = 0
param timeAggregation = 'Count'
param evaluationFrequency = 'PT1H'
param windowSize = 'P1D'

param dimensions = [
  {
    name: 'dataSourceURL'
    operator: 'Include'
    values: [
      '*'
    ]
  }
]
