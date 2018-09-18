# Lauanching new 2012 server, user is asked for key and type, one volume with Size and IOPS.
# Variables
$key = Read-Host -Prompt 'Input your keyname?'
$type = Read-Host -Prompt 'Input the instance type?'
$Rootvolume = Read-Host -Prompt 'Input the root volume size?'
$DesiredIOPS = Read-Host -Prompt 'Input the desired IOPS?'	
# Creating volumes
$Volume = New-Object Amazon.EC2.Model.EbsBlockDevice 
$Volume.DeleteOnTermination = $True 
$Volume.VolumeSize = $Rootvolume 
$Volume.VolumeType = 'io1' 
$volume.IOPS = $DesiredIOPS 
$Mapping = New-Object Amazon.EC2.Model.BlockDeviceMapping 
$Mapping.DeviceName = '/dev/sda1' 
$Mapping.Ebs = $Volume 
# Execution
$AMI = Get-EC2ImageByName -Name 'WINDOWS_2012_BASE' 
$Reservation = New-EC2Instance -ImageId $AMI[0].ImageId -KeyName $key -InstanceType $type -MinCount 1 -MaxCount 1 
	-BlockDeviceMapping $Mapping -EbsOptimized:$true 
$Instance = $Reservation.RunningInstance[0] 
