-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Homework_3_1 @language nvarchar(50) 	
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT gal_id_galerija, naslov, opis
	FROM GALERIJA_OPIS
	WHERE jazik_id_jazikg = @language
GO

CREATE PROCEDURE Homework_3_2 @InputID numeric(18,0)
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT adm_id_adminn, jazik_id_jazikn
	FROM KNOVOST
	WHERE id_novost = @InputID
GO

CREATE PROCEDURE Homework_3_3 @Visitor numeric(18,0)
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ime, naziv, ID_GRUPA 
	FROM MAILING
		 FULL JOIN
		 EMAIL
		 ON EMAIL_ID_POSETITEL = id_posetitel
		 FULL JOIN
		 EMAIL_GRUPA
		 ON EMAIL_ID_GRUPA = ID_GRUPA
	WHERE ime = @Visitor
GO

CREATE PROCEDURE Homework_3_4 @Active numeric(18,0)
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT NASLOV, TEKST
	FROM EMAIL_PORAKA
		 FULL JOIN
		 EMAIL_GRUPA
		 ON ID_GRUPA = GRUPA_ID_GRUPA
	WHERE aktivna = @Active
GO