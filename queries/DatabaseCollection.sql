IF (SELECT OBJECT_ID('tempdb..#dbsize')) IS NOT NULL
	DROP TABLE #dbsize

CREATE TABLE #dbsize
(
	database_id int
	,size bigint
)

exec sp_MSforeachdb N'USE [?]
	INSERT INTO #dbsize
	SELECT DB_ID()
	,SUM(SIZE) AS size
	FROM sys.database_files
'

select @@SERVERNAME as ServerName
	,Name as DatabaseName
	,page_verify_option_desc
	,recovery_model_desc
	,state
	,is_auto_close_on
	,is_auto_shrink_on
	,user_access_desc
	,collation_name
	,compatibility_level
	,is_auto_create_stats_on
	,size
from sys.databases sdb
	inner join #dbsize  dbs
		on sdb.database_id = dbs.database_id