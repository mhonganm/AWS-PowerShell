# Copying Snapshot from one region to another
# Variables
$From = Read-Host -Prompt 'Input your source region?'
$Where = Read-Host -Prompt 'Input your destination region?'
$Shotcopy = Read-Host -Prompt 'Input the snapshot id?'
$Desc = Read-Host -Prompt 'Give an Descrpition of the snapshot?'
# Execution
Copy-EC2Snapshot -SourceRegion $From -SourceSnapshotId $Shotcopy -Region $Where -Description $Desc