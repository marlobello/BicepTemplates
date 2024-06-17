using 'generic-metric-alertrule.bicep'

param alertName = 'vm-cpu-eastus-alertrule'
param alertDescription = 'Alert rule for vm cpu utilization across all subscriptions'
param targetResourceType = 'Microsoft.Compute/virtualMachines'
param metricName = 'Percentage CPU'
param targetResourceRegion = 'eastus'

param targetResourceId = [
  '/subscriptions/4b9e0820-996e-403d-8872-12683a5c3729'
  '/subscriptions/0bcdddd7-c81d-4da5-972e-a724a62bde47'
]

param isEnabled = true
param alertSeverity = 3
param operator = 'GreaterThan'
param threshold = 80
param timeAggregation = 'Average'
param evaluationFrequency = 'PT5M'
param windowSize = 'PT5M'

param dimensions = []
