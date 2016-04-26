function collect-backups {
    [CmdletBinding()]
	Param(
      [Parameter(Mandatory=$TRUE)]
	  [string]$InstanceName,
      [Parameter(Mandatory=$true)]
      [string]$Query,
      [Parameter(Mandatory=$true)]
      [string]$OutputDirectory
      )

    $OutputFile = "$OutputDirectory\backups.csv"
    if(test-path $OutputFile)
    {
        Remove-Item $OutputFile
    }
    New-Item -ItemType file $OutputFile
    Add-Content -Path $OutputFile -Value "ServerName,DatabaseName,Recovery_model_desc,LastFullBackup,LastLogBackup,LastDiffBackup,LastFileGroupBackup,LastFileGroupDiffBackup,LastPartialBackup,LastPartialDiffBackup"

    Submit-SQLStatement -ServerInstance $InstanceName -Query $Query -Database 'master' | % {
        $ServerName = $_.ServerName
        $DatabaseName = $_.DatabaseName
        $Recovery_model_desc = $_.Recovery_model_desc
        $LastFullBackup = $_.LastFullBackup
        $LastLogBackup = $_.LastLogBackup
        $LastDiffBackup = $_.LastDiffBackup
        $LastFileGroupBackup = $_.LastFileGroupBackup
        $LastFileGroupDiffBackup = $_.LastFileGroupDiffBackup
        $LastPartialBackup = $_.LastPartialBackup
        $LastPartialDiffBackup = $_.LastPartialDiffBackup

        Add-Content -Path $OutputFile -Value "$ServerName,$DatabaseName,$Recovery_model_desc,$LastFullBackup,$LastLogBackup,$LastDiffBackup,$LastFileGroupBackup,$LastFileGroupDiffBackup,$LastPartialBackup,$LastPartialDiffBackup"

    }
}