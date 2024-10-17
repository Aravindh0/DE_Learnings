USE [renewlytics]
GO

/****** Object:  Table [dbo].[autonumgen]    Script Date: 3/21/2024 4:03:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[autonumgen](
	[fileParam] [nvarchar](100) NULL,
	[tableType] [nvarchar](30) NULL,
	[lastgenno] [bigint] NULL,
	[createdby] [nvarchar](150) NULL,
	[createddate] [smalldatetime] NULL,
	[modifieddby] [nvarchar](150) NULL,
	[modifieddate] [smalldatetime] NULL
) ON [PRIMARY]
GO


