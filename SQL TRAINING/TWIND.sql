USE [renewlytics]
GO

/****** Object:  Table [dbo].[twind]    Script Date: 3/21/2024 4:06:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[twind](
	[sno] [int] NULL,
	[twindkey] [varchar](256) NULL,
	[datetimekey] [smalldatetime] NULL,
	[windkey] [varchar](256) NULL,
	[flidarid] [varchar](256) NULL,
	[packavalavg1] [numeric](18, 3) NULL,
	[wdirtnavg1] [numeric](18, 3) NULL,
	[wdirtnstd1] [numeric](18, 3) NULL,
	[hwsavg1] [numeric](18, 3) NULL,
	[hwsmin1] [numeric](18, 3) NULL,
	[hwsmax1] [numeric](18, 3) NULL,
	[hwsstd1] [numeric](18, 3) NULL,
	[vwsavg1] [numeric](18, 3) NULL,
	[ti1] [numeric](18, 3) NULL,
	[intflag1] [int] NULL,
	[extflag1] [int] NULL,
	[enabled1] [bit] NULL,
	[packavalavg2] [numeric](18, 3) NULL,
	[wdirtnavg2] [numeric](18, 3) NULL,
	[wdirtnstd2] [numeric](18, 3) NULL,
	[hwsavg2] [numeric](18, 3) NULL,
	[hwsmin2] [numeric](18, 3) NULL,
	[hwsmax2] [numeric](18, 3) NULL,
	[hwsstd2] [numeric](18, 3) NULL,
	[vwsavg2] [numeric](18, 3) NULL,
	[ti2] [numeric](18, 3) NULL,
	[intflag2] [int] NULL,
	[extflag2] [int] NULL,
	[enabled2] [bit] NULL,
	[packavalavg3] [numeric](18, 3) NULL,
	[wdirtnavg3] [numeric](18, 3) NULL,
	[wdirtnstd3] [numeric](18, 3) NULL,
	[hwsavg3] [numeric](18, 3) NULL,
	[hwsmin3] [numeric](18, 3) NULL,
	[hwsmax3] [numeric](18, 3) NULL,
	[hwsstd3] [numeric](18, 3) NULL,
	[vwsavg3] [numeric](18, 3) NULL,
	[ti3] [numeric](18, 3) NULL,
	[intflag3] [int] NULL,
	[extflag3] [int] NULL,
	[enabled3] [bit] NULL,
	[packavalavg4] [numeric](18, 3) NULL,
	[wdirtnavg4] [numeric](18, 3) NULL,
	[wdirtnstd4] [numeric](18, 3) NULL,
	[hwsavg4] [numeric](18, 3) NULL,
	[hwsmin4] [numeric](18, 3) NULL,
	[hwsmax4] [numeric](18, 3) NULL,
	[hwsstd4] [numeric](18, 3) NULL,
	[vwsavg4] [numeric](18, 3) NULL,
	[ti4] [numeric](18, 3) NULL,
	[intflag4] [int] NULL,
	[extflag4] [int] NULL,
	[enabled4] [bit] NULL,
	[packavalavg5] [numeric](18, 3) NULL,
	[wdirtnavg5] [numeric](18, 3) NULL,
	[wdirtnstd5] [numeric](18, 3) NULL,
	[hwsavg5] [numeric](18, 3) NULL,
	[hwsmin5] [numeric](18, 3) NULL,
	[hwsmax5] [numeric](18, 3) NULL,
	[hwsstd5] [numeric](18, 3) NULL,
	[vwsavg5] [numeric](18, 3) NULL,
	[ti5] [numeric](18, 3) NULL,
	[intflag5] [int] NULL,
	[extflag5] [int] NULL,
	[enabled5] [bit] NULL,
	[packavalavg6] [numeric](18, 3) NULL,
	[wdirtnavg6] [numeric](18, 3) NULL,
	[wdirtnstd6] [numeric](18, 3) NULL,
	[hwsavg6] [numeric](18, 3) NULL,
	[hwsmin6] [numeric](18, 3) NULL,
	[hwsmax6] [numeric](18, 3) NULL,
	[hwsstd6] [numeric](18, 3) NULL,
	[vwsavg6] [numeric](18, 3) NULL,
	[ti6] [numeric](18, 3) NULL,
	[intflag6] [int] NULL,
	[extflag6] [int] NULL,
	[enabled6] [bit] NULL,
	[packavalavg7] [numeric](18, 3) NULL,
	[wdirtnavg7] [numeric](18, 3) NULL,
	[wdirtnstd7] [numeric](18, 3) NULL,
	[hwsavg7] [numeric](18, 3) NULL,
	[hwsmin7] [numeric](18, 3) NULL,
	[hwsmax7] [numeric](18, 3) NULL,
	[hwsstd7] [numeric](18, 3) NULL,
	[vwsavg7] [numeric](18, 3) NULL,
	[ti7] [numeric](18, 3) NULL,
	[intflag7] [int] NULL,
	[extflag7] [int] NULL,
	[enabled7] [bit] NULL,
	[packavalavg8] [numeric](18, 3) NULL,
	[wdirtnavg8] [numeric](18, 3) NULL,
	[wdirtnstd8] [numeric](18, 3) NULL,
	[hwsavg8] [numeric](18, 3) NULL,
	[hwsmin8] [numeric](18, 3) NULL,
	[hwsmax8] [numeric](18, 3) NULL,
	[hwsstd8] [numeric](18, 3) NULL,
	[vwsavg8] [numeric](18, 3) NULL,
	[ti8] [numeric](18, 3) NULL,
	[intflag8] [int] NULL,
	[extflag8] [int] NULL,
	[enabled8] [bit] NULL,
	[packavalavg9] [numeric](18, 3) NULL,
	[wdirtnavg9] [numeric](18, 3) NULL,
	[wdirtnstd9] [numeric](18, 3) NULL,
	[hwsavg9] [numeric](18, 3) NULL,
	[hwsmin9] [numeric](18, 3) NULL,
	[hwsmax9] [numeric](18, 3) NULL,
	[hwsstd9] [numeric](18, 3) NULL,
	[vwsavg9] [numeric](18, 3) NULL,
	[ti9] [numeric](18, 3) NULL,
	[intflag9] [int] NULL,
	[extflag9] [int] NULL,
	[enabled9] [bit] NULL,
	[packavalavg10] [numeric](18, 3) NULL,
	[wdirtnavg10] [numeric](18, 3) NULL,
	[wdirtnstd10] [numeric](18, 3) NULL,
	[hwsavg10] [numeric](18, 3) NULL,
	[hwsmin10] [numeric](18, 3) NULL,
	[hwsmax10] [numeric](18, 3) NULL,
	[hwsstd10] [numeric](18, 3) NULL,
	[vwsavg10] [numeric](18, 3) NULL,
	[ti10] [numeric](18, 3) NULL,
	[intflag10] [int] NULL,
	[extflag10] [int] NULL,
	[enabled10] [bit] NULL,
	[packavalavg11] [numeric](18, 3) NULL,
	[wdirtnavg11] [numeric](18, 3) NULL,
	[wdirtnstd11] [numeric](18, 3) NULL,
	[hwsavg11] [numeric](18, 3) NULL,
	[hwsmin11] [numeric](18, 3) NULL,
	[hwsmax11] [numeric](18, 3) NULL,
	[hwsstd11] [numeric](18, 3) NULL,
	[vwsavg11] [numeric](18, 3) NULL,
	[ti11] [numeric](18, 3) NULL,
	[intflag11] [int] NULL,
	[extflag11] [int] NULL,
	[enabled11] [bit] NULL,
	[packavalavg12] [numeric](18, 3) NULL,
	[wdirtnavg12] [numeric](18, 3) NULL,
	[wdirtnstd12] [numeric](18, 3) NULL,
	[hwsavg12] [numeric](18, 3) NULL,
	[hwsmin12] [numeric](18, 3) NULL,
	[hwsmax12] [numeric](18, 3) NULL,
	[hwsstd12] [numeric](18, 3) NULL,
	[vwsavg12] [numeric](18, 3) NULL,
	[ti12] [numeric](18, 3) NULL,
	[intflag12] [int] NULL,
	[extflag12] [int] NULL,
	[enabled12] [bit] NULL,
	[packavalavg13] [numeric](18, 3) NULL,
	[wdirtnavg13] [numeric](18, 3) NULL,
	[wdirtnstd13] [numeric](18, 3) NULL,
	[hwsavg13] [numeric](18, 3) NULL,
	[hwsmin13] [numeric](18, 3) NULL,
	[hwsmax13] [numeric](18, 3) NULL,
	[hwsstd13] [numeric](18, 3) NULL,
	[vwsavg13] [numeric](18, 3) NULL,
	[ti13] [numeric](18, 3) NULL,
	[intflag13] [int] NULL,
	[extflag13] [int] NULL,
	[enabled13] [bit] NULL,
	[packavalavg14] [numeric](18, 3) NULL,
	[wdirtnavg14] [numeric](18, 3) NULL,
	[wdirtnstd14] [numeric](18, 3) NULL,
	[hwsavg14] [numeric](18, 3) NULL,
	[hwsmin14] [numeric](18, 3) NULL,
	[hwsmax14] [numeric](18, 3) NULL,
	[hwsstd14] [numeric](18, 3) NULL,
	[vwsavg14] [numeric](18, 3) NULL,
	[ti14] [numeric](18, 3) NULL,
	[intflag14] [int] NULL,
	[extflag14] [int] NULL,
	[enabled14] [bit] NULL,
	[packavalavg15] [numeric](18, 3) NULL,
	[wdirtnavg15] [numeric](18, 3) NULL,
	[wdirtnstd15] [numeric](18, 3) NULL,
	[hwsavg15] [numeric](18, 3) NULL,
	[hwsmin15] [numeric](18, 3) NULL,
	[hwsmax15] [numeric](18, 3) NULL,
	[hwsstd15] [numeric](18, 3) NULL,
	[vwsavg15] [numeric](18, 3) NULL,
	[ti15] [numeric](18, 3) NULL,
	[intflag15] [int] NULL,
	[extflag15] [int] NULL,
	[enabled15] [bit] NULL,
	[tilt] [numeric](18, 3) NULL,
	[bearing] [numeric](18, 3) NULL,
	[statusflag] [varchar](256) NULL,
	[infoflag] [varchar](256) NULL,
	[axysflag] [varchar](256) NULL,
	[algorithm] [varchar](256) NULL,
	[battery] [numeric](18, 3) NULL,
	[generator] [numeric](18, 3) NULL,
	[utemp] [numeric](18, 3) NULL,
	[ltemp] [numeric](18, 3) NULL,
	[podhumid] [numeric](18, 3) NULL,
	[metcmpbearing] [numeric](18, 3) NULL,
	[mettilt] [numeric](18, 3) NULL,
	[pcktsrain] [numeric](18, 3) NULL,
	[pcktsfog] [numeric](18, 3) NULL,
	[rangeflag] [int] NULL,
	[constantflag] [int] NULL,
	[rocflag] [int] NULL,
	[spikeflag] [int] NULL,
	[createdby] [varchar](256) NULL,
	[createddatetime] [smalldatetime] NULL,
	[updatedby] [varchar](256) NULL,
	[updateddatetime] [smalldatetime] NULL
) ON [PRIMARY]
GO


