. "C:\Users\jshurak\Documents\GitHub\SQL-Assessment\lib\config.ps1"



foreach($Instance in $InstanceList)
{
    collect-database -InstanceName $Instance -Query $DatabaseQuery -OutputDirectory $OutputDirectory
}