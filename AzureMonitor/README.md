# Azure Monitor Multi Metric Alerts

This feature can reduce the number of metric alerts that need to be created by an order of magnitude because it will create alerts for Azure resources across multiple subscriptions. It will also simply the process of creating identical alerts across multiple regions. All alerts will be created in a centralized resource group. Only a subset of Azure resources currently support this capability.

## Features

- **Automated Alert Rule Creation**: Scripts to automate the creation of a group of example metric alert rules in Azure Monitor, ensuring consistent monitoring across your Azure estate. Additional metrics can be monitored by adding them to the base-multi-metric-alertrules.bicep file. ONLY METRICS OUTLINED [HERE](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources-with-one-alert-rule) ARE SUPPORTED.
- **Multi-Subscription Support**: Ability to apply alert rules across multiple Azure subscriptions by reading from a target subscription list.
- **Region-Specific Alerts**: Supports the creation of alerts across a list of Azure regions.

## Getting Started

To get started with these tools, clone this repository to your local machine or download the files directly. Ensure you have the necessary permissions in your Azure account to create and manage alert rules.

### Prerequisites

- PowerShell for running the provided scripts, PowerShell 7 is recommended
- Relatively up to date Azure Az modules installed and configured
- Necessary Azure permissions to create and manage metric alerts

### Usage

1. **Modify subscriptions.txt**: Ensure that your target subscriptions are represented as "/subscriptions/GUID" -- one subscription per line.
2. **Customize baseline-multi-metricalertrules.bicep**: The provided alert rules are only a sample of what is available. [Azure Monitor Baseline Alerts](https://aka.ms/amba) is a good reference to identify desired alert rules as well as copy the bicep text from. Remember that only metrics outlined [here](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources-with-one-alert-rule) are supported by this repo.
3. **Run Create-MultiMetricAlerts.ps1**: Execute the PowerShell script with your specific parameters to create metric alerts in Azure Monitor.
```powershell
.\Create-MultiMetricAlerts.ps1 -AlertRuleSubscriptionName "MySubscription" -AlertRuleResourceGroupName "MyResourceGroup" -TargetSubscriptionFile "C:\subscriptions.txt" -TargetResourceRegion @("eastus", "westus")
```
### Example alerts created in a central location
![example-alerts](https://github.com/marlobello/BicepTemplates/blob/main/AzureMonitor/example-alerts.png?raw=true)

# Azure Monitor Activity Log Alerts

This feature will create identical activity log alerts in each subscription specified. Currently, there is no way to centarlize these types of alerts and so they must be created in each subscription seperately. A resource group will be created in each subscription to contain the alert rules.

## Features

- **Automated Alert Rule Creation**: Scripts to automate the creation of a group of example metric alert rules in Azure Monitor, ensuring consistent monitoring across your Azure estate. Additional activities can be monitored by adding them to the base-activitylog-alertrules.bicep file.
- **Multi-Subscription Support**: Ability to apply alert rules across multiple Azure subscriptions by reading from a target subscription list.

## Getting Started

To get started with these tools, clone this repository to your local machine or download the files directly. Ensure you have the necessary permissions in your Azure account to create and manage alert rules.

### Prerequisites

- PowerShell for running the provided scripts, PowerShell 7 is recommended
- Relatively up to date Azure Az modules installed and configured
- Necessary Azure permissions to create and manage metric alerts

### Usage

1. **Modify subscriptions.txt**: Ensure that your target subscriptions are represented as "/subscriptions/GUID" -- one subscription per line.
2. **Customize baseline-activitylog-alertrules.bicep**: The provided alert rules are only a sample of what is available.
3. **Run Create-ActivityLogAlerts.ps1**: Execute the PowerShell script with your specific parameters to create metric alerts in Azure Monitor.
```powershell
\Create-ActivityLogAlerts.ps1 -TargetSubscriptionFile "C:\subscriptions.txt" -TargetAlertRuleResourceGroupName "MyResourceGroup" -TargetAlertRuleResourceGroupRegion "East US"
```
### Example alerts created in each subscription
![example-alerts](https://github.com/marlobello/BicepTemplates/blob/main/AzureMonitor/example-activity-alerts.png?raw=true)

## License

This project is licensed under the MIT License - see the LICENSE file for details.