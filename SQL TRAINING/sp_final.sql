-- UNPIVOT
DROP PROCEDURE RENEW_SP
CREATE PROCEDURE RENEW_SP
AS
BEGIN
IF 
EXISTS(SELECT transflag FROM [dbo].[rwind] WHERE transflag = 0)
BEGIN
SET NOCOUNT ON
CREATE TABLE #UNPIVOT
	(windkey VARCHAR(20),
	datetimekey DATETIME,
	flidarid VARCHAR(20),
	transflag VARCHAR(20),
	WindValue VARCHAR(MAX),
	--WindNumber VARCHAR(20),
	trans1 VARCHAR(20))

INSERT INTO #UNPIVOT
SELECT 
	UPR.windkey,
	UPR.datetimekey,
	UPR.flidarid,
	--RF.flidarid,
	UPR.transflag,
	UPR.WindValue,
	--UPR.WindNumber,
	--RF.rawcol,
	RF.trans1
FROM 
	[dbo].[rwind]
UNPIVOT
(
WindValue FOR WindNumber IN 
(w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, 
w31, w32, w33, w34, w35, w36, w37, w38, w39, w40, w41, w42, w43, w44, w45, w46, w47, w48, w49, w50, w51, w52, w53, w54, w55, w56, w57, w58, w59, w60, 
w61, w62, w63, w64, w65, w66, w67, w68, w69, w70, w71, w72, w73, w74, w75, w76, w77, w78, w79, w80, w81, w82, w83, w84, w85, w86, w87, w88, w89, w90, 
w91, w92, w93, w94, w95, w96, w97, w98, w99, w100, w101, w102, w103, w104, w105, w106, w107, w108, w109, w110, w111, w112, w113, w114, w115, w116, w117, 
w118, w119, w120, w121, w122, w123, w124, w125, w126, w127, w128, w129, w130, w131, w132, w133, w134, w135, w136, w137, w138, w139, w140, w141, w142, 
w143, w144, w145, w146, w147, w148, w149, w150, w151, w152, w153, w154, w155, w156, w157, w158, w159, w160, w161, w162, w163, w164, w165, w166, w167, 
w168, w169, w170, w171, w172, w173, w174, w175, w176, w177, w178, w179, w180)
)
AS UPR
INNER JOIN
	[dbo].[rwindref] AS RF ON RF.flidarid = UPR.flidarid
WHERE
	UPR.transflag = 0
AND
	RF.rawcol = UPR.WindNumber

-- CONVERTING TO PIVOT AND INSERTING THE DATA IN A SEPERATE TEMP TABLE

SELECT * INTO #PIVOT 
FROM #UNPIVOT
PIVOT
(
MAX(WindValue) FOR TRANS1 IN 
(
packavalavg1,wdirtnavg1,wdirtnstd1,hwsavg1,hwsmin1,hwsmax1,hwsstd1,vwsavg1,ti1,intflag1,extflag1,enabled1,
packavalavg2,wdirtnavg2,wdirtnstd2,hwsavg2,hwsmin2,hwsmax2,hwsstd2,vwsavg2,ti2,intflag2,extflag2,enabled2,
packavalavg3,wdirtnavg3,wdirtnstd3,hwsavg3,hwsmin3,hwsmax3,hwsstd3,vwsavg3,ti3,intflag3,extflag3,enabled3,
packavalavg4,wdirtnavg4,wdirtnstd4,hwsavg4,hwsmin4,hwsmax4,hwsstd4,vwsavg4,ti4,intflag4,extflag4,enabled4,
packavalavg5,wdirtnavg5,wdirtnstd5,hwsavg5,hwsmin5,hwsmax5,hwsstd5,vwsavg5,ti5,intflag5,extflag5,enabled5,
packavalavg6,wdirtnavg6,wdirtnstd6,hwsavg6,hwsmin6,hwsmax6,hwsstd6,vwsavg6,ti6,intflag6,extflag6,enabled6,
packavalavg7,wdirtnavg7,wdirtnstd7,hwsavg7,hwsmin7,hwsmax7,hwsstd7,vwsavg7,ti7,intflag7,extflag7,enabled7,
packavalavg8,wdirtnavg8,wdirtnstd8,hwsavg8,hwsmin8,hwsmax8,hwsstd8,vwsavg8,ti8,intflag8,extflag8,enabled8,
packavalavg9,wdirtnavg9,wdirtnstd9,hwsavg9,hwsmin9,hwsmax9,hwsstd9,vwsavg9,ti9,intflag9,extflag9,enabled9,
packavalavg10,wdirtnavg10,wdirtnstd10,hwsavg10,hwsmin10,hwsmax10,hwsstd10,vwsavg10,ti10,intflag10,extflag10,enabled10,
packavalavg11,wdirtnavg11,wdirtnstd11,hwsavg11,hwsmin11,hwsmax11,hwsstd11,vwsavg11,ti11,intflag11,extflag11,enabled11,
packavalavg12,wdirtnavg12,wdirtnstd12,hwsavg12,hwsmin12,hwsmax12,hwsstd12,vwsavg12,ti12,intflag12,extflag12,enabled12,
packavalavg13,wdirtnavg13,wdirtnstd13,hwsavg13,hwsmin13,hwsmax13,hwsstd13,vwsavg13,ti13,intflag13,extflag13,enabled13,
packavalavg14,wdirtnavg14,wdirtnstd14,hwsavg14,hwsmin14,hwsmax14,hwsstd14,vwsavg14,ti14,intflag14,extflag14,enabled14,
packavalavg15,wdirtnavg15,wdirtnstd15,hwsavg15,hwsmin15,hwsmax15,hwsstd15,vwsavg15,ti15,intflag15,extflag15,enabled15,
tilt,bearing,statusflag,infoflag,axysflag,algorithm,battery,generator,utemp,ltemp,podhumid,metcmpbearing,mettilt,pcktsrain,
pcktsfog,rangeflag,constantflag,rocflag,spikeflag
)) AS PIVOTTABLE 

-- CREATING TABLE TO STORE THE DATAS THAT ARE CONVERTED TO NUMERIC

CREATE TABLE #TEMP(
	[windkey] [varchar](256) NULL,
	[datetimekey] [smalldatetime] NULL,
	[flidarid] [varchar](256) NULL,
	transflag [varchar](256) NULL,
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
	[spikeflag] [int] NULL
) 

-- INSERTING INM THE TABLE BY COVERTING THE VARCHAR VALUES TO NUMERIC (NOTE - SOME DATAS ARE VARCHAR SO WE ARE CHANGING IT TO NUMERIC)

INSERT INTO #TEMP
SELECT
	windkey,
	datetimekey,
	flidarid,
	transflag,
	CAST(packavalavg1 AS numeric(38,3))  AS packavalavg1, 
    CAST(wdirtnavg1 AS numeric(38,3)) AS wdirtnavg1, 
    CAST(wdirtnstd1 AS numeric(38,3))  AS wdirtnstd1, 
    CAST(hwsavg1 AS numeric(38,3)) AS hwsavg1, 
    CAST(hwsmin1 AS numeric(38,3)) AS hwsmin1,  
    CAST(hwsmax1 AS numeric(38,3)) AS hwsmax1, 
    CAST(hwsstd1 AS numeric(38,3)) AS hwsstd1 , 
    ROUND(CAST(vwsavg1 AS FLOAT), 3) AS vwsavg1, 
    ROUND (CAST(ti1 AS FLOAT), 3) AS ti1,
	intflag1,
	extflag1,
	enabled1 ,
    CAST(packavalavg2 AS numeric(38,3))  AS packavalavg2, 
    CAST(wdirtnavg2 AS numeric(38,3)) AS wdirtnavg2, 
    CAST(wdirtnstd2 AS numeric(38,3)) AS wdirtnstd2, 
    CAST(hwsavg2 AS numeric(38,3)) AS hwsavg2, 
    CAST(hwsmin2 AS numeric(38,3)) AS hwsmin2 , 
    CAST(hwsmax2 AS numeric(38,3)) AS hwsmax2, 
    CAST(hwsstd2 AS numeric(38,3)) AS hwsstd2, 
    ROUND(CAST(vwsavg2 AS FLOAT),3) AS vwsavg2 , 
    ROUND(CAST(ti2 AS FLOAT),3) AS ti2, 
	intflag2,
	extflag2,
	enabled2 ,
    CAST(packavalavg3 AS numeric(38,3)) AS packavalavg3, 
    CAST(wdirtnavg3 AS numeric(38,3)) AS wdirtnavg3, 
    CAST(wdirtnstd3 AS numeric(38,3)) AS wdirtnstd3, 
    CAST(hwsavg3 AS numeric(38,3)) AS hwsavg3, 
    CAST(hwsmin3 AS numeric(38,3)) AS hwsmin3, 
    CAST(hwsmax3 AS numeric(38,3)) AS hwsmax3, 
    CAST(hwsstd3 AS numeric(38,3)) AS hwsstd3, 
    ROUND(CAST(vwsavg3 AS FLOAT),3) AS vwsavg3, 
    ROUND(CAST(ti3 AS FLOAT),3)  AS ti3,
	intflag3,
	extflag3,
	enabled3 ,
    CAST(packavalavg4 AS numeric(38,3)) AS packavalavg4, 
    CAST(wdirtnavg4 AS numeric(38,3)) AS wdirtnavg4, 
    CAST(wdirtnstd4 AS numeric(38,3)) AS wdirtnstd4, 
    CAST(hwsavg4 AS numeric(38,3)) AS hwsavg4, 
    CAST(hwsmin4 AS numeric(38,3)) AS hwsmin4, 
    CAST(hwsmax4 AS numeric(38,3)) AS hwsmax4, 
    CAST(hwsstd4 AS numeric(38,3)) AS hwsstd4 , 
    ROUND(CAST(vwsavg4 AS FLOAT),3) AS vwsavg4, 
    ROUND(CAST(ti4 AS FLOAT),3) AS ti4,
	intflag4,
	extflag4,
	enabled4,
    CAST(packavalavg5 AS numeric(38,3)) AS packavalavg5, 
    CAST(wdirtnavg5 AS numeric(38,3)) AS wdirtnavg5, 
    CAST(wdirtnstd5 AS numeric(38,3) ) AS wdirtnstd5, 
    CAST(hwsavg5 AS numeric(38,3)) AS hwsavg5, 
    CAST(hwsmin5 AS numeric(38,3)) AS hwsmin5, 
    CAST(hwsmax5 AS numeric(38,3)) AS hwsmax5, 
    CAST(hwsstd5 AS numeric(38,3)) AS hwsstd5, 
    ROUND(CAST(vwsavg5 AS FLOAT),3) AS vwsavg5, 
    ROUND(CAST(ti5 AS FLOAT),3) AS ti5, 
	intflag5,
	extflag5,
	enabled5,
    CAST(packavalavg6 AS numeric(38,3)) AS packavalavg6, 
    CAST(wdirtnavg6 AS numeric(38,3)) AS wdirtnavg6, 
    CAST(wdirtnstd6 AS numeric(38,3)) AS wdirtnstd6, 
    CAST(hwsavg6 AS numeric(38,3)) AS hwsavg6, 
    CAST(hwsmin6 AS numeric(38,3)) AS hwsmin6, 
    CAST(hwsmax6 AS numeric(38,3)) AS hwsmax6, 
    CAST(hwsstd6 AS numeric(38,3)) AS hwsstd6, 
    ROUND(CAST(vwsavg6 AS FLOAT),3) AS vwsavg6, 
    ROUND(CAST(ti6 AS FLOAT),3) AS ti6, 
	intflag6,
	extflag6,
	enabled6,
    CAST(packavalavg7 AS numeric(38,3)) AS packavalavg7, 
    CAST(wdirtnavg7 AS numeric(38,3)) AS wdirtnavg7, 
    CAST(wdirtnstd7 AS numeric(38,3)) AS wdirtnstd7, 
    CAST(hwsavg7 AS numeric(38,3))  AS hwsavg7, 
    CAST(hwsmin7 AS numeric(38,3)) AS hwsmin7, 
    CAST(hwsmax7 AS numeric(38,3)) AS hwsmax7, 
    CAST(hwsstd7 AS numeric(38,3)) AS hwsstd7, 
    ROUND(CAST(vwsavg7 AS FLOAT),3) AS vwsavg7, 
    ROUND(CAST(ti7 AS FLOAT),3) AS ti7, 
	intflag7,
	extflag7,
	enabled7,
    CAST(packavalavg8 AS numeric(38,3)) AS packavalavg8, 
    CAST(wdirtnavg8 AS numeric(38,3)) AS wdirtnavg8, 
    CAST(wdirtnstd8 AS numeric(38,3)) AS wdirtnstd8, 
    CAST(hwsavg8 AS numeric(38,3)) AS hwsavg8, 
    CAST(hwsmin8 AS numeric(38,3)) AS hwsmin8, 
    CAST(hwsmax8 AS numeric(38,3)) AS hwsmax8, 
    CAST(hwsstd8 AS numeric(38,3)) AS hwsstd8, 
    ROUND(CAST(vwsavg8 AS FLOAT),3) AS vwsavg8,
	ROUND(CAST(ti8 AS FLOAT),3) AS ti8, 
	intflag8,
	extflag8,
	enabled8,
    CAST(packavalavg9 AS numeric(38,3)) AS packavalavg9, 
    CAST(wdirtnavg9 AS numeric(38,3)) AS wdirtnavg9, 
    CAST(wdirtnstd9 AS numeric(38,3)) AS wdirtnstd9, 
    cast(hwsavg9 AS numeric(38,3)) AS hwsavg9, 
    cast(hwsmin9 AS numeric(38,3)) AS hwsmin9, 
    cast(hwsmax9 AS numeric(38,3)) AS hwsmax9, 
    cast(hwsstd9 AS numeric(38,3)) AS hwsstd9, 
    ROUND(cast(vwsavg9 AS FLOAT),3) AS vwsavg9, 
    ROUND(CAST(ti9 AS FLOAT),3) AS ti9,
	intflag9,
	extflag9,
	enabled9,
    CAST(packavalavg10 AS numeric(38,3)) AS packavalavg10, 
    CAST(wdirtnavg10 AS numeric(38,3)) AS wdirtnavg10, 
    CAST(wdirtnstd10 AS numeric(38,3)) AS wdirtnstd10, 
    CAST(hwsavg10 AS numeric(38,3)) AS hwsavg10, 
    CAST(hwsmin10 AS numeric(38,3)) AS hwsmin10, 
    CAST(hwsmax10 AS numeric(38,3)) AS hwsmax10, 
    CAST(hwsstd10 AS numeric(38,3)) AS hwsstd10, 
    ROUND(CAST(vwsavg10 AS FLOAT),3) AS vwsavg10, 
    ROUND(CAST(ti10 AS FLOAT),3) AS ti10,  
	intflag10,
	extflag10,
	enabled10,
    CAST(packavalavg11 AS numeric(38,3)) AS packavalavg11, 
    CAST(wdirtnavg11 AS numeric(38,3)) AS wdirtnavg11, 
    CAST(wdirtnstd11 AS numeric(38,3)) AS wdirtnstd11, 
    CAST(hwsavg11 AS numeric(38,3)) AS hwsavg11, 
    CAST(hwsmin11 AS numeric(38,3)) AS hwsmin11, 
    CAST(hwsmax11 AS numeric(38,3)) AS hwsmax11, 
    CAST(hwsstd11 AS numeric(38,3)) AS hwsstd11, 
    ROUND(CAST(vwsavg11 AS FLOAT),3) AS vwsavg11, 
    ROUND(CAST(ti11 AS FLOAT),3) AS ti11, 
	intflag11,
	extflag11,
	enabled11,
    CAST(packavalavg12 AS numeric(38,3)) AS packavalavg12, 
    CAST(wdirtnavg12 AS numeric(38,3)) AS wdirtnavg12, 
    CAST(wdirtnstd12 AS numeric(38,3)) AS wdirtnstd12, 
    CAST(hwsavg12 AS numeric(38,3)) AS hwsavg12, 
    CAST(hwsmin12 AS numeric(38,3)) AS hwsmin12, 
    CAST(hwsmax12 AS numeric(38,3)) AS hwsmax12, 
    CAST(hwsstd12 AS numeric(38,3)) AS hwsstd12, 
    ROUND(CAST(vwsavg12 AS FLOAT),3) AS vwsavg12, 
    ROUND(CAST(ti12 AS FLOAT),3) AS ti12, 
	intflag12,
	extflag12,
	enabled12,
    CAST(packavalavg13 AS numeric(38,3)) AS packavalavg13, 
    CAST(wdirtnavg13 AS numeric(38,3)) AS wdirtnavg13, 
    CAST(wdirtnstd13 AS numeric(38,3)) AS wdirtnstd13, 
    CAST(hwsavg13 AS numeric(38,3)) AS hwsavg13, 
    CAST(hwsmin13 AS numeric(38,3)) AS hwsmin13, 
    CAST(hwsmax13 AS numeric(38,3)) AS hwsmax13, 
    CAST(hwsstd13 AS numeric(38,3)) AS hwsstd13, 
    ROUND(CAST(vwsavg13 AS FLOAT),3) AS vwsavg13, 
    ROUND(CAST(ti13 AS FLOAT),3) AS ti13, 
	intflag13,
	extflag13,
	enabled13 ,
    CAST(packavalavg14 AS numeric(38,3)) AS packavalavg14, 
    CAST(wdirtnavg14 AS numeric(38,3)) AS wdirtnavg14, 
    CAST(wdirtnstd14 AS numeric(38,3)) AS wdirtnstd14, 
    CAST(hwsavg14 AS numeric(38,3)) AS hwsavg14, 
    CAST(hwsmin14 AS numeric(38,3)) AS hwsmin14, 
    CAST(hwsmax14 AS numeric(38,3)) AS hwsmax14, 
    CAST(hwsstd14 AS numeric(38,3)) AS hwsstd14, 
    ROUND(CAST(vwsavg14 AS FLOAT),3) AS vwsavg14, 
    ROUND(CAST(ti14 AS FLOAT),3) AS ti14,  
	intflag14,
	extflag14,
	enabled14,
    CAST(packavalavg15 AS numeric(38,3)) AS packavalavg15, 
    CAST(wdirtnavg15 AS numeric(38,3)) AS wdirtnavg15, 
    CAST(wdirtnstd15 AS numeric(38,3)) AS wdirtnstd15, 
    CAST(hwsavg15 AS numeric(38,3)) AS hwsavg15, 
    CAST(hwsmin15 AS numeric(38,3)) AS hwsmin15, 
    CAST(hwsmax15 AS numeric(38,3)) AS hwsmax15, 
    CAST(hwsstd15 AS numeric(38,3)) AS hwsstd15, 
    ROUND(CAST(vwsavg15 AS FLOAT),3) AS vwsavg15, 
    ROUND(CAST(ti15 AS FLOAT),3) AS ti15,
	intflag15,
	extflag15,
	enabled15,
	tilt,
	bearing,
	statusflag,
	infoflag,
	axysflag,
	algorithm,
	battery,
	generator,
	utemp,
	ltemp,
	podhumid,
	metcmpbearing,
	mettilt,
	pcktsrain,
	CAST(CASE WHEN pcktsfog IS NULL THEN 0 ELSE pcktsfog END AS numeric(38,3)) AS pcktsfog,
	rangeflag,
	constantflag,
	rocflag,
	spikeflag
FROM #PIVOT

--CREATE TEMP TIME SERIES AT A TIME DIFFERENCE OF 10 MINUTES
 
-- DECLARING VARIABLES
DECLARE @ID VARCHAR(20) 
DECLARE @RowCount INT
DECLARE @Counter INT
DECLARE @MaxDateTwind DATETIME
DECLARE @MaxDateRwind DATETIME

-- Create a temporary table to store the flidarid's that are not updated
DECLARE @Temp TABLE(
    SNO INT IDENTITY(1,1),
    FLIDARID VARCHAR(20)
)

-- Insert distinct values from the column into the temporary table where transflag = 0
INSERT INTO @Temp(FLIDARID)
SELECT DISTINCT flidarid FROM rwind WHERE transflag = 0

-- Get the total number of rows in the #Temp table
SELECT @RowCount = COUNT(*) FROM @Temp

-- Initialize the counter
SET @Counter = 0

-- Create a table to store the final results
CREATE TABLE #Dates (
    flidarid VARCHAR(20),
    TimeSeries DATETIME
)

-- Start looping through the values
WHILE @Counter <= @RowCount 
BEGIN
-- Retrieve the value from the temporary table based on the counter
    SELECT @ID = FLIDARID FROM @Temp WHERE SNO = @Counter

-- Retrieve the maximum datetime from twind for the current flidarid
    SET @MaxDateTwind = (
            SELECT CASE 
            WHEN (SELECT MAX(datetimekey) FROM twind WHERE flidarid = @ID) IS NOT NULL
            THEN (SELECT MAX(datetimekey) FROM twind WHERE flidarid = @ID)
            ELSE (SELECT MIN(datetimekey) FROM rwind WHERE flidarid = @ID AND transflag = 0)
        END)

-- Retrieve the maximum datetime from rwind for the current flidarid
    SET @MaxDateRwind = (SELECT MAX(datetimekey) FROM rwind WHERE flidarid = @ID AND transflag = 0)

-- Calculate dates in 10-minute intervals
    WHILE @MaxDateRwind >= @MaxDateTwind 
    BEGIN
-- Insert the current date into the result table
        INSERT INTO #Dates (flidarid, TimeSeries)
        VALUES (@ID, @MaxDateTwind)

-- Update the current date based on the condition
 SET @MaxDateTwind = DATEADD(MINUTE, 10, @MaxDateTwind)
    END

    -- Increment the counter
    SET @Counter = @Counter + 1
END

-- JOINING BOTN CROSSJOIN AND #TEMP INSERTING THE JOINED DATA IN NEW TABLE

SELECT * INTO #FINAL_TBL
FROM
(SELECT 
	ROW_NUMBER()over(ORDER BY D.flidarid) + 7124 AS sno,T.windkey AS twindkey,D.TimeSeries AS datetimekey,
	T.windkey,D.flidarid,T.packavalavg1, T.wdirtnavg1, T.wdirtnstd1, T.hwsavg1, T.hwsmin1, T.hwsmax1, T.hwsstd1, T.vwsavg1, T.ti1, T.intflag1, T.extflag1, T.enabled1,
    T.packavalavg2, T.wdirtnavg2, T.wdirtnstd2, T.hwsavg2, T.hwsmin2, T.hwsmax2, T.hwsstd2, T.vwsavg2, T.ti2, T.intflag2, T.extflag2, T.enabled2,
    T.packavalavg3, T.wdirtnavg3, T.wdirtnstd3, T.hwsavg3, T.hwsmin3, T.hwsmax3, T.hwsstd3, T.vwsavg3, T.ti3, T.intflag3, T.extflag3, T.enabled3,
    T.packavalavg4, T.wdirtnavg4, T.wdirtnstd4, T.hwsavg4, T.hwsmin4, T.hwsmax4, T.hwsstd4, T.vwsavg4, T.ti4, T.intflag4, T.extflag4, T.enabled4,
    T.packavalavg5, T.wdirtnavg5, T.wdirtnstd5, T.hwsavg5, T.hwsmin5, T.hwsmax5, T.hwsstd5, T.vwsavg5, T.ti5, T.intflag5, T.extflag5, T.enabled5,
    T.packavalavg6, T.wdirtnavg6, T.wdirtnstd6, T.hwsavg6, T.hwsmin6, T.hwsmax6, T.hwsstd6, T.vwsavg6, T.ti6, T.intflag6, T.extflag6, T.enabled6,
    T.packavalavg7, T.wdirtnavg7, T.wdirtnstd7, T.hwsavg7, T.hwsmin7, T.hwsmax7, T.hwsstd7, T.vwsavg7, T.ti7, T.intflag7, T.extflag7, T.enabled7,
    T.packavalavg8, T.wdirtnavg8, T.wdirtnstd8, T.hwsavg8, T.hwsmin8, T.hwsmax8, T.hwsstd8, T.vwsavg8, T.ti8, T.intflag8, T.extflag8, T.enabled8,
    T.packavalavg9, T.wdirtnavg9, T.wdirtnstd9, T.hwsavg9, T.hwsmin9, T.hwsmax9, T.hwsstd9, T.vwsavg9, T.ti9, T.intflag9, T.extflag9, T.enabled9,
    T.packavalavg10, T.wdirtnavg10, T.wdirtnstd10, T.hwsavg10, T.hwsmin10, T.hwsmax10, T.hwsstd10, T.vwsavg10, T.ti10, T.intflag10, T.extflag10, T.enabled10,
    T.packavalavg11, T.wdirtnavg11, T.wdirtnstd11, T.hwsavg11, T.hwsmin11, T.hwsmax11, T.hwsstd11, T.vwsavg11, T.ti11, T.intflag11, T.extflag11, T.enabled11,
    T.packavalavg12, T.wdirtnavg12, T.wdirtnstd12, T.hwsavg12, T.hwsmin12, T.hwsmax12, T.hwsstd12, T.vwsavg12, T.ti12, T.intflag12, T.extflag12, T.enabled12,
    T.packavalavg13, T.wdirtnavg13, T.wdirtnstd13, T.hwsavg13, T.hwsmin13, T.hwsmax13, T.hwsstd13, T.vwsavg13, T.ti13, T.intflag13, T.extflag13, T.enabled13,
    T.packavalavg14, T.wdirtnavg14, T.wdirtnstd14, T.hwsavg14, T.hwsmin14, T.hwsmax14, T.hwsstd14, T.vwsavg14, T.ti14, T.intflag14, T.extflag14, T.enabled14,
    T.packavalavg15, T.wdirtnavg15, T.wdirtnstd15, T.hwsavg15, T.hwsmin15, T.hwsmax15, T.hwsstd15, T.vwsavg15, T.ti15, T.intflag15, T.extflag15, T.enabled15,
    T.tilt, T.bearing, T.statusflag, T.infoflag, T.axysflag, T.algorithm, T.battery, T.generator, T.utemp, T.ltemp, T.podhumid, T.metcmpbearing, T.mettilt, T.pcktsrain,
    T.pcktsfog , T.rangeflag, T.constantflag, T.rocflag, T.spikeflag 
FROM 
	#Dates AS D
LEFT JOIN
	#TEMP AS T
ON 
	T.flidarid = D.flidarid 
AND
	T.datetimekey = D.TimeSeries) AS A

-- INSERTING #FINAL_TBL IN PRIMARY TABLE(TWIND)

BEGIN 
TRAN
INSERT INTO [dbo].[twind]
SELECT 
#FINAL_TBL.*,
'AUTO-SCRIPT',	CAST (GETDATE() AS SMALLDATETIME),	'AUTO-SCRIPT'	,CAST (GETDATE() AS SMALLDATETIME)
FROM #FINAL_TBL
UPDATE [dbo].[twind]
SET 
    intflag1 = 99, extflag1 = 999, enabled1 = 1,
    intflag2 = 99, extflag2 = 999, enabled2 = 1,
    intflag3 = 99, extflag3 = 999, enabled3 = 1,
    intflag4 = 99, extflag4 = 999, enabled4 = 1,
    intflag5 = 99, extflag5 = 999, enabled5 = 1,
    intflag6 = 99, extflag6 = 999, enabled6 = 1,
    intflag7 = 99, extflag7 = 999, enabled7 = 1,
    intflag8 = 99, extflag8 = 999, enabled8 = 1,
    intflag9 = 99, extflag9 = 999, enabled9 = 1,
    intflag10 = 99, extflag10 = 999, enabled10 = 1,
    intflag11 = 99, extflag11 = 999, enabled11 = 1,
    intflag12 = 99, extflag12 = 999, enabled12 = 1,
    intflag13 = 99, extflag13 = 999, enabled13 = 1,
    intflag14 = 99, extflag14 = 999, enabled14 = 1,
    intflag15 = 99, extflag15 = 999, enabled15 = 1
where windkey is not null
select * from [dbo].[twind]
UPDATE [dbo].[rwind]
SET transflag = 1 
WHERE transflag = 0
ROLLBACK TRAN
END
ELSE 
BEGIN
PRINT 'TABLE ALREADY UPDATED'
END
END

EXEC SP_EXECUTESQL RENEW_SP

