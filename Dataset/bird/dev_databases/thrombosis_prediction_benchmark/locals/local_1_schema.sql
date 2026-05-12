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