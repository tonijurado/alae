-- Borrado de alae_error

 DELETE FROM alae_error 
 WHERE alae_error.fk_sample_batch IN 
 	(SELECT pk_sample_batch FROM alae_sample_batch WHERE fk_batch IN -- (347, 348, 349, 350, 351, 352, 358, 359, 360, 361, 362, 363, 417, 425));
	 	(
		 	SELECT pk_batch FROM alae_batch WHERE alae_batch.fk_study IN (403)
 		)
 	);
-- 	
-- Borrado de alae_batch_nominal

 DELETE FROM alae_batch_nominal
--  WHERE alae_batch_nominal.fk_batch IN (347, 348, 349, 350, 351, 352, 358, 359, 360, 361, 362, 363, 417, 425);
 
 WHERE alae_batch_nominal.fk_batch IN (	SELECT pk_batch FROM alae_batch WHERE alae_batch.fk_study IN (403));

-- Borrado d-- e alae_sample_Batch
 DELETE FROM alae_sample_batch
 -- WHERE alae_sample_batch.fk_batch IN (347, 348, 349, 350, 351, 352, 358, 359, 360, 361, 362, 363, 417, 425);
 WHERE alae_sample_batch.fk_batch IN  (	SELECT pk_batch FROM alae_batch WHERE alae_batch.fk_study IN (403));
-- 
-- Borrado de alae_batch
--DELETE FROM alae_batch WHERE pk_batch IN (8268,8269,);
 DELETE FROM alae_batch WHERE alae_batch.fk_study IN (403);
-- -- 
-- -- -- Borrado de alae_sample_verification_study
-- DELETE FROM alae_sample_verification_study WHERE alae_sample_verification_study.fk_analyte_study IN 
-- 	(SELECT alae_analyte_study.pk_analyte_study FROM alae_analyte_study WHERE alae_analyte_study.fk_study IN (397);

-- Borrado de alae_analyte_study
-- DELETE FROM alae_analyte_study WHERE alae_analyte_study.fk_study IN (397);
-- Borrado de alae_study
-- DELETE FROM alae_study WHERE alae_study.pk_study IN (379);