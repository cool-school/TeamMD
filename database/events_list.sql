/*
   1 декабря 2019 г.14:46:19
   Пользователь: 
   Сервер: LAPTOP-LSBPF23O
   База данных: ecolab
   Приложение: 
*/

/* Чтобы предотвратить возможность потери данных, необходимо внимательно просмотреть этот скрипт, прежде чем запускать его вне контекста конструктора баз данных.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.events_list
	DROP CONSTRAINT FK_events_list_users_list
GO
ALTER TABLE dbo.users_list SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.users_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.users_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.users_list', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_events_list
	(
	id int NOT NULL IDENTITY (1, 1),
	place varchar(200) NULL,
	date date NULL,
	head_id int NULL,
	name varchar(100) NULL,
	[desc] text NULL,
	amount int NULL,
	tags varchar(100) NULL,
	image varchar(100) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_events_list SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_events_list ON
GO
IF EXISTS(SELECT * FROM dbo.events_list)
	 EXEC('INSERT INTO dbo.Tmp_events_list (id, place, date, head_id, name, [desc], amount, tags, image)
		SELECT id, place, date, head_id, name, [desc], amount, tags, image FROM dbo.events_list WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_events_list OFF
GO
DROP TABLE dbo.events_list
GO
EXECUTE sp_rename N'dbo.Tmp_events_list', N'events_list', 'OBJECT' 
GO
ALTER TABLE dbo.events_list ADD CONSTRAINT
	PK_events_list PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.events_list ADD CONSTRAINT
	FK_events_list_users_list FOREIGN KEY
	(
	head_id
	) REFERENCES dbo.users_list
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.events_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.events_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.events_list', 'Object', 'CONTROL') as Contr_Per 