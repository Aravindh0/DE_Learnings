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

SELECT * INTO NEW_P
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

SELECT * FROM NEW_P


SELECT *FROM RWIND
SELECT * FROM RWINDREF WHERE flidarid = 'FLI000008'

-- CONVERTING FROM SCIENTIFIC TO NUMERIC
select * into TBL1
FROM
(SELECT
	windkey,
	datetimekey,
	flidarid,
	transflag,
	FORMAT (CAST(packavalavg1 AS FLOAT) , 'N3') AS packavalavg1, 
    FORMAT (CAST(wdirtnavg1 AS FLOAT), 'N3') AS wdirtnavg1, 
    FORMAT (CAST(wdirtnstd1 AS FLOAT) , 'N3') AS wdirtnstd1, 
    FORMAT (CAST(hwsavg1 AS FLOAT), 'N3') AS hwsavg1, 
    FORMAT (CAST(hwsmin1 AS FLOAT), 'N3') AS hwsmin1,  
    FORMAT (CAST(hwsmax1 AS FLOAT), 'N3') AS hwsmax1, 
    FORMAT (CAST(hwsstd1 AS FLOAT), 'N3') AS hwsstd1, 
    FORMAT (CAST(vwsavg1 AS FLOAT), 'N3') AS vwsavg1, 
    FORMAT (CAST(ti1 AS FLOAT), 'N3') AS ti1,
    FORMAT (CAST(packavalavg2 AS FLOAT) , 'N3') AS packavalavg2, 
    FORMAT (CAST(wdirtnavg2 AS FLOAT), 'N3') AS wdirtnavg2, 
    FORMAT (CAST(wdirtnstd2 AS FLOAT), 'N3') AS wdirtnstd2, 
    FORMAT (CAST(hwsavg2 AS FLOAT), 'N3') AS hwsavg2, 
    FORMAT (CAST(hwsmin2 AS FLOAT), 'N3') AS hwsmin2, 
    FORMAT (CAST(hwsmax2 AS FLOAT), 'N3') AS hwsmax2, 
    FORMAT (CAST(hwsstd2 AS FLOAT), 'N3') AS hwsstd2, 
    FORMAT (CAST(vwsavg2 AS FLOAT), 'N3') AS vwsavg2, 
    FORMAT (CAST(ti2 AS FLOAT), 'N3') AS ti2, 
    FORMAT (CAST(packavalavg3 AS FLOAT), 'N3') AS packavalavg3, 
    FORMAT (CAST(wdirtnavg3 AS FLOAT), 'N3') AS wdirtnavg3, 
    FORMAT (CAST(wdirtnstd3 AS FLOAT), 'N3') AS wdirtnstd3, 
    FORMAT (CAST(hwsavg3 AS FLOAT), 'N3') AS hwsavg3, 
    FORMAT (CAST(hwsmin3 AS FLOAT), 'N3') AS hwsmin3, 
    FORMAT (CAST(hwsmax3 AS FLOAT), 'N3') AS hwsmax3, 
    FORMAT (CAST(hwsstd3 AS FLOAT), 'N3') AS hwsstd3, 
    FORMAT (CAST(vwsavg3 AS FLOAT), 'N3') AS vwsavg3, 
    FORMAT (CAST(ti3 AS FLOAT) , 'N3') AS ti3,
    FORMAT (CAST(packavalavg4 AS FLOAT) , 'N3') AS packavalavg4, 
    FORMAT (CAST(wdirtnavg4 AS FLOAT), 'N3') AS wdirtnavg4, 
    FORMAT (CAST(wdirtnstd4 AS FLOAT), 'N3') AS wdirtnstd4, 
    FORMAT (CAST(hwsavg4 AS FLOAT), 'N3') AS hwsavg4, 
    FORMAT (CAST(hwsmin4 AS FLOAT), 'N3') AS hwsmin4, 
    FORMAT (CAST(hwsmax4 AS FLOAT), 'N3') AS hwsmax4, 
    FORMAT (CAST(hwsstd4 AS FLOAT), 'N3') AS hwsstd4, 
    FORMAT (CAST(vwsavg4 AS FLOAT), 'N3') AS vwsavg4, 
    FORMAT (CAST(ti4 AS FLOAT), 'N3') AS ti4,
    FORMAT (CAST(packavalavg5 AS FLOAT), 'N3') AS packavalavg5, 
    FORMAT (CAST(wdirtnavg5 AS FLOAT), 'N3') AS wdirtnavg5, 
    FORMAT (CAST(wdirtnstd5 AS FLOAT) , 'N3') AS wdirtnstd5, 
    FORMAT (CAST(hwsavg5 AS FLOAT), 'N3') AS hwsavg5, 
    FORMAT (CAST(hwsmin5 AS FLOAT), 'N3') AS hwsmin5, 
    FORMAT (CAST(hwsmax5 AS FLOAT), 'N3') AS hwsmax5, 
    FORMAT (CAST(hwsstd5 AS FLOAT), 'N3') AS hwsstd5, 
    FORMAT (CAST(vwsavg5 AS FLOAT), 'N3') AS vwsavg5, 
    FORMAT (CAST(ti5 AS FLOAT), 'N3') AS ti5,  
    FORMAT (CAST(packavalavg6 AS FLOAT), 'N3') AS packavalavg6, 
    FORMAT (CAST(wdirtnavg6 AS FLOAT), 'N3') AS wdirtnavg6, 
    FORMAT (CAST(wdirtnstd6 AS FLOAT), 'N3') AS wdirtnstd6, 
    FORMAT (CAST(hwsavg6 AS FLOAT), 'N3') AS hwsavg6, 
    FORMAT (CAST(hwsmin6 AS FLOAT), 'N3') AS hwsmin6, 
    FORMAT (CAST(hwsmax6 AS FLOAT), 'N3') AS hwsmax6, 
    FORMAT (CAST(hwsstd6 AS FLOAT) , 'N3') AS hwsstd6, 
    FORMAT (CAST(vwsavg6 AS FLOAT) , 'N3') AS vwsavg6, 
    FORMAT (CAST(ti6 AS FLOAT), 'N3') AS ti6, 
    FORMAT (CAST(packavalavg7 AS FLOAT), 'N3') AS packavalavg7, 
    FORMAT (CAST(wdirtnavg7 AS FLOAT), 'N3') AS wdirtnavg7, 
    FORMAT (CAST(wdirtnstd7 AS FLOAT), 'N3') AS wdirtnstd7, 
    FORMAT (CAST(hwsavg7 AS FLOAT) , 'N3') AS hwsavg7, 
    FORMAT (CAST(hwsmin7 AS FLOAT), 'N3') AS hwsmin7, 
    FORMAT (CAST(hwsmax7 AS FLOAT), 'N3') AS hwsmax7, 
    FORMAT (CAST(hwsstd7 AS FLOAT), 'N3') AS hwsstd7, 
    FORMAT (CAST(vwsavg7 AS FLOAT), 'N3') AS vwsavg7, 
    FORMAT (CAST(ti7 AS FLOAT), 'N3') AS ti7, 
    FORMAT (CAST(packavalavg8 AS FLOAT), 'N3') AS packavalavg8, 
    FORMAT (CAST(wdirtnavg8 AS FLOAT), 'N3') AS wdirtnavg8, 
    FORMAT (CAST(wdirtnstd8 AS FLOAT), 'N3') AS wdirtnstd8, 
    FORMAT (CAST(hwsavg8 AS FLOAT), 'N3') AS hwsavg8, 
    FORMAT (CAST(hwsmin8 AS FLOAT), 'N3') AS hwsmin8, 
    FORMAT (CAST(hwsmax8 AS FLOAT), 'N3') AS hwsmax8, 
    FORMAT (CAST(hwsstd8 AS FLOAT), 'N3') AS hwsstd8, 
    FORMAT (CAST(vwsavg8 AS FLOAT), 'N3') AS vwsavg8,
	FORMAT (CAST(ti8 AS FLOAT), 'N3') AS ti8, 
    FORMAT (CAST(packavalavg9 AS FLOAT), 'N3') AS packavalavg9, 
    FORMAT (CAST(wdirtnavg9 AS FLOAT), 'N3') AS wdirtnavg9, 
    FORMAT (CAST(wdirtnstd9 AS FLOAT), 'N3') AS wdirtnstd9, 
    FORMAT (cast(hwsavg9 AS FLOAT), 'N3') AS hwsavg9, 
    FORMAT (cast(hwsmin9 AS FLOAT), 'N3') AS hwsmin9, 
    FORMAT (cast(hwsmax9 AS FLOAT), 'N3') AS hwsmax9, 
    FORMAT (cast(hwsstd9 AS FLOAT), 'N3') AS hwsstd9, 
    FORMAT (cast(vwsavg9 AS FLOAT), 'N3') AS vwsavg9, 
    FORMAT (CAST(ti9 AS FLOAT), 'N3') AS ti9,  
    FORMAT (CAST(packavalavg10 AS FLOAT), 'N3') AS packavalavg10, 
    FORMAT (CAST(wdirtnavg10 AS FLOAT), 'N3') AS wdirtnavg10, 
    FORMAT (CAST(wdirtnstd10 AS FLOAT), 'N3') AS wdirtnstd10, 
    FORMAT (CAST(hwsavg10 AS FLOAT), 'N3') AS hwsavg10, 
    FORMAT (CAST(hwsmin10 AS FLOAT), 'N3') AS hwsmin10, 
    FORMAT (CAST(hwsmax10 AS FLOAT), 'N3') AS hwsmax10, 
    FORMAT (CAST(hwsstd10 AS FLOAT), 'N3') AS hwsstd10, 
    FORMAT (CAST(vwsavg10 AS FLOAT), 'N3') AS vwsavg10, 
    FORMAT (CAST(ti10 AS FLOAT), 'N3') AS ti10,  
    FORMAT (CAST(packavalavg11 AS FLOAT), 'N3') AS packavalavg11, 
    FORMAT (CAST(wdirtnavg11 AS FLOAT), 'N3') AS wdirtnavg11, 
    FORMAT (CAST(wdirtnstd11 AS FLOAT), 'N3') AS wdirtnstd11, 
    FORMAT (CAST(hwsavg11 AS FLOAT), 'N3') AS hwsavg11, 
    FORMAT (CAST(hwsmin11 AS FLOAT), 'N3') AS hwsmin11, 
    FORMAT (CAST(hwsmax11 AS FLOAT), 'N3') AS hwsmax11, 
    FORMAT (CAST(hwsstd11 AS FLOAT), 'N3') AS hwsstd11, 
    FORMAT (CAST(vwsavg11 AS FLOAT), 'N3') AS vwsavg11, 
    FORMAT (CAST(ti11 AS FLOAT), 'N3') AS ti11, 
    FORMAT (CAST(packavalavg12 AS FLOAT), 'N3') AS packavalavg12, 
    FORMAT (CAST(wdirtnavg12 AS FLOAT), 'N3') AS wdirtnavg12, 
    FORMAT (CAST(wdirtnstd12 AS FLOAT), 'N3') AS wdirtnstd12, 
    FORMAT (CAST(hwsavg12 AS FLOAT), 'N3') AS hwsavg12, 
    FORMAT (CAST(hwsmin12 AS FLOAT), 'N3') AS hwsmin12, 
    FORMAT (CAST(hwsmax12 AS FLOAT), 'N3') AS hwsmax12, 
    FORMAT (CAST(hwsstd12 AS FLOAT), 'N3') AS hwsstd12, 
    FORMAT (CAST(vwsavg12 AS FLOAT), 'N3') AS vwsavg12, 
    FORMAT (CAST(ti12 AS FLOAT), 'N3') AS ti12, 
    FORMAT (CAST(packavalavg13 AS FLOAT), 'N3') AS packavalavg13, 
    FORMAT (CAST(wdirtnavg13 AS FLOAT), 'N3') AS wdirtnavg13, 
    FORMAT (CAST(wdirtnstd13 AS FLOAT), 'N3') AS wdirtnstd13, 
    FORMAT (CAST(hwsavg13 AS FLOAT), 'N3') AS hwsavg13, 
    FORMAT (CAST(hwsmin13 AS FLOAT), 'N3') AS hwsmin13, 
    FORMAT (CAST(hwsmax13 AS FLOAT), 'N3') AS hwsmax13, 
    FORMAT (CAST(hwsstd13 AS FLOAT), 'N3') AS hwsstd13, 
    FORMAT (CAST(vwsavg13 AS FLOAT), 'N3') AS vwsavg13, 
    FORMAT (CAST(ti13 AS FLOAT), 'N3') AS ti13, 
    FORMAT (CAST(packavalavg14 AS FLOAT), 'N3') AS packavalavg14, 
    FORMAT (CAST(wdirtnavg14 AS FLOAT), 'N3') AS wdirtnavg14, 
    FORMAT (CAST(wdirtnstd14 AS FLOAT), 'N3') AS wdirtnstd14, 
    FORMAT (CAST(hwsavg14 AS FLOAT), 'N3') AS hwsavg14, 
    FORMAT (CAST(hwsmin14 AS FLOAT), 'N3') AS hwsmin14, 
    FORMAT (CAST(hwsmax14 AS FLOAT), 'N3') AS hwsmax14, 
    FORMAT (CAST(hwsstd14 AS FLOAT), 'N3') AS hwsstd14, 
    FORMAT (CAST(vwsavg14 AS FLOAT), 'N3') AS vwsavg14, 
    FORMAT (CAST(ti14 AS FLOAT), 'N3') AS ti14,  
    FORMAT (CAST(packavalavg15 AS FLOAT), 'N3') AS packavalavg15, 
    FORMAT (CAST(wdirtnavg15 AS FLOAT), 'N3') AS wdirtnavg15, 
    FORMAT (CAST(wdirtnstd15 AS FLOAT), 'N3') AS wdirtnstd15, 
    FORMAT (CAST(hwsavg15 AS FLOAT), 'N3') AS hwsavg15, 
    FORMAT (CAST(hwsmin15 AS FLOAT), 'N3') AS hwsmin15, 
    FORMAT (CAST(hwsmax15 AS FLOAT), 'N3') AS hwsmax15, 
    FORMAT (CAST(hwsstd15 AS FLOAT), 'N3') AS hwsstd15, 
    FORMAT (CAST(vwsavg15 AS FLOAT), 'N3') AS vwsavg15, 
    FORMAT (CAST(ti15 AS FLOAT), 'N3') AS ti15,
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
	pcktsfog,
	rangeflag,
	constantflag,
	rocflag,
	spikeflag
FROM NEW_P) AS A
--CREATING TEMP PIVOT
 DROP TABLE PIVOT_1
SELECT * 
INTO PIVOT_1
FROM
(SELECT windkey,datetimekey,flidarid,
	CAST(packavalavg1 AS FLOAT) AS packavalavg1, 
    CAST(wdirtnavg1 AS FLOAT) AS wdirtnavg1, 
    CAST(wdirtnstd1 AS FLOAT) AS wdirtnstd1, 
    CAST(hwsavg1 AS FLOAT) AS hwsavg1, 
    CAST(hwsmin1 AS FLOAT) AS hwsmin1, 
    CAST(hwsmax1 AS FLOAT) AS hwsmax1, 
    CAST(hwsstd1 AS FLOAT) AS hwsstd1, 
    CAST(vwsavg1 AS FLOAT) AS vwsavg1, 
    CAST(ti1 AS FLOAT) AS ti1, 
    CAST(intflag1 AS int) AS intflag1, 
    CAST(extflag1 AS int) AS extflag1, 
    CAST(enabled1 AS bit) AS enabled1, 
    CAST(packavalavg2 AS FLOAT) AS packavalavg2, 
    CAST(wdirtnavg2 AS FLOAT) AS wdirtnavg2, 
    CAST(wdirtnstd2 AS FLOAT) AS wdirtnstd2, 
    CAST(hwsavg2 AS FLOAT) AS hwsavg2, 
    CAST(hwsmin2 AS FLOAT) AS hwsmin2, 
    CAST(hwsmax2 AS FLOAT) AS hwsmax2, 
    CAST(hwsstd2 AS FLOAT) AS hwsstd2, 
    CAST(vwsavg2 AS FLOAT) AS vwsavg2, 
    CAST(ti2 AS FLOAT) AS ti2, 
    CAST(intflag2 AS int) AS intflag2, 
    CAST(extflag2 AS int) AS extflag2, 
    CAST(enabled2 AS bit) AS enabled2, 
    CAST(packavalavg3 AS FLOAT) AS packavalavg3, 
    CAST(wdirtnavg3 AS FLOAT) AS wdirtnavg3, 
    CAST(wdirtnstd3 AS FLOAT) AS wdirtnstd3, 
    CAST(hwsavg3 AS FLOAT) AS hwsavg3, 
    CAST(hwsmin3 AS FLOAT) AS hwsmin3, 
    CAST(hwsmax3 AS FLOAT) AS hwsmax3, 
    CAST(hwsstd3 AS FLOAT) AS hwsstd3, 
    CAST(vwsavg3 AS FLOAT) AS vwsavg3, 
    CAST(ti3 AS FLOAT) AS ti3, 
    CAST(intflag3 AS int) AS intflag3, 
    CAST(extflag3 AS int) AS extflag3, 
    CAST(enabled3 AS bit) AS enabled3, 
    CAST(packavalavg4 AS FLOAT) AS packavalavg4, 
    CAST(wdirtnavg4 AS FLOAT) AS wdirtnavg4, 
    CAST(wdirtnstd4 AS FLOAT) AS wdirtnstd4, 
    CAST(hwsavg4 AS FLOAT) AS hwsavg4, 
    CAST(hwsmin4 AS FLOAT) AS hwsmin4, 
    CAST(hwsmax4 AS FLOAT) AS hwsmax4, 
    CAST(hwsstd4 AS FLOAT) AS hwsstd4, 
    CAST(vwsavg4 AS FLOAT) AS vwsavg4, 
    CAST(ti4 AS FLOAT) AS ti4, 
    CAST(intflag4 AS int) AS intflag4, 
    CAST(extflag4 AS int) AS extflag4, 
    CAST(enabled4 AS bit) AS enabled4, 
    CAST(packavalavg5 AS FLOAT) AS packavalavg5, 
    CAST(wdirtnavg5 AS FLOAT) AS wdirtnavg5, 
    CAST(wdirtnstd5 AS FLOAT) AS wdirtnstd5, 
    CAST(hwsavg5 AS FLOAT) AS hwsavg5, 
    CAST(hwsmin5 AS FLOAT) AS hwsmin5, 
    CAST(hwsmax5 AS FLOAT) AS hwsmax5, 
    CAST(hwsstd5 AS FLOAT) AS hwsstd5, 
    CAST(vwsavg5 AS FLOAT) AS vwsavg5, 
    CAST(ti5 AS FLOAT) AS ti5, 
    CAST(intflag5 AS int) AS intflag5, 
    CAST(extflag5 AS int) AS extflag5, 
    CAST(enabled5 AS bit) AS enabled5, 
    CAST(packavalavg6 AS FLOAT) AS packavalavg6, 
    CAST(wdirtnavg6 AS FLOAT) AS wdirtnavg6, 
    CAST(wdirtnstd6 AS FLOAT) AS wdirtnstd6, 
    CAST(hwsavg6 AS FLOAT) AS hwsavg6, 
    CAST(hwsmin6 AS FLOAT) AS hwsmin6, 
    CAST(hwsmax6 AS FLOAT) AS hwsmax6, 
    CAST(hwsstd6 AS FLOAT) AS hwsstd6, 
    CAST(vwsavg6 AS FLOAT) AS vwsavg6, 
    CAST(ti6 AS FLOAT) AS ti6, 
    CAST(intflag6 AS int) AS intflag6, 
    CAST(extflag6 AS int) AS extflag6, 
    CAST(enabled6 AS bit) AS enabled6, 
    CAST(packavalavg7 AS FLOAT) AS packavalavg7, 
    CAST(wdirtnavg7 AS FLOAT) AS wdirtnavg7, 
    CAST(wdirtnstd7 AS FLOAT) AS wdirtnstd7, 
    CAST(hwsavg7 AS FLOAT) AS hwsavg7, 
    CAST(hwsmin7 AS FLOAT) AS hwsmin7, 
    CAST(hwsmax7 AS FLOAT) AS hwsmax7, 
    CAST(hwsstd7 AS FLOAT) AS hwsstd7, 
    CAST(vwsavg7 AS FLOAT) AS vwsavg7, 
    CAST(ti7 AS FLOAT) AS ti7, 
    CAST(intflag7 AS int) AS intflag7, 
    CAST(extflag7 AS int) AS extflag7, 
    CAST(enabled7 AS bit) AS enabled7, 
    CAST(packavalavg8 AS FLOAT) AS packavalavg8, 
    CAST(wdirtnavg8 AS FLOAT) AS wdirtnavg8, 
    CAST(wdirtnstd8 AS FLOAT) AS wdirtnstd8, 
    CAST(hwsavg8 AS FLOAT) AS hwsavg8, 
    CAST(hwsmin8 AS FLOAT) AS hwsmin8, 
    CAST(hwsmax8 AS FLOAT) AS hwsmax8, 
    CAST(hwsstd8 AS FLOAT) AS hwsstd8, 
    CAST(vwsavg8 AS FLOAT) AS vwsavg8,
	CAST(ti8 AS FLOAT) AS ti8, 
    CAST(intflag8 AS int) AS intflag8, 
    CAST(extflag8 AS int) AS extflag8, 
    CAST(enabled8 AS bit) AS enabled8, 
    CAST(packavalavg9 AS FLOAT) AS packavalavg9, 
    CAST(wdirtnavg9 AS FLOAT) AS wdirtnavg9, 
    CAST(wdirtnstd9 AS FLOAT) AS wdirtnstd9, 
    CAST(hwsavg9 AS FLOAT) AS hwsavg9, 
    CAST(hwsmin9 AS FLOAT) AS hwsmin9, 
    CAST(hwsmax9 AS FLOAT) AS hwsmax9, 
    CAST(hwsstd9 AS FLOAT) AS hwsstd9, 
    CAST(vwsavg9 AS FLOAT) AS vwsavg9, 
    CAST(ti9 AS FLOAT) AS ti9, 
    CAST(intflag9 AS int) AS intflag9, 
    CAST(extflag9 AS int) AS extflag9, 
    CAST(enabled9 AS bit) AS enabled9, 
    CAST(packavalavg10 AS FLOAT) AS packavalavg10, 
    CAST(wdirtnavg10 AS FLOAT) AS wdirtnavg10, 
    CAST(wdirtnstd10 AS FLOAT) AS wdirtnstd10, 
    CAST(hwsavg10 AS FLOAT) AS hwsavg10, 
    CAST(hwsmin10 AS FLOAT) AS hwsmin10, 
    CAST(hwsmax10 AS FLOAT) AS hwsmax10, 
    CAST(hwsstd10 AS FLOAT) AS hwsstd10, 
    CAST(vwsavg10 AS FLOAT) AS vwsavg10, 
    CAST(ti10 AS FLOAT) AS ti10, 
    CAST(intflag10 AS int) AS intflag10, 
    CAST(extflag10 AS int) AS extflag10, 
    CAST(enabled10 AS bit) AS enabled10, 
    CAST(packavalavg11 AS FLOAT) AS packavalavg11, 
    CAST(wdirtnavg11 AS FLOAT) AS wdirtnavg11, 
    CAST(wdirtnstd11 AS FLOAT) AS wdirtnstd11, 
    CAST(hwsavg11 AS FLOAT) AS hwsavg11, 
    CAST(hwsmin11 AS FLOAT) AS hwsmin11, 
    CAST(hwsmax11 AS FLOAT) AS hwsmax11, 
    CAST(hwsstd11 AS FLOAT) AS hwsstd11, 
    CAST(vwsavg11 AS FLOAT) AS vwsavg11, 
    CAST(ti11 AS FLOAT) AS ti11, 
    CAST(intflag11 AS int) AS intflag11, 
    CAST(extflag11 AS int) AS extflag11, 
    CAST(enabled11 AS bit) AS enabled11, 
    CAST(packavalavg12 AS FLOAT) AS packavalavg12, 
    CAST(wdirtnavg12 AS FLOAT) AS wdirtnavg12, 
    CAST(wdirtnstd12 AS FLOAT) AS wdirtnstd12, 
    CAST(hwsavg12 AS FLOAT) AS hwsavg12, 
    CAST(hwsmin12 AS FLOAT) AS hwsmin12, 
    CAST(hwsmax12 AS FLOAT) AS hwsmax12, 
    CAST(hwsstd12 AS FLOAT) AS hwsstd12, 
    CAST(vwsavg12 AS FLOAT) AS vwsavg12, 
    CAST(ti12 AS FLOAT) AS ti12, 
    CAST(intflag12 AS int) AS intflag12, 
    CAST(extflag12 AS int) AS extflag12, 
    CAST(enabled12 AS bit) AS enabled12, 
    CAST(packavalavg13 AS FLOAT) AS packavalavg13, 
    CAST(wdirtnavg13 AS FLOAT) AS wdirtnavg13, 
    CAST(wdirtnstd13 AS FLOAT) AS wdirtnstd13, 
    CAST(hwsavg13 AS FLOAT) AS hwsavg13, 
    CAST(hwsmin13 AS FLOAT) AS hwsmin13, 
    CAST(hwsmax13 AS FLOAT) AS hwsmax13, 
    CAST(hwsstd13 AS FLOAT) AS hwsstd13, 
    CAST(vwsavg13 AS FLOAT) AS vwsavg13, 
    CAST(ti13 AS FLOAT) AS ti13, 
    CAST(intflag13 AS int) AS intflag13, 
    CAST(extflag13 AS int) AS extflag13, 
    CAST(enabled13 AS bit) AS enabled13, 
    CAST(packavalavg14 AS FLOAT) AS packavalavg14, 
    CAST(wdirtnavg14 AS FLOAT) AS wdirtnavg14, 
    CAST(wdirtnstd14 AS FLOAT) AS wdirtnstd14, 
    CAST(hwsavg14 AS FLOAT) AS hwsavg14, 
    CAST(hwsmin14 AS FLOAT) AS hwsmin14, 
    CAST(hwsmax14 AS FLOAT) AS hwsmax14, 
    CAST(hwsstd14 AS FLOAT) AS hwsstd14, 
    CAST(vwsavg14 AS FLOAT) AS vwsavg14, 
    CAST(ti14 AS FLOAT) AS ti14, 
    CAST(intflag14 AS int) AS intflag14, 
    CAST(extflag14 AS int) AS extflag14, 
    CAST(enabled14 AS bit) AS enabled14, 
    CAST(packavalavg15 AS FLOAT) AS packavalavg15, 
    CAST(wdirtnavg15 AS FLOAT) AS wdirtnavg15, 
    CAST(wdirtnstd15 AS FLOAT) AS wdirtnstd15, 
    CAST(hwsavg15 AS FLOAT) AS hwsavg15, 
    CAST(hwsmin15 AS FLOAT) AS hwsmin15, 
    CAST(hwsmax15 AS FLOAT) AS hwsmax15, 
    CAST(hwsstd15 AS FLOAT) AS hwsstd15, 
    CAST(vwsavg15 AS FLOAT) AS vwsavg15, 
    CAST(ti15 AS FLOAT) AS ti15, 
    CAST(intflag15 AS int) AS intflag15, 
    CAST(extflag15 AS int) AS extflag15, 
    CAST(enabled15 AS bit) AS enabled15,
    CAST(tilt AS NUMERIC) AS tilt, 
    CAST(bearing AS NUMERIC) AS bearing, 
    CAST(pcktsrain AS NUMERIC) AS pcktsrain, 
    CAST(pcktsfog AS NUMERIC) AS pcktsfog, 
    CAST(statusflag AS varchar(max)) AS statusflag, 
    CAST(infoflag AS varchar(max)) AS infoflag, 
	CAST(axysflag AS varchar(max)) AS axysflag, 
    CAST(algorithm AS varchar(max)) AS algorithm, 
    CAST(battery AS NUMERIC) AS battery, 
    CAST(generator AS NUMERIC) AS generator, 
    CAST(utemp AS NUMERIC) AS utemp, 
    CAST(ltemp AS NUMERIC) AS ltemp, 
    CAST(podhumid AS NUMERIC) AS podhumid, 
    CAST(metcmpbearing AS NUMERIC) AS metcmpbearing, 
    CAST(mettilt AS NUMERIC) AS mettilt, 
    CAST(rangeflag AS int) AS rangeflag, 
    CAST(constantflag AS int) AS constantflag, 
    CAST(rocflag AS int) AS rocflag, 
    CAST(spikeflag AS int) AS spikeflag	FROM NEW_P) AS NEW


SELECT * FROM PIVOT_1 WHERE windkey ='WI0026369'

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
	PIVOT_1 AS P
ON 
	P.flidarid = C.flidarid 
AND
	P.datetimekey = C.TimeSeries