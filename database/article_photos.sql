/*
   30 ноября 2019 г.13:45:55
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
ALTER TABLE dbo.articles_list SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.article_photos
	(
	id int NOT NULL IDENTITY (1, 1),
	article_id int NOT NULL,
	photo image NOT NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.article_photos ADD CONSTRAINT
	FK_article_photos_articles_list FOREIGN KEY
	(
	article_id
	) REFERENCES dbo.articles_list
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.article_photos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.article_photos', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.article_photos', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.article_photos', 'Object', 'CONTROL') as Contr_Per 