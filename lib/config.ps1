$Global:RootDirectory = "C:\Users\jshurak\Documents\GitHub\SQL-Assessment"
$Global:ConfigDirectory = "$RootDirectory\lib"
$Global:QueryDirectory = "$RootDirectory\queries"
$Global:InstanceList = get-content "$ConfigDirectory\InstanceList.txt"

. "$ConfigDirectory\functions.ps1"