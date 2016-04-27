. "C:\Users\jshurak\Documents\GitHub\SQL-Assessment\lib\config.ps1"



foreach($Instance in $InstanceList)
{
    collect-database -InstanceName $Instance -Query $DatabaseQuery -OutputDirectory $OutputDirectory
    collect-waits -InstanceName $Instance -Query $WaitsQuery -OutputDirectory $OutputDirectory
    collect-signalwaits -InstanceName $Instance -Query $SignalQuery -OutputDirectory $OutputDirectory
    collect-backups -InstanceName $Instance -Query $BackupQuery -OutputDirectory $OutputDirectory
}