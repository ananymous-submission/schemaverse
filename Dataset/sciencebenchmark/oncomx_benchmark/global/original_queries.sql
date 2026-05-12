SELECT * FROM disease_mutation WHERE ref_aa = 'E';

SELECT count(*)
FROM biomarker_fda_test
WHERE biomarker_fda_test.test_manufacturer = '23andMe';

SELECT speciescommonname
FROM species
WHERE genus = 'Mus';

SELECT * FROM species;

SELECT * FROM disease_mutation;

SELECT biomarker_description FROM biomarker;

SELECT count(*)
FROM biomarker_fda_test
         JOIN biomarker_fda_test_trial
              ON biomarker_fda_test.test_submission = biomarker_fda_test_trial.test_submission and
                 biomarker_fda_test.test_trade_name = biomarker_fda_test_trial.test_trade_name
WHERE test_manufacturer = 'ABBOTT MOLECULAR INC';

SELECT biomarker.gene_symbol, biomarker_description FROM biomarker WHERE test_is_a_panel = 'false';

SELECT name FROM disease WHERE name like '%cancer%';

SELECT biomarker_title, qa_state FROM biomarker_edrn WHERE phase = 'Two';

SELECT gene_symbol FROM biomarker;

SELECT biomarker_title FROM biomarker_edrn WHERE biomarker_type != 'Protein';

SELECT differential_expression.gene_symbol
FROM differential_expression
         JOIN disease ON differential_expression.doid = disease.id
WHERE disease.name = 'lung cancer';

SELECT biomarker.gene_symbol, biomarker.biomarker_description
FROM biomarker
         JOIN biomarker_fda on biomarker.id = biomarker_fda.id
         JOIN biomarker_fda_test ON biomarker_fda.test_submission = biomarker_fda_test.test_submission and
                                    biomarker_fda.test_trade_name = biomarker_fda_test.test_trade_name
         JOIN disease ON disease.id = biomarker_fda_test.doid
WHERE disease.name = 'breast cancer';

SELECT DISTINCT phase from biomarker_edrn;

SELECT platform_method, test_study_design
FROM biomarker_fda_test
WHERE test_manufacturer = 'Dako Denmark A/S';

SELECT differential_expression.pvalue
FROM differential_expression
         JOIN disease ON differential_expression.doid = disease.id
WHERE disease.name = 'lung cancer';

SELECT disease_mutation.chromosome_pos
FROM disease_mutation
         JOIN disease ON disease_mutation.doid = disease.id
WHERE disease.name = 'skin cancer';

SELECT disease.name
FROM differential_expression
         JOIN disease ON differential_expression.doid = disease.id
WHERE differential_expression.gene_symbol = 'A1BG'
  and differential_expression.expression_change_direction = 'up';

SELECT differential_expression.gene_symbol,
       differential_expression.pvalue
FROM differential_expression JOIN disease ON differential_expression.doid = disease.id
WHERE differential_expression.gene_symbol = 'EGFR' AND disease.name = 'lung cancer';

SELECT COUNT(*) FROM healthy_expression JOIN stage ON healthy_expression.uberon_developmental_id = stage.id WHERE stage.name = 'late adult stage';

SELECT disease.name
FROM differential_expression
         JOIN disease ON differential_expression.doid = disease.id
WHERE differential_expression.gene_symbol = 'A1BG'
  and differential_expression.statistical_significance = 'Yes';

SELECT test_trade_name FROM biomarker_fda_test_use WHERE actual_use = 'predisposition';

SELECT biomarker_title FROM biomarker_edrn WHERE biomarker_type = 'Protein' AND phase = 'Two';

SELECT count(*) FROM xref_gene_ensembl JOIN species ON xref_gene_ensembl.speciesid = species.speciesid WHERE species.genus = 'Homo';

SELECT *
FROM biomarker_fda_test
WHERE test_manufacturer like 'Roche%';

SELECT test_submission
FROM biomarker_fda_test
WHERE test_manufacturer like 'Roche%';

SELECT disease.name
FROM disease JOIN disease_mutation ON disease.id = disease_mutation.doid
WHERE disease_mutation.cds_pos = 102997;

SELECT gene_symbol FROM differential_expression WHERE pvalue > 0.39 AND pvalue < 0.41;

SELECT DISTINCT disease_mutation.chromosome_id
FROM disease_mutation
         JOIN disease ON disease_mutation.doid = disease.id
WHERE disease.name = 'breast cancer';

SELECT anatomical_entity.name
FROM anatomical_entity
         JOIN healthy_expression ON anatomical_entity.id = healthy_expression.uberon_anatomical_id
WHERE expression_level_gene_relative = 'LOW'
  AND expression_level_anatomical_relative = 'HIGH';

SELECT name FROM anatomical_entity WHERE name LIKE 'bone%';

SELECT COUNT(*) FROM healthy_expression JOIN stage ON healthy_expression.uberon_developmental_id = stage.id WHERE stage.name LIKE 'late adult%';

SELECT biomarker.biomarker_description
FROM biomarker
         JOIN biomarker_fda ON biomarker.id = biomarker_fda.id
         JOIN biomarker_fda_test on biomarker_fda.test_submission = biomarker_fda_test.test_submission
WHERE biomarker_fda_test.test_approval_status = 'class II';

SELECT * FROM healthy_expression WHERE expression_score > (SELECT AVG(expression_score) FROM healthy_expression);

SELECT gene_symbol
FROM biomarker
         JOIN biomarker_edrn ON biomarker.id = biomarker_edrn.id
         JOIN anatomical_entity ON biomarker_edrn.uberon_anatomical_id = anatomical_entity.id
WHERE anatomical_entity.name = 'breast'
  and biomarker_edrn.biomarker_type = 'Genomic';

SELECT disease.name
FROM anatomical_entity
         JOIN cancer_tissue ON anatomical_entity.id = cancer_tissue.uberon_anatomical_id
         JOIN disease ON cancer_tissue.doid = disease.id
WHERE anatomical_entity.name = 'liver';

SELECT DISTINCT biomarker_fda_test.test_manufacturer
FROM biomarker
         JOIN biomarker_fda on biomarker.id = biomarker_fda.id
         JOIN biomarker_fda_test
              ON biomarker_fda.test_trade_name = biomarker_fda_test.test_trade_name AND biomarker_fda.test_submission = biomarker_fda_test.test_submission
WHERE biomarker.gene_symbol = 'BRAF';

SELECT biomarker_fda_test.test_manufacturer
FROM biomarker
         JOIN biomarker_fda on biomarker.id = biomarker_fda.id
         JOIN biomarker_fda_test
              ON biomarker_fda.test_trade_name = biomarker_fda_test.test_trade_name AND biomarker_fda.test_submission = biomarker_fda_test.test_submission
WHERE biomarker.gene_symbol = 'BRAF';

SELECT anatomical_entity.name, species.speciescommonname
FROM anatomical_entity
         JOIN healthy_expression ON anatomical_entity.id = healthy_expression.uberon_anatomical_id
         JOIN xref_gene_ensembl ON healthy_expression.ensembl_gene_id = xref_gene_ensembl.ensembl_gene_id
         JOIN species ON xref_gene_ensembl.speciesid = species.speciesid;

SELECT distinct anatomical_entity.name
FROM healthy_expression
         JOIN xref_gene_ensembl ON healthy_expression.ensembl_gene_id = xref_gene_ensembl.ensembl_gene_id
         JOIN anatomical_entity ON healthy_expression.uberon_anatomical_id = anatomical_entity.id
WHERE xref_gene_ensembl.gene_symbol = 'A1BG'
  and healthy_expression.expression_level_anatomical_relative != 'ABSENT';

SELECT biomarker.gene_symbol, biomarker.biomarker_description
FROM biomarker
         JOIN biomarker_edrn ON biomarker.id = biomarker_edrn.id
         JOIN anatomical_entity ON biomarker_edrn.uberon_anatomical_id = anatomical_entity.id
WHERE anatomical_entity.name = 'breast'
  and biomarker_edrn.phase = 'One';

SELECT anatomical_entity.name, healthy_expression.expression_score
FROM healthy_expression
         JOIN anatomical_entity
              ON healthy_expression.uberon_anatomical_id = anatomical_entity.id
WHERE healthy_expression.ensembl_gene_id = 'ENSMUSG00000000037'
   OR healthy_expression.ensembl_gene_id = 'ENSMUSG00000000078';

SELECT biomarker_fda_ncit_term.ncit_biomarker
FROM biomarker_fda_ncit_term
         JOIN biomarker_fda ON biomarker_fda_ncit_term.biomarker_fda_id = biomarker_fda.id
         JOIN biomarker ON biomarker_fda.id = biomarker.id
WHERE biomarker.gene_symbol = 'ALDH4A1';

SELECT *
FROM disease_mutation
         JOIN disease_mutation_tissue ON disease_mutation.id = disease_mutation_tissue.disease_mutation_id
         JOIN anatomical_entity ON disease_mutation_tissue.uberon_anatomical_id = anatomical_entity.id
WHERE anatomical_entity.name = 'liver';

SELECT *
FROM anatomical_entity
         JOIN disease_mutation_tissue ON anatomical_entity.id = disease_mutation_tissue.uberon_anatomical_id
         JOIN disease_mutation ON disease_mutation_tissue.disease_mutation_id = disease_mutation.id
where anatomical_entity.name = 'liver';

SELECT gene_symbol 
FROM biomarker
JOIN biomarker_fda ON biomarker.id = biomarker_fda.id
JOIN biomarker_fda_test ON biomarker_fda.test_submission = biomarker_fda_test.test_submission
WHERE biomarker_fda_test.test_approval_status = 'PMP';

SELECT biomarker.biomarker_description
FROM biomarker
JOIN biomarker_edrn ON biomarker.id = biomarker_edrn.id
JOIN anatomical_entity ON biomarker_edrn.uberon_anatomical_id = anatomical_entity.id
WHERE anatomical_entity.name = 'breast';

SELECT anatomical_entity.name, COUNT(*)
FROM biomarker
JOIN biomarker_edrn ON biomarker.id = biomarker_edrn.id
JOIN anatomical_entity ON biomarker_edrn.uberon_anatomical_id = anatomical_entity.id
GROUP BY anatomical_entity.name;

SELECT * FROM disease_mutation WHERE ref_aa = 'F';

SELECT distinct(biomarker_fda_test.test_manufacturer), biomarker_fda_test_use.actual_use
FROM biomarker
         JOIN biomarker_fda on biomarker.id = biomarker_fda.id
         JOIN biomarker_fda_test
              ON biomarker_fda.test_trade_name = biomarker_fda_test.test_trade_name AND
                 biomarker_fda.test_submission = biomarker_fda_test.test_submission
         JOIN biomarker_fda_test_use ON biomarker_fda_test.test_submission = biomarker_fda_test_use.test_submission and biomarker_fda_test.test_trade_name = biomarker_fda_test_use.test_trade_name
WHERE biomarker.gene_symbol = 'BRAF'
  AND biomarker_fda_test_use.actual_use = 'diagnostic';

SELECT *
FROM biomarker
  JOIN
     biomarker_edrn ON biomarker.id = biomarker_edrn.id
    JOIN
     biomarker_fda on biomarker.id = biomarker_fda.id
         JOIN
     biomarker_fda_test ON biomarker_fda.test_submission = biomarker_fda_test.test_submission and biomarker_fda.test_trade_name = biomarker_fda_test.test_trade_name
         LEFT JOIN anatomical_entity ON anatomical_entity.id = biomarker_edrn.uberon_anatomical_id
         JOIN cancer_tissue ON cancer_tissue.uberon_anatomical_id = anatomical_entity.id
         JOIN disease ON disease.id = biomarker_fda_test.doid or disease.id = cancer_tissue.doid
WHERE biomarker.test_is_a_panel = 'true'
  AND biomarker.gene_symbol != 'NULL';

select * from biomarker as b join  biomarker_fda as bf on b.id = bf.id
join biomarker_fda_test as bft on bf.test_trade_name = bft.test_trade_name and bf.test_submission = bft.test_submission
where test_manufacturer like '23andMe';

select distinct bft.test_manufacturer
from biomarker as  b join
biomarker_fda as  bf on b.id = bf.id
join biomarker_fda_test as  bft on 
bf.test_trade_name = bft.test_trade_name and bf.test_submission = bft.test_submission
where b.gene_symbol like '%BRCA%';

select *
from biomarker as b join
biomarker_fda as bf on b.id = bf.id
join biomarker_fda_test as bft on 
bf.test_trade_name = bft.test_trade_name and bf.test_submission = bft.test_submission
join biomarker_fda_test_use as  bfu on 
bfu.test_trade_name = bft.test_trade_name and bfu.test_submission = bft.test_submission
where b.gene_symbol like '%BRCA%';

SELECT anatomical_entity.name
FROM biomarker
JOIN biomarker_edrn ON biomarker.id = biomarker_edrn.id
JOIN anatomical_entity ON biomarker_edrn.uberon_anatomical_id = anatomical_entity.id
GROUP BY anatomical_entity.name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT  chromosome_id, count(*)  FROM disease_mutation where data_source = 'cosmic' group by chromosome_id order by count(*) desc limit 5;

select d.name , count(*)  from differential_expression JOIN disease as d ON d.id = doid 
group by d.name order by  count(*) desc limit 3;

SELECT t1.id from biomarker as t1 join biomarker_edrn as t2 on t1.id = t2.id WHERE t1.id NOT IN (SELECT t1.id from biomarker as t1 join biomarker_fda as t2 on t1.id = t2.id join biomarker_fda_test_use as bftu on t2.test_submission = bftu.test_submission);

SELECT t1.id from biomarker as t1 join biomarker_edrn as t2 on t1.id = t2.id WHERE t1.id
IN (SELECT t1.id from biomarker as t1 join biomarker_fda as t2 on t1.id = t2.id join biomarker_fda_test_use as bftu on t2.test_submission = bftu.test_submission);

select biomarker.gene_symbol
from disease as dis
join biomarker_fda_test as fda on dis.id = fda.doid
join biomarker_fda as bio_fda on bio_fda.test_trade_name = fda.test_trade_name
join biomarker as bio on bio.id = biomarker_fda.id
where dis.name = "prostate cancer";

select  
	bio.biomarker_description ,
	test_use.actual_use,
	count(*)
from biomarker_edrn as edrn
join anatomical_entity as anat_ent on edrn.uberon_anatomical_id = anat_ent.id
join biomarker as bio on bio.id = edrn.id
join biomarker_fda as bio_fda on bio_fda.id = bio.id
join biomarker_fda_test as fda_test on bio_fda.test_trade_name = fda_test.test_trade_name
join biomarker_fda_test_use as test_use on test_use.test_trade_name = fda_test.test_trade_name
GROUP BY test_use.actual_use, bio.biomarker_description;

SELECT distinct(bft.test_trade_name) FROM biomarker_fda_test_use as bftu JOIN biomarker_fda_test  as bft 
ON bft.test_trade_name = bftu.test_trade_name 
AND bft.test_submission = bftu.test_submission 
WHERE bftu.approved_indication LIKE '%diagnosis%';

SELECT distinct(d.name), bft.test_trade_name, bft.test_manufacturer
FROM biomarker_fda_test_use as bftu JOIN biomarker_fda_test as bft 
        ON bft.test_trade_name = bftu.test_trade_name 
        AND bft.test_submission = bftu.test_submission 
JOIN biomarker_fda as bf ON bft.test_trade_name = bf.test_trade_name 
        AND bft.test_submission = bf.test_submission 
JOIN biomarker as b ON bf.id = b.id
JOIN disease AS d ON d.id = bft.doid
WHERE
        bftu.approved_indication LIKE '%prognosis%'
                AND d.name LIKE '%lung%';

SELECT distinct(d.name) 
FROM biomarker_fda_test_use as bftu JOIN biomarker_fda_test as bft 
        ON bft.test_trade_name = bftu.test_trade_name 
        AND bft.test_submission = bftu.test_submission 
JOIN biomarker_fda as bf ON bft.test_trade_name = bf.test_trade_name 
        AND bft.test_submission = bf.test_submission 
JOIN biomarker as b ON bf.id = b.id
JOIN disease AS d ON d.id = bft.doid
WHERE
        bftu.approved_indication LIKE '%diagnosis%' 
        AND bft.specimen_type LIKE 'blood';

select bio.biomarker_description, species.species
from biomarker as bio
    join biomarker_edrn as be on bio.id = be.id
    join anatomical_entity as ae on be.uberon_anatomical_id = ae.id
    join healthy_expression as he on ae.id = he.uberon_anatomical_id
    join xref_gene_ensembl as xge on he.ensembl_gene_id = xge.ensembl_gene_id
    join species as s on xge.speciesid = s.speciesid;

