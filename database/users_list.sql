/*
   1 декабря 2019 г.11:17:05
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
ALTER TABLE dbo.users_list
	DROP CONSTRAINT DF_users_list_rating
GO
CREATE TABLE dbo.Tmp_users_list
	(
	id int NOT NULL IDENTITY (1, 1) NOT FOR REPLICATION,
	login varchar(50) NOT NULL,
	password varchar(256) NOT NULL,
	place varchar(100) COLLATE Latin1_General_100_CI_AI_SC_UTF8 NOT NULL,
	avatar varchar(100) NULL,
	tel_num varchar(15) NULL,
	email varchar(50) NULL,
	rating int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_users_list SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_users_list ADD CONSTRAINT
	DF_users_list_rating DEFAULT ((0)) FOR rating
GO
SET IDENTITY_INSERT dbo.Tmp_users_list ON
GO
IF EXISTS(SELECT * FROM dbo.users_list)
	 EXEC('INSERT INTO dbo.Tmp_users_list (id, login, password, place, avatar, tel_num, email, rating)
		SELECT id, login, password, place, avatar, tel_num, email, rating FROM dbo.users_list WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_users_list OFF
GO
ALTER TABLE dbo.events_list
	DROP CONSTRAINT FK_events_list_users_list
GO
ALTER TABLE dbo.articles_list
	DROP CONSTRAINT FK_articles_list_users_list
GO
ALTER TABLE dbo.news_list
	DROP CONSTRAINT FK_news_list_users_list
GO
DROP TABLE dbo.users_list
GO
EXECUTE sp_rename N'dbo.Tmp_users_list', N'users_list', 'OBJECT' 
GO
ALTER TABLE dbo.users_list ADD CONSTRAINT
	PK_users_list PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.users_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.users_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.users_list', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.news_list ADD CONSTRAINT
	FK_news_list_users_list FOREIGN KEY
	(
	author_id
	) REFERENCES dbo.users_list
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.news_list SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.news_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.news_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.news_list', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.articles_list ADD CONSTRAINT
	FK_articles_list_users_list FOREIGN KEY
	(
	author_id
	) REFERENCES dbo.users_list
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.articles_list SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
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
ALTER TABLE dbo.events_list SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.events_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.events_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.events_list', 'Object', 'CONTROL') as Contr_Per 