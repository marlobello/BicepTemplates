# Azure Monitor Scaled Metric Alerts

This repository contains scripts and configuration files designed to facilitate the creation and management of scaled metric alerts in Azure Monitor. This tool can reduce the number of metric alerts that need to be created by an order of magnitude because it will create alerts for Azure resources across multiple subscriptions. It will also simply the process of creating identical alerts across multiple regions. All alerts will be created in a centralized resource group.

## Features

- **Automated Alert Rule Creation**: Scripts to automate the creation of a group of example metric alert rules in Azure Monitor, ensuring consistent monitoring across your Azure estate. Additional metrics can be monitored by adding them to the base-metric-multi-alertrules.bicep file. ONLY METRICS OUTLINED [HERE](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources-with-one-alert-rule) ARE SUPPORTED.
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
2. **Customize baseline-metric-multi-alertrules.bicep**: The provided alert rules are only a sample of what is available. [Azure Monitor Baseline Alerts](https://aka.ms/amba) is a good reference to identify desired alert rules as well as copy the bicep text from. Remember that only metrics outlined [here](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources-with-one-alert-rule) are supported by this repo.
3. **Run Create-Alerts.ps1**: Execute the PowerShell script with your specific parameters to create metric alerts in Azure Monitor.
```powershell
.\Create-Alerts.ps1 -AlertRuleSubscriptionName "MySubscription" -AlertRuleResourceGroupName "MyResourceGroup" -TargetSubscriptionFile "C:\subscriptions.txt" -TargetResourceRegion @("eastus", "westus")
```

![example-alerts](http://x)

## License

This project is licensed under the MIT License - see the LICENSE file for details.