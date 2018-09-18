# Adding tags to instances
# Variables
$instanssi = Read-Host -Prompt 'Input your instance ID you wanna Tag ?'
$tagkey = Read-Host -Prompt 'Input the name of the tag ?'
$tagvalue = Read-Host -Prompt 'Input the value for the tag ?'
# Execution
$Reservation = Get-EC2Instance -Instance $instanssi
$InstanceId = $Reservation.RunningInstance[0].InstanceId 
$Tag = New-Object Amazon.EC2.Model.Tag 
$Tag.Key = $tagkey 
$Tag.Value = $tagvalue 
New-EC2Tag -ResourceId $InstanceId -Tag $Tag
