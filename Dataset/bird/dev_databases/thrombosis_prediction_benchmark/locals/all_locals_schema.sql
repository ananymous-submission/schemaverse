-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/thrombosis_prediction/thrombosis_prediction.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "PatientAdmissionRecord" (
    "AdmissionId" INTEGER DEFAULT 0,
    "AdmissionType" TEXT,
    "RecordDate" DATE,
    "PrimaryDiagnosis" TEXT,
    "Gender" TEXT
);

CREATE TABLE "PatientAdmissionBefore1994Feb22" (
    "AdmissionId" INTEGER DEFAULT 0,
    "AdmissionType" TEXT,
    "DateOfBirth" DATE,
    "RecordDate" DATE,
    "PrimaryDiagnosis" TEXT,
    "FirstVisitDate" DATE
);

CREATE TABLE "PatientAdmissionAfter1997Aug20" (
    "AdmissionId" INTEGER DEFAULT 0,
    "AdmissionType" TEXT,
    "DateOfBirth" DATE,
    "RecordDate" DATE,
    "PrimaryDiagnosis" TEXT,
    "FirstVisitDate" DATE
);

CREATE TABLE "LaboratoryAlbuminSecondary" (
    "AdmissionId" INTEGER DEFAULT 0,
    "ObservationDate" DATE DEFAULT '0000-00-00',
    "Albumin" REAL,
    "AlkalinePhosphatase" INTEGER,
    "ComplementC3" INTEGER,
    "ComplementC4" INTEGER,
    "CreatinePhosphokinase" INTEGER,
    "Fibrinogen" REAL,
    "Glucose" INTEGER,
    "AspartateAminotransferase" INTEGER,
    "AlanineAminotransferase" INTEGER,
    "Hematocrit" REAL,
    "Hemoglobin" REAL,
    "LactateDehydrogenase" INTEGER,
    "PlateletCount" INTEGER,
    "RedBloodCellCount" REAL,
    "TotalBilirubin" REAL,
    "TotalProtein" REAL,
    "UricAcid" REAL,
    "WhiteBloodCellCount" REAL,
    FOREIGN KEY ("AdmissionId") REFERENCES "PatientAdmissionAfter1997Aug20"("AdmissionId")
);

CREATE TABLE "LaboratoryAlbuminRange3Point9To4Point2" (
    "AdmissionId" INTEGER DEFAULT 0,
    "ObservationDate" DATE DEFAULT '0000-00-00',
    "Albumin" REAL,
    "AlkalinePhosphatase" INTEGER,
    "ActivatedPartialThromboplastinTime" INTEGER,
    "ComplementC3" INTEGER,
    "ComplementC4" INTEGER,
    "CreatinePhosphokinase" INTEGER,
    "Creatinine" REAL,
    "CReactiveProtein" TEXT,
    "Fibrinogen" REAL,
    "Glucose" INTEGER,
    "Hemoglobin" REAL,
    "ImmunoglobulinA" INTEGER,
    "ImmunoglobulinG" INTEGER,
    "ImmunoglobulinM" INTEGER,
    "LactateDehydrogenase" INTEGER,
    "TotalBilirubin" REAL,
    "TotalCholesterol" INTEGER,
    "Triglycerides" INTEGER,
    "TotalProtein" REAL,
    "UricAcid" REAL,
    "UreaNitrogen" INTEGER,
    FOREIGN KEY ("AdmissionId") REFERENCES "PatientAdmissionRecord"("AdmissionId"),
    FOREIGN KEY ("AdmissionId") REFERENCES "PatientAdmissionAfter1997Aug20"("AdmissionId")
);

CREATE TABLE "LaboratoryAlbuminRange4Point2To4Point5" (
    "AdmissionId" INTEGER DEFAULT 0,
    "ObservationDate" DATE DEFAULT '0000-00-00',
    "Albumin" REAL,
    "AlkalinePhosphatase" INTEGER,
    "ActivatedPartialThromboplastinTime" INTEGER,
    "ComplementC3" INTEGER,
    "ComplementC4" INTEGER,
    "CreatinePhosphokinase" INTEGER,
    "Creatinine" REAL,
    "CReactiveProtein" TEXT,
    "Fibrinogen" REAL,
    "Glucose" INTEGER,
    "Hemoglobin" REAL,
    "ImmunoglobulinA" INTEGER,
    "ImmunoglobulinG" INTEGER,
    "ImmunoglobulinM" INTEGER,
    "LactateDehydrogenase" INTEGER,
    "TotalBilirubin" REAL,
    "TotalCholesterol" INTEGER,
    "Triglycerides" INTEGER,
    "TotalProtein" REAL,
    "UricAcid" REAL,
    "UreaNitrogen" INTEGER,
    FOREIGN KEY ("AdmissionId") REFERENCES "PatientAdmissionBefore1994Feb22"("AdmissionId")
);

CREATE TABLE "LaboratoryAlbuminAbove4Point5OrMissing" (
    "AdmissionId" INTEGER DEFAULT 0,
    "ObservationDate" DATE DEFAULT '0000-00-00',
    "Albumin" REAL,
    "AlkalinePhosphatase" INTEGER,
    "ActivatedPartialThromboplastinTime" INTEGER,
    "ComplementC3" INTEGER,
    "ComplementC4" INTEGER,
    "CreatinePhosphokinase" INTEGER,
    "Creatinine" REAL,
    "CReactiveProtein" TEXT,
    "Fibrinogen" REAL,
    "Glucose" INTEGER,
    "Hemoglobin" REAL,
    "ImmunoglobulinA" INTEGER,
    "ImmunoglobulinG" INTEGER,
    "ImmunoglobulinM" INTEGER,
    "LactateDehydrogenase" INTEGER,
    "TotalBilirubin" REAL,
    "TotalCholesterol" INTEGER,
    "Triglycerides" INTEGER,
    "TotalProtein" REAL,
    "UricAcid" REAL,
    "UreaNitrogen" INTEGER,
    FOREIGN KEY ("AdmissionId") REFERENCES "PatientAdmissionAfter1997Aug20"("AdmissionId")
);

CREATE TABLE "LaboratoryCentromereAutoantibodyPanel" (
    "AdmissionId" INTEGER DEFAULT 0,
    "ObservationDate" DATE DEFAULT '0000-00-00',
    "CentromereAntibody" TEXT,
    "CReactiveProtein" TEXT,
    "AntiDoubleStrandedDNA" TEXT,
    "AntiDoubleStrandedDNATypeII" INTEGER,
    "RnpAntibody" TEXT,
    "Sc170Antibody" TEXT,
    "SmithAntibody" TEXT,
    "SsaAntibody" TEXT,
    "SsbAntibody" TEXT,
    FOREIGN KEY ("AdmissionId") REFERENCES "PatientAdmissionBefore1994Feb22"("AdmissionId"),
    FOREIGN KEY ("AdmissionId") REFERENCES "PatientAdmissionAfter1997Aug20"("AdmissionId")
);

CREATE TABLE "LaboratoryCoagulationAppttPanel" (
    "LabEntryId" INTEGER DEFAULT 0,
    "ObservationDate" DATE DEFAULT '0000-00-00',
    "ActivatedPartialThromboplastinTime" INTEGER,
    "Creatinine" REAL,
    "Hematocrit" REAL,
    "PlateletImmuneComplex" INTEGER,
    "ProthrombinTime" REAL,
    "ThrombinAntithrombinComplex" INTEGER,
    "ThrombinAntithrombinComplexRepeat" INTEGER,
    "UreaNitrogen" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "patient_examination" (
    "examination_id" INTEGER,
    "exam_date" DATE,
    "anticardiolipin_igg" REAL,
    "anticardiolipin_igm" REAL,
    "ana_result" INTEGER,
    "ana_pattern" TEXT,
    "anticardiolipin_iga" INTEGER,
    "clinical_diagnosis" TEXT,
    "kaolin_clotting_time" TEXT,
    "rvv_test" TEXT,
    "lupus_anticoagulant" TEXT,
    "reported_symptoms" TEXT,
    "thrombosis_present" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "lab_alb_lte_3_9" (
    "admit_id" INTEGER DEFAULT 0,
    "lab_date" DATE DEFAULT '0000-00-00',
    "alb_val" REAL,
    "alp_val" INTEGER,
    "aptt_val" INTEGER,
    "c3_val" INTEGER,
    "c4_val" INTEGER,
    "cpk_val" INTEGER,
    "cre_val" REAL,
    "crp_text" TEXT,
    "fg_val" REAL,
    "glu_val" INTEGER,
    "hgb_val" REAL,
    "iga_val" INTEGER,
    "igg_val" INTEGER,
    "igm_val" INTEGER,
    "ldh_val" INTEGER,
    "tbil_val" REAL,
    "tcho_val" INTEGER,
    "tg_val" INTEGER,
    "tp_val" REAL,
    "ua_val" REAL,
    "urea_n_val" INTEGER
);

CREATE TABLE "lab_ra_serology" (
    "admit_id" INTEGER DEFAULT 0,
    "test_date" DATE DEFAULT '0000-00-00',
    "ra_res" TEXT,
    "rf_res" TEXT,
    "u_prot_text" TEXT,
    FOREIGN KEY ("admit_id") REFERENCES "admit_desc_gt_1994_02_22_to_1997_03_01"("admit_id"),
    FOREIGN KEY ("admit_id") REFERENCES "admit_desc_gt_1997_03_01_to_1997_08_20"("admit_id")
);

CREATE TABLE "admit_desc_gt_1994_02_22_to_1997_03_01" (
    "admit_id" INTEGER DEFAULT 0,
    "admit_mode" TEXT,
    "birth_date" DATE,
    "desc_date" DATE,
    "diag_text" TEXT,
    "visit_date" DATE
);

CREATE TABLE "admit_desc_gt_1997_03_01_to_1997_08_20" (
    "admit_id" INTEGER DEFAULT 0,
    "admit_mode" TEXT,
    "birth_date" DATE,
    "desc_date" DATE,
    "diag_text" TEXT,
    "visit_date" DATE
);

