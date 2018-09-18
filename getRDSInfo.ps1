Code:

$rdpinst = Read-Host -Prompt 'Imput your RDBinstance name ?'

$DBInstance = Get-RDSDBInstance -DBInstanceIdentifier $rdpinst 
$days = $DBInstance.BackupRetentionPeriod
Write-Host "Latest backup was taken: " $DBInstance.LatestRestorableTime 
Write-host "There are backups from the last $days days" 
	