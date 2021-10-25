set nocount on
--find out how big buffer pool is and determine percentage used by each database

IF OBJECT_ID('tempdb..#PagesBreakdown') IS NOT NULL
	DROP TABLE #PagesBreakdown

CREATE TABLE #PagesBreakdown
(
	Object varchar(25)
	,value float
)

DECLARE @Version INT, @total_buffer INT,@free_pages int,@stolen_pages int,@db_pages int,@total_plans bigint,@SQL varchar(5000),@pages_string varchar(25);

SELECT @Version =  CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR)) -1) AS INT)
IF @Version < 11
BEGIN
	insert into #PagesBreakdown
	SELECT 'Total Buffer',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Total Pages';

	insert into #PagesBreakdown
	SELECT 'DB Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Database Pages';

	insert into #PagesBreakdown
	SELECT 'Free Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Free Pages';

	insert into #PagesBreakdown
	SELECT 'Stolen Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Stolen Pages';
END
ELSE
BEGIN

	insert into #PagesBreakdown
	SELECT 'DB Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Database Pages';

	insert into #PagesBreakdown
	SELECT 'Free Pages',cntr_value/8    FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Memory Manager'   AND counter_name = 'Free Memory (KB)';

	insert into #PagesBreakdown
	SELECT 'Stolen Pages',cntr_value/8   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Memory Manager'   AND counter_name = 'Stolen Server Memory (KB)';
	
	INSERT INTO #PagesBreakdown
	SELECT 'Total Buffer',sum(value)
	FROM #PagesBreakdown
END
select @db_pages = value
from #PagesBreakdown
where object = 'db pages'

SELECT @total_buffer = Value
FROM #PagesBreakdown
WHERE Object = 'Total Buffer'


SELECT @@Servername as ServerName,OBJECT, VALUE as Pages, CAST(VALUE/128.0 AS DECIMAL(10,2)) as MB_In_Cache,cast((VALUE/@Total_Buffer) * 100 as decimal (4,2)) as Percentage
FROM #PagesBreakdown
where object <> 'total buffer'
UNION
SELECT @@Servername as ServerName,Object,Value,CAST(VALUE/128.0 AS DECIMAL(10,2)) as MB_In_Cache,100.0
FROM #PagesBreakdown
where object = 'total buffer'