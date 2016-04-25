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

select Name as DatabaseName
	,sdb.database_id as LocalDatabaseID
	,page_verify_option
	,recovery_model
	,state
	,is_auto_close_on
	,is_auto_shrink_on
	,user_access
	,collation_name
	,compatibility_level
	,is_auto_create_stats_on
	,size
from sys.databases sdb
	inner join #dbsize  dbs
		on sdb.database_id = dbs.database_id