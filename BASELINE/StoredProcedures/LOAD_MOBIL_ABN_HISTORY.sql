CREATE PROCEDURE BASELINE.LOAD_MOB_ABN_HISTORY
AS
--populerer tabel med snapshots af admin.mob_abn
INSERT INTO
[BASELINE].[MOBIL_ABN_HISTORY]
SELECT * FROM ADMIN.MOBIL_ABN
;