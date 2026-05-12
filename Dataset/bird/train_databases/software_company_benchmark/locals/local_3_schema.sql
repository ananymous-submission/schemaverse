CREATE TABLE "AreaDemographics" (
    "GeoAreaId" INTEGER,
    "PopulationThousands" REAL,
    "IncomeThousands" REAL,
    "HouseholdSizeAverage" REAL,
    "EmploymentRate" REAL,
    "EducationAttainmentScore" REAL,
    "UrbanizationShare" REAL,
    "RuralPopulationShare" REAL,
    "MedianAge" REAL,
    "PopulationGrowthRate" REAL,
    "PovertyRate" REAL,
    "AccessibilityIndex" REAL,
    "HealthOutcomeIndex" REAL,
    "CrimeIncidenceRate" REAL,
    "InternetPenetrationRate" REAL,
    "PublicTransportUsage" REAL,
    "GreenSpacePercentage" REAL,
    "CommercialDensityIndex" REAL,
    "SchoolDensity" REAL,
    "HospitalDensity" REAL,
    "RecreationFacilityIndex" REAL
);

CREATE TABLE "CustomerProfilesEducationMiddleThird" (
    "CustomerId" INTEGER,
    "Gender" TEXT,
    "RelationshipStatus" TEXT,
    "GeoAreaId" INTEGER,
    "EducationLevelMiddleThird" INTEGER,
    "OccupationTitle" TEXT,
    "AgeYears" INTEGER
);