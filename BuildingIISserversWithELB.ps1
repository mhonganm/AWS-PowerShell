# This code creates an VPC, with 2 subnets. This code also launches one Windows Server 2012 
# instance to each of the subnets. While launching the instances, both are triggered with user 
# input that installs IIS-server. After that, code will create a new Elastic Load Balancer, 
# both instances are then associated with this ELB.


# Building a whole system
# Variables
$VPCCIDR = Read-Host -Prompt 'Give the CIDR, like a 192.168.0.0/16 ?'
$1stSubnetCIDR = Read-Host -Prompt 'Give the 1st subnet, like a 192.168.3.0/24 ?'
$2ndSubnetCIDR = Read-Host -Prompt 'Give the  2nd subnet, like a 192.168.4.0/24 ?'
$key = Read-Host -Prompt 'Input your keyname ?'
$type = Read-Host -Prompt 'Input the instance type ?'
Write-Host "just a minute, or two..."

$VPC = New-EC2Vpc -CidrBlock $VPCCIDR 
$AvailabilityZone1 = 'eu-west-1a' 
$AvailabilityZone2 = 'eu-west-1b'

$WebSubnet1 = New-EC2Subnet -VpcId $VPC.VpcId -CidrBlock $1stSubnetCIDR -AvailabilityZone $AvailabilityZone1 
$WebSubnet2 = New-EC2Subnet -VpcId $VPC.VpcId -CidrBlock $2ndSubnetCIDR -AvailabilityZone $AvailabilityZone2

$UserData = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(@' 
<powershell>
Install-WindowsFeature Web-Server -IncludeManagementTools -IncludeAllSubFeature 
</powershell> 
'@))

$AMI = Get-EC2ImageByName 'WINDOWS_2012_BASE' 
$Reservation1 = New-EC2Instance -ImageId $AMI[0].ImageId -KeyName $key -InstanceType $type -MinCount 1 -MaxCount 1 -SubnetId $WebSubnet1.SubnetId -UserData $UserData 
$Instance1 = $Reservation1.RunningInstance[0] 
$Reservation2 = New-EC2Instance -ImageId $AMI[0].ImageId -KeyName $key -InstanceType $type -MinCount 1 -MaxCount 1 -SubnetId $WebSubnet2.SubnetId -UserData $UserData 
$Instance2 = $Reservation2.RunningInstance[0] 

$ElbSubnet1 = New-EC2Subnet -VpcId $VPC.VpcId -CidrBlock '192.168.1.0/24' -AvailabilityZone $AvailabilityZone1 
$ElbSubnet2 = New-EC2Subnet -VpcId $VPC.VpcId -CidrBlock '192.168.2.0/24' -AvailabilityZone $AvailabilityZone2

$InternetGateway = New-EC2InternetGateway 
Add-EC2InternetGateway -InternetGatewayId $InternetGateway.InternetGatewayId -VpcId $VPC.VpcId

$PublicRouteTable = New-EC2RouteTable -VpcId $VPC.VpcId 
New-EC2Route -RouteTableId $PublicRouteTable.RouteTableId -DestinationCidrBlock '0.0.0.0/0' -GatewayId $InternetGateway.InternetGatewayId 
$NoEcho = Register-EC2RouteTable -RouteTableId $PublicRouteTable.RouteTableId -SubnetId $ElbSubnet1.SubnetId 
$NoEcho = Register-EC2RouteTable -RouteTableId $PublicRouteTable.RouteTableId -SubnetId $ElbSubnet2.SubnetId

$ElbGroupId = New-EC2SecurityGroup -GroupName 'ELB' -GroupDescription "Elastic Load Balancers" -VpcId $VPC.VpcId 
$HTTPRule = New-Object Amazon.EC2.Model.IpPermission 
$HTTPRule.IpProtocol='tcp' 
$HTTPRule.FromPort = 80 
$HTTPRule.ToPort = 80 
$HTTPRule.IpRanges = '0.0.0.0/0' 
$HTTPSRule = New-Object Amazon.EC2.Model.IpPermission
$HTTPSRule.IpProtocol='tcp'
$HTTPSRule.FromPort = 443
$HTTPSRule.ToPort = 443 
$HTTPSRule.IpRanges = '0.0.0.0/0' 
$NoEcho = Grant-EC2SecurityGroupIngress -GroupId $ElbGroupId -IpPermissions $HTTPRule, $HTTPSRule 	

$VPCFilter = New-Object Amazon.EC2.Model.Filter 
$VPCFilter.Name = 'vpc-id' 
$VPCFilter.Value = $VPC.VpcId 
$NameFilter = New-Object Amazon.EC2.Model.Filter 
$NameFilter.Name = 'group-name' 
$NameFilter.Value = 'default' 
$DefaultGroup = Get-EC2SecurityGroup -Filter $VPCFilter, $NameFilter

$HTTPListener = New-Object 'Amazon.ElasticLoadBalancing.Model.Listener' 
$HTTPListener.Protocol = 'http' 
$HTTPListener.LoadBalancerPort = 80 
$HTTPListener.InstancePort = 80

New-ELBLoadBalancer -LoadBalancerName 'WebLoadBalancer' -Subnets $ElbSubnet1.SubnetId, $ElbSubnet2.SubnetId -Listeners $HTTPListener -SecurityGroups $DefaultGroup.GroupId, $ElbGroupId
		
Set-ELBHealthCheck -LoadBalancerName 'WebLoadBalancer' -HealthCheck_Target 'HTTP:80/iisstart.htm' -HealthCheck_Interval 30 -HealthCheck_Timeout 5 -HealthCheck_HealthyThreshold 2 -HealthCheck_UnhealthyThreshold 10	

Register-ELBInstanceWithLoadBalancer -LoadBalancerName 'WebLoadBalancer' -Instances $Instance1.InstanceId, $Instance2.InstanceId
$tulema = (Get-ELBLoadBalancer -LoadBalancerName 'WebLoadBalancer').DNSName
Write-Host $tulema
