DECLARE @Version DECIMAL(3,1),@SQL varchar(5000)
SELECT @Version = CAST(SUBSTRING(CAST(SERVERPROPERTY('productVersion') AS VARCHAR),1,2) AS DECIMAL(3,1))
print cast(@Version as varchar)

IF (@Version < 11.0)
set @SQL = '
SELECT @@SERVERNAME as ServerName
,virtual_machine_type_desc
,cpu_count AS [Logical CPU Count], hyperthread_ratio AS [Hyperthread Ratio],
cpu_count/hyperthread_ratio AS [Physical CPU Count]
, physical_memory_in_bytes/1048576 AS [Physical Memory (MB)]
, sqlserver_start_time 
FROM sys.dm_os_sys_info WITH (NOLOCK) OPTION (RECOMPILE);'
else 
set @SQL = '
SELECT @@SERVERNAME as ServerName
,virtual_machine_type_desc
,cpu_count AS [Logical CPU Count], hyperthread_ratio AS [Hyperthread Ratio],
cpu_count/hyperthread_ratio AS [Physical CPU Count]
, physical_memory_kb/1024 AS [Physical Memory (MB)]
, sqlserver_start_time 
FROM sys.dm_os_sys_info WITH (NOLOCK) OPTION (RECOMPILE);'

exec(@SQL)
