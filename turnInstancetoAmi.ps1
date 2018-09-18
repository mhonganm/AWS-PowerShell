# Creating new AMI from instance
# Variables
$Insta = Read-Host -Prompt 'Give the instance ID ?'
$Name = Read-Host -Prompt 'Give the name for your AMI ?'
$Desc = Read-Host -Prompt 'Give the description for your AMI ?'
# Execution
$AMIID = New-EC2Image -InstanceId $Insta -Name $Name -Description $Desc

$AMI = Get-EC2Image $AMIID 
While($AMI.ImageState -ne "available") { 
        $AMI = Get-EC2Image $AMIID 
        Start-Sleep -Seconds 15 
        }
	