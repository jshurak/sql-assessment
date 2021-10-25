SELECT @@SERVERNAME as ServerName
,name as ConfigurationName
,description
,value_in_use
FROM sys.configurations