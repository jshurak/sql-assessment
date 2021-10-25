select @@SERVERNAME as ServerName
	,sd.Name as DatabaseName
	,sd.recovery_model_desc
	,CASE
		WHEN d.LastFullBackup IS NULL THEN 'No Full Backups'
		ELSE CAST(d.LastFullBackup AS VARCHAR)
	END LastFullBackup
	,CASE
		WHEN sd.Recovery_model = 3 THEN 'NA'
		WHEN sd.Recovery_model <> 3 AND L.LastLogBackup IS NULL THEN 'No Log Backups'
		ELSE CAST(l.LastLogBackup AS VARCHAR)
	END LastLogBackup
	,CASE
		WHEN i.LastDiffBackup IS NULL THEN 'No Differential backups'
		ELSE CAST(i.LastDiffBackup AS VARCHAR)
	END LastDiffBackup
	,CASE
		WHEN f.LastBackup IS NULL THEN 'No Filegroup backups'
		ELSE CAST(f.LastBackup AS VARCHAR)
	END LastFileGroupBackup
	,CASE
		WHEN g.LastBackup IS NULL THEN 'No Filegroup differentials'
		ELSE CAST(g.LastBackup AS VARCHAR)
	END LastFileGroupDiffBackup
	,CASE
		WHEN p.LastBackup IS NULL THEN 'No Partial Backups'
		ELSE CAST(p.LastBackup AS VARCHAR)
	END LastPartialBackup
	,CASE
		WHEN q.LastBackup IS NULL THEN 'No Partial differentials'
		ELSE CAST(q.LastBackup AS VARCHAR)
	END LastPartialDiffBackup
FROM sys.databases sd
	LEFT OUTER JOIN
(select
	Database_Name
	,MAX(backup_finish_date) LastFullBackup
from msdb.dbo.backupset
where type = 'd'
group by database_name) d
	ON sd.name = d.database_name
LEFT OUTER JOIN
(
	select
		bs.Database_Name
		,MAX(bs.backup_finish_date) LastLogBackup
	from msdb.dbo.backupset bs
	where type = 'l'
	group by database_name
) l
	ON sd.Name = l.Database_Name
LEFT OUTER JOIN
(
	select
		bs.Database_Name
		,MAX(bs.backup_finish_date) LastDiffBackup
	from msdb.dbo.backupset bs
	where type = 'i'
	group by database_name
) i
	ON sd.Name = i.Database_Name
LEFT OUTER JOIN
(
	select
		bs.Database_Name
		,MAX(bs.backup_finish_date) LastBackup
	from msdb.dbo.backupset bs
	where type = 'f'
	group by database_name
) f
	ON sd.Name = f.Database_Name
LEFT OUTER JOIN
(
	select
		bs.Database_Name
		,MAX(bs.backup_finish_date) LastBackup
	from msdb.dbo.backupset bs
	where type = 'g'
	group by database_name
) g
	ON sd.Name = g.Database_Name
LEFT OUTER JOIN
(
	select
		bs.Database_Name
		,MAX(bs.backup_finish_date) LastBackup
	from msdb.dbo.backupset bs
	where type = 'p'
	group by database_name
) p
	ON sd.Name = p.Database_Name
LEFT OUTER JOIN
(
	select
		bs.Database_Name
		,MAX(bs.backup_finish_date) LastBackup
	from msdb.dbo.backupset bs
	where type = 'q'
	group by database_name
) q
	ON sd.Name = q.Database_Name