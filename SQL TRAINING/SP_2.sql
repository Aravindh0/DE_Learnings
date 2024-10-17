-- UNPIVOT

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

--SELECT * FROM #UNPIVOT


--DROP TABLE #UNPIVOT


-- CONVERTING TO PIVOT

SELECT * 
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
where datetimekey = '2020-12-30 11:40:00'

--CREATING TEMP PIVOT
drop table #PIVOT 
CREATE TABLE #PIVOT (
    packavalavg1 NUMERIC(18, 3),
    wdirtnavg1 NUMERIC(18, 3),
    wdirtnstd1 NUMERIC(18, 3),
    hwsavg1 NUMERIC(18, 3),
    hwsmin1 NUMERIC(18, 3),
    hwsmax1 NUMERIC(18, 3),
    hwsstd1 NUMERIC(18, 3),
    vwsavg1 NUMERIC(18, 3),
    ti1 NUMERIC(18, 3),
    intflag1 INT,
    extflag1 INT,
    enabled1 BIT,
    packavalavg2 NUMERIC(18, 3),
    wdirtnavg2 NUMERIC(18, 3),
    wdirtnstd2 NUMERIC(18, 3),
    hwsavg2 NUMERIC(18, 3),
    hwsmin2 NUMERIC(18, 3),
    hwsmax2 NUMERIC(18, 3),
    hwsstd2 NUMERIC(18, 3),
    vwsavg2 NUMERIC(18, 3),
    ti2 NUMERIC(18, 3),
    intflag2 INT,
    extflag2 INT,
    enabled2 BIT,
    packavalavg3 NUMERIC(18, 3),
    wdirtnavg3 NUMERIC(18, 3),
    wdirtnstd3 NUMERIC(18, 3),
    hwsavg3 NUMERIC(18, 3),
    hwsmin3 NUMERIC(18, 3),
    hwsmax3 NUMERIC(18, 3),
    hwsstd3 NUMERIC(18, 3),
    vwsavg3 NUMERIC(18, 3),
    ti3 NUMERIC(18, 3),
    intflag3 INT,
    extflag3 INT,
    enabled3 BIT,
    packavalavg4 NUMERIC(18, 3),
    wdirtnavg4 NUMERIC(18, 3),
    wdirtnstd4 NUMERIC(18, 3),
    hwsavg4 NUMERIC(18, 3),
    hwsmin4 NUMERIC(18, 3),
    hwsmax4 NUMERIC(18, 3),
    hwsstd4 NUMERIC(18, 3),
    vwsavg4 NUMERIC(18, 3),
    ti4 NUMERIC(18, 3),
    intflag4 INT,
    extflag4 INT,
    enabled4 BIT,
    packavalavg5 NUMERIC(18, 3),
    wdirtnavg5 NUMERIC(18, 3),
    wdirtnstd5 NUMERIC(18, 3),
    hwsavg5 NUMERIC(18, 3),
    hwsmin5 NUMERIC(18, 3),
    hwsmax5 NUMERIC(18, 3),
    hwsstd5 NUMERIC(18, 3),
    vwsavg5 NUMERIC(18, 3),
    ti5 NUMERIC(18, 3),
    intflag5 INT,
    extflag5 INT,
    enabled5 BIT,
    packavalavg6 NUMERIC(18, 3),
    wdirtnavg6 NUMERIC(18, 3),
    wdirtnstd6 NUMERIC(18, 3),
    hwsavg6 NUMERIC(18, 3),
    hwsmin6 NUMERIC(18, 3),
    hwsmax6 NUMERIC(18, 3),
    hwsstd6 NUMERIC(18, 3),
    vwsavg6 NUMERIC(18, 3),
    ti6 NUMERIC(18, 3),
    intflag6 INT,
    extflag6 INT,
    enabled6 BIT,
    packavalavg7 NUMERIC(18, 3),
    wdirtnavg7 NUMERIC(18, 3),
    wdirtnstd7 NUMERIC(18, 3),
    hwsavg7 NUMERIC(18, 3),
    hwsmin7 NUMERIC(18, 3),
    hwsmax7 NUMERIC(18, 3),
    hwsstd7 NUMERIC(18, 3),
    vwsavg7 NUMERIC(18, 3),
    ti7 NUMERIC(18, 3),
    intflag7 INT,
    extflag7 INT,
    enabled7 BIT,
    packavalavg8 NUMERIC(18, 3),
    wdirtnavg8 NUMERIC(18, 3),
    wdirtnstd8 NUMERIC(18, 3),
    hwsavg8 NUMERIC(18, 3),
    hwsmin8 NUMERIC(18, 3),
    hwsmax8 NUMERIC(18, 3),
    hwsstd8 NUMERIC(18, 3),
    vwsavg8 NUMERIC(18, 3),
    ti8 NUMERIC(18, 3),
    intflag8 INT,
    extflag8 INT,
    enabled8 BIT,
    packavalavg9 NUMERIC(18, 3),
    wdirtnavg9 NUMERIC(18, 3),
    wdirtnstd9 NUMERIC(18, 3),
    hwsavg9 NUMERIC(18, 3),
    hwsmin9 NUMERIC(18, 3),
    hwsmax9 NUMERIC(18, 3),
    hwsstd9 NUMERIC(18, 3),
    vwsavg9 NUMERIC(18, 3),
    ti9 NUMERIC(18, 3),
    intflag9 INT,
    extflag9 INT,
    enabled9 BIT,
    packavalavg10 NUMERIC(18, 3),
    wdirtnavg10 NUMERIC(18, 3),
    wdirtnstd10 NUMERIC(18, 3),
    hwsavg10 NUMERIC(18, 3),
    hwsmin10 NUMERIC(18, 3),
    hwsmax10 NUMERIC(18, 3),
    hwsstd10 NUMERIC(18, 3),
    vwsavg10 NUMERIC(18, 3),
    ti10 NUMERIC(18, 3),
    intflag10 INT,
    extflag10 INT,
    enabled10 BIT,
    packavalavg11 NUMERIC(18, 3),
    wdirtnavg11 NUMERIC(18, 3),
    wdirtnstd11 NUMERIC(18, 3),
    hwsavg11 NUMERIC(18, 3),
    hwsmin11 NUMERIC(18, 3),
    hwsmax11 NUMERIC(18, 3),
    hwsstd11 NUMERIC(18, 3),
    vwsavg11 NUMERIC(18, 3),
    ti11 NUMERIC(18, 3),
    intflag11 INT,
    extflag11 INT,
    enabled11 BIT,
    packavalavg12 NUMERIC(18, 3),
    wdirtnavg12 NUMERIC(18, 3),
    wdirtnstd12 NUMERIC(18, 3),
	hwsavg12 NUMERIC(18, 3),
    hwsmin12 NUMERIC(18, 3),
    hwsmax12 NUMERIC(18, 3),
    hwsstd12 NUMERIC(18, 3),
    vwsavg12 NUMERIC(18, 3),
    ti12 NUMERIC(18, 3),
    intflag12 INT,
    extflag12 INT,
    enabled12 BIT,
	packavalavg13 NUMERIC(18, 3),
    wdirtnavg13 NUMERIC(18, 3),
    wdirtnstd13 NUMERIC(18, 3),
	hwsavg13 NUMERIC(18, 3),
    hwsmin13 NUMERIC(18, 3),
    hwsmax13 NUMERIC(18, 3),
    hwsstd13 NUMERIC(18, 3),
    vwsavg13 NUMERIC(18, 3),
    ti13 NUMERIC(18, 3),
    intflag13 INT,
    extflag13 INT,
    enabled13 BIT,
	packavalavg14 NUMERIC(18, 3),
    wdirtnavg14 NUMERIC(18, 3),
    wdirtnstd14 NUMERIC(18, 3),
	hwsavg14 NUMERIC(18, 3),
    hwsmin14 NUMERIC(18, 3),
    hwsmax14 NUMERIC(18, 3),
    hwsstd14 NUMERIC(18, 3),
    vwsavg14 NUMERIC(18, 3),
    ti14 NUMERIC(18, 3),
    intflag14 INT,
    extflag14 INT,
    enabled14 BIT,
	packavalavg15 NUMERIC(18, 3),
    wdirtnavg15 NUMERIC(18, 3),
    wdirtnstd15 NUMERIC(18, 3),
	hwsavg15 NUMERIC(18, 3),
    hwsmin15 NUMERIC(18, 3),
    hwsmax15 NUMERIC(18, 3),
    hwsstd15 NUMERIC(18, 3),
    vwsavg15 NUMERIC(18, 3),
    ti15 NUMERIC(18, 3),
    intflag15 INT,
    extflag15 INT,
    enabled15 BIT,
	tilt NUMERIC(18, 3),
    bearing NUMERIC(18, 3),
    statusflag VARCHAR(MAX),
    infoflag VARCHAR(MAX),
    axysflag VARCHAR(MAX),
    algorithm VARCHAR(MAX),
    battery NUMERIC(18, 3),
    generator NUMERIC(18, 3),
    utemp NUMERIC(18, 3),
    ltemp NUMERIC(18, 3),
    podhumid NUMERIC(18, 3),
    metcmpbearing NUMERIC(18, 3),
    mettilt NUMERIC(18, 3),
    pcktsrain NUMERIC(18, 3),
    pcktsfog NUMERIC(18, 3),
    rangeflag INT,
    constantflag INT,
	rocflag INT,
    spikeflag INT
)

SELECT *
INTO #PIVOT
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

SELECT * FROM #PIVOT

-- DROP TABLE #PIVOT

--CREATE TEMP TIME SERIES 

SELECT MAX(datetimekey) FROM [dbo].[rwind]
SELECT MAX(datetimekey) FROM [dbo].[twind]

DECLARE @RMAXDATE DATETIME
DECLARE @TMAXDATE DATETIME
SELECT @RMAXDATE = MAX(datetimekey) FROM [dbo].[rwind]
SELECT @TMAXDATE = MAX(datetimekey) FROM [dbo].[twind]

CREATE TABLE #TIME
	(TimeSeries DATETIME) 

WHILE @RMAXDATE > @TMAXDATE
BEGIN
    INSERT INTO #TIME 
    VALUES (@TMAXDATE)
    SET @TMAXDATE = DATEADD(MINUTE, 10, @TMAXDATE)
END

SELECT * FROM #TIME

--DROP TABLE #TIME

--CREATING TEMP TABLE FOR CROSS JOINED TIME SERIES

CREATE TABLE #CROSSJOIN
(
flidarid VARCHAR(MAX),
TimeSeries DATETIME
)

INSERT INTO #CROSSJOIN
SELECT DISTINCT flidarid, TimeSeries FROM #TIME 
CROSS JOIN [dbo].[rwind] 

SELECT * FROM #CROSSJOIN 
--DROP TABLE #CROSSJOIN

-- JOINING PIVOT AND TIME SERIES TABLES

SELECT C.TimeSeries,
	C.flidarid,P.windkey,P.packavalavg1, P.wdirtnavg1, P.wdirtnstd1, P.hwsavg1, P.hwsmin1, P.hwsmax1, P.hwsstd1, P.vwsavg1, P.ti1, P.intflag1, P.extflag1, P.enabled1,
    P.packavalavg2, P.wdirtnavg2, P.wdirtnstd2, P.hwsavg2, P.hwsmin2, P.hwsmax2, P.hwsstd2, P.vwsavg2, P.ti2, P.intflag2, P.extflag2, P.enabled2,
    P.packavalavg3, P.wdirtnavg3, P.wdirtnstd3, P.hwsavg3, P.hwsmin3, P.hwsmax3, P.hwsstd3, P.vwsavg3, P.ti3, P.intflag3, P.extflag3, P.enabled3,
    P.packavalavg4, P.wdirtnavg4, P.wdirtnstd4, P.hwsavg4, P.hwsmin4, P.hwsmax4, P.hwsstd4, P.vwsavg4, P.ti4, P.intflag4, P.extflag4, P.enabled4,
    P.packavalavg5, P.wdirtnavg5, P.wdirtnstd5, P.hwsavg5, P.hwsmin5, P.hwsmax5, P.hwsstd5, P.vwsavg5, P.ti5, P.intflag5, P.extflag5, P.enabled5,
    P.packavalavg6, P.wdirtnavg6, P.wdirtnstd6, P.hwsavg6, P.hwsmin6, P.hwsmax6, P.hwsstd6, P.vwsavg6, P.ti6, P.intflag6, P.extflag6, P.enabled6,
    P.packavalavg7, P.wdirtnavg7, P.wdirtnstd7, P.hwsavg7, P.hwsmin7, P.hwsmax7, P.hwsstd7, P.vwsavg7, P.ti7, P.intflag7, P.extflag7, P.enabled7,
    P.packavalavg8, P.wdirtnavg8, P.wdirtnstd8, P.hwsavg8, P.hwsmin8, P.hwsmax8, P.hwsstd8, P.vwsavg8, P.ti8, P.intflag8, P.extflag8, P.enabled8,
    P.packavalavg9, P.wdirtnavg9, P.wdirtnstd9, P.hwsavg9, P.hwsmin9, P.hwsmax9, P.hwsstd9, P.vwsavg9, P.ti9, P.intflag9, P.extflag9, P.enabled9,
    P.packavalavg10, P.wdirtnavg10, P.wdirtnstd10, P.hwsavg10, P.hwsmin10, P.hwsmax10, P.hwsstd10, P.vwsavg10, P.ti10, P.intflag10, P.extflag10, P.enabled10,
    P.packavalavg11, P.wdirtnavg11, P.wdirtnstd11, P.hwsavg11, P.hwsmin11, P.hwsmax11, P.hwsstd11, P.vwsavg11, P.ti11, P.intflag11, P.extflag11, P.enabled11,
    P.packavalavg12, P.wdirtnavg12, P.wdirtnstd12, P.hwsavg12, P.hwsmin12, P.hwsmax12, P.hwsstd12, P.vwsavg12, P.ti12, P.intflag12, P.extflag12, P.enabled12,
    P.packavalavg13, P.wdirtnavg13, P.wdirtnstd13, P.hwsavg13, P.hwsmin13, P.hwsmax13, P.hwsstd13, P.vwsavg13, P.ti13, P.intflag13, P.extflag13, P.enabled13,
    P.packavalavg14, P.wdirtnavg14, P.wdirtnstd14, P.hwsavg14, P.hwsmin14, P.hwsmax14, P.hwsstd14, P.vwsavg14, P.ti14, P.intflag14, P.extflag14, P.enabled14,
    P.packavalavg15, P.wdirtnavg15, P.wdirtnstd15, P.hwsavg15, P.hwsmin15, P.hwsmax15, P.hwsstd15, P.vwsavg15, P.ti15, P.intflag15, P.extflag15, P.enabled15,
    P.tilt, P.bearing, P.statusflag, P.infoflag, P.axysflag, P.algorithm, P.battery, P.generator, P.utemp, P.ltemp, P.podhumid, P.metcmpbearing, P.mettilt, P.pcktsrain,
    P.pcktsfog, P.rangeflag, P.constantflag, P.rocflag, P.spikeflag 
FROM 
	#CROSSJOIN AS C
LEFT JOIN
	#PIVOT AS P
ON 
	P.flidarid = C.flidarid 
AND
	P.datetimekey = C.TimeSeries


-- CREATING TABLE FROM JOINING PIVOT AND TIME SERIES
insert into PT
SELECT ROW_NUMBER()over(ORDER BY C.flidarid) + 7124 AS sno,P.windkey AS twindkey,C.TimeSeries  AS datetimekey,
	P.windkey,C.flidarid,P.packavalavg1, P.wdirtnavg1, P.wdirtnstd1, P.hwsavg1, P.hwsmin1, P.hwsmax1, P.hwsstd1, P.vwsavg1, P.ti1, P.intflag1, P.extflag1, P.enabled1,
    P.packavalavg2, P.wdirtnavg2, P.wdirtnstd2, P.hwsavg2, P.hwsmin2, P.hwsmax2, P.hwsstd2, P.vwsavg2, P.ti2, P.intflag2, P.extflag2, P.enabled2,
    P.packavalavg3, P.wdirtnavg3, P.wdirtnstd3, P.hwsavg3, P.hwsmin3, P.hwsmax3, P.hwsstd3, P.vwsavg3, P.ti3, P.intflag3, P.extflag3, P.enabled3,
    P.packavalavg4, P.wdirtnavg4, P.wdirtnstd4, P.hwsavg4, P.hwsmin4, P.hwsmax4, P.hwsstd4, P.vwsavg4, P.ti4, P.intflag4, P.extflag4, P.enabled4,
    P.packavalavg5, P.wdirtnavg5, P.wdirtnstd5, P.hwsavg5, P.hwsmin5, P.hwsmax5, P.hwsstd5, P.vwsavg5, P.ti5, P.intflag5, P.extflag5, P.enabled5,
    P.packavalavg6, P.wdirtnavg6, P.wdirtnstd6, P.hwsavg6, P.hwsmin6, P.hwsmax6, P.hwsstd6, P.vwsavg6, P.ti6, P.intflag6, P.extflag6, P.enabled6,
    P.packavalavg7, P.wdirtnavg7, P.wdirtnstd7, P.hwsavg7, P.hwsmin7, P.hwsmax7, P.hwsstd7, P.vwsavg7, P.ti7, P.intflag7, P.extflag7, P.enabled7,
    P.packavalavg8, P.wdirtnavg8, P.wdirtnstd8, P.hwsavg8, P.hwsmin8, P.hwsmax8, P.hwsstd8, P.vwsavg8, P.ti8, P.intflag8, P.extflag8, P.enabled8,
    P.packavalavg9, P.wdirtnavg9, P.wdirtnstd9, P.hwsavg9, P.hwsmin9, P.hwsmax9, P.hwsstd9, P.vwsavg9, P.ti9, P.intflag9, P.extflag9, P.enabled9,
    P.packavalavg10, P.wdirtnavg10, P.wdirtnstd10, P.hwsavg10, P.hwsmin10, P.hwsmax10, P.hwsstd10, P.vwsavg10, P.ti10, P.intflag10, P.extflag10, P.enabled10,
    P.packavalavg11, P.wdirtnavg11, P.wdirtnstd11, P.hwsavg11, P.hwsmin11, P.hwsmax11, P.hwsstd11, P.vwsavg11, P.ti11, P.intflag11, P.extflag11, P.enabled11,
    P.packavalavg12, P.wdirtnavg12, P.wdirtnstd12, P.hwsavg12, P.hwsmin12, P.hwsmax12, P.hwsstd12, P.vwsavg12, P.ti12, P.intflag12, P.extflag12, P.enabled12,
    P.packavalavg13, P.wdirtnavg13, P.wdirtnstd13, P.hwsavg13, P.hwsmin13, P.hwsmax13, P.hwsstd13, P.vwsavg13, P.ti13, P.intflag13, P.extflag13, P.enabled13,
    P.packavalavg14, P.wdirtnavg14, P.wdirtnstd14, P.hwsavg14, P.hwsmin14, P.hwsmax14, P.hwsstd14, P.vwsavg14, P.ti14, P.intflag14, P.extflag14, P.enabled14,
    P.packavalavg15, P.wdirtnavg15, P.wdirtnstd15, P.hwsavg15, P.hwsmin15, P.hwsmax15, P.hwsstd15, P.vwsavg15, P.ti15, P.intflag15, P.extflag15, P.enabled15,
    P.tilt, P.bearing, P.statusflag, P.infoflag, P.axysflag, P.algorithm, P.battery, P.generator, P.utemp, P.ltemp, P.podhumid, P.metcmpbearing, P.mettilt, P.pcktsrain,
    P.pcktsfog, P.rangeflag, P.constantflag, P.rocflag, P.spikeflag
FROM  
	#CROSSJOIN AS C
LEFT JOIN
	#PIVOT AS P
ON 
	P.flidarid = C.flidarid 
AND
	P.datetimekey = C.TimeSeries

--SELECT * FROM PT WHERE FLIDARID = 'FLI000008' ORDER BY 1

select * from PT
--DROP TABLE PT

--INSERTING 
BEGIN 
TRAN
INSERT INTO [dbo].[twind]
SELECT 
PT.*,
'AUTO-SCRIPT',	CAST ('2021-01-07 04:17:00' AS SMALLDATETIME),	'AUTO-SCRIPT'	,CAST ('2021-01-07 04:17:00' AS SMALLDATETIME)
FROM PT
select * from [dbo].[twind]
ROLLBACK TRAN


INSERT INTO [dbo].[twind] (updateddatetime)
SELECT 
   TOP 1 CAST ('2021-01-07 04:17:00' AS SMALLDATETIME) 
   
FROM PT


SELECT * FROM [dbo].[twind]



SELECT COUNT(*) AS NumberOfColumns
FROM sys.columns
WHERE object_id = OBJECT_ID('[dbo].[Twind]')

SELECT COUNT(*) AS NumberOfColumns
FROM sys.columns
WHERE object_id = OBJECT_ID('PT')



