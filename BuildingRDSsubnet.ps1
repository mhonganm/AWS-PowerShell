# This code creates an VPC for databases, with two new subnets. After VPC has configurated, 
# code tells RDS which subnets to use for database instances, by using a subnet group. When 
# RDS environment is ready, finally code launches a SQL Server instance as a database instance.

$VPC = New-EC2Vpc -CidrBlock '192.168.0.0/16'

$AvailabilityZone1 = 'eu-west-1a' 
$AvailabilityZone2 = 'eu-west-1b' 
$PrimarySubnet = New-EC2Subnet -VpcId $VPC.VpcId -CidrBlock '192.168.5.0/24' -AvailabilityZone $AvailabilityZone1 
$StandbySubnet = New-EC2Subnet -VpcId $VPC.VpcId -CidrBlock '192.168.6.0/24' -AvailabilityZone $AvailabilityZone2

New-RDSDBSubnetGroup -DBSubnetGroupName 'MySubnetGroup' -DBSubnetGroupDescription 'Pair of subnets for RDS' -SubnetIds $PrimarySubnet.SubnetId, $StandbySubnet.SubnetId 

$RDSGroupId = New-EC2SecurityGroup –VpcId $VPC.VpcId -GroupName 'RDS' -GroupDescription "RDS Instances" 

$VPCFilter = New-Object Amazon.EC2.Model.Filter 
$VPCFilter.Name = 'vpc-id' 
$VPCFilter.Value = $VPC.VpcId 
$GroupFilter = New-Object Amazon.EC2.Model.Filter 
$GroupFilter.Name = 'group-name' 
$GroupFilter.Value = 'default' 
$DefaultGroup = Get-EC2SecurityGroup -Filter $VPCFilter, $GroupFilter 
$DefaultGroupPair = New-Object Amazon.EC2.Model.UserIdGroupPair 
$DefaultGroupPair.GroupId = $DefaultGroup.GroupId

$SQLServerRule = New-Object Amazon.EC2.Model.IpPermission 
$SQLServerRule.IpProtocol='tcp' 
$SQLServerRule.FromPort = 1433 
$SQLServerRule.ToPort = 1433 
$SQLServerRule.UserIdGroupPair = $DefaultGroupPair
 
Grant-EC2SecurityGroupIngress -GroupId $RDSGroupId -IpPermissions $SQLServerRule

$MySQLRule = New-Object Amazon.EC2.Model.IpPermission 
$MySQLRule.IpProtocol='tcp' 
$MySQLRule.FromPort = 3306 
$MySQLRule.ToPort = 3306 
$MySQLRule.UserIdGroupPair = $DefaultGroupPair

Grant-EC2SecurityGroupIngress -GroupId $RDSGroupId -IpPermissions $MySQLRule 

# instance
New-RDSDBInstance -DBInstanceIdentifier 'SQLServer01' -Engine 'sqlserver-ex' -AllocatedStorage 20 -DBInstanceClass 'db.t1.micro' -MasterUsername 'sa' -MasterUserPassword 'password' -DBSubnetGroupName 'MySubnetGroup' -VpcSecurityGroupIds $GroupId 
 
