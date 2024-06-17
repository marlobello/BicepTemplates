using 'generic-metric-alertrule.bicep'

param alertName  = 'sql-mem-eastus-alertrule'
param alertDescription = 'Alert rule for SQL memory across all subscriptions'
param targetResourceType = 'Microsoft.Sql/servers/databases'
param metricName = 'app_memory_percent'
param targetResourceRegion = 'eastus'

param targetResourceId = [
  '/subscriptions/4b9e0820-996e-403d-8872-12683a5c3729'
  '/subscriptions/0bcdddd7-c81d-4da5-972e-a724a62bde47'
]

param isEnabled = true
param alertSeverity = 3
param operator = 'GreaterThan'
param evaluationFrequency = 'PT1M'
param windowSize = 'PT5M'
param threshold = 90
param timeAggregation = 'Average'

param dimensions = []
