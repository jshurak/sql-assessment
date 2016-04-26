function collect-signalwaits {
    [CmdletBinding()]
	Param(
      [Parameter(Mandatory=$TRUE)]
	  [string]$InstanceName,
      [Parameter(Mandatory=$true)]
      [string]$Query,
      [Parameter(Mandatory=$true)]
      [string]$OutputDirectory
      )

    $OutputFile = "$OutputDirectory\SignalWaits.csv"
    if(test-path $OutputFile)
    {
        Remove-Item $OutputFile
    }
    New-Item -ItemType file $OutputFile
    Add-Content -Path $OutputFile -Value "ServerName,Signal_Waits,Resource_Waits"

    Submit-SQLStatement -ServerInstance $InstanceName -Query $Query -Database 'master' | % {
        $ServerName = $_.ServerName
        $Signal_Waits = $_.Signal_Waits
        $Resource_Waits = $_.Resource_Waits

        Add-Content -Path $OutputFile -Value "$ServerName,$Signal_Waits,$Resource_Waits"

    }
}