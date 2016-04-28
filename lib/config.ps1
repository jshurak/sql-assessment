
$Global:RootDirectory = "C:\Users\jshurak\Documents\GitHub\SQL-Assessment"
$Global:ConfigDirectory = "$RootDirectory\lib"
$Global:QueryDirectory = "$RootDirectory\queries"
$Global:InstanceList = get-content "$ConfigDirectory\InstanceList.txt"
$Global:OutputDirectory = "$RootDirectory\output\"
$Global:DatabaseQuery = [io.file]::ReadAllText("$QueryDirectory\DatabaseCollection.sql")
$Global:DatabaseFileQuery = [io.file]::ReadAllText("$QueryDirectory\DatabaseFileCollection.sql")
$Global:InstanceQuery = [io.file]::ReadAllText("$QueryDirectory\InstanceCollection.sql")
$Global:WaitsQuery = [io.file]::ReadAllText("$QueryDirectory\WaitCollection.sql")
$Global:SignalQuery = [io.file]::ReadAllText("$QueryDirectory\SignalCollection.sql")
$Global:BackupQuery = [io.file]::ReadAllText("$QueryDirectory\BackupCollection.sql")
$Global:SConfigQuery = [io.file]::ReadAllText("$QueryDirectory\ServerConfigurationsCollection.sql")
$Global:LoginQuery = [io.file]::ReadAllText("$QueryDirectory\LoginCountCollection.sql")
$Global:ServerQuery = [io.file]::ReadAllText("$QueryDirectory\ServerCollection.sql")
$Global:FileStallQuery = [io.file]::ReadAllText("$QueryDirectory\FileStallCollection.sql")
$Global:LoggingDirectory = "$ROOTDIRECTORY\Logs\"
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null

$Modules = @('Database','WaitStats','SignalWaits','Backups','ServerConfiguration','DatabaseFiles','LoginInfo','ServerInfo','FileStallInfo')
foreach($m in $Modules)
{
    $OutputFile = "$OutputDirectory\$m.csv"
    if(test-path $OutputFile)
    {
        Remove-Item $OutputFile
    }
    New-Item -ItemType file $OutputFile
}
. "$ConfigDirectory\functions.ps1"
. "$RootDirectory\Collection\collect-info.ps1"