SELECT T2.value, T2.units FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.date = '2008-03-11' AND T2.description = 'Body Height';

SELECT SUM(CASE WHEN strftime('%Y', T2.date) = '2009' THEN T2.VALUE END) - SUM(CASE WHEN strftime('%Y', T2.date) = '2008' THEN T2.VALUE END) AS increase , T2.units FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.description = 'Body Height';

SELECT T2.value, T2.units FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.description = 'Systolic Blood Pressure' ORDER BY T2.VALUE DESC LIMIT 1;

SELECT COUNT(T2.description) FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.description = 'Systolic Blood Pressure';

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T2.VALUE = ( SELECT MAX(VALUE) FROM observations WHERE description = 'Systolic Blood Pressure' ) LIMIT 1;

SELECT strftime('%J', T2.STOP) - strftime('%J', T2.START) AS days FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.description LIKE 'Acetaminophen%';

SELECT DISTINCT T2.description FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss';

SELECT T2.REASONDESCRIPTION FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.description LIKE 'Acetaminophen%';

SELECT T2.description FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.reasondescription = 'Streptococcal sore throat (disorder)';

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.description LIKE 'Acetaminophen%';

SELECT T2.description FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.START = '2009-01-08';

SELECT strftime('%J', T2.STOP) - strftime('%J', T2.START) AS days FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.description = 'Cystitis';

SELECT AVG(T2.VALUE), T2.units FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.description = 'Body Weight';

SELECT CAST(SUM(CASE WHEN T1.marital = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T2.description = 'Cystitis';

SELECT T2.description, T2.VALUE, T2.units FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Mr.' AND T1.first = 'Vincent' AND T1.last = 'Wyman' AND T2.date = '2010-08-02' AND T2.description = 'Body Height';

SELECT COUNT(T2.PATIENT) FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Mrs.' AND T1.first = 'Norman' AND T1.last = 'Berge';

SELECT T2.reasondescription FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Mrs.' AND T1.first = 'Annabelle' AND T1.last = 'Pouros' AND T2.start = '1970-12-19' AND T2.description = 'Leucovorin 100 MG Injection';

SELECT DISTINCT T1."PREVALENCE PERCENTAGE" FROM all_prevalences AS T1 INNER JOIN conditions AS T2 ON lower(T1.ITEM) = lower(T2.DESCRIPTION) WHERE T2.code = '64859006';

SELECT DISTINCT T1."PREVALENCE RATE" FROM all_prevalences AS T1 INNER JOIN conditions AS T2 ON lower(T1.ITEM) = lower(T2.DESCRIPTION) WHERE T2.code = '368581000119106';

SELECT DISTINCT T2.description FROM patients AS T1 INNER JOIN procedures AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Ms.' AND T1.first = 'Jacquelyn' AND T1.last = 'Shanahan' AND T2.DATE = '2009-08-09';

SELECT COUNT(T2.BILLABLEPERIOD) FROM patients AS T1 INNER JOIN claims AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Ms.' AND T1.first = 'Abbie' AND T1.last = 'Cole' AND T2.BILLABLEPERIOD BETWEEN '2010-12-31' AND '2012-01-01';

SELECT COUNT(DISTINCT T2.code) FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Mrs.' AND T1.first = 'Saundra' AND T1.last = 'Monahan';

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN claims AS T2 ON T1.patient = T2.PATIENT WHERE T2.billableperiod = '1947-09-11';

SELECT T2.description FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Mr.' AND T1.first = 'Hubert' AND T1.last = 'Baumbach' AND T2.date = '2008-10-25';

SELECT T2.description FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Keven' AND T1.last = 'Kuhn' AND T2.start = '2016-09-24' AND T2.stop = '2016-10-10';

SELECT T2.date FROM patients AS T1 INNER JOIN procedures AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Mrs.' AND T1.first = 'Ira' AND T1.last = 'Deckow' AND T2.description = 'Standard pregnancy test';

SELECT CAST(SUM(strftime('%J', T2.STOP) - strftime('%J', T2.START)) AS REAL) / COUNT(T1.patient) FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Mr.' AND T1.first = 'Wesley' AND T1.last = 'Lemke';

SELECT CAST(SUM(strftime('%J', T2.STOP) - strftime('%J', T2.START)) AS REAL) / COUNT(T2.PATIENT) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Ms.' AND T1.first = 'Angelena' AND T1.last = 'Kertzmann' AND T2.description = 'Normal pregnancy';

SELECT PATIENT FROM allergies WHERE STOP IS NOT NULL GROUP BY PATIENT ORDER BY CASE WHEN SUBSTR(STOP, -2, 1) != '9' THEN SUBSTR(STOP, LENGTH(STOP) - 1) + 2000 END - CASE WHEN SUBSTR(START, -2, 1) = '9' THEN SUBSTR(START, LENGTH(START) - 1) + 1900 ELSE SUBSTR(START, LENGTH(START) - 1) + 2000 END LIMIT 1;

SELECT COUNT(PATIENT) FROM conditions WHERE DESCRIPTION = 'Diabetes' AND strftime('%Y', START) = '1988';

SELECT COUNT(PATIENT) FROM allergies WHERE DESCRIPTION = 'Allergy to eggs';

SELECT PATIENT FROM conditions WHERE START = ( SELECT MAX(START) FROM conditions WHERE DESCRIPTION = 'Hypertension' );

SELECT DESCRIPTION FROM allergies GROUP BY DESCRIPTION ORDER BY COUNT(DESCRIPTION) DESC LIMIT 1;

SELECT PATIENT FROM observations WHERE DESCRIPTION = 'Body Height' AND UNITS = 'cm' ORDER BY VALUE DESC LIMIT 1;

SELECT T2.DESCRIPTION FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.gender = 'F' AND T1.ethnicity = 'american' GROUP BY T2.DESCRIPTION ORDER BY COUNT(T2.DESCRIPTION) DESC LIMIT 1;

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Ibuprofen 200 MG Oral Tablet' AND T1.ethnicity = 'dominican' AND strftime('%Y', T2.START) = '2016' AND strftime('%m', T2.STOP) - strftime('%m', T2.START) = 1;

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE DESCRIPTION = 'Pneumonia' AND strftime('%Y', T1.birthdate) LIKE '192%';

SELECT DISTINCT T1.first, T1.last, T1.suffix FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Yaz 28 Day Pack' AND strftime('%Y', T2.START) = '2011';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T1.race = 'black' AND T2.DESCRIPTION = 'DTaP' AND strftime('%Y', T2.DATE) = '2013';

SELECT COUNT(T2.patient) FROM all_prevalences AS T1 INNER JOIN conditions AS T2 ON lower(T1.ITEM) = lower(T2.DESCRIPTION) INNER JOIN immunizations AS T3 ON T2.PATIENT = T3.PATIENT GROUP BY T2.PATIENT ORDER BY T2.START DESC, T1."PREVALENCE RATE" DESC LIMIT 1;

SELECT COUNT(DISTINCT T2.patient) FROM all_prevalences AS T1 INNER JOIN conditions AS T2 ON lower(T1.ITEM) = lower(T2.DESCRIPTION) ORDER BY T1."PREVALENCE RATE" DESC LIMIT 1;

SELECT T2.DESCRIPTION FROM immunizations AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.DESCRIPTION = 'Influenza  seasonal  injectable  preservative free' GROUP BY T2.DESCRIPTION ORDER BY COUNT(T2.DESCRIPTION) DESC LIMIT 1;

SELECT DISTINCT T1.PATIENT FROM conditions AS T1 INNER JOIN all_prevalences AS T2 ON lower(T2.ITEM) = lower(T1.DESCRIPTION) WHERE T2."PREVALENCE PERCENTAGE" = CAST(18.8 AS float);

SELECT COUNT(DISTINCT T2.DESCRIPTION) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Tyree' AND T1.last = 'Eichmann';

SELECT COUNT(DISTINCT T1.patient) FROM immunizations AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.DESCRIPTION = 'meningococcal MCV4P' AND T2.DESCRIPTION = 'Viral sinusitis (disorder)';

SELECT COUNT(DISTINCT T2.patient) FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.gender = 'F' AND T1.DESCRIPTION = 'Prediabetes';

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Body Mass Index' AND T2.UNITS = 'kg/m2' ORDER BY T2.VALUE LIMIT 1;

SELECT strftime('%Y', T2.deathdate) - strftime('%Y', T2.birthdate) AS age FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.first = 'Giovanni' AND T2.last = 'Russel' AND T1.DESCRIPTION = 'Hypertension';

SELECT COUNT(DISTINCT T2.patient) FROM medications AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'oxaliplatin 5 MG/ML [Eloxatin]' AND T2.race = 'asian' AND T2.gender = 'F';

SELECT COUNT(DISTINCT T2.patient) FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.description = 'Stroke' AND T2.deathdate IS NULL;

SELECT COUNT(T2.patient) FROM allergies AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Allergy to peanuts' AND T2.race = 'asian';

SELECT AVG(T1.VALUE) FROM observations AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient INNER JOIN conditions AS T3 ON T2.patient = T3.PATIENT WHERE T3.DESCRIPTION = 'Hypertension' AND T1.DESCRIPTION = 'Diastolic Blood Pressure';

SELECT T1.DESCRIPTION FROM medications AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.ssn = '999-94-3751';

SELECT T2.ssn FROM allergies AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Allergy to grass pollen' AND T2.ethnicity = 'irish' AND T2.gender = 'F';

SELECT T2.first, T2.last FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.CODE = 315043002;

SELECT T1.DESCRIPTION FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.deathdate IS NOT NULL ORDER BY strftime('%Y', T2.deathdate) - strftime('%Y', T2.birthdate) DESC LIMIT 1;

SELECT T2.code FROM all_prevalences AS T1 INNER JOIN conditions AS T2 ON T1.ITEM = T2.DESCRIPTION ORDER BY T1.OCCURRENCES DESC LIMIT 1;

SELECT DISTINCT T2.DESCRIPTION, T2.VALUE, T2.UNITS FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Glucose' AND T1.address = '365 Della Crossroad Suite 202 Deerfield MA 01342 US';

SELECT DISTINCT T2.ssn FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient INNER JOIN all_prevalences AS T3 ON lower(T1.DESCRIPTION) = lower(T3.ITEM) WHERE CAST(T3."PREVALENCE PERCENTAGE" AS REAL) * 100 / ( SELECT AVG('PREVALENCE PERCENTAGE') FROM all_prevalences ) < 30 LIMIT 5;

SELECT CAST(SUM(CASE WHEN T2.gender = 'F' AND T2.race = 'asian' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.gender) FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Acute bronchitis (disorder)';

SELECT COUNT(T2.ID) FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Major' AND T1.last = 'D''Amore';

SELECT T2.DESCRIPTION FROM patients AS T1 INNER JOIN procedures AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Emmy' AND T1.last = 'Waelchi';

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN procedures AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Extraction of wisdom tooth';

SELECT T2.DESCRIPTION, T2.VALUE, T2.UNITS FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.DESCRIPTION = 'Body Weight';

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Allergy to soya';

SELECT COUNT(T2.CODE) FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Keven' AND T1.last = 'Kuhn' AND T2.DESCRIPTION = 'DTaP';

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Clopidogrel 75 MG Oral Tablet' AND strftime('%Y', T2.STOP) - strftime('%Y', T2.START) > 10;

SELECT DISTINCT T1.DESCRIPTION, T3.DESCRIPTION FROM procedures AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT INNER JOIN medications AS T3 ON T2.patient = T3.PATIENT WHERE T2.DESCRIPTION = 'Third degree burn';

SELECT T2.DESCRIPTION FROM allergies AS T1 INNER JOIN medications AS T2 ON T1.PATIENT = T2.PATIENT WHERE T1.START = '6/6/16' AND T1.DESCRIPTION = 'Allergy to mould';

SELECT DISTINCT T1.DESCRIPTION FROM careplans AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Secondary malignant neoplasm of colon';

SELECT T2."PREVALENCE RATE" FROM conditions AS T1 INNER JOIN all_prevalences AS T2 ON lower(T1.DESCRIPTION) = lower(T2.ITEM) WHERE T1.START = '2014-05-09';

SELECT T2.first, T2.last , CASE WHEN T2.deathdate IS NULL THEN strftime('%Y', T1.DATE) - strftime('%Y', T2.birthdate) ELSE strftime('%Y', T2.deathdate) - strftime('%Y', T2.birthdate) END AS age FROM observations AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Systolic Blood Pressure' AND T1.VALUE = 200 AND T1.UNITS = 'mmHg' AND strftime('%Y', T1.DATE) = '2011';

SELECT CAST(SUM(CASE WHEN T2.DESCRIPTION = 'Influenza seasonal injectable preservative free' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.patient), SUM(CASE WHEN T1.ethnicity = 'english' THEN 1 ELSE 0 END) FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE strftime('%Y', T2.DATE) = '2017';

SELECT DISTINCT T1.first FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T2.REASONDESCRIPTION = 'Normal pregnancy';

SELECT DISTINCT T1.birthdate FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Outpatient Encounter';

SELECT DISTINCT T1.first FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Cystitis';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Stroke' AND T1.marital = 'M';

SELECT DISTINCT T1.address FROM patients AS T1 INNER JOIN claims AS T2 ON T1.patient = T2.PATIENT WHERE T2.BILLABLEPERIOD LIKE '2010%';

SELECT DISTINCT T1.last FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Allergy to dairy product';

SELECT T2.START FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Adolfo' AND T1.last = 'Schmitt' AND T2.STOP IS NOT NULL;

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'House dust mite allergy' AND T1.gender = 'M';

SELECT T2.DESCRIPTION FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T1.race = 'white' GROUP BY T2.DESCRIPTION ORDER BY COUNT(T2.DESCRIPTION) DESC LIMIT 1;

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Influenza  seasonal  injectable  preservative free';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'HPV  quadrivalent' AND T1.gender = 'F';

SELECT DISTINCT T2.DESCRIPTION FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.birthplace = 'Pittsfield MA US';

SELECT COUNT(DISTINCT T2.DESCRIPTION) FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T1.ethnicity = 'german';

SELECT CAST(SUM(CASE WHEN T1.deathdate IS NULL THEN strftime('%Y', T2.STOP) - strftime('%Y', T1.birthdate) ELSE strftime('%Y', T1.deathdate) - strftime('%Y', T1.birthdate) END) AS REAL) / COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T2.REASONDESCRIPTION = 'Prediabetes';

SELECT COUNT(DISTINCT T2.patient) FROM medications AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.REASONDESCRIPTION = 'Coronary Heart Disease' AND T1.STOP IS NOT NULL AND T2.deathdate IS NULL;

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN procedures AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Bone immobilization' AND T1.drivers IS NOT NULL;

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT GROUP BY T1.patient ORDER BY COUNT(DISTINCT T2.DESCRIPTION) > 3;

SELECT COUNT(DISTINCT T2.patient) FROM allergies AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient INNER JOIN immunizations AS T3 ON T2.patient = T3.PATIENT WHERE T1.DESCRIPTION = 'Allergy to eggs' AND T3.DESCRIPTION = 'Td (adult) preservative free';

SELECT COUNT(DISTINCT T2.patient) FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient INNER JOIN observations AS T3 ON T2.patient = T3.PATIENT WHERE T3.DESCRIPTION = 'Body Weight' AND T1.DESCRIPTION = 'Diabetes self management plan' AND T3.VALUE > 100 AND T3.UNITS = 'kg';

SELECT T1.gender FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Dander (animal) allergy' GROUP BY T1.gender ORDER BY COUNT(T1.gender) DESC LIMIT 1;

SELECT DISTINCT T2.BILLABLEPERIOD FROM patients AS T1 INNER JOIN claims AS T2 ON T1.patient = T2.PATIENT WHERE T1.last = 'Dickinson';

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Otitis media';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.REASONDESCRIPTION = 'Myocardial Infarction' AND T1.ethnicity = 'irish';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.marital = 'M' AND T2.REASONDESCRIPTION = 'Concussion with loss of consciousness';

SELECT COUNT(DISTINCT T1.patient) FROM careplans AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'rotavirus  monovalent' AND T1.STOP = '2013-11-23';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Nitroglycerin 0.4 MG/ACTUAT [Nitrolingual]' AND T1.gender = 'F';

SELECT CAST(SUM(CASE WHEN T2.DESCRIPTION = 'Allergy to grass pollen' THEN 1 ELSE 0 END) AS REL) * 100 / COUNT(T1.patient) FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T1.birthplace = 'Pembroke MA US';

SELECT SUM(T2.VALUE) / COUNT(T1.patient) FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.race = 'asian' AND T2.DESCRIPTION = 'Body Weight' AND T2.UNITS = 'kg';

SELECT T1.ssn FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Latex allergy';

SELECT CASE WHEN SUBSTR(T1.STOP, -2, 1) != '9' THEN SUBSTR(T1.STOP, LENGTH(T1.STOP) - 1) + 2000 END - CASE WHEN SUBSTR(T1.START, -2, 1) = '9' THEN SUBSTR(T1.START, LENGTH(T1.START) - 1) + 1900 ELSE SUBSTR(T1.START, LENGTH(T1.START) - 1) + 2000 END AS years , T1.DESCRIPTION FROM allergies AS T1 INNER JOIN patients AS T2 ON T2.patient = T1.PATIENT WHERE T1.STOP IS NOT NULL AND T1.START IS NOT NULL AND T2.first = 'Isadora' AND T2.last = 'Moen';

SELECT COUNT(T2.PATIENT) FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND T2.START BETWEEN '2009-01-11' AND '2010-10-23';

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.marital = 'M' AND strftime('%J', T2.STOP) - strftime('%J', T2.START) > 60;

SELECT T2.DATE FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Influenza  seasonal  injectable  preservative free' AND T1.first = 'Elly' AND T1.last = 'Koss';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'meningococcal MCV4P' AND T2.DATE BETWEEN '2010-07-09' AND '2013-10-29' AND T1.race = 'black';

SELECT DISTINCT T2.CODE, T2.DATE FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T1.prefix = 'Ms.' AND T1.first = 'Jacquelyn' AND T1.last = 'Shanahan' AND T2.DESCRIPTION = 'Influenza  seasonal  injectable  preservative free';

SELECT strftime('%J', T2.STOP) - strftime('%J', T2.START) AS takenDays FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Berry' AND T1.last = 'Keebler' AND T2.REASONDESCRIPTION = 'Acute bronchitis (disorder)' AND T2.DESCRIPTION = 'Acetaminophen 160 MG';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.marital = 'S' AND T2.REASONDESCRIPTION = 'Cystitis' AND T2.DESCRIPTION = 'Nitrofurantoin 5 MG/ML [Furadantin]' AND strftime('%Y', T2.START) = '2010';

SELECT T2.REASONDESCRIPTION FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T2.DATE = '2013-11-20' AND T1.first = 'Lavelle' AND T1.last = 'Vandervort';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.ethnicity = 'german' AND T2.DATE BETWEEN '2011-01-09' AND '2012-08-29' AND T2.DESCRIPTION = 'Outpatient Encounter';

SELECT T1.ssn, T1.address FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T2.DATE = '2008-06-13' AND T2.REASONDESCRIPTION = 'Viral sinusitis (disorder)' AND T2.DESCRIPTION = 'Encounter for symptom';

SELECT T2.REASONDESCRIPTION, T2.DESCRIPTION , strftime('%J', T2.STOP) - strftime('%J', T2.START) AS days , CASE WHEN T1.deathdate IS NULL THEN 'alive' ELSE 'dead' END FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.ENCOUNTER = '23c293ec-dbae-4a22-896e-f12cf3c8bac3';

SELECT T1.first, T1.last FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Shellfish allergy' AND CAST((strftime('%J', T1.deathdate) - strftime('%J', T1.birthdate)) AS REAL) / 365 < 12;

SELECT strftime('%J', T2.STOP) - strftime('%J', T2.START) AS days FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = ' Amoxicillin 250 MG / Clavulanate 125 MG [Augmentin]' AND T1.first = 'Major' AND T1.last = 'D''Amore';

SELECT COUNT(DISTINCT T2.DESCRIPTION) FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Major' AND T1.last = 'D''Amore';

SELECT DISTINCT T2.DESCRIPTION, T2.VALUE, T2.UNITS FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Bella' AND T1.last = 'Rolfson';

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Calcium' AND T2.VALUE < 8.6;

SELECT DISTINCT T2.DESCRIPTION, T2.VALUE, T2.UNITS FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Body Mass Index' GROUP BY T2.VALUE ORDER BY COUNT(T2.VALUE) LIMIT 5;

SELECT COUNT(DISTINCT T2.PATIENT) FROM encounters AS T1 INNER JOIN immunizations AS T2 ON T1.PATIENT = T2.PATIENT WHERE T1.REASONDESCRIPTION = 'Normal pregnancy' AND T1.DATE = T2.DATE;

SELECT T2.DESCRIPTION FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND T1.last = 'Koss' AND strftime('%Y', T2.START) = '2013';

SELECT DISTINCT T3.DESCRIPTION, T4.DESCRIPTION, T5.DESCRIPTION, T1.first, T1.last FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT INNER JOIN careplans AS T3 ON T1.patient = T3.PATIENT INNER JOIN procedures AS T4 ON T1.patient = T4.PATIENT INNER JOIN medications AS T5 ON T1.patient = T5.PATIENT WHERE T2.ID = '6f2e3935-b203-493e-a9c0-f23e847b9798';

SELECT COUNT(DISTINCT CASE WHEN T2.gender = 'M' THEN T2.patient END) AS Male , COUNT(DISTINCT CASE WHEN T2.gender = 'F' THEN T2.patient END) AS Female FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Hypertension';

SELECT COUNT(DISTINCT T2.patient) FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Normal pregnancy' AND T2.gender = 'F' AND T2.marital = 'S';

SELECT DISTINCT T2.DESCRIPTION, T3.DESCRIPTION FROM encounters AS T1 INNER JOIN procedures AS T2 ON T1.PATIENT = T2.PATIENT INNER JOIN medications AS T3 ON T1.PATIENT = T3.PATIENT WHERE T1.REASONDESCRIPTION = 'Drug overdose';

SELECT SUM(T1.VALUE) / COUNT(T1.PATIENT) FROM observations AS T1 INNER JOIN ( SELECT DISTINCT PATIENT FROM observations WHERE DESCRIPTION = 'Total Cholesterol' AND VALUE > 200 ) AS T2 ON T1.PATIENT = T2.PATIENT WHERE T1.DESCRIPTION = 'Body Mass Index';

SELECT SUM(CASE WHEN ROUND((strftime('%J', T2.DATE) - strftime('%J', T1.birthdate)) / 365) BETWEEN 20 AND 30 THEN T2.VALUE ELSE 0 END) / COUNT(CASE WHEN ROUND((strftime('%J', T2.DATE) - strftime('%J', T1.birthdate)) / 365) BETWEEN 20 AND 30 THEN T2.PATIENT END) - SUM(CASE WHEN ROUND((strftime('%J', T2.DATE) - strftime('%J', T1.birthdate)) / 365) BETWEEN 50 AND 60 THEN T2.VALUE ELSE 0 END) / COUNT(CASE WHEN ROUND((strftime('%J', T2.DATE) - strftime('%J', T1.birthdate)) / 365) BETWEEN 50 AND 60 THEN T2.PATIENT END) AS difference FROM patients AS T1 INNER JOIN observations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Glucose';

SELECT CAST(SUM(CASE WHEN T5.DESCRIPTION = T3.DESCRIPTION THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.patient) FROM ( SELECT T2.DESCRIPTION, T1.patient FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE ROUND((strftime('%J', T2.START) - strftime('%J', T1.birthdate)) / 365) > 60 GROUP BY T2.DESCRIPTION ORDER BY COUNT(T2.DESCRIPTION) DESC LIMIT 1 ) AS T3 INNER JOIN patients AS T4 ON T3.patient = T4.patient INNER JOIN conditions AS T5 ON T4.patient = T5.PATIENT WHERE ROUND((strftime('%J', T5.START) - strftime('%J', T4.birthdate)) / 365) > 60;

SELECT T2.REASONDESCRIPTION FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Walter' AND T1.last = 'Bahringer' AND T2.DATE LIKE '2009-07%';

SELECT T2.DATE - T1.birthdate AS age FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Stacy' AND T1.last = 'Morar' AND T2.DESCRIPTION = 'Emergency Room Admission' AND T2.REASONDESCRIPTION = 'Drug overdose' ORDER BY T2.DATE LIMIT 1;

SELECT DESCRIPTION FROM medications WHERE REASONDESCRIPTION = 'Child attention deficit disorder' GROUP BY DESCRIPTION ORDER BY COUNT(DESCRIPTION) DESC LIMIT 1;

SELECT T2.first, T2.last FROM procedures AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Transplant of lung (procedure)';

SELECT CAST(COUNT(PATIENT) AS REAL) / COUNT(DISTINCT strftime('%Y', DATE)) FROM procedures WHERE DESCRIPTION = 'Combined chemotherapy and radiation therapy (procedure)';

SELECT strftime('%J', T2.STOP) - strftime('%J', T2.START) AS timeFrame , T2.DESCRIPTION FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Jacquelyn' AND T1.last = 'Shanahan' ORDER BY T2.START DESC LIMIT 1;

SELECT T2.START, T2.STOP, T2.DESCRIPTION FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Isadora' AND T1.last = 'Moen';

SELECT T2.DATE - T1.birthdate AS age FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Laronda' AND T1.last = 'Bernier' ORDER BY T2.DATE DESC LIMIT 1;

SELECT T2.DESCRIPTION FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Joye' AND T1.last = 'Homenick' AND strftime('%Y', T2.START) = '2017';

SELECT T2.DATE FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Influenza  seasonal  injectable  preservative free' AND T1.first = 'Joye' AND T1.last = 'Homenick' ORDER BY T2.DATE DESC LIMIT 1;

SELECT strftime('%J', T2.STOP) - strftime('%J', T2.START) AS days FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Elly' AND last = 'Koss' AND T2.DESCRIPTION = 'Acetaminophen 160 MG';

SELECT COUNT(DISTINCT T2.PATIENT), T2.DESCRIPTION FROM encounters AS T1 INNER JOIN careplans AS T2 ON T1.PATIENT = T2.PATIENT WHERE T2.REASONDESCRIPTION = 'Second degree burn';

SELECT CAST(SUM(CASE WHEN T2.gender = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.PATIENT) FROM encounters AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE strftime('%Y', T1.DATE) = '2010' AND T1.REASONDESCRIPTION = 'Contact dermatitis';

SELECT COUNT(T1.patient) , CAST(SUM(CASE WHEN T2.DESCRIPTION = 'Prenatal visit' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.patient) FROM patients AS T1 INNER JOIN encounters AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Lorri' AND T1.last = 'Simonis' AND strftime('%Y', T2.DATE) BETWEEN '2010' AND '2017';

SELECT T1.DESCRIPTION FROM medications AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.first = 'Joye' AND T2.last = 'Homenick';

SELECT DISTINCT T1.START FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.maiden = 'Adams';

SELECT T2.first, T2.last FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.gender = 'M' ORDER BY T1.START LIMIT 1;

SELECT CAST(SUM(CASE WHEN T2.race = 'hispanic' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.PATIENT) FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE strftime('%Y', T1.stop) = '2011';

SELECT DISTINCT T1.REASONDESCRIPTION FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.first = 'Angelo' AND T2.last = 'Buckridge';

SELECT DISTINCT T1.DESCRIPTION FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.ethnicity = 'american';

SELECT DISTINCT T1.ENCOUNTER FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.birthplace = 'Pembroke MA US';

SELECT DISTINCT T1.START FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.deathdate IS NULL;

SELECT COUNT(DISTINCT T1.PATIENT) FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.race = 'white' AND T1.REASONCODE = '10509002';

SELECT DISTINCT T2.first, T2.last FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Diabetic diet';

SELECT DISTINCT T1.STOP FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.deathdate IS NOT NULL AND T1.STOP IS NOT NULL;

SELECT COUNT(DISTINCT T2.patient) FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.ethnicity = 'italian' AND T1.CODE = '304510005';

SELECT CAST(SUM(CASE WHEN T2.gender = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.PATIENT) AS percentage FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE strftime('%Y', T1.START) = '2010';

SELECT COUNT(DISTINCT T2.patient) FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.race = 'black' AND strftime('%Y', T1.STOP) = '2017';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN conditions AS T2 WHERE T2.DESCRIPTION = 'Prediabetes' AND T1.gender = 'M';

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN allergies AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Allergy to nut';

SELECT T2.DESCRIPTION FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Wilmer' AND T1.last = 'Koepp';

SELECT SUM(CASE WHEN T1.gender = 'F' THEN 1 ELSE 0 END), SUM(CASE WHEN T1.gender = 'M' THEN 1 ELSE 0 END) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Viral sinusitis (disorder)';

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Penicillin V Potassium 250 MG' AND strftime('%Y', T2.START) >= '1948';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.patient WHERE strftime('%Y', T1.birthdate) = '1935' AND T1.race = 'white' AND T2.DESCRIPTION = 'Stroke';

SELECT DISTINCT T2.DESCRIPTION FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT INNER JOIN immunizations AS T3 ON T1.patient = T3.PATIENT WHERE T3.DESCRIPTION = 'IPV';

SELECT T1.patient FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT INNER JOIN all_prevalences AS T3 ON T3.ITEM = T2.DESCRIPTION ORDER BY T3.OCCURRENCES DESC LIMIT 1;

SELECT DISTINCT T1.first, T1.last FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.patient WHERE T2.DESCRIPTION = 'Cystitis';

SELECT COUNT(DISTINCT T1.patient) FROM patients AS T1 INNER JOIN immunizations AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'HPV  quadrivalent' AND T1.gender = 'M';

SELECT DISTINCT T2.start FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Walter' AND T1.last = 'Bahringer';

SELECT DISTINCT T2.DESCRIPTION FROM patients AS T1 INNER JOIN careplans AS T2 ON T1.patient = T2.PATIENT WHERE T1.first = 'Major' AND T1.last = 'D''Amore';

SELECT CAST(SUM(CASE WHEN T1.gender = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.patient) FROM patients AS T1 INNER JOIN conditions AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Viral sinusitis (disorder)';

SELECT CAST(SUM(CASE WHEN T1.gender = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.patient) FROM patients AS T1 INNER JOIN medications AS T2 ON T1.patient = T2.PATIENT WHERE T2.DESCRIPTION = 'Penicillin V Potassium 250 MG';

SELECT AVG(T1.VALUE) FROM observations AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.race = 'white' AND T1.DESCRIPTION = 'Body Height';

SELECT T1.DESCRIPTION FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.address = '179 Sydni Roads Taunton MA 02780 US';

SELECT T1.DESCRIPTION FROM allergies AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.first = 'Dirk' AND T2.last = 'Langosh' AND T2.ethnicity = 'dominican';

SELECT COUNT(DISTINCT T2.patient) FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient INNER JOIN allergies AS T3 ON T2.patient = T3.PATIENT WHERE T1.DESCRIPTION = 'Asthma' AND T3.DESCRIPTION = 'Allergy to peanuts';

SELECT T2.first, T2.last FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Drug overdose' AND ROUND((strftime('%J', T2.deathdate) - strftime('%J', T2.birthdate)) / 365) = 44;

SELECT T2.ssn FROM observations AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Systolic Blood Pressure' ORDER BY T1.VALUE DESC LIMIT 1;

SELECT T4.DESCRIPTION FROM all_prevalences AS T1 INNER JOIN conditions AS T2 ON T2.DESCRIPTION = T1.ITEM INNER JOIN encounters AS T3 ON T2.ENCOUNTER = T3.ID INNER JOIN careplans AS T4 ON T4.ENCOUNTER = T3.ID ORDER BY T1."PREVALENCE PERCENTAGE" DESC LIMIT 1;

SELECT DISTINCT T1.DESCRIPTION FROM careplans AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T2.ssn = '999-15-3685';

SELECT SUM(CASE WHEN T2.deathdate IS NULL THEN ROUND((strftime('%J', date('now')) - strftime('%J', T2.birthdate)) / 365) ELSE ROUND((strftime('%J', T2.deathdate) - strftime('%J', T2.birthdate)) / 365) END) / COUNT(T2.patient) FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Hypertension' AND T2.gender = 'M';

SELECT DISTINCT T2.first, T2.last FROM medications AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.REASONDESCRIPTION = 'Streptococcal sore throat (disorder)' LIMIT 5;

SELECT T2.first, T2.last FROM observations AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Body Weight' AND T1.UNITS = 'kg' AND T1.VALUE = 61.97;

SELECT DISTINCT T2.birthdate FROM medications AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Penicillin V Potassium 250 MG' AND T2.gender = 'M' LIMIT 5;

SELECT DISTINCT T2.first, T2.last FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient INNER JOIN all_prevalences AS T3 ON T1.DESCRIPTION = T3.ITEM WHERE T2.ethnicity = 'irish' AND 100 * CAST(T3.OCCURRENCES AS REAL) / ( SELECT AVG(OCCURRENCES) FROM all_prevalences ) > 96;

SELECT SUM(CASE WHEN T2.marital = 'M' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.marital = 'S' THEN 1 ELSE 0 END) FROM conditions AS T1 INNER JOIN patients AS T2 ON T1.PATIENT = T2.patient WHERE T1.DESCRIPTION = 'Diabetes';

