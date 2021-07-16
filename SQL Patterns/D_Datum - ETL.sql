/******************************
** File:	D_Datum
** Name:	ETL Voor de D_Datum
** Desc:    Dit is een algemeen script, gekopieerd van het WWW en aangepast voor de specifieke toepassing voor Naktuinbouw. Daarnaast is deze vernederlandsd.
** Auth:	Guido de Vries
** Date:	16-6-2020
** TFS:		
**************************
** Change History
**************************
** PR	Date        Author		Description 
** --   --------	-------		------------------------------------
** 1    16-6-2020   Guido		Initieel script.
**      20-10-2020  Guido       ISO Week, periode, iso jaar en periode nummer toegevoegd.
**      16-2-2021   Guido       Quamester toegevoegd.
*******************************/

SET NOCOUNT ON
-- Hier zetten we de taal naar Dutch om ervoor te zorgen dat de nederlandse kalender wordt gebruikt.
SET LANGUAGE dutch
TRUNCATE TABLE D_Datum
-- start en eind datum van de loop.
DECLARE @CurrentDate DATE = '2005-01-01'
DECLARE @EndDate DATE = '2025-12-31'
--start van de loop.
WHILE @CurrentDate < @EndDate
BEGIN
   INSERT INTO [dbo].[D_Datum] (
      [datum_id],
      [Datum],
      [Dagnummer],
      [Weekdag nummer],
      [Weekdag naam],
      [Weekdag naam kort],
      [Weekdag naam eerste Letter],
      [Dag van het jaar],
      [Week van maand],
      [Week van jaar],
      [Maandnummer],
      [Maand naam],
      [Maand naam kort],
      [Kwartaal nummer],
      [Kwartaal],
	  [Jaar Kwartaal],
      [Jaar],
      [Jaar maand],
      [IsWeekend],
	  Periode,
	  [ISO Week],
	  [ISO Jaar],
	  [Periode nummer],
      [Quamester]
      )
   SELECT datum_id = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + DAY(@CurrentDate),
      Datum = @CurrentDate,
      Dagnummer = DAY(@CurrentDate),
      [Weekdag nummer] = DATEPART(dw, @CurrentDate),
      [Weekdag naam] = DATENAME(dw, @CurrentDate),
      [Weekdag naam kort] = lower(LEFT(DATENAME(dw, @CurrentDate), 3)),
      [Weekdag naam eerste Letter] = LEFT(DATENAME(dw, @CurrentDate), 1),
      [Dag van het jaar] = DATENAME(dy, @CurrentDate),
      [Week van maand] = DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1,
      [Week van jaar] = DATEPART(wk, @CurrentDate),
	   
      [Maandnummer] = MONTH(@CurrentDate),
      [Maand naam] = DATENAME(mm, @CurrentDate),
      [Maand naam kort] = lower(LEFT(DATENAME(mm, @CurrentDate), 3)),
      
      [Kwartaal nummer] = DATEPART(q, @CurrentDate),
      [Kwartaal] = 'Q'+ cast(datepart(q,@CurrentDate) as varchar),
	  [Jaar Kwartaal] = CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-Q'+ cast(datepart(q,@CurrentDate) as varchar),
      [Jaar] = YEAR(@CurrentDate),
      [Jaar maand] = CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)), 2),      
      [IsWeekend] = CASE 
         WHEN DATEPART(dw, @CurrentDate) = 6
            OR DATEPART(dw, @CurrentDate) = 7
            THEN 1
         ELSE 0
         END,
      Periode = CONCAT( YEAR(DATEADD(day, 26 - DATEPART(isoww, @CurrentDate), @CurrentDate)), CASE WHEN LEN(CEILING(CONVERT(decimal(18,2), datepart(ISO_WEEK, @CurrentDate)) / 4) ) = 1 THEN CONCAT('0',CONVERT(VARCHAR,CEILING(CONVERT(decimal(18,2), datepart(ISO_WEEK, @CurrentDate)) / 4))) ELSE CONVERT(VARCHAR,CEILING(CONVERT(decimal(18,2), datepart(ISO_WEEK, @CurrentDate)) / 4)) END) ,
	  [ISO Week] = datepart(ISO_WEEK, @CurrentDate) ,
	  [ISO Jaar] = YEAR(DATEADD(day, 26 - DATEPART(isoww, @CurrentDate), @CurrentDate)) ,
	  [Periode nummer] = CONVERT(VARCHAR,CEILING(CONVERT(decimal(18,2), datepart(ISO_WEEK, @CurrentDate)) / 4)) ,
      Quamester = CASE 
		WHEN MONTH(@CurrentDate) BETWEEN 0 and 4 then  1
		WHEN MONTH(@CurrentDate) BETWEEN 4 and 8 THEN  2
		WHEN MONTH(@CurrentDate) BETWEEN 8 AND 12 THEN 3
	  END 

   SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END

