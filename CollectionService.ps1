. "C:\Users\jshurak\Documents\GitHub\SQL-Assessment\lib\config.ps1"


$CreateHeader = 1
foreach($Instance in $InstanceList)
{
    collect-info -InstanceName $Instance -Query $DatabaseQuery -OutputDirectory $OutputDirectory -Module 'Database' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $WaitsQuery -OutputDirectory $OutputDirectory -Module 'WaitStats' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $SignalQuery -OutputDirectory $OutputDirectory -Module 'SignalWaits' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $BackupQuery -OutputDirectory $OutputDirectory -Module 'Backups' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $SConfigQuery -OutputDirectory $OutputDirectory -Module 'ServerConfiguration' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $DatabaseFileQuery -OutputDirectory $OutputDirectory -Module 'DatabaseFiles' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $LoginQuery -OutputDirectory $OutputDirectory -Module 'LoginInfo' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $ServerQuery -OutputDirectory $OutputDirectory -Module 'ServerInfo' -CreateHeader $CreateHeader
    collect-info -InstanceName $Instance -Query $FileStallQuery -OutputDirectory $OutputDirectory -Module 'FileStallInfo' -CreateHeader $CreateHeader
    $CreateHeader = 0
}