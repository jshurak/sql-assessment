get-service -name 'MSSQL*' | % {
    $name = $_.Name
    if($name -like '*`$*')
    {
        $stub = $name.Substring($name.IndexOf("`$") + 1)
        Write-Output "$ENV:COMPUTERNAME\$stub"
    }
    else
    {
        Write-Output "$ENV:COMPUTERNAME"    
    }
    
}