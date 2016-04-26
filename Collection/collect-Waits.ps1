function collect-waits {
    [CmdletBinding()]
	Param(
      [Parameter(Mandatory=$TRUE)]
	  [string]$InstanceName,
      [Parameter(Mandatory=$true)]
      [string]$Query,
      [Parameter(Mandatory=$true)]
      [string]$OutputDirectory
      )

    $OutputFile = "$OutputDirectory\Waits.csv"
    if(test-path $OutputFile)
    {
        Remove-Item $OutputFile
    }
    New-Item -ItemType file $OutputFile
    Add-Content -Path $OutputFile -Value "ServerName,WaitType,Wait_Sec,Resource_Sec,Signal_sec,Wait_Count,Wait_Percentage,AvgWait_Sec,AvgRes_Sec,AvgSig_Sec"

    Submit-SQLStatement -ServerInstance $InstanceName -Query $Query -Database 'master' | % {
        $ServerName = $_.ServerName
        $WaitType = $_.WaitType
        $Wait_Sec = $_.Wait_Sec
        $Resource_Sec = $_.Resource_Sec
        $Signal_sec = $_.Signal_sec
        $Wait_Count = $_.Wait_Count
        $Wait_Percentage = $_.Wait_Percentage
        $AvgWait_Sec = $_.AvgWait_Sec
        $AvgRes_Sec = $_.AvgRes_Sec
        $AvgSig_Sec = $_.AvgSig_Sec

        Add-Content -Path $OutputFile -Value "$ServerName,$WaitType,$Wait_Sec,$Resource_Sec,$Signal_sec,$Wait_Count,$Wait_Percentage,$AvgWait_Sec,$AvgRes_Sec,$AvgSig_Sec"

    }
}