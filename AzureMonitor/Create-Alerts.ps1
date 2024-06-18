<#
.SYNOPSIS
This script creates alert rules in Azure across multiple subscriptions and regions.

.DESCRIPTION
The script takes in parameters for a specific alert rule's subscription name, resource group name, a file containing target subscription IDs, and target resource regions. It ensures the user is logged into Azure, reads the target subscription IDs from the provided file, and then proceeds to create alert rules based on the input parameters.

.PARAMETER AlertRuleSubscriptionName
The name of the subscription where the alert rule is to be created.

.PARAMETER AlertRuleResourceGroupName
The name of the resource group within the subscription for the alert rule.

.PARAMETER TargetSubscriptionFile
The path to a file containing a list of subscription IDs where the alert rule should be applied.

.PARAMETER TargetResourceRegions
An array of regions where the alert rule should be applied.

.EXAMPLE
.\Create-Alerts.ps1 -AlertRuleSubscriptionName "MySubscription" -AlertRuleResourceGroupName "MyResourceGroup" -TargetSubscriptionFile "C:\subscriptions.txt" -TargetResourceRegion @("eastus", "westus")

This example creates an alert rule in the specified subscription and resource group, targeting the subscriptions listed in "C:\subscriptions.txt" and in the "eastus" and "westus" regions.

.NOTES
Author: Marlo Bell
Date: 18 June 2024
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$AlertRuleSubscriptionName,

    [Parameter(Mandatory = $true)]
    [string]$AlertRuleResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$TargetSubscriptionFile,

    [Parameter(Mandatory = $true)]
    [array]$TargetResourceRegions

)

$context = Get-AzContext

if(!$context)
{
    Write-Host "Please login to Azure"
    Connect-AzAccount
}

$subids = Get-Content $TargetSubscriptionFile

# login to Azure
if(-not (Get-AzContext)) {
    Connect-AzAccount
}

Select-AzSubscription -SubscriptionName $AlertRuleSubscriptionName

ForEach ($region in $TargetResourceRegions) {
    New-AzResourceGroupDeployment -Name "NewMultiAlertRule-$region" -ResourceGroupName $AlertRuleResourceGroupName -targetResourceRegion $region -targetResourceId $subids -TemplateFile .\baseline-metric-multi-alertrules.bicep
}