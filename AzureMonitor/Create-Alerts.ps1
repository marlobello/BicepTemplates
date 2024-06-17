$subids = Get-Content subscription-ids.txt

New-AzResourceGroupDeployment -Name NewMultiAlert1 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion eastus -targetResourceId $subids -TemplateParameterFile .\sql-avail-alertrule.bicepparam
New-AzResourceGroupDeployment -Name NewMultiAlert2 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion eastus -targetResourceId $subids -TemplateParameterFile .\sql-cpu-alertrule.bicepparam
New-AzResourceGroupDeployment -Name NewMultiAlert3 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion eastus -targetResourceId $subids -TemplateParameterFile .\srv-backuphealth-alertrule.bicepparam
New-AzResourceGroupDeployment -Name NewMultiAlert4 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion eastus -targetResourceId $subids -TemplateParameterFile .\vm-cpu-alertrule.bicepparam
New-AzResourceGroupDeployment -Name NewMultiAlert5 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion westus -targetResourceId $subids -TemplateParameterFile .\sql-avail-alertrule.bicepparam
New-AzResourceGroupDeployment -Name NewMultiAlert6 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion westus -targetResourceId $subids -TemplateParameterFile .\sql-cpu-alertrule.bicepparam
New-AzResourceGroupDeployment -Name NewMultiAlert7 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion westus -targetResourceId $subids -TemplateParameterFile .\srv-backuphealth-alertrule.bicepparam
New-AzResourceGroupDeployment -Name NewMultiAlert8 -ResourceGroupName enterprise-alert-rules-rg -targetResourceRegion westus -targetResourceId $subids -TemplateParameterFile .\vm-cpu-alertrule.bicepparam