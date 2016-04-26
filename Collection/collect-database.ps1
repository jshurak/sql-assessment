function collect-database {
    [CmdletBinding()]
	Param(
      [Parameter(Mandatory=$TRUE)]
	  [string]$InstanceName,
      [Parameter(Mandatory=$true)]
      [string]$Query,
      [Parameter(Mandatory=$true)]
      [string]$OutputDirectory
      )

    $OutputFile = "$OutputDirectory\Databases.csv"
    if(test-path $OutputFile)
    {
        Remove-Item $OutputFile
    }
    New-Item -ItemType file $OutputFile
    Add-Content -Path $OutputFile -Value "ServerName,DatabaseName,Page_verify_option_desc,recovery_model_desc,state,is_auto_close_on,is_auto_shrink_on,user_access_desc,collation_name,compatibility_level,is_auto_create_stats_on,size"

    Submit-SQLStatement -ServerInstance $InstanceName -Query $Query -Database 'master' | % {
        $ServerName = $_.ServerName
        $DatabaseName = $_.DatabaseName
        $PageVerifyOption = $_.Page_verify_option_desc
        $RecoveryModel = $_.recovery_model_desc
        $State = $_.state
        $AutoClose = $_.is_auto_close_on
        $AutoShrink = $_.is_auto_shrink_on
        $UserAccess = $_.user_access_desc
        $Collation = $_.collation_name
        $Compat = $_.compatibility_level
        $AutoStat = $_.is_auto_create_stats_on
        $Size = $_.size

        Add-Content -Path $OutputFile -Value "$ServerName,$DatabaseName,$PageVerifyOption,$RecoveryModel,$State,$AutoClose,$AutoShrink,$UserAccess,$Collation,$Compat,$AutoStat,$Size"

    }
}