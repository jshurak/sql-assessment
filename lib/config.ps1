$Global:RootDirectory = "C:\Users\jshurak\Documents\GitHub\SQL-Assessment"
$Global:ConfigDirectory = "$RootDirectory\lib"
$Global:QueryDirectory = "$RootDirectory\queries"
$Global:InstanceList = get-content "$ConfigDirectory\InstanceList.txt"
$Global:OutputDirectory = "$RootDirectory\output\"
$Global:DatabaseQuery = [io.file]::ReadAllText("$QueryDirectory\DatabaseCollection.sql")
$Global:InstanceQuery = [io.file]::ReadAllText("$QueryDirectory\InstanceCollection.sql")
. "$ConfigDirectory\functions.ps1"