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
      [string]$Module,
      [Parameter(Mandatory=$true)]
      [int32]$CreateHeader

      )

    $OutputFile = "$OutputDirectory\$Module.csv"

   try{ 
    #test sql connection
    $InstanceObject = New-Object('Microsoft.SqlServer.Management.Smo.Server') $Instancename
        if($InstanceObject.ComputerNamePhysicalNetBIOS -ne $null){
            $Results = Submit-SQLStatement -ServerInstance $InstanceName -Query $Query -Database 'master' 
            $Properties = $Results | Get-Member -MemberType properties | select name
            if($CreateHeader -eq 1)
            {
                foreach($p in $Properties)
                {
                    $Header = "$Header,$($p.name)"    
                }
                $Header = $Header.Substring(1)
                Add-Content -Path $OutputFile -Value $Header
            }
           foreach($r in $Results)
           {
                $row=""
                foreach($p in $Properties)
                {
                    $value = $($r.$($p.name))
            
                    $value = $value -replace ',','`'
            
                    $row = "$row,$value"
                }
                $row = $row.Substring(1)
     
                Add-Content -Path $OutputFile -Value $row
            }
        }
        else
        {
            log-message -ModuleName $Module -Message "Connection to $InstanceName failed."
        }
    }
    catch{
    log-message -ModuleName $Module -Message $_.exception.message
    
    
    }
}