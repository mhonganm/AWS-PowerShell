# Lauanching new 2012 server, user is asked for key and type, with adding tags for user input name, volumeID and nicID 
# Variables
$key = Read-Host -Prompt 'Input your keyname ?'
$type = Read-Host -Prompt 'Input the instance type ?'
$tagkey = Read-Host -Prompt 'Input the name of the tag ?'
$tagvalue = Read-Host -Prompt 'Input the value for the tag ?'
# Execution
$AMI = Get-EC2ImageByName -Name 'WINDOWS_2012_BASE' 
$Reservation = New-EC2Instance -ImageId $AMI[0].ImageId -KeyName $key -InstanceType $type -MinCount 1 -MaxCount 1 
$InstanceId = $Reservation.RunningInstance[0].InstanceId
Start-Sleep -s 120
# Wait for drives to be mounted, etc.
$Machine = Get-EC2Instance -Instance $InstanceId
$VolumeId = $Machine.RunningInstance[0].BlockDeviceMappings.EBS.VolumeId
$NetworkInterfaceId = $Machine.RunningInstance[0].NetworkInterfaces.NetworkInterfaceId
$Tag = New-Object Amazon.EC2.Model.Tag
$Tag.Key = $tagkey
$Tag.Value = $tagvalue
New-EC2Tag -ResourceId $InstanceId -Tag $Tag
$Tag2 = New-Object Amazon.EC2.Model.Tag
$Tag2.Key = 'Volume ID'
$Tag2.Value = $VolumeId
New-EC2Tag -ResourceId $InstanceId -Tag $Tag2
$Tag3 = New-Object Amazon.EC2.Model.Tag
$Tag3.Key = 'Network interface ID'
$Tag3.Value = $NetworkInterfaceId
New-EC2Tag -ResourceId $InstanceId -Tag $Tag3
		   			   			   			 