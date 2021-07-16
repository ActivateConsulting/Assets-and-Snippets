CREATE TABLE [dbo].[D_Datum] (
    [datum_id]                   INT          NOT NULL,
    [Datum]                      DATE         NOT NULL,
    [Dagnummer]                  TINYINT      NOT NULL,
    [Weekdag nummer]             TINYINT      NOT NULL,
    [Weekdag naam]               VARCHAR (10) NOT NULL,
    [Weekdag naam kort]          CHAR (3)     NOT NULL,
    [Weekdag naam eerste Letter] CHAR (1)     NOT NULL,
    [Dag van het jaar]           SMALLINT     NOT NULL,
    [Week van maand]             TINYINT      NOT NULL,
    [Week van jaar]              TINYINT      NOT NULL,
    [Maandnummer]                TINYINT      NOT NULL,
    [Maand naam]                 VARCHAR (10) NOT NULL,
    [Maand naam kort]            CHAR (3)     NOT NULL,
    [Kwartaal nummer]            TINYINT      NOT NULL,
    [Kwartaal]                   VARCHAR (2)  NOT NULL,
    [Jaar Kwartaal]              VARCHAR (7)  NOT NULL,
    [Jaar]                       INT          NOT NULL,
    [Jaar maand]                 CHAR (7)     NOT NULL,
    [IsWeekend]                  BIT          NOT NULL,
    [Periode]                    VARCHAR (43) NOT NULL,
    [ISO Week]                   INT          NULL,
    [ISO Jaar]                   INT          NULL,
    [Periode nummer]             VARCHAR (30) NULL,
    [Quamester]                  INT NULL
    PRIMARY KEY CLUSTERED ([datum_id] ASC)
);

