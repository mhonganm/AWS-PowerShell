#This code displays the information about S3 bucket.

# Bucket information
#
# Variables
$haku = Read-Host "Give the name of your bucket ?"
# Execution
$info = Get-S3Bucket -BucketName $haku
$info2 = Get-S3BucketLocation -BucketName $haku
# Output
Write-Host " "
Write-Host "Bucket was created in: " $info.CreationDate
Write-Host "It is in zone:" $info2
	
