UPDATE
alae_batch b
JOIN alae_study s
ON s.pk_study = b.fk_study
SET b.validation_date = NULL,
	b.valid_flag = NULL
WHERE s.code = '20ANE-3525V' AND b.file_name = '001-3525V+O1_NADN.txt';

DELETE e FROM alae_error e JOIN 
alae_sample_batch sb ON e.fk_sample_batch = sb.pk_sample_batch JOIN 
alae_batch b ON b.pk_batch = sb.fk_batch JOIN
alae_study s ON s.pk_study = b.fk_study
WHERE s.code = '20ANE-3525V' AND b.file_name = '001-3525V+O1_NADN.txt';