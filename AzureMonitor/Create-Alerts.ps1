$subids = Get-Content subscription-ids.txt

New-AzResourceGroupDeployment -Name NewMultiAlert1 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion eastus -targetResourceId $subids -TemplateFile .\baseline-metric-multi-alertrules.bicep
New-AzResourceGroupDeployment -Name NewMultiAlert2 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion westus -targetResourceId $subids -TemplateFile .\baseline-metric-multi-alertrules.bicep