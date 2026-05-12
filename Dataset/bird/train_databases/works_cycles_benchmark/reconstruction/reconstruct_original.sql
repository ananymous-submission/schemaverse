-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";
ATTACH DATABASE 'local_8.sqlite' AS "local_8";

-- Reconstruct Address from row partitions (UNION (overlap))
CREATE VIEW "Address" AS
SELECT "local_1"."addressForSelectedCities"."addressId" AS "AddressID", "local_1"."addressForSelectedCities"."streetLine1" AS "AddressLine1", "local_1"."addressForSelectedCities"."streetLine2" AS "AddressLine2", "local_1"."addressForSelectedCities"."cityName" AS "City", "local_1"."addressForSelectedCities"."stateProvinceId" AS "StateProvinceID", "local_1"."addressForSelectedCities"."postalCode" AS "PostalCode", "local_1"."addressForSelectedCities"."spatialLocation" AS "SpatialLocation", "local_1"."addressForSelectedCities"."rowGuid" AS "rowguid", "local_1"."addressForSelectedCities"."modifiedDate" AS "ModifiedDate" FROM "local_1"."addressForSelectedCities"
UNION
SELECT "local_8"."address_other_cities"."address_id" AS "AddressID", "local_8"."address_other_cities"."address_line_primary" AS "AddressLine1", "local_8"."address_other_cities"."address_line_secondary" AS "AddressLine2", "local_8"."address_other_cities"."city_name" AS "City", "local_8"."address_other_cities"."state_province_id" AS "StateProvinceID", "local_8"."address_other_cities"."postal_code" AS "PostalCode", "local_8"."address_other_cities"."spatial_location" AS "SpatialLocation", "local_8"."address_other_cities"."row_guid" AS "rowguid", "local_8"."address_other_cities"."modified_at" AS "ModifiedDate" FROM "local_8"."address_other_cities";

-- Reconstruct AddressType from local_1.addressTypeRef
CREATE VIEW "AddressType" AS
SELECT
    "local_1"."addressTypeRef"."addressTypeId" AS "AddressTypeID",
    "local_1"."addressTypeRef"."displayName" AS "Name",
    "local_1"."addressTypeRef"."rowGuid" AS "rowguid",
    "local_1"."addressTypeRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."addressTypeRef";

-- Reconstruct BillOfMaterials from vertical split + row partition on a fragment
CREATE VIEW "BillOfMaterials" AS
SELECT t0.[billOfMaterialsId], t0.[productAssemblyId], t0.[componentId], t1.[startDate], t1.[endDate], t0.[unitMeasureCode], t0.[bomLevel], t0.[perAssemblyQuantity], t0.[modifiedDate]
FROM (
SELECT [billOfMaterialsModifiedJunToAug2010].[__orig_rowid] AS __orig_rowid, [local_1].[billOfMaterialsModifiedJunToAug2010].[billOfMaterialsId], [local_1].[billOfMaterialsModifiedJunToAug2010].[productAssemblyId], [local_1].[billOfMaterialsModifiedJunToAug2010].[componentId], [local_1].[billOfMaterialsModifiedJunToAug2010].[unitMeasureCode], [local_1].[billOfMaterialsModifiedJunToAug2010].[bomLevel], [local_1].[billOfMaterialsModifiedJunToAug2010].[perAssemblyQuantity], [local_1].[billOfMaterialsModifiedJunToAug2010].[modifiedDate] FROM [local_1].[billOfMaterialsModifiedJunToAug2010]
UNION
SELECT [billOfMaterialsModifiedMayToJun2010].[__orig_rowid] AS __orig_rowid, [local_1].[billOfMaterialsModifiedMayToJun2010].[billOfMaterialsId], [local_1].[billOfMaterialsModifiedMayToJun2010].[productAssemblyId], [local_1].[billOfMaterialsModifiedMayToJun2010].[componentId], [local_1].[billOfMaterialsModifiedMayToJun2010].[unitMeasureCode], [local_1].[billOfMaterialsModifiedMayToJun2010].[bomLevel], [local_1].[billOfMaterialsModifiedMayToJun2010].[perAssemblyQuantity], [local_1].[billOfMaterialsModifiedMayToJun2010].[modifiedDate] FROM [local_1].[billOfMaterialsModifiedMayToJun2010]
UNION
SELECT [bill_of_materials_modified_after_2010_09_01_or_null].[__orig_rowid] AS __orig_rowid, [local_6].[bill_of_materials_modified_after_2010_09_01_or_null].[bill_of_materials_id], [local_6].[bill_of_materials_modified_after_2010_09_01_or_null].[product_assembly_id], [local_6].[bill_of_materials_modified_after_2010_09_01_or_null].[component_id], [local_6].[bill_of_materials_modified_after_2010_09_01_or_null].[unit_of_measure_code], [local_6].[bill_of_materials_modified_after_2010_09_01_or_null].[assembly_level], [local_6].[bill_of_materials_modified_after_2010_09_01_or_null].[quantity_per_assembly], [local_6].[bill_of_materials_modified_after_2010_09_01_or_null].[modified_at] FROM [local_6].[bill_of_materials_modified_after_2010_09_01_or_null]
UNION
SELECT [bill_of_materials_modified_on_or_before_2010_05_12].[__orig_rowid] AS __orig_rowid, [local_6].[bill_of_materials_modified_on_or_before_2010_05_12].[bill_of_materials_id], [local_6].[bill_of_materials_modified_on_or_before_2010_05_12].[product_assembly_id], [local_6].[bill_of_materials_modified_on_or_before_2010_05_12].[component_id], [local_6].[bill_of_materials_modified_on_or_before_2010_05_12].[unit_of_measure_code], [local_6].[bill_of_materials_modified_on_or_before_2010_05_12].[assembly_level], [local_6].[bill_of_materials_modified_on_or_before_2010_05_12].[quantity_per_assembly], [local_6].[bill_of_materials_modified_on_or_before_2010_05_12].[modified_at] FROM [local_6].[bill_of_materials_modified_on_or_before_2010_05_12]
) t0
JOIN [local_1].[billOfMaterialsAssemblyLevel] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct BusinessEntity from row partitions (UNION (overlap))
CREATE VIEW "BusinessEntity" AS
SELECT "local_1"."businessEntityModifiedBefore20171213"."businessEntityId" AS "BusinessEntityID", "local_1"."businessEntityModifiedBefore20171213"."rowGuid" AS "rowguid", "local_1"."businessEntityModifiedBefore20171213"."modifiedDate" AS "ModifiedDate" FROM "local_1"."businessEntityModifiedBefore20171213"
UNION
SELECT "local_1"."businessEntityModifiedAfter20171213OrNull"."businessEntityId" AS "BusinessEntityID", "local_1"."businessEntityModifiedAfter20171213OrNull"."rowGuid" AS "rowguid", "local_1"."businessEntityModifiedAfter20171213OrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."businessEntityModifiedAfter20171213OrNull"
UNION
SELECT "local_8"."business_entity_modified_quartile"."business_entity_id" AS "BusinessEntityID", "local_8"."business_entity_modified_quartile"."row_guid" AS "rowguid", "local_8"."business_entity_modified_quartile"."modified_at" AS "ModifiedDate" FROM "local_8"."business_entity_modified_quartile";

-- Reconstruct BusinessEntityAddress from vertical split + row partition on a fragment
CREATE VIEW "BusinessEntityAddress" AS
SELECT t0.[businessEntityId], t0.[addressId], t0.[addressTypeId], t0.[rowGuid], t0.[modifiedDate]
FROM (
SELECT [businessEntityAddressModifiedFebSep2013].[__orig_rowid] AS __orig_rowid, [local_1].[businessEntityAddressModifiedFebSep2013].[businessEntityId], [local_1].[businessEntityAddressModifiedFebSep2013].[addressId], [local_1].[businessEntityAddressModifiedFebSep2013].[addressTypeId], [local_1].[businessEntityAddressModifiedFebSep2013].[rowGuid], [local_1].[businessEntityAddressModifiedFebSep2013].[modifiedDate] FROM [local_1].[businessEntityAddressModifiedFebSep2013]
UNION
SELECT [businessEntityAddressModifiedSep2013ToFeb2014].[__orig_rowid] AS __orig_rowid, [local_1].[businessEntityAddressModifiedSep2013ToFeb2014].[businessEntityId], [local_1].[businessEntityAddressModifiedSep2013ToFeb2014].[addressId], [local_1].[businessEntityAddressModifiedSep2013ToFeb2014].[addressTypeId], [local_1].[businessEntityAddressModifiedSep2013ToFeb2014].[rowGuid], [local_1].[businessEntityAddressModifiedSep2013ToFeb2014].[modifiedDate] FROM [local_1].[businessEntityAddressModifiedSep2013ToFeb2014]
UNION
SELECT [BusinessAddressModifiedAfter20140210OrNull].[__orig_rowid] AS __orig_rowid, [local_7].[BusinessAddressModifiedAfter20140210OrNull].[BusinessEntityKey], [local_7].[BusinessAddressModifiedAfter20140210OrNull].[AddressKey], [local_7].[BusinessAddressModifiedAfter20140210OrNull].[AddressTypeKey], [local_7].[BusinessAddressModifiedAfter20140210OrNull].[RowGuidValue], [local_7].[BusinessAddressModifiedAfter20140210OrNull].[LastModifiedAt] FROM [local_7].[BusinessAddressModifiedAfter20140210OrNull]
UNION
SELECT [BusinessAddressModifiedOnOrBefore20130209].[__orig_rowid] AS __orig_rowid, [local_7].[BusinessAddressModifiedOnOrBefore20130209].[BusinessEntityKey], [local_7].[BusinessAddressModifiedOnOrBefore20130209].[AddressKey], [local_7].[BusinessAddressModifiedOnOrBefore20130209].[AddressTypeKey], [local_7].[BusinessAddressModifiedOnOrBefore20130209].[RowGuidValue], [local_7].[BusinessAddressModifiedOnOrBefore20130209].[LastModifiedAt] FROM [local_7].[BusinessAddressModifiedOnOrBefore20130209]
) t0
JOIN [local_1].[businessEntityAddressByGuid] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct BusinessEntityContact from vertical split + row partition on a fragment
CREATE VIEW "BusinessEntityContact" AS
SELECT t0.[businessEntityId], t0.[personId], t0.[contactTypeId], t0.[rowGuid], t0.[modifiedDate]
FROM (
SELECT [businessEntityContactModifiedDec13Early2017].[__orig_rowid] AS __orig_rowid, [local_1].[businessEntityContactModifiedDec13Early2017].[businessEntityId], [local_1].[businessEntityContactModifiedDec13Early2017].[personId], [local_1].[businessEntityContactModifiedDec13Early2017].[contactTypeId], [local_1].[businessEntityContactModifiedDec13Early2017].[rowGuid], [local_1].[businessEntityContactModifiedDec13Early2017].[modifiedDate] FROM [local_1].[businessEntityContactModifiedDec13Early2017]
UNION
SELECT [businessEntityContactModifiedDec13Mid2017].[__orig_rowid] AS __orig_rowid, [local_1].[businessEntityContactModifiedDec13Mid2017].[businessEntityId], [local_1].[businessEntityContactModifiedDec13Mid2017].[personId], [local_1].[businessEntityContactModifiedDec13Mid2017].[contactTypeId], [local_1].[businessEntityContactModifiedDec13Mid2017].[rowGuid], [local_1].[businessEntityContactModifiedDec13Mid2017].[modifiedDate] FROM [local_1].[businessEntityContactModifiedDec13Mid2017]
UNION
SELECT [business_entity_contact_modified_earliest_quartile].[__orig_rowid] AS __orig_rowid, [local_8].[business_entity_contact_modified_earliest_quartile].[business_entity_id], [local_8].[business_entity_contact_modified_earliest_quartile].[person_id], [local_8].[business_entity_contact_modified_earliest_quartile].[contact_type_id], [local_8].[business_entity_contact_modified_earliest_quartile].[row_guid], [local_8].[business_entity_contact_modified_earliest_quartile].[modified_at] FROM [local_8].[business_entity_contact_modified_earliest_quartile]
UNION
SELECT [business_entity_contact_modified_latest_quartile].[__orig_rowid] AS __orig_rowid, [local_8].[business_entity_contact_modified_latest_quartile].[business_entity_id], [local_8].[business_entity_contact_modified_latest_quartile].[person_id], [local_8].[business_entity_contact_modified_latest_quartile].[contact_type_id], [local_8].[business_entity_contact_modified_latest_quartile].[row_guid], [local_8].[business_entity_contact_modified_latest_quartile].[modified_at] FROM [local_8].[business_entity_contact_modified_latest_quartile]
) t0
JOIN [local_1].[businessEntityContactByGuid] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct ContactType from local_1.contactTypeRef
CREATE VIEW "ContactType" AS
SELECT
    "local_1"."contactTypeRef"."contactTypeId" AS "ContactTypeID",
    "local_1"."contactTypeRef"."displayName" AS "Name",
    "local_1"."contactTypeRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."contactTypeRef";

-- Reconstruct CountryRegion from local_1.countryRegionRef
CREATE VIEW "CountryRegion" AS
SELECT
    "local_1"."countryRegionRef"."countryRegionCode" AS "CountryRegionCode",
    "local_1"."countryRegionRef"."displayName" AS "Name",
    "local_1"."countryRegionRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."countryRegionRef";

-- Reconstruct CountryRegionCurrency from local_2.CountryRegionCurrencyMap
CREATE VIEW "CountryRegionCurrency" AS
SELECT
    "local_2"."CountryRegionCurrencyMap"."RegionCode" AS "CountryRegionCode",
    "local_2"."CountryRegionCurrencyMap"."CurrencyIsoCode" AS "CurrencyCode",
    "local_2"."CountryRegionCurrencyMap"."LastModifiedDate" AS "ModifiedDate"
FROM "local_2"."CountryRegionCurrencyMap";

-- Reconstruct CreditCard from row partitions (UNION (overlap))
CREATE VIEW "CreditCard" AS
SELECT "local_1"."creditCardExpMonthLow"."creditCardId" AS "CreditCardID", "local_1"."creditCardExpMonthLow"."cardType" AS "CardType", "local_1"."creditCardExpMonthLow"."cardNumber" AS "CardNumber", "local_1"."creditCardExpMonthLow"."expMonth" AS "ExpMonth", "local_1"."creditCardExpMonthLow"."expYear" AS "ExpYear", "local_1"."creditCardExpMonthLow"."modifiedDate" AS "ModifiedDate" FROM "local_1"."creditCardExpMonthLow"
UNION
SELECT "local_1"."creditCardExpMonthHighOrNull"."creditCardId" AS "CreditCardID", "local_1"."creditCardExpMonthHighOrNull"."cardType" AS "CardType", "local_1"."creditCardExpMonthHighOrNull"."cardNumber" AS "CardNumber", "local_1"."creditCardExpMonthHighOrNull"."expMonth" AS "ExpMonth", "local_1"."creditCardExpMonthHighOrNull"."expYear" AS "ExpYear", "local_1"."creditCardExpMonthHighOrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."creditCardExpMonthHighOrNull"
UNION
SELECT "local_4"."cc_exp_may_jul"."cc_id" AS "CreditCardID", "local_4"."cc_exp_may_jul"."cc_type" AS "CardType", "local_4"."cc_exp_may_jul"."cc_num" AS "CardNumber", "local_4"."cc_exp_may_jul"."exp_mon" AS "ExpMonth", "local_4"."cc_exp_may_jul"."exp_yr" AS "ExpYear", "local_4"."cc_exp_may_jul"."mod_dt" AS "ModifiedDate" FROM "local_4"."cc_exp_may_jul"
UNION
SELECT "local_4"."cc_exp_aug_oct"."cc_id" AS "CreditCardID", "local_4"."cc_exp_aug_oct"."cc_type" AS "CardType", "local_4"."cc_exp_aug_oct"."cc_num" AS "CardNumber", "local_4"."cc_exp_aug_oct"."exp_mon" AS "ExpMonth", "local_4"."cc_exp_aug_oct"."exp_yr" AS "ExpYear", "local_4"."cc_exp_aug_oct"."mod_dt" AS "ModifiedDate" FROM "local_4"."cc_exp_aug_oct";

-- Reconstruct Culture from local_1.cultureRef
CREATE VIEW "Culture" AS
SELECT
    "local_1"."cultureRef"."cultureId" AS "CultureID",
    "local_1"."cultureRef"."displayName" AS "Name",
    "local_1"."cultureRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."cultureRef";

-- Reconstruct Currency from local_1.currencyRef
CREATE VIEW "Currency" AS
SELECT
    "local_1"."currencyRef"."currencyCode" AS "CurrencyCode",
    "local_1"."currencyRef"."displayName" AS "Name",
    "local_1"."currencyRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."currencyRef";

-- Reconstruct CurrencyRate from row partitions (UNION (overlap))
CREATE VIEW "CurrencyRate" AS
SELECT "local_1"."currencyRateAverageRangeLowMid"."currencyRateId" AS "CurrencyRateID", "local_1"."currencyRateAverageRangeLowMid"."currencyRateDate" AS "CurrencyRateDate", "local_1"."currencyRateAverageRangeLowMid"."fromCurrencyCode" AS "FromCurrencyCode", "local_1"."currencyRateAverageRangeLowMid"."toCurrencyCode" AS "ToCurrencyCode", "local_1"."currencyRateAverageRangeLowMid"."averageRate" AS "AverageRate", "local_1"."currencyRateAverageRangeLowMid"."endOfDayRate" AS "EndOfDayRate", "local_1"."currencyRateAverageRangeLowMid"."modifiedDate" AS "ModifiedDate" FROM "local_1"."currencyRateAverageRangeLowMid"
UNION
SELECT "local_1"."currencyRateAverageRangeMidHigh"."currencyRateId" AS "CurrencyRateID", "local_1"."currencyRateAverageRangeMidHigh"."currencyRateDate" AS "CurrencyRateDate", "local_1"."currencyRateAverageRangeMidHigh"."fromCurrencyCode" AS "FromCurrencyCode", "local_1"."currencyRateAverageRangeMidHigh"."toCurrencyCode" AS "ToCurrencyCode", "local_1"."currencyRateAverageRangeMidHigh"."averageRate" AS "AverageRate", "local_1"."currencyRateAverageRangeMidHigh"."endOfDayRate" AS "EndOfDayRate", "local_1"."currencyRateAverageRangeMidHigh"."modifiedDate" AS "ModifiedDate" FROM "local_1"."currencyRateAverageRangeMidHigh"
UNION
SELECT "local_3"."currency_rate_avg_up_to_1_0684"."currency_rate_id" AS "CurrencyRateID", "local_3"."currency_rate_avg_up_to_1_0684"."rate_effective_date" AS "CurrencyRateDate", "local_3"."currency_rate_avg_up_to_1_0684"."source_currency_code" AS "FromCurrencyCode", "local_3"."currency_rate_avg_up_to_1_0684"."target_currency_code" AS "ToCurrencyCode", "local_3"."currency_rate_avg_up_to_1_0684"."average_exchange_rate" AS "AverageRate", "local_3"."currency_rate_avg_up_to_1_0684"."end_of_day_exchange_rate" AS "EndOfDayRate", "local_3"."currency_rate_avg_up_to_1_0684"."last_modified_at" AS "ModifiedDate" FROM "local_3"."currency_rate_avg_up_to_1_0684"
UNION
SELECT "local_3"."currency_rate_avg_above_8_2871_or_null"."currency_rate_id" AS "CurrencyRateID", "local_3"."currency_rate_avg_above_8_2871_or_null"."rate_effective_date" AS "CurrencyRateDate", "local_3"."currency_rate_avg_above_8_2871_or_null"."source_currency_code" AS "FromCurrencyCode", "local_3"."currency_rate_avg_above_8_2871_or_null"."target_currency_code" AS "ToCurrencyCode", "local_3"."currency_rate_avg_above_8_2871_or_null"."average_exchange_rate" AS "AverageRate", "local_3"."currency_rate_avg_above_8_2871_or_null"."end_of_day_exchange_rate" AS "EndOfDayRate", "local_3"."currency_rate_avg_above_8_2871_or_null"."last_modified_at" AS "ModifiedDate" FROM "local_3"."currency_rate_avg_above_8_2871_or_null";

-- Reconstruct Customer from local_1.customerRecord
CREATE VIEW "Customer" AS
SELECT
    "local_1"."customerRecord"."customerId" AS "CustomerID",
    "local_1"."customerRecord"."personId" AS "PersonID",
    "local_1"."customerRecord"."storeId" AS "StoreID",
    "local_1"."customerRecord"."territoryId" AS "TerritoryID",
    "local_1"."customerRecord"."accountNumber" AS "AccountNumber",
    "local_1"."customerRecord"."rowGuid" AS "rowguid",
    "local_1"."customerRecord"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."customerRecord";

-- Reconstruct Department from local_1.departmentRef
CREATE VIEW "Department" AS
SELECT
    "local_1"."departmentRef"."departmentId" AS "DepartmentID",
    "local_1"."departmentRef"."displayName" AS "Name",
    "local_1"."departmentRef"."groupName" AS "GroupName",
    "local_1"."departmentRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."departmentRef";

-- Reconstruct Document from vertical (column) split (2 fragments)
CREATE VIEW "Document" AS
SELECT
    t0."documentKey" AS "DocumentNode",
    t0."documentLevel" AS "DocumentLevel",
    t0."title" AS "Title",
    t1."ownerId" AS "Owner",
    t0."folderFlag" AS "FolderFlag",
    t0."fileName" AS "FileName",
    t0."fileExtension" AS "FileExtension",
    t1."revisionLabel" AS "Revision",
    t1."changeSequence" AS "ChangeNumber",
    t0."statusCode" AS "Status",
    t0."documentSummary" AS "DocumentSummary",
    t0."documentData" AS "Document",
    t0."rowGuid" AS "rowguid",
    t0."modifiedDate" AS "ModifiedDate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "documentKey" ORDER BY rowid) AS __rn FROM "local_1"."documentRepository") t0
JOIN "local_5"."documentRevisionTracker" t1 ON t0."documentKey" IS t1."documentNodeToken" AND t0.__rn = t1.__rn;

-- Reconstruct EmailAddress from row partitions (UNION (overlap))
CREATE VIEW "EmailAddress" AS
SELECT "local_1"."emailAddressModifiedBefore20121212"."businessEntityId" AS "BusinessEntityID", "local_1"."emailAddressModifiedBefore20121212"."emailAddressId" AS "EmailAddressID", "local_1"."emailAddressModifiedBefore20121212"."emailAddress" AS "EmailAddress", "local_1"."emailAddressModifiedBefore20121212"."rowGuid" AS "rowguid", "local_1"."emailAddressModifiedBefore20121212"."modifiedDate" AS "ModifiedDate" FROM "local_1"."emailAddressModifiedBefore20121212"
UNION
SELECT "local_1"."emailAddressModifiedDec2012ToSep2013"."businessEntityId" AS "BusinessEntityID", "local_1"."emailAddressModifiedDec2012ToSep2013"."emailAddressId" AS "EmailAddressID", "local_1"."emailAddressModifiedDec2012ToSep2013"."emailAddress" AS "EmailAddress", "local_1"."emailAddressModifiedDec2012ToSep2013"."rowGuid" AS "rowguid", "local_1"."emailAddressModifiedDec2012ToSep2013"."modifiedDate" AS "ModifiedDate" FROM "local_1"."emailAddressModifiedDec2012ToSep2013"
UNION
SELECT "local_1"."emailAddressModifiedSep2013ToJan2014"."businessEntityId" AS "BusinessEntityID", "local_1"."emailAddressModifiedSep2013ToJan2014"."emailAddressId" AS "EmailAddressID", "local_1"."emailAddressModifiedSep2013ToJan2014"."emailAddress" AS "EmailAddress", "local_1"."emailAddressModifiedSep2013ToJan2014"."rowGuid" AS "rowguid", "local_1"."emailAddressModifiedSep2013ToJan2014"."modifiedDate" AS "ModifiedDate" FROM "local_1"."emailAddressModifiedSep2013ToJan2014"
UNION
SELECT "local_1"."emailAddressModifiedAfterJan302014OrNull"."businessEntityId" AS "BusinessEntityID", "local_1"."emailAddressModifiedAfterJan302014OrNull"."emailAddressId" AS "EmailAddressID", "local_1"."emailAddressModifiedAfterJan302014OrNull"."emailAddress" AS "EmailAddress", "local_1"."emailAddressModifiedAfterJan302014OrNull"."rowGuid" AS "rowguid", "local_1"."emailAddressModifiedAfterJan302014OrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."emailAddressModifiedAfterJan302014OrNull";

-- Reconstruct Employee from vertical split + row partition on a fragment
CREATE VIEW "Employee" AS
SELECT t0.[business_entity_id], t2.[NationalIdentifier], t1.[loginId], t3.[OrgNodePath], t3.[OrgLevel], t1.[jobTitle], t0.[birth_date], t1.[maritalStatus], t1.[gender], t0.[hire_date], t1.[salariedFlag], t1.[vacationHours], t1.[sickLeaveHours], t1.[currentFlag], t2.[RowGuidValue], t0.[modified_at]
FROM [local_6].[employee_life_dates] t0
JOIN [local_1].[employeeCurrentFlags] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [EmployeeCurrentFlagSalariedNonPositive].[__orig_rowid] AS __orig_rowid, [local_2].[EmployeeCurrentFlagSalariedNonPositive].[EmployeeId], [local_2].[EmployeeCurrentFlagSalariedNonPositive].[NationalIdentifier], [local_2].[EmployeeCurrentFlagSalariedNonPositive].[LoginName], [local_2].[EmployeeCurrentFlagSalariedNonPositive].[SalariedIndicator], [local_2].[EmployeeCurrentFlagSalariedNonPositive].[IsCurrent], [local_2].[EmployeeCurrentFlagSalariedNonPositive].[RowGuidValue] FROM [local_2].[EmployeeCurrentFlagSalariedNonPositive]
UNION
SELECT [EmployeeCurrentFlagSalariedPositiveOrNull].[__orig_rowid] AS __orig_rowid, [local_2].[EmployeeCurrentFlagSalariedPositiveOrNull].[EmployeeId], [local_2].[EmployeeCurrentFlagSalariedPositiveOrNull].[NationalIdentifier], [local_2].[EmployeeCurrentFlagSalariedPositiveOrNull].[LoginName], [local_2].[EmployeeCurrentFlagSalariedPositiveOrNull].[SalariedIndicator], [local_2].[EmployeeCurrentFlagSalariedPositiveOrNull].[IsCurrent], [local_2].[EmployeeCurrentFlagSalariedPositiveOrNull].[RowGuidValue] FROM [local_2].[EmployeeCurrentFlagSalariedPositiveOrNull]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[EmployeeGenderProfile] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct EmployeeDepartmentHistory from local_6.employee_department_history
CREATE VIEW "EmployeeDepartmentHistory" AS
SELECT
    "local_6"."employee_department_history"."business_entity_id" AS "BusinessEntityID",
    "local_6"."employee_department_history"."department_id" AS "DepartmentID",
    "local_6"."employee_department_history"."shift_id" AS "ShiftID",
    "local_6"."employee_department_history"."start_date" AS "StartDate",
    "local_6"."employee_department_history"."end_date" AS "EndDate",
    "local_6"."employee_department_history"."modified_at" AS "ModifiedDate"
FROM "local_6"."employee_department_history";

-- Reconstruct EmployeePayHistory from row partitions (UNION (overlap))
CREATE VIEW "EmployeePayHistory" AS
SELECT "local_1"."employeePayRateRange11To14"."businessEntityId" AS "BusinessEntityID", "local_1"."employeePayRateRange11To14"."rateChangeDate" AS "RateChangeDate", "local_1"."employeePayRateRange11To14"."rate" AS "Rate", "local_1"."employeePayRateRange11To14"."payFrequency" AS "PayFrequency", "local_1"."employeePayRateRange11To14"."modifiedDate" AS "ModifiedDate" FROM "local_1"."employeePayRateRange11To14"
UNION
SELECT "local_1"."employeePayRateRange14To230769"."businessEntityId" AS "BusinessEntityID", "local_1"."employeePayRateRange14To230769"."rateChangeDate" AS "RateChangeDate", "local_1"."employeePayRateRange14To230769"."rate" AS "Rate", "local_1"."employeePayRateRange14To230769"."payFrequency" AS "PayFrequency", "local_1"."employeePayRateRange14To230769"."modifiedDate" AS "ModifiedDate" FROM "local_1"."employeePayRateRange14To230769"
UNION
SELECT "local_2"."EmployeePayHistoryLowestRateQuartile"."EmployeeId" AS "BusinessEntityID", "local_2"."EmployeePayHistoryLowestRateQuartile"."RateEffectiveDate" AS "RateChangeDate", "local_2"."EmployeePayHistoryLowestRateQuartile"."PayRate" AS "Rate", "local_2"."EmployeePayHistoryLowestRateQuartile"."PayInterval" AS "PayFrequency", "local_2"."EmployeePayHistoryLowestRateQuartile"."LastModifiedDate" AS "ModifiedDate" FROM "local_2"."EmployeePayHistoryLowestRateQuartile"
UNION
SELECT "local_2"."EmployeePayHistoryHighestRateQuartileOrNull"."EmployeeId" AS "BusinessEntityID", "local_2"."EmployeePayHistoryHighestRateQuartileOrNull"."RateEffectiveDate" AS "RateChangeDate", "local_2"."EmployeePayHistoryHighestRateQuartileOrNull"."PayRate" AS "Rate", "local_2"."EmployeePayHistoryHighestRateQuartileOrNull"."PayInterval" AS "PayFrequency", "local_2"."EmployeePayHistoryHighestRateQuartileOrNull"."LastModifiedDate" AS "ModifiedDate" FROM "local_2"."EmployeePayHistoryHighestRateQuartileOrNull";

-- Reconstruct JobCandidate from local_3.job_candidate_profile
CREATE VIEW "JobCandidate" AS
SELECT
    "local_3"."job_candidate_profile"."job_candidate_id" AS "JobCandidateID",
    "local_3"."job_candidate_profile"."business_entity_id" AS "BusinessEntityID",
    "local_3"."job_candidate_profile"."resume_text" AS "Resume",
    "local_3"."job_candidate_profile"."last_modified_at" AS "ModifiedDate"
FROM "local_3"."job_candidate_profile";

-- Reconstruct Location from local_1.locationRef
CREATE VIEW "Location" AS
SELECT
    "local_1"."locationRef"."locationId" AS "LocationID",
    "local_1"."locationRef"."locationName" AS "Name",
    "local_1"."locationRef"."costRate" AS "CostRate",
    "local_1"."locationRef"."availability" AS "Availability",
    "local_1"."locationRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."locationRef";

-- Reconstruct Password from row partitions (UNION (overlap))
CREATE VIEW "Password" AS
SELECT "local_1"."passwordModifiedBefore20121212"."businessEntityId" AS "BusinessEntityID", "local_1"."passwordModifiedBefore20121212"."passwordHash" AS "PasswordHash", "local_1"."passwordModifiedBefore20121212"."passwordSalt" AS "PasswordSalt", "local_1"."passwordModifiedBefore20121212"."rowGuid" AS "rowguid", "local_1"."passwordModifiedBefore20121212"."modifiedDate" AS "ModifiedDate" FROM "local_1"."passwordModifiedBefore20121212"
UNION
SELECT "local_1"."passwordModifiedDec2012ToSep2013"."businessEntityId" AS "BusinessEntityID", "local_1"."passwordModifiedDec2012ToSep2013"."passwordHash" AS "PasswordHash", "local_1"."passwordModifiedDec2012ToSep2013"."passwordSalt" AS "PasswordSalt", "local_1"."passwordModifiedDec2012ToSep2013"."rowGuid" AS "rowguid", "local_1"."passwordModifiedDec2012ToSep2013"."modifiedDate" AS "ModifiedDate" FROM "local_1"."passwordModifiedDec2012ToSep2013"
UNION
SELECT "local_1"."passwordModifiedSep2013ToJan302014"."businessEntityId" AS "BusinessEntityID", "local_1"."passwordModifiedSep2013ToJan302014"."passwordHash" AS "PasswordHash", "local_1"."passwordModifiedSep2013ToJan302014"."passwordSalt" AS "PasswordSalt", "local_1"."passwordModifiedSep2013ToJan302014"."rowGuid" AS "rowguid", "local_1"."passwordModifiedSep2013ToJan302014"."modifiedDate" AS "ModifiedDate" FROM "local_1"."passwordModifiedSep2013ToJan302014"
UNION
SELECT "local_1"."passwordModifiedAfterJan302014OrNull"."businessEntityId" AS "BusinessEntityID", "local_1"."passwordModifiedAfterJan302014OrNull"."passwordHash" AS "PasswordHash", "local_1"."passwordModifiedAfterJan302014OrNull"."passwordSalt" AS "PasswordSalt", "local_1"."passwordModifiedAfterJan302014OrNull"."rowGuid" AS "rowguid", "local_1"."passwordModifiedAfterJan302014OrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."passwordModifiedAfterJan302014OrNull";

-- Reconstruct Person from vertical split + row partition on a fragment
CREATE VIEW "Person" AS
SELECT t0.[businessEntityId], t0.[personType], t0.[nameStyle], t0.[title], t1.[name], t1.[middle_name], t1.[last_name], t0.[suffix], t0.[emailPromotion], t0.[additionalContactInfo], t0.[demographics], t0.[rowGuid], t0.[modifiedDate]
FROM (
SELECT [personAdditionalContactAfterJan302014OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[personAdditionalContactAfterJan302014OrNull].[businessEntityId], [local_1].[personAdditionalContactAfterJan302014OrNull].[personType], [local_1].[personAdditionalContactAfterJan302014OrNull].[nameStyle], [local_1].[personAdditionalContactAfterJan302014OrNull].[title], [local_1].[personAdditionalContactAfterJan302014OrNull].[suffix], [local_1].[personAdditionalContactAfterJan302014OrNull].[emailPromotion], [local_1].[personAdditionalContactAfterJan302014OrNull].[additionalContactInfo], [local_1].[personAdditionalContactAfterJan302014OrNull].[demographics], [local_1].[personAdditionalContactAfterJan302014OrNull].[rowGuid], [local_1].[personAdditionalContactAfterJan302014OrNull].[modifiedDate] FROM [local_1].[personAdditionalContactAfterJan302014OrNull]
UNION
SELECT [personAdditionalContactBefore20121212].[__orig_rowid] AS __orig_rowid, [local_1].[personAdditionalContactBefore20121212].[businessEntityId], [local_1].[personAdditionalContactBefore20121212].[personType], [local_1].[personAdditionalContactBefore20121212].[nameStyle], [local_1].[personAdditionalContactBefore20121212].[title], [local_1].[personAdditionalContactBefore20121212].[suffix], [local_1].[personAdditionalContactBefore20121212].[emailPromotion], [local_1].[personAdditionalContactBefore20121212].[additionalContactInfo], [local_1].[personAdditionalContactBefore20121212].[demographics], [local_1].[personAdditionalContactBefore20121212].[rowGuid], [local_1].[personAdditionalContactBefore20121212].[modifiedDate] FROM [local_1].[personAdditionalContactBefore20121212]
UNION
SELECT [PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[__orig_rowid] AS __orig_rowid, [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[PersonId], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[PersonCategory], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[NameStyleFlag], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[NameTitle], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[NameSuffix], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[EmailPromotionFlag], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[AdditionalContacts], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[DemographicData], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[RowGuidValue], [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13].[ModifiedTimestamp] FROM [local_2].[PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13]
UNION
SELECT [PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[__orig_rowid] AS __orig_rowid, [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[PersonId], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[PersonCategory], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[NameStyleFlag], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[NameTitle], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[NameSuffix], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[EmailPromotionFlag], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[AdditionalContacts], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[DemographicData], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[RowGuidValue], [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30].[ModifiedTimestamp] FROM [local_2].[PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30]
) t0
JOIN [local_6].[person_additional_contact_info] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct PersonCreditCard from row partitions (UNION (overlap))
CREATE VIEW "PersonCreditCard" AS
SELECT "local_1"."personCreditCardModifiedFebToSep2013"."businessEntityId" AS "BusinessEntityID", "local_1"."personCreditCardModifiedFebToSep2013"."creditCardId" AS "CreditCardID", "local_1"."personCreditCardModifiedFebToSep2013"."modifiedDate" AS "ModifiedDate" FROM "local_1"."personCreditCardModifiedFebToSep2013"
UNION
SELECT "local_1"."personCreditCardModifiedSep2013ToFeb2014"."businessEntityId" AS "BusinessEntityID", "local_1"."personCreditCardModifiedSep2013ToFeb2014"."creditCardId" AS "CreditCardID", "local_1"."personCreditCardModifiedSep2013ToFeb2014"."modifiedDate" AS "ModifiedDate" FROM "local_1"."personCreditCardModifiedSep2013ToFeb2014"
UNION
SELECT "local_4"."person_cc_pre20130213"."be_id" AS "BusinessEntityID", "local_4"."person_cc_pre20130213"."cc_id" AS "CreditCardID", "local_4"."person_cc_pre20130213"."mod_dt" AS "ModifiedDate" FROM "local_4"."person_cc_pre20130213"
UNION
SELECT "local_4"."person_cc_post20140205_or_null"."be_id" AS "BusinessEntityID", "local_4"."person_cc_post20140205_or_null"."cc_id" AS "CreditCardID", "local_4"."person_cc_post20140205_or_null"."mod_dt" AS "ModifiedDate" FROM "local_4"."person_cc_post20140205_or_null";

-- Reconstruct PhoneNumberType from local_2.PhoneNumberTypeLookup
CREATE VIEW "PhoneNumberType" AS
SELECT
    "local_2"."PhoneNumberTypeLookup"."PhoneTypeId" AS "PhoneNumberTypeID",
    "local_2"."PhoneNumberTypeLookup"."TypeName" AS "Name",
    "local_2"."PhoneNumberTypeLookup"."LastUpdated" AS "ModifiedDate"
FROM "local_2"."PhoneNumberTypeLookup";

-- Reconstruct Product from vertical split + row partition on a fragment
CREATE VIEW "Product" AS
SELECT t0.[productId], t0.[productName], t0.[productNumber], t2.[makeFlag], t2.[finishedGoodsFlag], t0.[color], t0.[safetyStockLevel], t0.[reorderPoint], t0.[standardCost], t0.[listPrice], t0.[size], t1.[size_unit_code], t1.[weight_unit_code], t1.[weight], t2.[daysToManufacture], t0.[productLine], t0.[productClass], t0.[style], t0.[productSubcategoryId], t0.[productModelId], t3.[sellStartDate], t3.[sellEndDate], t3.[discontinuedDate], t0.[rowGuid], t3.[modifiedDate]
FROM [local_1].[productDetails] t0
JOIN [local_8].[product_classification_core] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [productDaysToManufactureGreaterOneOrNull].[__orig_rowid] AS __orig_rowid, [local_1].[productDaysToManufactureGreaterOneOrNull].[productId], [local_1].[productDaysToManufactureGreaterOneOrNull].[makeFlag], [local_1].[productDaysToManufactureGreaterOneOrNull].[finishedGoodsFlag], [local_1].[productDaysToManufactureGreaterOneOrNull].[daysToManufacture] FROM [local_1].[productDaysToManufactureGreaterOneOrNull]
UNION
SELECT [productDaysToManufactureOne].[__orig_rowid] AS __orig_rowid, [local_1].[productDaysToManufactureOne].[productId], [local_1].[productDaysToManufactureOne].[makeFlag], [local_1].[productDaysToManufactureOne].[finishedGoodsFlag], [local_1].[productDaysToManufactureOne].[daysToManufacture] FROM [local_1].[productDaysToManufactureOne]
UNION
SELECT [productDaysToManufactureZeroOrLess].[__orig_rowid] AS __orig_rowid, [local_1].[productDaysToManufactureZeroOrLess].[productId], [local_1].[productDaysToManufactureZeroOrLess].[makeFlag], [local_1].[productDaysToManufactureZeroOrLess].[finishedGoodsFlag], [local_1].[productDaysToManufactureZeroOrLess].[daysToManufacture] FROM [local_1].[productDaysToManufactureZeroOrLess]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[productDiscontinuedDates] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct ProductCategory from local_1.productCategoryRef
CREATE VIEW "ProductCategory" AS
SELECT
    "local_1"."productCategoryRef"."productCategoryId" AS "ProductCategoryID",
    "local_1"."productCategoryRef"."displayName" AS "Name",
    "local_1"."productCategoryRef"."rowGuid" AS "rowguid",
    "local_1"."productCategoryRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."productCategoryRef";

-- Reconstruct ProductCostHistory from row partitions (UNION (overlap))
CREATE VIEW "ProductCostHistory" AS
SELECT "local_1"."productCostHistoryLowCost"."productId" AS "ProductID", "local_1"."productCostHistoryLowCost"."startDate" AS "StartDate", "local_1"."productCostHistoryLowCost"."endDate" AS "EndDate", "local_1"."productCostHistoryLowCost"."standardCost" AS "StandardCost", "local_1"."productCostHistoryLowCost"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productCostHistoryLowCost"
UNION
SELECT "local_1"."productCostHistorySecondQuartile"."productId" AS "ProductID", "local_1"."productCostHistorySecondQuartile"."startDate" AS "StartDate", "local_1"."productCostHistorySecondQuartile"."endDate" AS "EndDate", "local_1"."productCostHistorySecondQuartile"."standardCost" AS "StandardCost", "local_1"."productCostHistorySecondQuartile"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productCostHistorySecondQuartile"
UNION
SELECT "local_1"."productCostHistoryThirdQuartile"."productId" AS "ProductID", "local_1"."productCostHistoryThirdQuartile"."startDate" AS "StartDate", "local_1"."productCostHistoryThirdQuartile"."endDate" AS "EndDate", "local_1"."productCostHistoryThirdQuartile"."standardCost" AS "StandardCost", "local_1"."productCostHistoryThirdQuartile"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productCostHistoryThirdQuartile"
UNION
SELECT "local_1"."productCostHistoryHighOrNull"."productId" AS "ProductID", "local_1"."productCostHistoryHighOrNull"."startDate" AS "StartDate", "local_1"."productCostHistoryHighOrNull"."endDate" AS "EndDate", "local_1"."productCostHistoryHighOrNull"."standardCost" AS "StandardCost", "local_1"."productCostHistoryHighOrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productCostHistoryHighOrNull";

-- Reconstruct ProductDescription from row partitions (UNION (overlap))
CREATE VIEW "ProductDescription" AS
SELECT "local_3"."product_description_as_of_2013_04_30"."product_description_id" AS "ProductDescriptionID", "local_3"."product_description_as_of_2013_04_30"."description_text" AS "Description", "local_3"."product_description_as_of_2013_04_30"."row_guid" AS "rowguid", "local_3"."product_description_as_of_2013_04_30"."last_modified_at" AS "ModifiedDate" FROM "local_3"."product_description_as_of_2013_04_30"
UNION
SELECT "local_3"."product_description_as_of_2014_02_08"."product_description_id" AS "ProductDescriptionID", "local_3"."product_description_as_of_2014_02_08"."description_text" AS "Description", "local_3"."product_description_as_of_2014_02_08"."row_guid" AS "rowguid", "local_3"."product_description_as_of_2014_02_08"."last_modified_at" AS "ModifiedDate" FROM "local_3"."product_description_as_of_2014_02_08";

-- Reconstruct ProductDocument from local_5.productDocumentLink
CREATE VIEW "ProductDocument" AS
SELECT
    "local_5"."productDocumentLink"."productReferenceId" AS "ProductID",
    "local_5"."productDocumentLink"."documentNodeToken" AS "DocumentNode",
    "local_5"."productDocumentLink"."updatedAt" AS "ModifiedDate"
FROM "local_5"."productDocumentLink";

-- Reconstruct ProductInventory from vertical split + row partition on a fragment
CREATE VIEW "ProductInventory" AS
SELECT t0.[ProductKey], t0.[LocationKey], t0.[ShelfCode], t0.[BinNumber], t0.[QuantityOnHand], t0.[RowGuidValue], t1.[modifiedDate]
FROM [local_7].[ProductInventoryBinAssignment] t0
JOIN (
SELECT [productInventoryModifiedApr2012ToJul2014].[__orig_rowid] AS __orig_rowid, [local_1].[productInventoryModifiedApr2012ToJul2014].[productId], [local_1].[productInventoryModifiedApr2012ToJul2014].[locationId], [local_1].[productInventoryModifiedApr2012ToJul2014].[quantity], [local_1].[productInventoryModifiedApr2012ToJul2014].[rowGuid], [local_1].[productInventoryModifiedApr2012ToJul2014].[modifiedDate] FROM [local_1].[productInventoryModifiedApr2012ToJul2014]
UNION
SELECT [productInventoryModifiedBefore20120430].[__orig_rowid] AS __orig_rowid, [local_1].[productInventoryModifiedBefore20120430].[productId], [local_1].[productInventoryModifiedBefore20120430].[locationId], [local_1].[productInventoryModifiedBefore20120430].[quantity], [local_1].[productInventoryModifiedBefore20120430].[rowGuid], [local_1].[productInventoryModifiedBefore20120430].[modifiedDate] FROM [local_1].[productInventoryModifiedBefore20120430]
UNION
SELECT [productInventoryModifiedJulAug2014].[__orig_rowid] AS __orig_rowid, [local_1].[productInventoryModifiedJulAug2014].[productId], [local_1].[productInventoryModifiedJulAug2014].[locationId], [local_1].[productInventoryModifiedJulAug2014].[quantity], [local_1].[productInventoryModifiedJulAug2014].[rowGuid], [local_1].[productInventoryModifiedJulAug2014].[modifiedDate] FROM [local_1].[productInventoryModifiedJulAug2014]
UNION
SELECT [ProductInventoryModifiedAfter20140809OrNull].[__orig_rowid] AS __orig_rowid, [local_7].[ProductInventoryModifiedAfter20140809OrNull].[ProductKey], [local_7].[ProductInventoryModifiedAfter20140809OrNull].[LocationKey], [local_7].[ProductInventoryModifiedAfter20140809OrNull].[QuantityOnHand], [local_7].[ProductInventoryModifiedAfter20140809OrNull].[RowGuidValue], [local_7].[ProductInventoryModifiedAfter20140809OrNull].[InventoryModifiedAt] FROM [local_7].[ProductInventoryModifiedAfter20140809OrNull]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct ProductListPriceHistory from row partitions (UNION (overlap))
CREATE VIEW "ProductListPriceHistory" AS
SELECT "local_1"."productListPriceLowQuartile"."productId" AS "ProductID", "local_1"."productListPriceLowQuartile"."startDate" AS "StartDate", "local_1"."productListPriceLowQuartile"."endDate" AS "EndDate", "local_1"."productListPriceLowQuartile"."listPrice" AS "ListPrice", "local_1"."productListPriceLowQuartile"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productListPriceLowQuartile"
UNION
SELECT "local_1"."productListPriceSecondQuartile"."productId" AS "ProductID", "local_1"."productListPriceSecondQuartile"."startDate" AS "StartDate", "local_1"."productListPriceSecondQuartile"."endDate" AS "EndDate", "local_1"."productListPriceSecondQuartile"."listPrice" AS "ListPrice", "local_1"."productListPriceSecondQuartile"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productListPriceSecondQuartile"
UNION
SELECT "local_1"."productListPriceThirdQuartile"."productId" AS "ProductID", "local_1"."productListPriceThirdQuartile"."startDate" AS "StartDate", "local_1"."productListPriceThirdQuartile"."endDate" AS "EndDate", "local_1"."productListPriceThirdQuartile"."listPrice" AS "ListPrice", "local_1"."productListPriceThirdQuartile"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productListPriceThirdQuartile"
UNION
SELECT "local_1"."productListPriceHighOrNull"."productId" AS "ProductID", "local_1"."productListPriceHighOrNull"."startDate" AS "StartDate", "local_1"."productListPriceHighOrNull"."endDate" AS "EndDate", "local_1"."productListPriceHighOrNull"."listPrice" AS "ListPrice", "local_1"."productListPriceHighOrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productListPriceHighOrNull";

-- Reconstruct ProductModel from row partitions (UNION (overlap))
CREATE VIEW "ProductModel" AS
SELECT "local_1"."productModelOlderModifiedBefore20120430"."productModelId" AS "ProductModelID", "local_1"."productModelOlderModifiedBefore20120430"."modelName" AS "Name", "local_1"."productModelOlderModifiedBefore20120430"."catalogDescription" AS "CatalogDescription", "local_1"."productModelOlderModifiedBefore20120430"."instructions" AS "Instructions", "local_1"."productModelOlderModifiedBefore20120430"."rowGuid" AS "rowguid", "local_1"."productModelOlderModifiedBefore20120430"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productModelOlderModifiedBefore20120430"
UNION
SELECT "local_3"."product_model_filtered_by_modified_date"."product_model_id" AS "ProductModelID", "local_3"."product_model_filtered_by_modified_date"."model_name" AS "Name", "local_3"."product_model_filtered_by_modified_date"."catalog_summary" AS "CatalogDescription", "local_3"."product_model_filtered_by_modified_date"."usage_instructions" AS "Instructions", "local_3"."product_model_filtered_by_modified_date"."row_guid" AS "rowguid", "local_3"."product_model_filtered_by_modified_date"."last_modified_at" AS "ModifiedDate" FROM "local_3"."product_model_filtered_by_modified_date";

-- Reconstruct ProductModelProductDescriptionCulture from local_3.product_model_description_culture_link
CREATE VIEW "ProductModelProductDescriptionCulture" AS
SELECT
    "local_3"."product_model_description_culture_link"."product_model_id" AS "ProductModelID",
    "local_3"."product_model_description_culture_link"."product_description_id" AS "ProductDescriptionID",
    "local_3"."product_model_description_culture_link"."culture_code" AS "CultureID",
    "local_3"."product_model_description_culture_link"."last_modified_at" AS "ModifiedDate"
FROM "local_3"."product_model_description_culture_link";

-- Reconstruct ProductPhoto from row partitions (UNION (overlap))
CREATE VIEW "ProductPhoto" AS
SELECT "local_4"."prod_photo_early_20120430"."photo_id" AS "ProductPhotoID", "local_4"."prod_photo_early_20120430"."thumb_img" AS "ThumbNailPhoto", "local_4"."prod_photo_early_20120430"."thumb_fn" AS "ThumbnailPhotoFileName", "local_4"."prod_photo_early_20120430"."large_img" AS "LargePhoto", "local_4"."prod_photo_early_20120430"."large_fn" AS "LargePhotoFileName", "local_4"."prod_photo_early_20120430"."mod_dt" AS "ModifiedDate" FROM "local_4"."prod_photo_early_20120430"
UNION
SELECT "local_4"."prod_photo_mid_20120430_20121019"."photo_id" AS "ProductPhotoID", "local_4"."prod_photo_mid_20120430_20121019"."thumb_img" AS "ThumbNailPhoto", "local_4"."prod_photo_mid_20120430_20121019"."thumb_fn" AS "ThumbnailPhotoFileName", "local_4"."prod_photo_mid_20120430_20121019"."large_img" AS "LargePhoto", "local_4"."prod_photo_mid_20120430_20121019"."large_fn" AS "LargePhotoFileName", "local_4"."prod_photo_mid_20120430_20121019"."mod_dt" AS "ModifiedDate" FROM "local_4"."prod_photo_mid_20120430_20121019"
UNION
SELECT "local_4"."prod_photo_post_20121019"."photo_id" AS "ProductPhotoID", "local_4"."prod_photo_post_20121019"."thumb_img" AS "ThumbNailPhoto", "local_4"."prod_photo_post_20121019"."thumb_fn" AS "ThumbnailPhotoFileName", "local_4"."prod_photo_post_20121019"."large_img" AS "LargePhoto", "local_4"."prod_photo_post_20121019"."large_fn" AS "LargePhotoFileName", "local_4"."prod_photo_post_20121019"."mod_dt" AS "ModifiedDate" FROM "local_4"."prod_photo_post_20121019";

-- Reconstruct ProductProductPhoto from row partitions (UNION (overlap))
CREATE VIEW "ProductProductPhoto" AS
SELECT "local_1"."productPhotoModified20080331To20110501"."productId" AS "ProductID", "local_1"."productPhotoModified20080331To20110501"."productPhotoId" AS "ProductPhotoID", "local_1"."productPhotoModified20080331To20110501"."isPrimary" AS "Primary", "local_1"."productPhotoModified20080331To20110501"."modifiedDate" AS "ModifiedDate" FROM "local_1"."productPhotoModified20080331To20110501"
UNION
SELECT "local_4"."prod_photo_xref_early_20080331"."prod_id" AS "ProductID", "local_4"."prod_photo_xref_early_20080331"."photo_id" AS "ProductPhotoID", "local_4"."prod_photo_xref_early_20080331"."primary_flag" AS "Primary", "local_4"."prod_photo_xref_early_20080331"."mod_dt" AS "ModifiedDate" FROM "local_4"."prod_photo_xref_early_20080331"
UNION
SELECT "local_4"."prod_photo_xref_post20110501"."prod_id" AS "ProductID", "local_4"."prod_photo_xref_post20110501"."photo_id" AS "ProductPhotoID", "local_4"."prod_photo_xref_post20110501"."primary_flag" AS "Primary", "local_4"."prod_photo_xref_post20110501"."mod_dt" AS "ModifiedDate" FROM "local_4"."prod_photo_xref_post20110501";

-- Reconstruct ProductReview from local_1.productReview
CREATE VIEW "ProductReview" AS
SELECT
    "local_1"."productReview"."productReviewId" AS "ProductReviewID",
    "local_1"."productReview"."productId" AS "ProductID",
    "local_1"."productReview"."reviewerName" AS "ReviewerName",
    "local_1"."productReview"."reviewDate" AS "ReviewDate",
    "local_1"."productReview"."emailAddress" AS "EmailAddress",
    "local_1"."productReview"."rating" AS "Rating",
    "local_1"."productReview"."comments" AS "Comments",
    "local_1"."productReview"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."productReview";

-- Reconstruct ProductSubcategory from local_1.productSubcategoryRef
CREATE VIEW "ProductSubcategory" AS
SELECT
    "local_1"."productSubcategoryRef"."productSubcategoryId" AS "ProductSubcategoryID",
    "local_1"."productSubcategoryRef"."productCategoryId" AS "ProductCategoryID",
    "local_1"."productSubcategoryRef"."displayName" AS "Name",
    "local_1"."productSubcategoryRef"."rowGuid" AS "rowguid",
    "local_1"."productSubcategoryRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."productSubcategoryRef";

-- Reconstruct ProductVendor from vertical split + row partition on a fragment
CREATE VIEW "ProductVendor" AS
SELECT t0.[product_id], t0.[vendor_business_entity_id], t0.[average_lead_time_days], t0.[standard_price], t0.[last_receipt_cost], t0.[last_receipt_date], t2.[minOrderQty], t2.[maxOrderQty], t2.[onOrderQty], t0.[unit_measure_code], t0.[modified_at]
FROM [local_8].[supplier_product_lead_time] t0
JOIN [local_1].[productVendorAverageLeadTime] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [productVendorMaxOrderQtyLow].[__orig_rowid] AS __orig_rowid, [local_1].[productVendorMaxOrderQtyLow].[productId], [local_1].[productVendorMaxOrderQtyLow].[vendorId], [local_1].[productVendorMaxOrderQtyLow].[minOrderQty], [local_1].[productVendorMaxOrderQtyLow].[maxOrderQty], [local_1].[productVendorMaxOrderQtyLow].[onOrderQty] FROM [local_1].[productVendorMaxOrderQtyLow]
UNION
SELECT [productVendorMaxOrderQtyMixed].[__orig_rowid] AS __orig_rowid, [local_1].[productVendorMaxOrderQtyMixed].[productId], [local_1].[productVendorMaxOrderQtyMixed].[vendorId], [local_1].[productVendorMaxOrderQtyMixed].[minOrderQty], [local_1].[productVendorMaxOrderQtyMixed].[maxOrderQty], [local_1].[productVendorMaxOrderQtyMixed].[onOrderQty] FROM [local_1].[productVendorMaxOrderQtyMixed]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct PurchaseOrderDetail from vertical split + row partition on a fragment
CREATE VIEW "PurchaseOrderDetail" AS
SELECT t1.[purchaseOrderId], t0.[purchaseOrderDetailId], t0.[dueDate], t0.[orderQty], t1.[productId], t0.[unitPrice], t0.[lineTotal], t2.[receivedQty], t2.[rejectedQty], t2.[stockedQty], t0.[modifiedDate]
FROM [local_1].[purchaseOrderDetailDueDate] t0
JOIN [local_1].[purchaseOrderDetailLineTotal] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [purchaseOrderDetailReceivedQtyLow].[__orig_rowid] AS __orig_rowid, [local_1].[purchaseOrderDetailReceivedQtyLow].[purchaseOrderDetailId], [local_1].[purchaseOrderDetailReceivedQtyLow].[receivedQty], [local_1].[purchaseOrderDetailReceivedQtyLow].[rejectedQty], [local_1].[purchaseOrderDetailReceivedQtyLow].[stockedQty] FROM [local_1].[purchaseOrderDetailReceivedQtyLow]
UNION
SELECT [purchaseOrderDetailReceivedQtyMixed].[__orig_rowid] AS __orig_rowid, [local_1].[purchaseOrderDetailReceivedQtyMixed].[purchaseOrderDetailId], [local_1].[purchaseOrderDetailReceivedQtyMixed].[receivedQty], [local_1].[purchaseOrderDetailReceivedQtyMixed].[rejectedQty], [local_1].[purchaseOrderDetailReceivedQtyMixed].[stockedQty] FROM [local_1].[purchaseOrderDetailReceivedQtyMixed]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct PurchaseOrderHeader from vertical split + row partition on a fragment
CREATE VIEW "PurchaseOrderHeader" AS
SELECT t0.[purchaseOrderId], t1.[revisionNumber], t0.[status], t0.[employeeId], t0.[vendorId], t0.[shipMethodId], t2.[orderDate], t2.[shipDate], t0.[subTotal], t0.[taxAmount], t0.[freight], t1.[totalDue], t2.[modifiedDate]
FROM [local_1].[purchaseOrderHeaderByEmployee] t0
JOIN [local_1].[purchaseOrderHeaderFreightInfo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [purchaseOrderHeaderModifiedAfterMay302014OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[purchaseOrderHeaderModifiedAfterMay302014OrNull].[purchaseOrderId], [local_1].[purchaseOrderHeaderModifiedAfterMay302014OrNull].[revisionNumber], [local_1].[purchaseOrderHeaderModifiedAfterMay302014OrNull].[orderDate], [local_1].[purchaseOrderHeaderModifiedAfterMay302014OrNull].[shipDate], [local_1].[purchaseOrderHeaderModifiedAfterMay302014OrNull].[modifiedDate] FROM [local_1].[purchaseOrderHeaderModifiedAfterMay302014OrNull]
UNION
SELECT [purchaseOrderHeaderModifiedBefore20131015].[__orig_rowid] AS __orig_rowid, [local_1].[purchaseOrderHeaderModifiedBefore20131015].[purchaseOrderId], [local_1].[purchaseOrderHeaderModifiedBefore20131015].[revisionNumber], [local_1].[purchaseOrderHeaderModifiedBefore20131015].[orderDate], [local_1].[purchaseOrderHeaderModifiedBefore20131015].[shipDate], [local_1].[purchaseOrderHeaderModifiedBefore20131015].[modifiedDate] FROM [local_1].[purchaseOrderHeaderModifiedBefore20131015]
UNION
SELECT [purchaseOrderHeaderModifiedFebToMay2014].[__orig_rowid] AS __orig_rowid, [local_1].[purchaseOrderHeaderModifiedFebToMay2014].[purchaseOrderId], [local_1].[purchaseOrderHeaderModifiedFebToMay2014].[revisionNumber], [local_1].[purchaseOrderHeaderModifiedFebToMay2014].[orderDate], [local_1].[purchaseOrderHeaderModifiedFebToMay2014].[shipDate], [local_1].[purchaseOrderHeaderModifiedFebToMay2014].[modifiedDate] FROM [local_1].[purchaseOrderHeaderModifiedFebToMay2014]
UNION
SELECT [purchaseOrderHeaderModifiedOct2013ToFeb2014].[__orig_rowid] AS __orig_rowid, [local_1].[purchaseOrderHeaderModifiedOct2013ToFeb2014].[purchaseOrderId], [local_1].[purchaseOrderHeaderModifiedOct2013ToFeb2014].[revisionNumber], [local_1].[purchaseOrderHeaderModifiedOct2013ToFeb2014].[orderDate], [local_1].[purchaseOrderHeaderModifiedOct2013ToFeb2014].[shipDate], [local_1].[purchaseOrderHeaderModifiedOct2013ToFeb2014].[modifiedDate] FROM [local_1].[purchaseOrderHeaderModifiedOct2013ToFeb2014]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct SalesOrderDetail from vertical split + row partition on a fragment
CREATE VIEW "SalesOrderDetail" AS
SELECT t1.[SalesOrderKey], t0.[salesOrderDetailId], t0.[carrierTrackingNumber], t0.[orderQty], t0.[productId], t0.[specialOfferId], t0.[unitPrice], t0.[unitPriceDiscount], t0.[lineTotal], t1.[RowGuidValue], t0.[modifiedDate]
FROM (
SELECT [salesOrderDetailHighLineTotalOrNull].[__orig_rowid] AS __orig_rowid, [local_1].[salesOrderDetailHighLineTotalOrNull].[salesOrderDetailId], [local_1].[salesOrderDetailHighLineTotalOrNull].[carrierTrackingNumber], [local_1].[salesOrderDetailHighLineTotalOrNull].[orderQty], [local_1].[salesOrderDetailHighLineTotalOrNull].[productId], [local_1].[salesOrderDetailHighLineTotalOrNull].[specialOfferId], [local_1].[salesOrderDetailHighLineTotalOrNull].[unitPrice], [local_1].[salesOrderDetailHighLineTotalOrNull].[unitPriceDiscount], [local_1].[salesOrderDetailHighLineTotalOrNull].[lineTotal], [local_1].[salesOrderDetailHighLineTotalOrNull].[modifiedDate] FROM [local_1].[salesOrderDetailHighLineTotalOrNull]
UNION
SELECT [salesOrderDetailLowLineTotal].[__orig_rowid] AS __orig_rowid, [local_1].[salesOrderDetailLowLineTotal].[salesOrderDetailId], [local_1].[salesOrderDetailLowLineTotal].[carrierTrackingNumber], [local_1].[salesOrderDetailLowLineTotal].[orderQty], [local_1].[salesOrderDetailLowLineTotal].[productId], [local_1].[salesOrderDetailLowLineTotal].[specialOfferId], [local_1].[salesOrderDetailLowLineTotal].[unitPrice], [local_1].[salesOrderDetailLowLineTotal].[unitPriceDiscount], [local_1].[salesOrderDetailLowLineTotal].[lineTotal], [local_1].[salesOrderDetailLowLineTotal].[modifiedDate] FROM [local_1].[salesOrderDetailLowLineTotal]
UNION
SELECT [OrderDetailCarrierLineTotalOver135To1120].[__orig_rowid] AS __orig_rowid, [local_7].[OrderDetailCarrierLineTotalOver135To1120].[OrderDetailKey], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[CarrierTrackingCode], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[OrderQuantity], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[ProductKey], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[SpecialOfferKey], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[UnitPriceAmount], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[UnitPriceDiscountAmount], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[LineTotalAmount], [local_7].[OrderDetailCarrierLineTotalOver135To1120].[DetailModifiedAt] FROM [local_7].[OrderDetailCarrierLineTotalOver135To1120]
UNION
SELECT [OrderDetailCarrierLineTotalOver25To135].[__orig_rowid] AS __orig_rowid, [local_7].[OrderDetailCarrierLineTotalOver25To135].[OrderDetailKey], [local_7].[OrderDetailCarrierLineTotalOver25To135].[CarrierTrackingCode], [local_7].[OrderDetailCarrierLineTotalOver25To135].[OrderQuantity], [local_7].[OrderDetailCarrierLineTotalOver25To135].[ProductKey], [local_7].[OrderDetailCarrierLineTotalOver25To135].[SpecialOfferKey], [local_7].[OrderDetailCarrierLineTotalOver25To135].[UnitPriceAmount], [local_7].[OrderDetailCarrierLineTotalOver25To135].[UnitPriceDiscountAmount], [local_7].[OrderDetailCarrierLineTotalOver25To135].[LineTotalAmount], [local_7].[OrderDetailCarrierLineTotalOver25To135].[DetailModifiedAt] FROM [local_7].[OrderDetailCarrierLineTotalOver25To135]
) t0
JOIN [local_7].[OrderDetailCarrierWithSplitOfferLinks] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct SalesOrderHeader from vertical split + row partition on a fragment
CREATE VIEW "SalesOrderHeader" AS
SELECT t0.[salesOrderId], t0.[revisionNumber], t2.[order_date], t2.[due_date], t2.[ship_date], t0.[status], t0.[onlineOrderFlag], t0.[salesOrderNumber], t0.[purchaseOrderNumber], t0.[accountNumber], t0.[customerId], t1.[salesPersonId], t0.[territoryId], t1.[billToAddressId], t1.[shipToAddressId], t1.[shipMethodId], t1.[creditCardId], t0.[creditCardApprovalCode], t0.[currencyRateId], t3.[subtotal_amount], t3.[tax_amount], t1.[freight], t3.[total_due_amount], t0.[comment], t0.[rowGuid], t2.[last_modified_at]
FROM [local_1].[salesOrderHeaderWithAccount] t0
JOIN [local_1].[salesOrderHeaderFullDetails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [sales_order_due_after_2014_03_12_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[sales_order_due_after_2014_03_12_or_null].[sales_order_id], [local_3].[sales_order_due_after_2014_03_12_or_null].[order_date], [local_3].[sales_order_due_after_2014_03_12_or_null].[due_date], [local_3].[sales_order_due_after_2014_03_12_or_null].[ship_date], [local_3].[sales_order_due_after_2014_03_12_or_null].[last_modified_at] FROM [local_3].[sales_order_due_after_2014_03_12_or_null]
UNION
SELECT [sales_order_due_between_2013_07_02_and_2013_11_15].[__orig_rowid] AS __orig_rowid, [local_3].[sales_order_due_between_2013_07_02_and_2013_11_15].[sales_order_id], [local_3].[sales_order_due_between_2013_07_02_and_2013_11_15].[order_date], [local_3].[sales_order_due_between_2013_07_02_and_2013_11_15].[due_date], [local_3].[sales_order_due_between_2013_07_02_and_2013_11_15].[ship_date], [local_3].[sales_order_due_between_2013_07_02_and_2013_11_15].[last_modified_at] FROM [local_3].[sales_order_due_between_2013_07_02_and_2013_11_15]
UNION
SELECT [sales_order_due_between_2013_11_15_and_2014_03_12].[__orig_rowid] AS __orig_rowid, [local_3].[sales_order_due_between_2013_11_15_and_2014_03_12].[sales_order_id], [local_3].[sales_order_due_between_2013_11_15_and_2014_03_12].[order_date], [local_3].[sales_order_due_between_2013_11_15_and_2014_03_12].[due_date], [local_3].[sales_order_due_between_2013_11_15_and_2014_03_12].[ship_date], [local_3].[sales_order_due_between_2013_11_15_and_2014_03_12].[last_modified_at] FROM [local_3].[sales_order_due_between_2013_11_15_and_2014_03_12]
UNION
SELECT [sales_order_due_on_or_before_2013_07_02].[__orig_rowid] AS __orig_rowid, [local_3].[sales_order_due_on_or_before_2013_07_02].[sales_order_id], [local_3].[sales_order_due_on_or_before_2013_07_02].[order_date], [local_3].[sales_order_due_on_or_before_2013_07_02].[due_date], [local_3].[sales_order_due_on_or_before_2013_07_02].[ship_date], [local_3].[sales_order_due_on_or_before_2013_07_02].[last_modified_at] FROM [local_3].[sales_order_due_on_or_before_2013_07_02]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[sales_order_freight_financials] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct SalesOrderHeaderSalesReason from row partitions (UNION (overlap))
CREATE VIEW "SalesOrderHeaderSalesReason" AS
SELECT "local_1"."salesOrderHeaderSalesReasonModifiedAugToNov2013"."salesOrderId" AS "SalesOrderID", "local_1"."salesOrderHeaderSalesReasonModifiedAugToNov2013"."salesReasonId" AS "SalesReasonID", "local_1"."salesOrderHeaderSalesReasonModifiedAugToNov2013"."modifiedDate" AS "ModifiedDate" FROM "local_1"."salesOrderHeaderSalesReasonModifiedAugToNov2013"
UNION
SELECT "local_1"."salesOrderHeaderSalesReasonModifiedNov2013ToMar2014"."salesOrderId" AS "SalesOrderID", "local_1"."salesOrderHeaderSalesReasonModifiedNov2013ToMar2014"."salesReasonId" AS "SalesReasonID", "local_1"."salesOrderHeaderSalesReasonModifiedNov2013ToMar2014"."modifiedDate" AS "ModifiedDate" FROM "local_1"."salesOrderHeaderSalesReasonModifiedNov2013ToMar2014"
UNION
SELECT "local_5"."salesOrderReasonModifiedOnOrBefore2013Aug02"."salesOrderRefId" AS "SalesOrderID", "local_5"."salesOrderReasonModifiedOnOrBefore2013Aug02"."salesReasonRefId" AS "SalesReasonID", "local_5"."salesOrderReasonModifiedOnOrBefore2013Aug02"."modifiedAt" AS "ModifiedDate" FROM "local_5"."salesOrderReasonModifiedOnOrBefore2013Aug02"
UNION
SELECT "local_5"."salesOrderReasonModifiedAfter2014Mar11OrNull"."salesOrderRefId" AS "SalesOrderID", "local_5"."salesOrderReasonModifiedAfter2014Mar11OrNull"."salesReasonRefId" AS "SalesReasonID", "local_5"."salesOrderReasonModifiedAfter2014Mar11OrNull"."modifiedAt" AS "ModifiedDate" FROM "local_5"."salesOrderReasonModifiedAfter2014Mar11OrNull";

-- Reconstruct SalesPerson from vertical (column) split (2 fragments)
CREATE VIEW "SalesPerson" AS
SELECT
    t0."businessEntityRefId" AS "BusinessEntityID",
    t1."territory_id" AS "TerritoryID",
    t0."salesQuotaAmount" AS "SalesQuota",
    t0."bonusAmount" AS "Bonus",
    t0."commissionPercent" AS "CommissionPct",
    t0."salesYearToDate" AS "SalesYTD",
    t0."salesPreviousYearAmount" AS "SalesLastYear",
    t1."row_guid" AS "rowguid",
    t0."modifiedAt" AS "ModifiedDate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "businessEntityRefId" ORDER BY rowid) AS __rn FROM "local_5"."salesPersonCompensation") t0
JOIN "local_4"."sp_comp_bonus" t1 ON t0."businessEntityRefId" IS t1."be_id" AND t0.__rn = t1.__rn;

-- Reconstruct SalesPersonQuotaHistory from row partitions (UNION (overlap))
CREATE VIEW "SalesPersonQuotaHistory" AS
SELECT "local_4"."sp_quota_hist_20120115_20121016"."be_id" AS "BusinessEntityID", "local_4"."sp_quota_hist_20120115_20121016"."quota_dt" AS "QuotaDate", "local_4"."sp_quota_hist_20120115_20121016"."quota_amt" AS "SalesQuota", "local_4"."sp_quota_hist_20120115_20121016"."row_guid" AS "rowguid", "local_4"."sp_quota_hist_20120115_20121016"."mod_dt" AS "ModifiedDate" FROM "local_4"."sp_quota_hist_20120115_20121016"
UNION
SELECT "local_4"."sp_quota_hist_20121016_20130716"."be_id" AS "BusinessEntityID", "local_4"."sp_quota_hist_20121016_20130716"."quota_dt" AS "QuotaDate", "local_4"."sp_quota_hist_20121016_20130716"."quota_amt" AS "SalesQuota", "local_4"."sp_quota_hist_20121016_20130716"."row_guid" AS "rowguid", "local_4"."sp_quota_hist_20121016_20130716"."mod_dt" AS "ModifiedDate" FROM "local_4"."sp_quota_hist_20121016_20130716"
UNION
SELECT "local_5"."salesPersonQuotaHistoryOnOrBefore2012Jan15"."businessEntityRefId" AS "BusinessEntityID", "local_5"."salesPersonQuotaHistoryOnOrBefore2012Jan15"."quotaEffectiveDate" AS "QuotaDate", "local_5"."salesPersonQuotaHistoryOnOrBefore2012Jan15"."quotaAmount" AS "SalesQuota", "local_5"."salesPersonQuotaHistoryOnOrBefore2012Jan15"."recordGuid" AS "rowguid", "local_5"."salesPersonQuotaHistoryOnOrBefore2012Jan15"."modifiedAt" AS "ModifiedDate" FROM "local_5"."salesPersonQuotaHistoryOnOrBefore2012Jan15"
UNION
SELECT "local_5"."salesPersonQuotaHistoryAfter2013Jul16OrNull"."businessEntityRefId" AS "BusinessEntityID", "local_5"."salesPersonQuotaHistoryAfter2013Jul16OrNull"."quotaEffectiveDate" AS "QuotaDate", "local_5"."salesPersonQuotaHistoryAfter2013Jul16OrNull"."quotaAmount" AS "SalesQuota", "local_5"."salesPersonQuotaHistoryAfter2013Jul16OrNull"."recordGuid" AS "rowguid", "local_5"."salesPersonQuotaHistoryAfter2013Jul16OrNull"."modifiedAt" AS "ModifiedDate" FROM "local_5"."salesPersonQuotaHistoryAfter2013Jul16OrNull";

-- Reconstruct SalesReason from local_5.salesReasonLookup
CREATE VIEW "SalesReason" AS
SELECT
    "local_5"."salesReasonLookup"."salesReasonRefId" AS "SalesReasonID",
    "local_5"."salesReasonLookup"."reasonName" AS "Name",
    "local_5"."salesReasonLookup"."reasonCategory" AS "ReasonType",
    "local_5"."salesReasonLookup"."modifiedAt" AS "ModifiedDate"
FROM "local_5"."salesReasonLookup";

-- Reconstruct SalesTaxRate from local_1.salesTaxRateRef
CREATE VIEW "SalesTaxRate" AS
SELECT
    "local_1"."salesTaxRateRef"."salesTaxRateId" AS "SalesTaxRateID",
    "local_1"."salesTaxRateRef"."stateProvinceId" AS "StateProvinceID",
    "local_1"."salesTaxRateRef"."taxType" AS "TaxType",
    "local_1"."salesTaxRateRef"."taxRate" AS "TaxRate",
    "local_1"."salesTaxRateRef"."taxName" AS "Name",
    "local_1"."salesTaxRateRef"."rowGuid" AS "rowguid",
    "local_1"."salesTaxRateRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."salesTaxRateRef";

-- Reconstruct SalesTerritory from vertical (column) split (2 fragments)
CREATE VIEW "SalesTerritory" AS
SELECT
    t0."territoryId" AS "TerritoryID",
    t1."terr_name" AS "Name",
    t0."countryRegionCode" AS "CountryRegionCode",
    t0."territoryGroup" AS "Group",
    t0."salesYearToDate" AS "SalesYTD",
    t0."salesLastYear" AS "SalesLastYear",
    t0."costYearToDate" AS "CostYTD",
    t0."costLastYear" AS "CostLastYear",
    t0."rowGuid" AS "rowguid",
    t0."modifiedDate" AS "ModifiedDate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "territoryId" ORDER BY rowid) AS __rn FROM "local_1"."salesTerritoryCostsLastYear") t0
JOIN "local_4"."territory_country_region" t1 ON t0."territoryId" IS t1."territory_id" AND t0.__rn = t1.__rn;

-- Reconstruct SalesTerritoryHistory from vertical (column) split (2 fragments)
CREATE VIEW "SalesTerritoryHistory" AS
SELECT
    t0."businessEntityId" AS "BusinessEntityID",
    t0."territoryId" AS "TerritoryID",
    t0."startDate" AS "StartDate",
    t1."end_dt" AS "EndDate",
    t0."rowGuid" AS "rowguid",
    t0."modifiedDate" AS "ModifiedDate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "businessEntityId", "territoryId", "startDate" ORDER BY rowid) AS __rn FROM "local_1"."salesTerritoryHistoryModifiedDate") t0
JOIN "local_4"."sp_territory_hist_with_end" t1 ON t0."businessEntityId" IS t1."be_id" AND t0."territoryId" IS t1."territory_id" AND t0."startDate" IS t1."start_dt" AND t0.__rn = t1.__rn;

-- Reconstruct ScrapReason from local_1.scrapReasonRef
CREATE VIEW "ScrapReason" AS
SELECT
    "local_1"."scrapReasonRef"."scrapReasonId" AS "ScrapReasonID",
    "local_1"."scrapReasonRef"."displayName" AS "Name",
    "local_1"."scrapReasonRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."scrapReasonRef";

-- Reconstruct Shift from local_6.work_shift
CREATE VIEW "Shift" AS
SELECT
    "local_6"."work_shift"."shift_id" AS "ShiftID",
    "local_6"."work_shift"."shift_name" AS "Name",
    "local_6"."work_shift"."start_time" AS "StartTime",
    "local_6"."work_shift"."end_time" AS "EndTime",
    "local_6"."work_shift"."modified_at" AS "ModifiedDate"
FROM "local_6"."work_shift";

-- Reconstruct ShipMethod from local_1.shipMethodRef
CREATE VIEW "ShipMethod" AS
SELECT
    "local_1"."shipMethodRef"."shipMethodId" AS "ShipMethodID",
    "local_1"."shipMethodRef"."displayName" AS "Name",
    "local_1"."shipMethodRef"."shipBase" AS "ShipBase",
    "local_1"."shipMethodRef"."shipRate" AS "ShipRate",
    "local_1"."shipMethodRef"."rowGuid" AS "rowguid",
    "local_1"."shipMethodRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."shipMethodRef";

-- Reconstruct ShoppingCartItem from local_2.ShoppingCartItemEntry
CREATE VIEW "ShoppingCartItem" AS
SELECT
    "local_2"."ShoppingCartItemEntry"."CartItemId" AS "ShoppingCartItemID",
    "local_2"."ShoppingCartItemEntry"."CartId" AS "ShoppingCartID",
    "local_2"."ShoppingCartItemEntry"."ItemQuantity" AS "Quantity",
    "local_2"."ShoppingCartItemEntry"."ProductRefId" AS "ProductID",
    "local_2"."ShoppingCartItemEntry"."CreatedTimestamp" AS "DateCreated",
    "local_2"."ShoppingCartItemEntry"."LastModifiedTimestamp" AS "ModifiedDate"
FROM "local_2"."ShoppingCartItemEntry";

-- Reconstruct SpecialOffer from vertical (column) split (2 fragments)
CREATE VIEW "SpecialOffer" AS
SELECT
    t0."SpecialOfferKey" AS "SpecialOfferID",
    t0."OfferDescription" AS "Description",
    t0."DiscountPercentage" AS "DiscountPct",
    t0."OfferType" AS "Type",
    t0."OfferCategory" AS "Category",
    t1."StartAt" AS "StartDate",
    t1."EndAt" AS "EndDate",
    t0."MinimumQuantity" AS "MinQty",
    t0."MaximumQuantity" AS "MaxQty",
    t0."RowGuidValue" AS "rowguid",
    t1."LastModifiedAt" AS "ModifiedDate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "SpecialOfferKey" ORDER BY rowid) AS __rn FROM "local_7"."SpecialOfferCategoryCore") t0
JOIN "local_7"."SpecialOfferCategoryWithDates" t1 ON t0."SpecialOfferKey" IS t1."SpecialOfferKey" AND t0.__rn = t1.__rn;

-- Reconstruct SpecialOfferProduct from row partitions (UNION (overlap))
CREATE VIEW "SpecialOfferProduct" AS
SELECT "local_1"."specialOfferProductApr2011Mid"."specialOfferId" AS "SpecialOfferID", "local_1"."specialOfferProductApr2011Mid"."productId" AS "ProductID", "local_1"."specialOfferProductApr2011Mid"."rowGuid" AS "rowguid", "local_1"."specialOfferProductApr2011Mid"."modifiedDate" AS "ModifiedDate" FROM "local_1"."specialOfferProductApr2011Mid"
UNION
SELECT "local_7"."SpecialOfferProductModifiedOnOrBefore20110401"."SpecialOfferKey" AS "SpecialOfferID", "local_7"."SpecialOfferProductModifiedOnOrBefore20110401"."ProductKey" AS "ProductID", "local_7"."SpecialOfferProductModifiedOnOrBefore20110401"."RowGuidValue" AS "rowguid", "local_7"."SpecialOfferProductModifiedOnOrBefore20110401"."LastModifiedAt" AS "ModifiedDate" FROM "local_7"."SpecialOfferProductModifiedOnOrBefore20110401"
UNION
SELECT "local_7"."SpecialOfferProductModifiedAfter20110501OrNull"."SpecialOfferKey" AS "SpecialOfferID", "local_7"."SpecialOfferProductModifiedAfter20110501OrNull"."ProductKey" AS "ProductID", "local_7"."SpecialOfferProductModifiedAfter20110501OrNull"."RowGuidValue" AS "rowguid", "local_7"."SpecialOfferProductModifiedAfter20110501OrNull"."LastModifiedAt" AS "ModifiedDate" FROM "local_7"."SpecialOfferProductModifiedAfter20110501OrNull";

-- Reconstruct StateProvince from vertical split + row partition on a fragment
CREATE VIEW "StateProvince" AS
SELECT t0.[stateProvinceId], t0.[stateProvinceCode], t0.[countryRegionCode], t0.[isOnlyStateProvinceFlag], t0.[name], t0.[territoryId], t1.[rowGuid], t0.[modifiedDate]
FROM (
SELECT [stateProvinceFixedModified20080430].[__orig_rowid] AS __orig_rowid, [local_1].[stateProvinceFixedModified20080430].[stateProvinceId], [local_1].[stateProvinceFixedModified20080430].[stateProvinceCode], [local_1].[stateProvinceFixedModified20080430].[countryRegionCode], [local_1].[stateProvinceFixedModified20080430].[isOnlyStateProvinceFlag], [local_1].[stateProvinceFixedModified20080430].[name], [local_1].[stateProvinceFixedModified20080430].[territoryId], [local_1].[stateProvinceFixedModified20080430].[modifiedDate] FROM [local_1].[stateProvinceFixedModified20080430]
UNION
SELECT [stateProvinceModified20140208OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[stateProvinceModified20140208OrNull].[stateProvinceId], [local_1].[stateProvinceModified20140208OrNull].[stateProvinceCode], [local_1].[stateProvinceModified20140208OrNull].[countryRegionCode], [local_1].[stateProvinceModified20140208OrNull].[isOnlyStateProvinceFlag], [local_1].[stateProvinceModified20140208OrNull].[name], [local_1].[stateProvinceModified20140208OrNull].[territoryId], [local_1].[stateProvinceModified20140208OrNull].[modifiedDate] FROM [local_1].[stateProvinceModified20140208OrNull]
) t0
JOIN [local_1].[stateProvinceModifiedDateInfo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Store from local_1.storeInfo
CREATE VIEW "Store" AS
SELECT
    "local_1"."storeInfo"."businessEntityId" AS "BusinessEntityID",
    "local_1"."storeInfo"."storeName" AS "Name",
    "local_1"."storeInfo"."salesPersonId" AS "SalesPersonID",
    "local_1"."storeInfo"."demographics" AS "Demographics",
    "local_1"."storeInfo"."rowGuid" AS "rowguid",
    "local_1"."storeInfo"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."storeInfo";

-- Reconstruct TransactionHistory from row partitions (UNION (overlap))
CREATE VIEW "TransactionHistory" AS
SELECT "local_1"."transactionHistoryActualCostNonPositive"."transactionId" AS "TransactionID", "local_1"."transactionHistoryActualCostNonPositive"."productId" AS "ProductID", "local_1"."transactionHistoryActualCostNonPositive"."referenceOrderId" AS "ReferenceOrderID", "local_1"."transactionHistoryActualCostNonPositive"."referenceOrderLineId" AS "ReferenceOrderLineID", "local_1"."transactionHistoryActualCostNonPositive"."transactionDate" AS "TransactionDate", "local_1"."transactionHistoryActualCostNonPositive"."transactionType" AS "TransactionType", "local_1"."transactionHistoryActualCostNonPositive"."quantity" AS "Quantity", "local_1"."transactionHistoryActualCostNonPositive"."actualCost" AS "ActualCost", "local_1"."transactionHistoryActualCostNonPositive"."modifiedDate" AS "ModifiedDate" FROM "local_1"."transactionHistoryActualCostNonPositive"
UNION
SELECT "local_1"."transactionHistoryActualCostRange0To21"."transactionId" AS "TransactionID", "local_1"."transactionHistoryActualCostRange0To21"."productId" AS "ProductID", "local_1"."transactionHistoryActualCostRange0To21"."referenceOrderId" AS "ReferenceOrderID", "local_1"."transactionHistoryActualCostRange0To21"."referenceOrderLineId" AS "ReferenceOrderLineID", "local_1"."transactionHistoryActualCostRange0To21"."transactionDate" AS "TransactionDate", "local_1"."transactionHistoryActualCostRange0To21"."transactionType" AS "TransactionType", "local_1"."transactionHistoryActualCostRange0To21"."quantity" AS "Quantity", "local_1"."transactionHistoryActualCostRange0To21"."actualCost" AS "ActualCost", "local_1"."transactionHistoryActualCostRange0To21"."modifiedDate" AS "ModifiedDate" FROM "local_1"."transactionHistoryActualCostRange0To21"
UNION
SELECT "local_1"."transactionHistoryActualCostRange21To54"."transactionId" AS "TransactionID", "local_1"."transactionHistoryActualCostRange21To54"."productId" AS "ProductID", "local_1"."transactionHistoryActualCostRange21To54"."referenceOrderId" AS "ReferenceOrderID", "local_1"."transactionHistoryActualCostRange21To54"."referenceOrderLineId" AS "ReferenceOrderLineID", "local_1"."transactionHistoryActualCostRange21To54"."transactionDate" AS "TransactionDate", "local_1"."transactionHistoryActualCostRange21To54"."transactionType" AS "TransactionType", "local_1"."transactionHistoryActualCostRange21To54"."quantity" AS "Quantity", "local_1"."transactionHistoryActualCostRange21To54"."actualCost" AS "ActualCost", "local_1"."transactionHistoryActualCostRange21To54"."modifiedDate" AS "ModifiedDate" FROM "local_1"."transactionHistoryActualCostRange21To54"
UNION
SELECT "local_1"."transactionHistoryActualCostHighOrNull"."transactionId" AS "TransactionID", "local_1"."transactionHistoryActualCostHighOrNull"."productId" AS "ProductID", "local_1"."transactionHistoryActualCostHighOrNull"."referenceOrderId" AS "ReferenceOrderID", "local_1"."transactionHistoryActualCostHighOrNull"."referenceOrderLineId" AS "ReferenceOrderLineID", "local_1"."transactionHistoryActualCostHighOrNull"."transactionDate" AS "TransactionDate", "local_1"."transactionHistoryActualCostHighOrNull"."transactionType" AS "TransactionType", "local_1"."transactionHistoryActualCostHighOrNull"."quantity" AS "Quantity", "local_1"."transactionHistoryActualCostHighOrNull"."actualCost" AS "ActualCost", "local_1"."transactionHistoryActualCostHighOrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."transactionHistoryActualCostHighOrNull";

-- Reconstruct TransactionHistoryArchive from row partitions (UNION (overlap))
CREATE VIEW "TransactionHistoryArchive" AS
SELECT "local_8"."transaction_history_archive_actualcost_lowest"."transaction_id" AS "TransactionID", "local_8"."transaction_history_archive_actualcost_lowest"."product_id" AS "ProductID", "local_8"."transaction_history_archive_actualcost_lowest"."reference_order_id" AS "ReferenceOrderID", "local_8"."transaction_history_archive_actualcost_lowest"."reference_order_line_id" AS "ReferenceOrderLineID", "local_8"."transaction_history_archive_actualcost_lowest"."transaction_date" AS "TransactionDate", "local_8"."transaction_history_archive_actualcost_lowest"."transaction_type" AS "TransactionType", "local_8"."transaction_history_archive_actualcost_lowest"."quantity" AS "Quantity", "local_8"."transaction_history_archive_actualcost_lowest"."actual_cost" AS "ActualCost", "local_8"."transaction_history_archive_actualcost_lowest"."modified_at" AS "ModifiedDate" FROM "local_8"."transaction_history_archive_actualcost_lowest"
UNION
SELECT "local_8"."transaction_history_archive_actualcost_middle"."transaction_id" AS "TransactionID", "local_8"."transaction_history_archive_actualcost_middle"."product_id" AS "ProductID", "local_8"."transaction_history_archive_actualcost_middle"."reference_order_id" AS "ReferenceOrderID", "local_8"."transaction_history_archive_actualcost_middle"."reference_order_line_id" AS "ReferenceOrderLineID", "local_8"."transaction_history_archive_actualcost_middle"."transaction_date" AS "TransactionDate", "local_8"."transaction_history_archive_actualcost_middle"."transaction_type" AS "TransactionType", "local_8"."transaction_history_archive_actualcost_middle"."quantity" AS "Quantity", "local_8"."transaction_history_archive_actualcost_middle"."actual_cost" AS "ActualCost", "local_8"."transaction_history_archive_actualcost_middle"."modified_at" AS "ModifiedDate" FROM "local_8"."transaction_history_archive_actualcost_middle"
UNION
SELECT "local_8"."transaction_history_archive_actualcost_highest"."transaction_id" AS "TransactionID", "local_8"."transaction_history_archive_actualcost_highest"."product_id" AS "ProductID", "local_8"."transaction_history_archive_actualcost_highest"."reference_order_id" AS "ReferenceOrderID", "local_8"."transaction_history_archive_actualcost_highest"."reference_order_line_id" AS "ReferenceOrderLineID", "local_8"."transaction_history_archive_actualcost_highest"."transaction_date" AS "TransactionDate", "local_8"."transaction_history_archive_actualcost_highest"."transaction_type" AS "TransactionType", "local_8"."transaction_history_archive_actualcost_highest"."quantity" AS "Quantity", "local_8"."transaction_history_archive_actualcost_highest"."actual_cost" AS "ActualCost", "local_8"."transaction_history_archive_actualcost_highest"."modified_at" AS "ModifiedDate" FROM "local_8"."transaction_history_archive_actualcost_highest";

-- Reconstruct UnitMeasure from local_1.unitMeasureRef
CREATE VIEW "UnitMeasure" AS
SELECT
    "local_1"."unitMeasureRef"."unitMeasureCode" AS "UnitMeasureCode",
    "local_1"."unitMeasureRef"."displayName" AS "Name",
    "local_1"."unitMeasureRef"."modifiedDate" AS "ModifiedDate"
FROM "local_1"."unitMeasureRef";

-- Reconstruct Vendor from row partitions (UNION (overlap))
CREATE VIEW "Vendor" AS
SELECT "local_1"."vendorModifiedBefore20111224"."businessEntityId" AS "BusinessEntityID", "local_1"."vendorModifiedBefore20111224"."accountNumber" AS "AccountNumber", "local_1"."vendorModifiedBefore20111224"."vendorName" AS "Name", "local_1"."vendorModifiedBefore20111224"."creditRating" AS "CreditRating", "local_1"."vendorModifiedBefore20111224"."preferredVendorStatus" AS "PreferredVendorStatus", "local_1"."vendorModifiedBefore20111224"."activeFlag" AS "ActiveFlag", "local_1"."vendorModifiedBefore20111224"."purchasingWebServiceUrl" AS "PurchasingWebServiceURL", "local_1"."vendorModifiedBefore20111224"."modifiedDate" AS "ModifiedDate" FROM "local_1"."vendorModifiedBefore20111224"
UNION
SELECT "local_1"."vendorModifiedAfter20120202OrNull"."businessEntityId" AS "BusinessEntityID", "local_1"."vendorModifiedAfter20120202OrNull"."accountNumber" AS "AccountNumber", "local_1"."vendorModifiedAfter20120202OrNull"."vendorName" AS "Name", "local_1"."vendorModifiedAfter20120202OrNull"."creditRating" AS "CreditRating", "local_1"."vendorModifiedAfter20120202OrNull"."preferredVendorStatus" AS "PreferredVendorStatus", "local_1"."vendorModifiedAfter20120202OrNull"."activeFlag" AS "ActiveFlag", "local_1"."vendorModifiedAfter20120202OrNull"."purchasingWebServiceUrl" AS "PurchasingWebServiceURL", "local_1"."vendorModifiedAfter20120202OrNull"."modifiedDate" AS "ModifiedDate" FROM "local_1"."vendorModifiedAfter20120202OrNull"
UNION
SELECT "local_8"."vendor_modified_quartile"."business_entity_id" AS "BusinessEntityID", "local_8"."vendor_modified_quartile"."account_number" AS "AccountNumber", "local_8"."vendor_modified_quartile"."vendor_name" AS "Name", "local_8"."vendor_modified_quartile"."credit_rating" AS "CreditRating", "local_8"."vendor_modified_quartile"."preferred_vendor_status" AS "PreferredVendorStatus", "local_8"."vendor_modified_quartile"."active_flag" AS "ActiveFlag", "local_8"."vendor_modified_quartile"."purchasing_webservice_url" AS "PurchasingWebServiceURL", "local_8"."vendor_modified_quartile"."modified_at" AS "ModifiedDate" FROM "local_8"."vendor_modified_quartile";

-- Reconstruct WorkOrder from vertical split + row partition on a fragment
CREATE VIEW "WorkOrder" AS
SELECT t0.[workOrderId], t0.[productId], t1.[orderQty], t0.[stockedQty], t1.[scrappedQty], t0.[startDate], t0.[endDate], t0.[dueDate], t0.[scrapReasonId], t0.[modifiedDate]
FROM (
SELECT [workOrderDueDate20120722To20130608].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderDueDate20120722To20130608].[workOrderId], [local_1].[workOrderDueDate20120722To20130608].[productId], [local_1].[workOrderDueDate20120722To20130608].[stockedQty], [local_1].[workOrderDueDate20120722To20130608].[startDate], [local_1].[workOrderDueDate20120722To20130608].[endDate], [local_1].[workOrderDueDate20120722To20130608].[dueDate], [local_1].[workOrderDueDate20120722To20130608].[scrapReasonId], [local_1].[workOrderDueDate20120722To20130608].[modifiedDate] FROM [local_1].[workOrderDueDate20120722To20130608]
UNION
SELECT [workOrderDueDate20130608To20131221].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderDueDate20130608To20131221].[workOrderId], [local_1].[workOrderDueDate20130608To20131221].[productId], [local_1].[workOrderDueDate20130608To20131221].[stockedQty], [local_1].[workOrderDueDate20130608To20131221].[startDate], [local_1].[workOrderDueDate20130608To20131221].[endDate], [local_1].[workOrderDueDate20130608To20131221].[dueDate], [local_1].[workOrderDueDate20130608To20131221].[scrapReasonId], [local_1].[workOrderDueDate20130608To20131221].[modifiedDate] FROM [local_1].[workOrderDueDate20130608To20131221]
UNION
SELECT [workOrderDueDateAfter20131221OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderDueDateAfter20131221OrNull].[workOrderId], [local_1].[workOrderDueDateAfter20131221OrNull].[productId], [local_1].[workOrderDueDateAfter20131221OrNull].[stockedQty], [local_1].[workOrderDueDateAfter20131221OrNull].[startDate], [local_1].[workOrderDueDateAfter20131221OrNull].[endDate], [local_1].[workOrderDueDateAfter20131221OrNull].[dueDate], [local_1].[workOrderDueDateAfter20131221OrNull].[scrapReasonId], [local_1].[workOrderDueDateAfter20131221OrNull].[modifiedDate] FROM [local_1].[workOrderDueDateAfter20131221OrNull]
UNION
SELECT [workOrderDueDateBefore20120722].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderDueDateBefore20120722].[workOrderId], [local_1].[workOrderDueDateBefore20120722].[productId], [local_1].[workOrderDueDateBefore20120722].[stockedQty], [local_1].[workOrderDueDateBefore20120722].[startDate], [local_1].[workOrderDueDateBefore20120722].[endDate], [local_1].[workOrderDueDateBefore20120722].[dueDate], [local_1].[workOrderDueDateBefore20120722].[scrapReasonId], [local_1].[workOrderDueDateBefore20120722].[modifiedDate] FROM [local_1].[workOrderDueDateBefore20120722]
) t0
JOIN [local_1].[workOrderDueDateDetails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct WorkOrderRouting from vertical split + row partition on a fragment
CREATE VIEW "WorkOrderRouting" AS
SELECT t0.[workOrderId], t0.[productId], t0.[operationSequence], t3.[locationId], t1.[scheduledStartDate], t2.[scheduledEndDate], t1.[actualStartDate], t1.[actualEndDate], t0.[actualResourceHours], t1.[plannedCost], t1.[actualCost], t1.[modifiedDate]
FROM [local_1].[workOrderRoutingActualResourceHours] t0
JOIN (
SELECT [workOrderRoutingActualCostEndDate20120926To20130719].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[workOrderId], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[productId], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[operationSequence], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[scheduledStartDate], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[actualStartDate], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[actualEndDate], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[plannedCost], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[actualCost], [local_1].[workOrderRoutingActualCostEndDate20120926To20130719].[modifiedDate] FROM [local_1].[workOrderRoutingActualCostEndDate20120926To20130719]
UNION
SELECT [workOrderRoutingActualCostEndDate20130719To20140112].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[workOrderId], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[productId], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[operationSequence], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[scheduledStartDate], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[actualStartDate], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[actualEndDate], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[plannedCost], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[actualCost], [local_1].[workOrderRoutingActualCostEndDate20130719To20140112].[modifiedDate] FROM [local_1].[workOrderRoutingActualCostEndDate20130719To20140112]
UNION
SELECT [workOrderRoutingActualCostEndDateAfter20140112OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[workOrderId], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[productId], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[operationSequence], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[scheduledStartDate], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[actualStartDate], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[actualEndDate], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[plannedCost], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[actualCost], [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull].[modifiedDate] FROM [local_1].[workOrderRoutingActualCostEndDateAfter20140112OrNull]
UNION
SELECT [workOrderRoutingActualCostEndDateBefore20120926].[__orig_rowid] AS __orig_rowid, [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[workOrderId], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[productId], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[operationSequence], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[scheduledStartDate], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[actualStartDate], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[actualEndDate], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[plannedCost], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[actualCost], [local_1].[workOrderRoutingActualCostEndDateBefore20120926].[modifiedDate] FROM [local_1].[workOrderRoutingActualCostEndDateBefore20120926]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[workOrderRoutingActualEndDateInfo] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[workOrderRoutingLocation] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];
