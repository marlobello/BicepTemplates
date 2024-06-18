<#
.SYNOPSIS
This script creates common activity log alert rules in Azure across multiple subscriptions.

.DESCRIPTION
Activity Log alerts can only be assigned to a single subscription. This script reads a list of subscription IDs from a file and creates activity log alert rules in each subscription. The script takes in parameters for the target subscription file, the target alert rule resource group name, and the target alert rule resource group region. It ensures the user is logged into Azure, reads the target subscription IDs from the provided file, and then proceeds to create activity log alert rules based on the input parameters. The script uses a Bicep template file to deploy the alert rules.

.PARAMETER TargetSubscriptionFile
The path to a file containing a list of subscription IDs where the alert rule should be applied.

.PARAMETER TargetAlertRuleResourceGroupName
The name of the resource group within the target subscription for the alert rules to reside.

.PARAMETER TargetAlertRuleResourceGroupRegion
OPTIONAL: The region where the target resource group will be created (if it doesn't already exist). Default is "East US".

.EXAMPLE
.\Create-ActivityLogAlerts.ps1 -TargetSubscriptionFile "C:\subscriptions.txt" -TargetAlertRuleResourceGroupName "MyResourceGroup" -TargetAlertRuleResourceGroupRegion "East US"

This example creates activity log alert rules in the specified resource group for each subscription listed in "C:\subscriptions.txt" in the "East US" region.

.NOTES
Author: Marlo Bell
Date: 18 June 2024
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$TargetSubscriptionFile,
    
    [Parameter(Mandatory = $true)]
    [string]$TargetAlertRuleResourceGroupName,

    [Parameter(Mandatory = $false)]
    [string]$TargetAlertRuleResourceGroupRegion = "East US"
)

# login to Azure
if(-not (Get-AzContext)) {
    Connect-AzAccount
}

$subids = Get-Content $TargetSubscriptionFile

ForEach ($subid in $subids) {
    $guid = $subid.Split("/")[2]

    Select-AzSubscription -SubscriptionId $guid

    if(-not (Get-AzResourceGroup -Name $TargetAlertRuleResourceGroupName -ErrorAction SilentlyContinue)) {
        New-AzResourceGroup -Name $TargetAlertRuleResourceGroupName -Location $TargetAlertRuleResourceGroupRegion
    }

    New-AzResourceGroupDeployment -Name NewActivityLogsAlert -ResourceGroupname $TargetAlertRuleResourceGroupName -targetResourceId $subid -TemplateFile .\baseline-activitylog-multi-alertrules.bicep
}