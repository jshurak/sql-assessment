#
# functions.ps1
#
function Submit-SQLStatement
{
    param([string]$ServerInstance,[string]$Database,[string]$ModuleName,[string]$Query,[Int32]$QueryTimeout=600)
    $conn=new-object System.Data.SqlClient.SQLConnection
    $conn.ConnectionString=”Server={0};Database={1};Integrated Security=True” -f $ServerInstance,$Database

    Try
    {
        $conn.Open()
        $con = 1
    }
    catch
    {
        $message = $_.Exception.Message
        $Message = "$Message : $ServerInstance : $Database : $Query"
        #$message | out-file -append -filepath 
        log-message $ModuleName $message
        $con = 0
    }

    if ($con -eq 1)
    {
    
 
        try
        {      
           $cmd=new-object system.Data.SqlClient.SqlCommand($Query,$conn)
           $cmd.CommandTimeout=$QueryTimeout
           $ds=New-Object system.Data.DataSet
           $da=New-Object system.Data.SqlClient.SqlDataAdapter($cmd)
           [void]$da.fill($ds)
           $ds.Tables[0]
           $conn.Close()
        }
        Catch
        {
            $message = $_.Exception.Message
            $Message = "$Message : $ServerInstance : $Database : $Query"
            #$message | out-file -append -filepath 
            log-message $ModuleName $message
        }  
    }
}

function log-message {
    param([string]$ModuleName,[string]$Message)
    
    $ModuleName = $ModuleName
    $date = get-date -format 'yyyyMMdd'
    $MsgDate =get-date -format 'yyyy-MM-dd hhmmss'
    $logfile = "$ModuleName.txt"
    $outfile = "$LoggingDirectory$logfile"
    
    $outMessage = "$MsgDate` : $ModuleName` : $Message"
    $outMessage | out-file -append -filepath $outfile

}