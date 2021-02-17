/**
sample type Standard and Quality Control
**/
SELECT * FROM alae_sample_batch sb JOIN
alae_batch b ON b.pk_batch = sb.fk_batch JOIN
alae_study s ON s.pk_study = b.fk_study
WHERE s.code = '20ANE-3525V' AND b.file_name = '001-3525V+O1_NADN.TXT' AND
sb.sample_name LIKE '%_NT%' AND (sb.sample_type = 'Standard' OR sb.sample_type = 'Quality Control');

/**
All sample type
**/
SELECT * FROM alae_sample_batch sb JOIN
alae_batch b ON b.pk_batch = sb.fk_batch JOIN
alae_study s ON s.pk_study = b.fk_study
WHERE s.code = '20ANE-3525V' AND b.file_name = '001-3525V+O1_NADN.TXT' AND
sb.sample_name LIKE '%_NT%';

SELECT * FROM alae_batch_nominal bn JOIN
alae_batch b ON b.pk_batch = bn.fk_batch  JOIN
alae_study s ON s.pk_study = b.fk_study
WHERE s.code = '20ANE-3525V' AND b.file_name = '001-3525V+O1_NADN.TXT';

