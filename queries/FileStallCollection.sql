SELECT @@ServerName as ServerName,DB_NAME(fs.database_id) AS [Database Name]
,name as LogicalName
,mf.file_id 
,physical_name
,num_of_reads
,num_of_writes
,io_stall_read_ms
,io_stall_write_ms
,CAST((io_stall_read_ms*1.0/io_stall) * 100 AS DECIMAL (5,2)) AS [IO Stall Reads Pct]
,CAST((io_stall_write_ms*1.0/io_stall) * 100 AS DECIMAL (5,2)) AS [IO Stall Writes Pct]
FROM sys.dm_io_virtual_file_stats(null,null) AS fs
INNER JOIN sys.master_files AS mf WITH (NOLOCK)
ON fs.database_id = mf.database_id
AND fs.[file_id] = mf.[file_id]
--ORDER BY avg_io_stall_ms DESC OPTION (RECOMPILE);
