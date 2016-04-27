function collect-info {
    [CmdletBinding()]
	Param(
      [Parameter(Mandatory=$TRUE)]
	  [string]$InstanceName,
      [Parameter(Mandatory=$true)]
      [string]$Query,
      [Parameter(Mandatory=$true)]
      [string]$OutputDirectory,
      [Parameter(Mandatory=$true)]
      [string]$Module

      )

    $OutputFile = "$OutputDirectory\$Module.csv"
    if(test-path $OutputFile)
    {
        Remove-Item $OutputFile
    }
    New-Item -ItemType file $OutputFile
    
    
    $Results = Submit-SQLStatement -ServerInstance $InstanceName -Query $Query -Database 'master' 
    $Properties = $Results | Get-Member -MemberType properties | select name
    foreach($p in $Properties)
    {
        $Header = "$Header,$($p.name)"    
    }
    $Header = $Header.Substring(1)
    Add-Content -Path $OutputFile -Value $Header

    
   foreach($r in $Results)
   {
        foreach($p in $Properties)
        {
            $row = "$row,$($r.$($p.name))"
        }
        $row = $row.Substring(1)
     
        Add-Content -Path $OutputFile -Value $row
    }
}