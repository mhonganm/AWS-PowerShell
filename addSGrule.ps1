# Adding rule to excisting security group

$Proto = Read-Host -Prompt 'Give the protocol, like a tcp ?'
$Port = Read-Host -Prompt 'Give the port number ?'
$Range = Read-Host -Prompt 'Give the IP range ?'
$Group = Read-Host -Prompt 'Give the Group ID ?'
$CustomRule = New-Object Amazon.EC2.Model.IpPermission 
$CustomRule.IpProtocol= $Proto 
$CustomRule.FromPort = $Port
$CustomRule.ToPort = $Port 
$CustomRule.IpRanges = $Range

Grant-EC2SecurityGroupIngress -GroupId $Group -IpPermissions $CustomRule
Write-Host " "
Write-Host "The protocol: " $CustomRule.IpProtocol
Write-Host "with Port: " $CustomRule.ToPort
Write-Host "and IP range: " $CustomRule.IpRanges
Write-Host "was added to: " $Group