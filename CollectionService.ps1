. "C:\Users\jshurak\Documents\GitHub\SQL-Assessment\lib\config.ps1"



foreach($Instance in $InstanceList)
{
    collect-info -InstanceName $Instance -Query $DatabaseQuery -OutputDirectory $OutputDirectory -Module 'Database'
    collect-info -InstanceName $Instance -Query $WaitsQuery -OutputDirectory $OutputDirectory -Module 'WaitStats'
    collect-info -InstanceName $Instance -Query $SignalQuery -OutputDirectory $OutputDirectory -Module 'SignalWaits'
    collect-info -InstanceName $Instance -Query $BackupQuery -OutputDirectory $OutputDirectory -Module 'Backups'
    collect-info -InstanceName $Instance -Query $SConfigQuery -OutputDirectory $OutputDirectory -Module 'ServerConfiguration'
    collect-info -InstanceName $Instance -Query $DatabaseFileQuery -OutputDirectory $OutputDirectory -Module 'DatabaseFiles'
    collect-info -InstanceName $Instance -Query $LoginQuery -OutputDirectory $OutputDirectory -Module 'LoginInfo'
}