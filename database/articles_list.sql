/*
   1 декабря 2019 г.6:18:59
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
ALTER TABLE dbo.articles_list ADD
	popularity int NULL
GO
ALTER TABLE dbo.articles_list ADD CONSTRAINT
	DF_articles_list_popularity DEFAULT 0 FOR popularity
GO
ALTER TABLE dbo.articles_list SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.articles_list', 'Object', 'CONTROL') as Contr_Per 