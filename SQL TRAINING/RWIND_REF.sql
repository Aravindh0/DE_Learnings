USE [renewlytics]
GO

/****** Object:  Table [dbo].[rwindref]    Script Date: 3/21/2024 4:06:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[rwindref](
	[flidarid] [varchar](256) NULL,
	[manuid] [varchar](256) NULL,
	[rawcol] [varchar](256) NULL,
	[actcol] [varchar](256) NULL,
	[trans1] [varchar](256) NULL,
	[level] [varchar](256) NULL,
	[height] [varchar](256) NULL,
	[units] [varchar](256) NULL,
	[aheight] [varchar](256) NULL,
	[aunits] [varchar](256) NULL
) ON [PRIMARY]
GO


