# Variables
$key = Read-Host -Prompt 'Input your keyname'
$type = Read-Host -Prompt 'Input the instance type'
$min = Read-Host -Prompt 'Input your minimum count'
$max = Read-Host -Prompt 'Input your maximum count'
$AMI = Get-EC2ImageByName -Name 'WINDOWS_2012_BASE' 
# Execution
New-EC2Instance -ImageId $AMI[0].ImageId -KeyName $key -InstanceType $type -MinCount $min -MaxCount $max