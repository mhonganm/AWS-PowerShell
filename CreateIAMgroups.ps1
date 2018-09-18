# This code creates five different user groups, each have kind of rights. 
# Groups are Users, Admins, Developers, Network Admins and System Admins.

# Users
$Policy = @"
{  
"Statement": [ 
   {
   "Effect": "Allow",
   "Action": [         
        "iam:ChangePassword",
        "iam:GetAccountPasswordPolicy"
        ],
   "Resource": "*"
   }  
 ] 
} 
"@ 
New-IAMGroup -GroupName "USERS" 
Write-IAMGroupPolicy -GroupName "USERS" -PolicyName "USERS-ChangePassword" -PolicyDocument $Policy

# Admins
$Policy = @"
{  
    "Statement": [
        {      
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"    
         }  
   ] 
}
"@ 
New-IAMGroup -GroupName "ADMINS" 
Write-IAMGroupPolicy -GroupName "ADMINS" -PolicyName "ADMINS-FullControl" -PolicyDocument $Policy

# Developers
$Policy = @"
{  
    "Statement": [
        {      
           "Effect": "Allow",
           "Action": [        
                "ec2:AttachVolume",        
                "ec2:CopySnapshot",        
                "ec2:CreateKeyPair",        
                "ec2:CreateSnapshot",        
                "ec2:CreateTags",        
                "ec2:CreateVolume",        
                "ec2:DeleteKeyPair",        
                "ec2:DeleteSnapshot",        
                "ec2:DeleteTags",        
                "ec2:DeleteVolume",        
                "ec2:DescribeAddresses",        
                "ec2:DescribeAvailabilityZones",        
                "ec2:DescribeBundleTasks",        
                "ec2:DescribeConversionTasks",        
                "ec2:DescribeCustomerGateways",        
                "ec2:DescribeDhcpOptions",        
                "ec2:DescribeExportTasks",        
                "ec2:DescribeImageAttribute",        
                "ec2:DescribeImages",        
                "ec2:DescribeInstanceAttribute",        
                "ec2:DescribeInstances",        
                "ec2:DescribeInstanceStatus",        
                "ec2:DescribeInternetGateways",        
                "ec2:DescribeKeyPairs",        
                "ec2:DescribeLicenses",        
                "ec2:DescribeNetworkAcls",        
                "ec2:DescribeNetworkInterfaceAttribute",        
                "ec2:DescribeNetworkInterfaces",        
                "ec2:DescribePlacementGroups",        
                "ec2:DescribeRegions",        
                "ec2:DescribeReservedInstances",        
                "ec2:DescribeReservedInstancesOfferings",        
                "ec2:DescribeRouteTables",        
                "ec2:DescribeSecurityGroups",        
                "ec2:DescribeSnapshotAttribute",        
                "ec2:DescribeSnapshots",        
                "ec2:DescribeSpotDatafeedSubscription",
                "ec2:DescribeSpotInstanceRequests",        
                "ec2:DescribeSpotPriceHistory",        
                "ec2:DescribeSubnets",        
                "ec2:DescribeTags",        
                "ec2:DescribeVolumeAttribute",        
                "ec2:DescribeVolumes",        
                "ec2:DescribeVolumeStatus",        
                "ec2:DescribeVpcs",        
                "ec2:DescribeVpnConnections",        
                "ec2:DescribeVpnGateways",        
                "ec2:DetachVolume",        
                "ec2:EnableVolumeIO",        
                "ec2:GetConsoleOutput",        
                "ec2:GetPasswordData",        
                "ec2:ImportKeyPair",        
                "ec2:ModifyInstanceAttribute",        
                "ec2:ModifySnapshotAttribute",        
                "ec2:ModifyVolumeAttribute",        
                "ec2:MonitorInstances",        
                "ec2:RebootInstances",        
                "ec2:ReportInstanceStatus",        
                "ec2:ResetInstanceAttribute",        
                "ec2:ResetSnapshotAttribute",        
                "ec2:RunInstances",        
                "ec2:StartInstances",        
                "ec2:StopInstances",        
                "ec2:TerminateInstances",        
                "ec2:UnmonitorInstances",        
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer"      ],      
                "Resource": "*"    
         }  
     ] 
} 
"@ 
New-IAMGroup -GroupName "DEVELOPERS" 
Write-IAMGroupPolicy -GroupName "DEVELOPERS" -PolicyName "DEVELOPERS-ManageInstances" -PolicyDocument $Policy
#Network admins
$Policy = @" 
{  
    "Statement": [    
        {      
            "Effect": "Allow",      
            "Action": [
                "directconnect:*",        
                "ec2:AllocateAddress",
                "ec2:AssociateAddress",        
                "ec2:AssociateDhcpOptions",        
                "ec2:AssociateRouteTable",        
                "ec2:AttachInternetGateway",        
                "ec2:AttachNetworkInterface",        
                "ec2:AttachVpnGateway",        
                "ec2:AuthorizeSecurityGroupEgress",        
                "ec2:AuthorizeSecurityGroupIngress",        
                "ec2:CreateCustomerGateway",        
                "ec2:CreateDhcpOptions",        
                "ec2:CreateInternetGateway",        
                "ec2:CreateNetworkAcl",        
                "ec2:CreateNetworkAclEntry",        
                "ec2:CreateNetworkInterface",        
                "ec2:CreateRoute",        
                "ec2:CreateRouteTable",        
                "ec2:CreateSecurityGroup",        
                "ec2:CreateSubnet",        
                "ec2:CreateTags",        
                "ec2:CreateVpc",        
                "ec2:CreateVpnConnection",        
                "ec2:CreateVpnGateway",        
                "ec2:DeleteCustomerGateway",        
                "ec2:DeleteDhcpOptions",        
                "ec2:DeleteInternetGateway",        
                "ec2:DeleteNetworkAcl",        
                "ec2:DeleteNetworkAclEntry",        
                "ec2:DeleteNetworkInterface",        
                "ec2:DeleteRoute",        
                "ec2:DeleteRouteTable",        
                "ec2:DeleteSecurityGroup",        
                "ec2:DeleteSubnet",        
                "ec2:DeleteTags",        
                "ec2:DeleteVpc",        
                "ec2:DeleteVpnConnection",        
                "ec2:DeleteVpnGateway",        
                "ec2:DescribeAddresses",        
                "ec2:DescribeAvailabilityZones",        
                "ec2:DescribeBundleTasks",        
                "ec2:DescribeConversionTasks",        
                "ec2:DescribeCustomerGateways",        
                "ec2:DescribeDhcpOptions",        
                "ec2:DescribeExportTasks",        
                "ec2:DescribeImageAttribute",        
                "ec2:DescribeImages",       
                "ec2:DescribeInstanceAttribute",        
                "ec2:DescribeInstances",        
                "ec2:DescribeInstanceStatus",        
                "ec2:DescribeInternetGateways",        
                "ec2:DescribeKeyPairs",        
                "ec2:DescribeLicenses",
                "ec2:DescribeNetworkAcls",        
                "ec2:DescribeNetworkInterfaceAttribute",        
                "ec2:DescribeNetworkInterfaces",        
                "ec2:DescribePlacementGroups",        
                "ec2:DescribeRegions",        
                "ec2:DescribeReservedInstances",        
                "ec2:DescribeReservedInstancesOfferings",        
                "ec2:DescribeRouteTables",        
                "ec2:DescribeSecurityGroups",        
                "ec2:DescribeSnapshotAttribute",        
                "ec2:DescribeSnapshots",        
                "ec2:DescribeSpotDatafeedSubscription",        
                "ec2:DescribeSpotInstanceRequests",        
                "ec2:DescribeSpotPriceHistory",        
                "ec2:DescribeSubnets",        
                "ec2:DescribeTags",        
                "ec2:DescribeVolumeAttribute",        
                "ec2:DescribeVolumes",        
                "ec2:DescribeVolumeStatus",        
                "ec2:DescribeVpcs",        
                "ec2:DescribeVpnConnections",        
                "ec2:DescribeVpnGateways",        
                "ec2:DetachInternetGateway",        
                "ec2:DetachNetworkInterface",        
                "ec2:DetachVpnGateway",        
                "ec2:DisassociateAddress",        
                "ec2:DisassociateRouteTable",        
                "ec2:GetConsoleOutput",        
                "ec2:GetPasswordData",        
                "ec2:ModifyNetworkInterfaceAttribute",        
                "ec2:MonitorInstances",        
                "ec2:ReleaseAddress",        
                "ec2:ReplaceNetworkAclAssociation",        
                "ec2:ReplaceNetworkAclEntry",        
                "ec2:ReplaceRoute",        
                "ec2:ReplaceRouteTableAssociation",        
                "ec2:ResetNetworkInterfaceAttribute",        
                "ec2:RevokeSecurityGroupEgress",        
                "ec2:RevokeSecurityGroupIngress",        
                "ec2:UnmonitorInstances",        
                "elasticloadbalancing:ConfigureHealthCheck",        
                "elasticloadbalancing:CreateAppCookieStickinessPolicy",        
                "elasticloadbalancing:CreateLBCookieStickinessPolicy",        
                "elasticloadbalancing:CreateLoadBalancer",        
                "elasticloadbalancing:CreateLoadBalancerListeners",        
                "elasticloadbalancing:DeleteLoadBalancer",        
                "elasticloadbalancing:DeleteLoadBalancerListeners",        
                "elasticloadbalancing:DeleteLoadBalancerPolicy",        
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",        
                "elasticloadbalancing:DescribeInstanceHealth",        
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DisableAvailabilityZonesForLoadBalancer",        
                "elasticloadbalancing:EnableAvailabilityZonesForLoadBalancer",        
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",        
                "elasticloadbalancing:SetLoadBalancerListenerSSLCertificate",        
                "elasticloadbalancing:SetLoadBalancerPoliciesOfListener"      
                ],      
                "Resource": "*"    
            }  
       ] 
} 
"@ 
New-IAMGroup -GroupName "NETWORK_ADMINS" 
Write-IAMGroupPolicy -GroupName "NETWORK_ADMINS" -PolicyName "NETWORK_ADMINS-ManageNetwork" -PolicyDocument $Policy 
# System admins
$Policy = @" 
{  
    "Statement": [
        {      
            "Effect": "Allow",      
            "Action": [        
                "ec2:AttachVolume",        
                "ec2:CancelConversionTask",        
                "ec2:CancelExportTask",        
                "ec2:CancelSpotInstanceRequests",        
                "ec2:CopySnapshot",        
                "ec2:CreateImage",        
                "ec2:CreateInstanceExportTask",        
                "ec2:CreateKeyPair",        
                "ec2:CreatePlacementGroup",        
                "ec2:CreateSnapshot",        
                "ec2:CreateSpotDatafeedSubscription",        
                "ec2:CreateTags",        
                "ec2:CreateVolume",        
                "ec2:DeleteKeyPair",        
                "ec2:DeletePlacementGroup",        
                "ec2:DeleteSnapshot",        
                "ec2:DeleteSpotDatafeedSubscription",        
                "ec2:DeleteTags",        
                "ec2:DeleteVolume",        
                "ec2:DeregisterImage",        
                "ec2:DescribeAddresses",        
                "ec2:DescribeAvailabilityZones",        
                "ec2:DescribeBundleTasks",        
                "ec2:DescribeConversionTasks",        
                "ec2:DescribeCustomerGateways",
                "ec2:DescribeDhcpOptions",        
                "ec2:DescribeExportTasks",        
                "ec2:DescribeImageAttribute",        
                "ec2:DescribeImages",        
                "ec2:DescribeInstanceAttribute",        
                "ec2:DescribeInstances",        
                "ec2:DescribeInstanceStatus",        
                "ec2:DescribeInternetGateways",        
                "ec2:DescribeKeyPairs",        
                "ec2:DescribeLicenses",        
                "ec2:DescribeNetworkAcls",        
                "ec2:DescribeNetworkInterfaceAttribute",        
                "ec2:DescribeNetworkInterfaces",        
                "ec2:DescribePlacementGroups",        
                "ec2:DescribeRegions",        
                "ec2:DescribeReservedInstances",        
                "ec2:DescribeReservedInstancesOfferings",        
                "ec2:DescribeRouteTables",        
                "ec2:DescribeSecurityGroups",        
                "ec2:DescribeSnapshotAttribute",        
                "ec2:DescribeSnapshots",        
                "ec2:DescribeSpotDatafeedSubscription",        
                "ec2:DescribeSpotInstanceRequests",        
                "ec2:DescribeSpotPriceHistory",        
                "ec2:DescribeSubnets",        
                "ec2:DescribeTags",        
                "ec2:DescribeVolumeAttribute",        
                "ec2:DescribeVolumes",        
                "ec2:DescribeVolumeStatus",        
                "ec2:DescribeVpcs",        
                "ec2:DescribeVpnConnections",        
                "ec2:DescribeVpnGateways",        
                "ec2:DetachVolume",        
                "ec2:EnableVolumeIO",        
                "ec2:GetConsoleOutput",        
                "ec2:GetPasswordData",        
                "ec2:ImportInstance",        
                "ec2:ImportKeyPair",        
                "ec2:ImportVolume",        
                "ec2:ModifyImageAttribute",        
                "ec2:ModifyInstanceAttribute",        
                "ec2:ModifySnapshotAttribute",        
                "ec2:ModifyVolumeAttribute",        
                "ec2:MonitorInstances",        
                "ec2:PurchaseReservedInstancesOffering",        
                "ec2:RebootInstances",        
                "ec2:RegisterImage",        
                "ec2:ReportInstanceStatus",        
                "ec2:RequestSpotInstances",        
                "ec2:ResetImageAttribute",        
                "ec2:ResetInstanceAttribute",
                "ec2:ResetSnapshotAttribute",        
                "ec2:RunInstances",        
                "ec2:StartInstances",        
                "ec2:StopInstances",       
                "ec2:TerminateInstances",        
                "ec2:UnmonitorInstances"      
                ],      
                "Resource": "*"    
             }  
       ] 
       } 
"@ 
New-IAMGroup -GroupName "SYS_ADMINS" 
Write-IAMGroupPolicy -GroupName "SYS_ADMINS" -PolicyName "SYS_ADMINS-ManageImages" -PolicyDocument $Policy 
