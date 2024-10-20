-- UNPIVOT

CREATE TABLE #UNPIVOT
	(windkey VARCHAR(20),
	datetimekey DATETIME,
	flidarid VARCHAR(20),
	transflag VARCHAR(20),
	WindValue VARCHAR(100),
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


-- Update wind values in the trans1 column by pivoting
UPDATE #UNPIVOT
SET trans1 = PIVOTTABLE.[TRANS1]
FROM (
    SELECT   WindValue, TRANS1 AS Pivot_TRANS1
    FROM #UNPIVOT
) AS SourceTable
PIVOT
(
    MAX(WindValue) FOR Pivot_TRANS1 IN ([TRANS1])
) AS PIVOTTABLE

SELECT * FROM #UNPIVOT
UPDATE #UNPIVOT
SET WindValue= trans1
SELECT * FROM #UNPIVOT
--DROP TABLE #UNPIVOT

--PIVOT

SELECT  * FROM #UNPIVOT
PIVOT
(
MAX(TRANS1) FOR WindNumber IN 
([w1], [w2], [w3], [w4], [w5], [w6], [w7], [w8], [w9], [w10], [w11], [w12], [w13], [w14], [w15], [w16], [w17], [w18], [w19], [w20], [w21], [w22], [w23], [w24], [w25], [w26], [w27], [w28], [w29], [w30], 
[w31], [w32], [w33], [w34], [w35], [w36], [w37], [w38], [w39], [w40], [w41], [w42], [w43], [w44], [w45], [w46], [w47], [w48], [w49], [w50], [w51], [w52], [w53], [w54], [w55], [w56], [w57], [w58], [w59], [w60], 
[w61], [w62], [w63], [w64], [w65], [w66], [w67], [w68], [w69], [w70], [w71], [w72], [w73], [w74], [w75], [w76], [w77], [w78], [w79], [w80], [w81], [w82], [w83], [w84], [w85], [w86], [w87], [w88], [w89], [w90], 
[w91], [w92], [w93], [w94], [w95], [w96], [w97], [w98], [w99], [w100], [w101], [w102], [w103], [w104], [w105], [w106], [w107], [w108], [w109], [w110], [w111], [w112], [w113], [w114], [w115], [w116], [w117], [w118], [w119], [w120], 
[w121], [w122], [w123], [w124], [w125], [w126], [w127], [w128], [w129], [w130], [w131], [w132], [w133], [w134], [w135], [w136], [w137], [w138], [w139], [w140], [w141], [w142], [w143], [w144], [w145], [w146], [w147], [w148], [w149], [w150], 
[w151], [w152], [w153], [w154], [w155], [w156], [w157], [w158], [w159], [w160], [w161], [w162], [w163], [w164], [w165], [w166], [w167], [w168], [w169], [w170], [w171], [w172], [w173], [w174], [w175], [w176], [w177], [w178], [w179], [w180]
)) AS PIVOTTABLE














