using 'generic-metric-alertrule.bicep'

param alertName  = 'sql-cpu-westus-alertrule'
param alertDescription = 'Alert rule for SQL CPU across all subscriptions'
param targetResourceType = 'Microsoft.Sql/servers/databases'
param metricName = 'app_cpu_percent'
param targetResourceRegion = 'westus'

param targetResourceId = [
  '/subscriptions/4b9e0820-996e-403d-8872-12683a5c3729'
  '/subscriptions/0bcdddd7-c81d-4da5-972e-a724a62bde47'
]

param isEnabled = true
param alertSeverity = 3
param operator = 'GreaterThan'
param evaluationFrequency = 'PT1M'
param windowSize = 'PT5M'
param threshold = 80
param timeAggregation = 'Average'

param dimensions = []
