#This code was my first "automation" code for AWS. In this code user is working with in his default zone and has 
#stored his credentials with Set-DefaultAWSRegion and Set-AWSCredentials commands. While running this script, 
#user is asked for his keyfile name, what type of instance he wants to launch and setting minimum and maximum 
#numbers for the instances.


# Variables
$key = Read-Host -Prompt 'Input your keyname'
$type = Read-Host -Prompt 'Input the instance type'
$min = Read-Host -Prompt 'Input your minimum count'
$max = Read-Host -Prompt 'Input your maximum count'
$AMI = Get-EC2ImageByName -Name 'WINDOWS_2012_BASE' 
# Execution
New-EC2Instance -ImageId $AMI[0].ImageId -KeyName $key -InstanceType $type -MinCount $min -MaxCount $max
