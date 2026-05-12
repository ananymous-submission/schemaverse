-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct incidents from row partitions (UNION (overlap))
CREATE VIEW "incidents" AS
SELECT "local_1"."incidentsWithHandgun"."incidentId" AS "case_number", "local_1"."incidentsWithHandgun"."incidentDate" AS "date", "local_1"."incidentsWithHandgun"."incidentLocation" AS "location", "local_1"."incidentsWithHandgun"."subjectInjuryStatuses" AS "subject_statuses", "local_1"."incidentsWithHandgun"."subjectWeaponType" AS "subject_weapon", "local_1"."incidentsWithHandgun"."involvedSubjects" AS "subjects", "local_1"."incidentsWithHandgun"."involvedSubjectCount" AS "subject_count", "local_1"."incidentsWithHandgun"."respondingOfficers" AS "officers" FROM "local_1"."incidentsWithHandgun"
UNION
SELECT "local_1"."incidentsHandsKnifeOrOther"."incidentId" AS "case_number", "local_1"."incidentsHandsKnifeOrOther"."incidentDate" AS "date", "local_1"."incidentsHandsKnifeOrOther"."incidentLocation" AS "location", "local_1"."incidentsHandsKnifeOrOther"."subjectInjuryStatuses" AS "subject_statuses", "local_1"."incidentsHandsKnifeOrOther"."subjectWeaponType" AS "subject_weapon", "local_1"."incidentsHandsKnifeOrOther"."involvedSubjects" AS "subjects", "local_1"."incidentsHandsKnifeOrOther"."involvedSubjectCount" AS "subject_count", "local_1"."incidentsHandsKnifeOrOther"."respondingOfficers" AS "officers" FROM "local_1"."incidentsHandsKnifeOrOther"
UNION
SELECT "local_3"."VehicleInvolvedIncidents"."CaseNumber" AS "case_number", "local_3"."VehicleInvolvedIncidents"."IncidentDate" AS "date", "local_3"."VehicleInvolvedIncidents"."IncidentLocation" AS "location", "local_3"."VehicleInvolvedIncidents"."SubjectStatuses" AS "subject_statuses", "local_3"."VehicleInvolvedIncidents"."SubjectWeapon" AS "subject_weapon", "local_3"."VehicleInvolvedIncidents"."SubjectsList" AS "subjects", "local_3"."VehicleInvolvedIncidents"."SubjectCount" AS "subject_count", "local_3"."VehicleInvolvedIncidents"."OfficerList" AS "officers" FROM "local_3"."VehicleInvolvedIncidents"
UNION
SELECT "local_3"."UnarmedAndFirearmIncidents"."CaseNumber" AS "case_number", "local_3"."UnarmedAndFirearmIncidents"."IncidentDate" AS "date", "local_3"."UnarmedAndFirearmIncidents"."IncidentLocation" AS "location", "local_3"."UnarmedAndFirearmIncidents"."SubjectStatuses" AS "subject_statuses", "local_3"."UnarmedAndFirearmIncidents"."SubjectWeapon" AS "subject_weapon", "local_3"."UnarmedAndFirearmIncidents"."SubjectsList" AS "subjects", "local_3"."UnarmedAndFirearmIncidents"."SubjectCount" AS "subject_count", "local_3"."UnarmedAndFirearmIncidents"."OfficerList" AS "officers" FROM "local_3"."UnarmedAndFirearmIncidents";

-- Reconstruct officers from local_2.incident_officer
CREATE VIEW "officers" AS
SELECT
    "local_2"."incident_officer"."case_reference" AS "case_number",
    "local_2"."incident_officer"."race_category" AS "race",
    "local_2"."incident_officer"."gender_identity" AS "gender",
    "local_2"."incident_officer"."surname" AS "last_name",
    "local_2"."incident_officer"."given_name" AS "first_name",
    "local_2"."incident_officer"."display_name" AS "full_name"
FROM "local_2"."incident_officer";

-- Reconstruct subjects from local_3.IncidentSubjects
CREATE VIEW "subjects" AS
SELECT
    "local_3"."IncidentSubjects"."CaseNumber" AS "case_number",
    "local_3"."IncidentSubjects"."Race" AS "race",
    "local_3"."IncidentSubjects"."Gender" AS "gender",
    "local_3"."IncidentSubjects"."LastName" AS "last_name",
    "local_3"."IncidentSubjects"."FirstName" AS "first_name",
    "local_3"."IncidentSubjects"."FullName" AS "full_name"
FROM "local_3"."IncidentSubjects";
