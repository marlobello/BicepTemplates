using 'generic-metric-alertrule.bicep'

param targetResourceRegion = 'eastus'
param alertName  = 'sql-avail-${targetResourceRegion}-alertrule'
param alertDescription = 'Alert rule for SQL availability across all subscriptions'
param targetResourceType = 'Microsoft.Sql/servers/databases'
param metricName = 'availability'

param targetResourceId = [
  '/subscriptions/4b9e0820-996e-403d-8872-12683a5c3729'
]

param isEnabled = true
param alertSeverity = 3
param operator = 'LessThan'
param threshold = 98
param timeAggregation = 'Average'
param evaluationFrequency = 'PT1M'
param windowSize = 'PT5M'

param dimensions = []
