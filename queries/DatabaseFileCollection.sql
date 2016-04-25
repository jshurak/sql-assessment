IF (SELECT OBJECT_ID('TEMPDB..#DBFILE')) IS NOT NULL
	DROP TABLE #DBFILE

CREATE TABLE #DBFILE
(
	LocalDatabaseID int
	,LocalFileID int
	,file_guid varchar(36)
	,type tinyint
	,name sysname
	,physical_name nvarchar(260)
	,state tinyint
	,size int
	,max_size int
	,growth int
)

exec sp_MSforeachdb N'USE [?]
insert into #DBFILE
select	
	DB_ID() AS LocalDatabaseID
	,[file_id] as LocalFileID
	,file_guid
	,type
	,name
	,physical_name
	,state
	,size
	,max_size
	,growth
from sys.database_files
'

SELECT *
FROM #DBFILE