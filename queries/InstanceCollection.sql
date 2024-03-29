IF (SELECT OBJECT_ID('TEMPDB..#OUTPUT')) IS NOT NULL
	DROP TABLE #OUTPUT
CREATE TABLE #OUTPUT
(
	InstanceName sysname
	,[Version] varchar(60)
	,Edition varchar(60)
	,Collation varchar(60)
	,LastInstanceStartTime datetime
	,MaxServerMemory int
	,CTFP int
	,[MAXDOP] int
	,AdHoc int
)

INSERT INTO #OUTPUT (InstanceName,[Version],Edition,Collation,LastInstanceStartTime)
SELECT @@Servername AS InstanceName
	,CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR) as Version
	,CAST(SERVERPROPERTY('Edition') AS VARCHAR) AS Edition 
	,CAST(SERVERPROPERTY('Collation') AS VARCHAR) as Collation
	,(SELECT create_date FROM SYS.databases WHERE database_id = 2) AS LastInstanceStartTime



UPDATE #OUTPUT
SET MaxServerMemory = CAST(value as Int)
from sys.configurations
where Name = 'max server memory (MB)'

UPDATE #OUTPUT
SET CTFP = CAST(value as Int)
from sys.configurations
where Name = 'cost threshold for parallelism'

UPDATE #OUTPUT
SET [MAXDOP] = CAST(value as Int)
from sys.configurations
where Name = 'max degree of parallelism'

UPDATE #OUTPUT
SET AdHoc = CAST(value as Int)
from sys.configurations
where Name = 'optimize for ad hoc workloads'


SELECT *
FROM #OUTPUT