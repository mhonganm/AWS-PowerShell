# Allowing Ping to Security Group
# Variable
$Group = Read-Host -Prompt 'Give the Group ID ?'
# Execution
$PingRule = New-Object Amazon.EC2.Model.IpPermission 
$PingRule.IpProtocol = 'icmp' 
$PingRule.FromPort = 8 
$PingRule.ToPort = -1 
$PingRule.IpRanges = '0.0.0.0/0' 
#
Grant-EC2SecurityGroupIngress -GroupId $Group -IpPermissions $PingRule
#
Write-Host " "
Write-Host "Ping is now allowed to SG: " $Group
	
