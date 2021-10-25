IF (SELECT OBJECT_ID('TEMPDB..#DBFILE')) IS NOT NULL
	DROP TABLE #DBFILE

CREATE TABLE #DBFILE
(
	ServerName sysname
	,DatabaseName sysname
	,type_desc nvarchar(60)
	,name sysname
	,physical_name nvarchar(260)
	,state_desc nvarchar(60)
	,size int
	,max_size int
	,growth int
	,is_percent_growth bit
	,is_read_only bit
)

exec sp_MSforeachdb N'USE [?]
insert into #DBFILE
select
	@@ServerName as ServerName	
	,DB_NAME() AS DatabaseName
	,type_desc
	,name
	,physical_name
	,state_desc
	,SIZE
	,max_size
	,growth
	,is_percent_growth
	,is_read_only
from sys.database_files
'

SELECT *
FROM #DBFILE