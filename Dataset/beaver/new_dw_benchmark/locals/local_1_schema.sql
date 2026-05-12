CREATE TABLE "academic_term_add_drop_nonregular_group_a" (
    "academic_terms_key" TEXT DEFAULT NULL,
    "add_date" TEXT DEFAULT NULL,
    "drop_date" TEXT DEFAULT NULL,
    "day_of_classes" TEXT DEFAULT NULL,
    "graduate_award_end_date" TEXT DEFAULT NULL,
    "graduate_award_start_date" TEXT DEFAULT NULL,
    "is_current_term" TEXT DEFAULT NULL,
    "is_regular_term" TEXT DEFAULT NULL,
    "last_day_of_classes" TEXT DEFAULT NULL,
    "last_day_of_final_exam" TEXT DEFAULT NULL,
    "pre_registration_start_day" TEXT DEFAULT NULL,
    "registration_day" TEXT DEFAULT NULL,
    "term_end_date" TEXT DEFAULT NULL,
    "term_selector" TEXT DEFAULT NULL,
    "term_start_date" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "academic_term_day_schedule" (
    "academic_terms_key" TEXT DEFAULT NULL,
    "day_of_classes" TEXT DEFAULT NULL,
    "graduate_award_end_date" TEXT DEFAULT NULL,
    "graduate_award_start_date" TEXT DEFAULT NULL,
    "is_current_term" TEXT DEFAULT NULL,
    "last_day_of_classes" TEXT DEFAULT NULL,
    "last_day_of_final_exam" TEXT DEFAULT NULL,
    "pre_registration_start_day" TEXT DEFAULT NULL,
    "registration_day" TEXT DEFAULT NULL,
    "term_end_date" TEXT DEFAULT NULL,
    "term_selector" TEXT DEFAULT NULL,
    "term_start_date" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "academic_term_parameter_current_flag" (
    "term_code" TEXT DEFAULT NULL,
    "is_current_term" TEXT DEFAULT NULL,
    "term_description" TEXT DEFAULT NULL,
    "term_indicator" TEXT DEFAULT NULL,
    "term_last_day_before_next_term" TEXT DEFAULT NULL,
    "term_parameter" TEXT DEFAULT NULL
);

CREATE TABLE "academic_term_parameter_period" (
    "term_code" TEXT DEFAULT NULL,
    "term_description" TEXT DEFAULT NULL,
    "term_end_date" TEXT DEFAULT NULL,
    "term_indicator" TEXT DEFAULT NULL,
    "term_last_day_before_next_term" TEXT DEFAULT NULL,
    "term_start_date" TEXT DEFAULT NULL
);

CREATE TABLE "building_assignable_and_gross_area" (
    "building_key" TEXT DEFAULT NULL,
    "assignable_square_footage" INTEGER DEFAULT NULL,
    "gross_square_footage" INTEGER DEFAULT NULL,
    "building_counter" INTEGER DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "building_identifier_counter" (
    "building_key" TEXT DEFAULT NULL,
    "building_counter" INTEGER DEFAULT NULL,
    "building_mailing_address" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "building_street_address" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cip_programs_category_51" (
    "program_code" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "category_code" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_code" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "note" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL
);

CREATE TABLE "cip_programs_category_60" (
    "program_code" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "category_code" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_code" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "note" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL
);

CREATE TABLE "cip_programs_category_mixed_61_14_15" (
    "program_code" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "category_code" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_code" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "note" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL
);

CREATE TABLE "cip_programs_category_mixed_52_13_26_1" (
    "program_code" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "category_code" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_code" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "note" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL
);

CREATE TABLE "cip_programs_category_other_bucket" (
    "program_code" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "category_code" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_code" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "note" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL
);

CREATE TABLE "cip_with_version_by_category_code" (
    "cip_with_version_key" TEXT DEFAULT NULL,
    "category_code" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_code" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "program_code" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cip_with_version_category_title_group_a" (
    "cip_with_version_key" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cip_with_version_category_title_group_b" (
    "cip_with_version_key" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cip_with_version_category_title_group_c" (
    "cip_with_version_key" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cip_with_version_category_title_other_bucket" (
    "cip_with_version_key" TEXT DEFAULT NULL,
    "category_title" TEXT DEFAULT NULL,
    "four_digit_title" TEXT DEFAULT NULL,
    "program_title" TEXT DEFAULT NULL,
    "version" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cis_course_catalog_comm_req_attributes" (
    "academic_year" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "comm_req_attribute" TEXT DEFAULT NULL,
    "comm_req_attribute_description" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "effective_term_code" TEXT DEFAULT NULL,
    "gir_attribute" TEXT DEFAULT NULL,
    "gir_attribute_description" TEXT DEFAULT NULL,
    "global_countries" TEXT DEFAULT NULL,
    "global_regions" TEXT DEFAULT NULL,
    "grade_rule" TEXT DEFAULT NULL,
    "grade_type" TEXT DEFAULT NULL,
    "hass_attribute" TEXT DEFAULT NULL,
    "hass_attribute_description" TEXT DEFAULT NULL,
    "hgn_code" TEXT DEFAULT NULL,
    "hgn_description" TEXT DEFAULT NULL,
    "hgn_exception" TEXT DEFAULT NULL,
    "subject_code" TEXT DEFAULT NULL,
    "tuition_attribute" TEXT DEFAULT NULL,
    "write_req_attribute" TEXT DEFAULT NULL,
    "write_req_attribute_description" TEXT DEFAULT NULL
);

CREATE TABLE "cis_course_catalog_comm_req_grade_rule_n" (
    "academic_year" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "comm_req_attribute_description" TEXT DEFAULT NULL,
    "gir_attribute" TEXT DEFAULT NULL,
    "gir_attribute_description" TEXT DEFAULT NULL,
    "grade_rule" TEXT DEFAULT NULL,
    "grade_rule_description" TEXT DEFAULT NULL,
    "grade_type" TEXT DEFAULT NULL,
    "grade_type_description" TEXT DEFAULT NULL,
    "hass_attribute" TEXT DEFAULT NULL,
    "hass_attribute_description" TEXT DEFAULT NULL,
    "hgn_description" TEXT DEFAULT NULL,
    "supervisor_attribute" TEXT DEFAULT NULL,
    "supervisor_attribute_description" TEXT DEFAULT NULL,
    "tuition_attribute" TEXT DEFAULT NULL,
    "tuition_attribute_description" TEXT DEFAULT NULL,
    "write_req_attribute_description" TEXT DEFAULT NULL
);

CREATE TABLE "cis_course_catalog_comm_req_grade_rule_various" (
    "academic_year" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "comm_req_attribute_description" TEXT DEFAULT NULL,
    "gir_attribute" TEXT DEFAULT NULL,
    "gir_attribute_description" TEXT DEFAULT NULL,
    "grade_rule" TEXT DEFAULT NULL,
    "grade_rule_description" TEXT DEFAULT NULL,
    "grade_type" TEXT DEFAULT NULL,
    "grade_type_description" TEXT DEFAULT NULL,
    "hass_attribute" TEXT DEFAULT NULL,
    "hass_attribute_description" TEXT DEFAULT NULL,
    "hgn_description" TEXT DEFAULT NULL,
    "supervisor_attribute" TEXT DEFAULT NULL,
    "supervisor_attribute_description" TEXT DEFAULT NULL,
    "tuition_attribute" TEXT DEFAULT NULL,
    "tuition_attribute_description" TEXT DEFAULT NULL,
    "write_req_attribute_description" TEXT DEFAULT NULL
);

CREATE TABLE "cis_course_catalog_unit_breakdown" (
    "academic_year" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "design_units" INTEGER DEFAULT NULL,
    "is_variable_units" TEXT DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lecture_units" INTEGER DEFAULT NULL,
    "preparation_units" INTEGER DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL
);

CREATE TABLE "cis_course_catalog_effective_term" (
    "academic_year" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "effective_term_code" TEXT DEFAULT NULL,
    "fall_instructors" TEXT DEFAULT NULL,
    "is_offered_fall_term" TEXT DEFAULT NULL,
    "is_offered_iap" TEXT DEFAULT NULL,
    "is_offered_spring_term" TEXT DEFAULT NULL,
    "is_offered_summer_term" TEXT DEFAULT NULL,
    "is_offered_this_year" TEXT DEFAULT NULL,
    "is_printed_in_bulletin" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL,
    "online_page_number" TEXT DEFAULT NULL,
    "school_wide_electives" TEXT DEFAULT NULL,
    "spring_instructors" TEXT DEFAULT NULL,
    "status_change" TEXT DEFAULT NULL,
    "term_duration" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cis_course_catalog_department_details" (
    "academic_year" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "equivalent_subjects" TEXT DEFAULT NULL,
    "global_countries" TEXT DEFAULT NULL,
    "global_regions" TEXT DEFAULT NULL,
    "hgn_exception" TEXT DEFAULT NULL,
    "is_printed_in_bulletin" TEXT DEFAULT NULL,
    "joint_subjects" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "meets_with_subjects" TEXT DEFAULT NULL,
    "online_page_number" TEXT DEFAULT NULL,
    "prerequisites" TEXT DEFAULT NULL,
    "print_subject_id" TEXT DEFAULT NULL,
    "school_wide_electives" TEXT DEFAULT NULL,
    "source_subject_id" TEXT DEFAULT NULL,
    "status_change" TEXT DEFAULT NULL,
    "subject_code" TEXT DEFAULT NULL,
    "subject_description" TEXT DEFAULT NULL,
    "subject_number" TEXT DEFAULT NULL,
    "subject_short_title" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_duration" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cis_hass_attribute_groups" (
    "icon_gif_name" TEXT DEFAULT NULL,
    "cis_attribute_group" TEXT DEFAULT NULL,
    "cis_attribute_group_note" TEXT DEFAULT NULL,
    "description_in_bulletin" TEXT DEFAULT NULL,
    "description_on_form" TEXT DEFAULT NULL,
    "hass_attribute" TEXT DEFAULT NULL,
    "last_update_user" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "cis_hass_attribute_bulletin_description" (
    "icon_gif_name" TEXT DEFAULT NULL,
    "description_in_bulletin" TEXT DEFAULT NULL,
    "description_on_form" TEXT DEFAULT NULL,
    "icon_height" TEXT DEFAULT NULL,
    "icon_width" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL,
    "last_update_user" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_course_catalog_academic_year_details" (
    "so_subject_id" TEXT DEFAULT NULL,
    "so_term_code" TEXT DEFAULT NULL,
    "academic_year" TEXT DEFAULT NULL,
    "effective_term_code" TEXT DEFAULT NULL,
    "equivalent_subjects" TEXT DEFAULT NULL,
    "fall_instructors" TEXT DEFAULT NULL,
    "global_countries" TEXT DEFAULT NULL,
    "global_regions" TEXT DEFAULT NULL,
    "grade_rule" TEXT DEFAULT NULL,
    "grade_rule_description" TEXT DEFAULT NULL,
    "hgn_code" TEXT DEFAULT NULL,
    "hgn_description" TEXT DEFAULT NULL,
    "hgn_exception" TEXT DEFAULT NULL,
    "is_offered_fall_term" TEXT DEFAULT NULL,
    "is_offered_iap" TEXT DEFAULT NULL,
    "is_offered_spring_term" TEXT DEFAULT NULL,
    "is_offered_summer_term" TEXT DEFAULT NULL,
    "is_offered_this_year" TEXT DEFAULT NULL,
    "is_printed_in_bulletin" TEXT DEFAULT NULL,
    "joint_subjects" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL,
    "meets_with_subjects" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "meet_time" TEXT DEFAULT NULL,
    "online_page_number" TEXT DEFAULT NULL,
    "prerequisites" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "school_wide_electives" TEXT DEFAULT NULL,
    "so_cluster_type" TEXT DEFAULT NULL,
    "so_term_description" TEXT DEFAULT NULL,
    "spring_instructors" TEXT DEFAULT NULL,
    "status_change" TEXT DEFAULT NULL,
    "supervisor_attribute_description" TEXT DEFAULT NULL,
    "term_duration" TEXT DEFAULT NULL,
    "tuition_attribute" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_course_catalog_academic_year_comm_requirements" (
    "so_subject_id" TEXT DEFAULT NULL,
    "so_term_code" TEXT DEFAULT NULL,
    "academic_year" TEXT DEFAULT NULL,
    "comm_req_attribute" TEXT DEFAULT NULL,
    "comm_req_attribute_description" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "effective_term_code" TEXT DEFAULT NULL,
    "gir_attribute" TEXT DEFAULT NULL,
    "gir_attribute_description" TEXT DEFAULT NULL,
    "grade_rule" TEXT DEFAULT NULL,
    "grade_rule_description" TEXT DEFAULT NULL,
    "grade_type" TEXT DEFAULT NULL,
    "grade_type_description" TEXT DEFAULT NULL,
    "hass_attribute" TEXT DEFAULT NULL,
    "hass_attribute_description" TEXT DEFAULT NULL,
    "hgn_code" TEXT DEFAULT NULL,
    "hgn_description" TEXT DEFAULT NULL,
    "hgn_exception" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL,
    "meet_time" TEXT DEFAULT NULL,
    "school_wide_electives" TEXT DEFAULT NULL,
    "so_cluster_type" TEXT DEFAULT NULL,
    "so_term_description" TEXT DEFAULT NULL,
    "supervisor_attribute" TEXT DEFAULT NULL,
    "supervisor_attribute_description" TEXT DEFAULT NULL,
    "tuition_attribute" TEXT DEFAULT NULL,
    "tuition_attribute_description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "write_req_attribute" TEXT DEFAULT NULL,
    "write_req_attribute_description" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_course_catalog_department_index" (
    "so_subject_id" TEXT DEFAULT NULL,
    "so_term_code" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "equivalent_subjects" TEXT DEFAULT NULL,
    "fall_instructors" TEXT DEFAULT NULL,
    "global_countries" TEXT DEFAULT NULL,
    "global_regions" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "online_page_number" TEXT DEFAULT NULL,
    "prerequisites" TEXT DEFAULT NULL,
    "print_subject_id" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "source_subject_id" TEXT DEFAULT NULL,
    "status_change" TEXT DEFAULT NULL,
    "subject_code" TEXT DEFAULT NULL,
    "subject_description" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_number" TEXT DEFAULT NULL,
    "subject_short_title" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_duration" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_course_design_units" (
    "so_subject_id" TEXT DEFAULT NULL,
    "so_term_code" TEXT DEFAULT NULL,
    "design_units" INTEGER DEFAULT NULL,
    "is_variable_units" TEXT DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lecture_units" INTEGER DEFAULT NULL,
    "preparation_units" INTEGER DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL
);

CREATE TABLE "drupal_design_section_flag_nn_variant" (
    "so_subject_id" TEXT DEFAULT NULL,
    "so_term_code" TEXT DEFAULT NULL,
    "is_design_section" TEXT DEFAULT NULL,
    "is_lab_section" TEXT DEFAULT NULL,
    "is_lecture_section" TEXT DEFAULT NULL,
    "is_master_section" TEXT DEFAULT NULL,
    "is_printed_in_bulletin" TEXT DEFAULT NULL,
    "is_recitation_section" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_design_section_flag_n" (
    "so_subject_id" TEXT DEFAULT NULL,
    "so_term_code" TEXT DEFAULT NULL,
    "is_design_section" TEXT DEFAULT NULL,
    "is_lab_section" TEXT DEFAULT NULL,
    "is_lecture_section" TEXT DEFAULT NULL,
    "is_master_section" TEXT DEFAULT NULL,
    "is_printed_in_bulletin" TEXT DEFAULT NULL,
    "is_recitation_section" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_design_section_flag_mixed_other" (
    "so_subject_id" TEXT DEFAULT NULL,
    "so_term_code" TEXT DEFAULT NULL,
    "is_design_section" TEXT DEFAULT NULL,
    "is_lab_section" TEXT DEFAULT NULL,
    "is_lecture_section" TEXT DEFAULT NULL,
    "is_master_section" TEXT DEFAULT NULL,
    "is_printed_in_bulletin" TEXT DEFAULT NULL,
    "is_recitation_section" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_employee_directory_titles" (
    "mit_id" TEXT DEFAULT NULL,
    "directory_title" TEXT DEFAULT NULL,
    "primary_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_employee_directory_emails" (
    "mit_id" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "employee_group" TEXT DEFAULT NULL,
    "employee_type" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "personal_url" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_employee_directory_emails_additional" (
    "mit_id" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "employee_group" TEXT DEFAULT NULL,
    "employee_type" TEXT DEFAULT NULL,
    "has_addl_appointment" TEXT DEFAULT NULL,
    "has_dual_appointment" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "personal_url" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_employee_directory_names_specific_orgs" (
    "mit_id" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL
);

CREATE TABLE "drupal_employee_directory_names_other_orgs" (
    "mit_id" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL
);

CREATE TABLE "employee_directory_department_lincoln_lab" (
    "mit_id" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "directory_full_name" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name" TEXT DEFAULT NULL,
    "full_name_uppercase" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "krb_name_uppercase" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "name_known_by" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "personal_url" TEXT DEFAULT NULL,
    "preferred_name" TEXT DEFAULT NULL,
    "preferred_name_upper" TEXT DEFAULT NULL,
    "preferred_last_name" TEXT DEFAULT NULL,
    "preferred_last_name_upper" TEXT DEFAULT NULL,
    "preferred_middle_name" TEXT DEFAULT NULL
);

CREATE TABLE "employee_directory_department_selected_schools" (
    "mit_id" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "directory_full_name" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name" TEXT DEFAULT NULL,
    "full_name_uppercase" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "krb_name_uppercase" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "name_known_by" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "personal_url" TEXT DEFAULT NULL,
    "preferred_name" TEXT DEFAULT NULL,
    "preferred_name_upper" TEXT DEFAULT NULL,
    "preferred_last_name" TEXT DEFAULT NULL,
    "preferred_last_name_upper" TEXT DEFAULT NULL,
    "preferred_middle_name" TEXT DEFAULT NULL
);

CREATE TABLE "employee_directory_department_other_bucket" (
    "mit_id" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "directory_full_name" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name" TEXT DEFAULT NULL,
    "full_name_uppercase" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "krb_name_uppercase" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "name_known_by" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "personal_url" TEXT DEFAULT NULL,
    "preferred_name" TEXT DEFAULT NULL,
    "preferred_name_upper" TEXT DEFAULT NULL,
    "preferred_last_name" TEXT DEFAULT NULL,
    "preferred_last_name_upper" TEXT DEFAULT NULL,
    "preferred_middle_name" TEXT DEFAULT NULL
);

CREATE TABLE "employee_directory_department_number" (
    "mit_id" TEXT DEFAULT NULL,
    "department_number" TEXT DEFAULT NULL,
    "directory_title" TEXT DEFAULT NULL,
    "primary_title" TEXT DEFAULT NULL
);

CREATE TABLE "employee_directory_department_secondary" (
    "mit_id" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "directory_full_name" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "email_address_uppercase" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "krb_name_uppercase" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "name_known_by" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "personal_url" TEXT DEFAULT NULL,
    "preferred_middle_name" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_access_height_known_values" (
    "fac_building_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_access_height_other_bucket" (
    "fac_building_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_access_level_names" (
    "fac_building_key" TEXT DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_name_long" TEXT DEFAULT NULL,
    "parent_building_name" TEXT DEFAULT NULL,
    "parent_building_name_long" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_assignable_area_summary" (
    "fac_building_key" TEXT DEFAULT NULL,
    "assignable_area" REAL DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "non_assignable_area" REAL DEFAULT NULL
);

CREATE TABLE "fac_building_access_level_geo_metrics" (
    "fac_building_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "easting_x_spcs" REAL DEFAULT NULL,
    "latitude_wgs" REAL DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "northing_y_spcs" REAL DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_use_and_dates" (
    "fac_building_key" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "date_acquired" TEXT DEFAULT NULL,
    "date_built" TEXT DEFAULT NULL,
    "date_occupied" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_address_city_index" (
    "building_address_key" TEXT DEFAULT NULL,
    "address_city_id" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "city" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "street_name" TEXT DEFAULT NULL,
    "street_number" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_address_purpose_street" (
    "building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "post_directional" TEXT DEFAULT NULL,
    "pre_directional" TEXT DEFAULT NULL,
    "street_name" TEXT DEFAULT NULL,
    "street_number" TEXT DEFAULT NULL,
    "street_number_suffix" TEXT DEFAULT NULL,
    "street_suffix" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_address_purpose_e911_1" (
    "building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "post_directional" TEXT DEFAULT NULL,
    "pre_directional" TEXT DEFAULT NULL,
    "street_name" TEXT DEFAULT NULL,
    "street_number" TEXT DEFAULT NULL,
    "street_number_suffix" TEXT DEFAULT NULL,
    "street_suffix" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_address_purpose_mail" (
    "building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "post_directional" TEXT DEFAULT NULL,
    "pre_directional" TEXT DEFAULT NULL,
    "street_name" TEXT DEFAULT NULL,
    "street_number" TEXT DEFAULT NULL,
    "street_number_suffix" TEXT DEFAULT NULL,
    "street_suffix" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_building_address_purpose_other_bucket" (
    "building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "post_directional" TEXT DEFAULT NULL,
    "pre_directional" TEXT DEFAULT NULL,
    "street_name" TEXT DEFAULT NULL,
    "street_number" TEXT DEFAULT NULL,
    "street_number_suffix" TEXT DEFAULT NULL,
    "street_suffix" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_floor_access_level_floor_1" (
    "floor_key" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "building_wings_id" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "level_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_floor_access_level_floor_2" (
    "floor_key" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "building_wings_id" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "level_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_floor_access_level_floor_3" (
    "floor_key" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "building_wings_id" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "level_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_floor_access_level_floor_0" (
    "floor_key" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "building_wings_id" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "level_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_floor_access_level_floor_4_or_other" (
    "floor_key" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "building_wings_id" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "level_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_floor_access_level_floors_5_to_8" (
    "floor_key" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "building_wings_id" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "level_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_floor_assignable_area" (
    "floor_key" TEXT DEFAULT NULL,
    "assignable_area" REAL DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "non_assignable_area" REAL DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_major_use_lookup" (
    "major_use_key" TEXT DEFAULT NULL,
    "major_use" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_organization_assignable_summary" (
    "organization_id" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "organization" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_organization_descriptions" (
    "organization_id" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "d_code" TEXT DEFAULT NULL,
    "major_org" TEXT DEFAULT NULL,
    "major_org_key" TEXT DEFAULT NULL,
    "organization" TEXT DEFAULT NULL,
    "organization_key" TEXT DEFAULT NULL
);

CREATE TABLE "fac_rooms_access_level_dof" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fac_room_key" TEXT DEFAULT NULL,
    "organization_key" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL,
    "use_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_rooms_access_level_reside" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fac_room_key" TEXT DEFAULT NULL,
    "organization_key" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL,
    "use_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_rooms_access_level_selected_orgs" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fac_room_key" TEXT DEFAULT NULL,
    "organization_key" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL,
    "use_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_rooms_access_level_other_bucket" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fac_room_key" TEXT DEFAULT NULL,
    "organization_key" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL,
    "use_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_rooms_building_reference" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_key" TEXT DEFAULT NULL
);

CREATE TABLE "fac_rooms_access_level_extended" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fac_room_key" TEXT DEFAULT NULL,
    "minor_organization" TEXT DEFAULT NULL,
    "minor_organization_key" TEXT DEFAULT NULL,
    "minor_use_key" TEXT DEFAULT NULL,
    "organization_key" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fac_rooms_spatial_coordinates" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "easting_spcs" REAL DEFAULT NULL,
    "latitude_wgs" REAL DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "northing_spcs" REAL DEFAULT NULL
);

CREATE TABLE "fac_rooms_major_use_descriptions" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "major_use_description" TEXT DEFAULT NULL,
    "major_use_key" TEXT DEFAULT NULL,
    "minor_use_description" TEXT DEFAULT NULL,
    "minor_use_key" TEXT DEFAULT NULL,
    "use_description" TEXT DEFAULT NULL,
    "use_key" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_access_level_codes" (
    "fclt_building_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "easting_x_spcs" REAL DEFAULT NULL,
    "latitude_wgs" REAL DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "northing_y_spcs" REAL DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_named_for_dash_group" (
    "fclt_building_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_name_long" TEXT DEFAULT NULL,
    "parent_building_name" TEXT DEFAULT NULL,
    "parent_building_name_long" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_named_for_selected_people_group" (
    "fclt_building_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_name_long" TEXT DEFAULT NULL,
    "parent_building_name" TEXT DEFAULT NULL,
    "parent_building_name_long" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_assignable_area_summary" (
    "fclt_building_key" TEXT DEFAULT NULL,
    "assignable_area" REAL DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "non_assignable_area" REAL DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_sorting_info" (
    "fclt_building_key" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_dates_acquired_built_occupied" (
    "fclt_building_key" TEXT DEFAULT NULL,
    "date_acquired" TEXT DEFAULT NULL,
    "date_built" TEXT DEFAULT NULL,
    "date_occupied" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_city_index" (
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "address_city_id" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "city" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "street_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_purpose_street" (
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_purpose_e911_1" (
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_purpose_mail" (
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_purpose_other_bucket" (
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_building_numbers" (
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "street_number" TEXT DEFAULT NULL,
    "street_number_suffix" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_post_directionals" (
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "post_directional" TEXT DEFAULT NULL,
    "pre_directional" TEXT DEFAULT NULL,
    "street_suffix" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_city_index" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "address_city_id" TEXT DEFAULT NULL,
    "city" TEXT DEFAULT NULL,
    "street_name" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_purpose_street" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_purpose_e911_1" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_purpose_mail" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_purpose_other_bucket" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "address_purpose" TEXT DEFAULT NULL,
    "is_e911_address" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_building_numbers" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "street_number" TEXT DEFAULT NULL,
    "street_number_suffix" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_city_extended" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "address_city_id" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "fclt_building_address_key" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "postal_code" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_address_hist_post_directionals" (
    "fclt_building_address_hist_key" TEXT DEFAULT NULL,
    "post_directional" TEXT DEFAULT NULL,
    "pre_directional" TEXT DEFAULT NULL,
    "street_number_suffix" TEXT DEFAULT NULL,
    "street_suffix" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_access_level_codes" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_named_for_dash" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_name_long" TEXT DEFAULT NULL,
    "parent_building_name" TEXT DEFAULT NULL,
    "parent_building_name_long" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_named_for_selected_people" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_name_long" TEXT DEFAULT NULL,
    "parent_building_name" TEXT DEFAULT NULL,
    "parent_building_name_long" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_access_level_area_metrics" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "assignable_area" REAL DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "non_assignable_area" REAL DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_height_and_dates" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "date_acquired" TEXT DEFAULT NULL,
    "date_built" TEXT DEFAULT NULL,
    "date_occupied" TEXT DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_campus_sector_coords" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "easting_x_spcs" REAL DEFAULT NULL,
    "latitude_wgs" REAL DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "northing_y_spcs" REAL DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_access_named_parent_group_a" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_name_long" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "parent_building_name" TEXT DEFAULT NULL,
    "parent_building_name_long" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_access_named_parent_group_b" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "access_level_name" TEXT DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_name" TEXT DEFAULT NULL,
    "building_named_for" TEXT DEFAULT NULL,
    "building_name_long" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "parent_building_name" TEXT DEFAULT NULL,
    "parent_building_name_long" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_assignable_area" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "assignable_area" REAL DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "non_assignable_area" REAL DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_access_level_geo_metrics_group_a" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "access_level_code" INTEGER DEFAULT NULL,
    "building_height" TEXT DEFAULT NULL,
    "building_number" TEXT DEFAULT NULL,
    "building_sort" TEXT DEFAULT NULL,
    "building_type" TEXT DEFAULT NULL,
    "building_use" TEXT DEFAULT NULL,
    "campus_sector" TEXT DEFAULT NULL,
    "cost_center_code" TEXT DEFAULT NULL,
    "cost_collector_key" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "num_of_rooms" INTEGER DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "ownership_type" TEXT DEFAULT NULL,
    "parent_building_number" TEXT DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_dates_and_occupancy" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "date_acquired" TEXT DEFAULT NULL,
    "date_built" TEXT DEFAULT NULL,
    "date_occupied" TEXT DEFAULT NULL,
    "occupancy_class" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_building_hist_spatial_coordinates" (
    "fclt_building_hist_key" TEXT DEFAULT NULL,
    "easting_x_spcs" REAL DEFAULT NULL,
    "latitude_wgs" REAL DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "northing_y_spcs" REAL DEFAULT NULL,
    "site" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_floor_access_levels_floors_5_to_8" (
    "fclt_floor_key" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_wings_id" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "level_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_floor_assignable_area_summary" (
    "fclt_floor_key" TEXT DEFAULT NULL,
    "assignable_area" REAL DEFAULT NULL,
    "ext_gross_area" REAL DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_sort_sequence" TEXT DEFAULT NULL,
    "non_assignable_area" REAL DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_major_use_lookup" (
    "fclt_major_use_key" TEXT DEFAULT NULL,
    "major_use" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_major_use_hist_assignable_bldg_and_residential" (
    "fclt_major_use_hist_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_major_use_hist_assignable_classroom_general" (
    "fclt_major_use_hist_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_major_use_hist_assignable_health_lab" (
    "fclt_major_use_hist_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_major_use_hist_assignable_mechanical_offices" (
    "fclt_major_use_hist_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_major_use_hist_assignable_other_bucket" (
    "fclt_major_use_hist_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_major_use_hist_assignable_snapshot" (
    "fclt_major_use_hist_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "fclt_major_use_key" TEXT DEFAULT NULL,
    "major_use" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_assignable_provost" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "fclt_major_org_key" TEXT DEFAULT NULL,
    "fclt_org_parent_key" TEXT DEFAULT NULL,
    "major_org" TEXT DEFAULT NULL,
    "organization_id" TEXT DEFAULT NULL,
    "organization_level" TEXT DEFAULT NULL,
    "organization_sort" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_assignable_chancellor" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "fclt_major_org_key" TEXT DEFAULT NULL,
    "fclt_org_parent_key" TEXT DEFAULT NULL,
    "major_org" TEXT DEFAULT NULL,
    "organization_id" TEXT DEFAULT NULL,
    "organization_level" TEXT DEFAULT NULL,
    "organization_sort" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_assignable_executive_vp" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "fclt_major_org_key" TEXT DEFAULT NULL,
    "fclt_org_parent_key" TEXT DEFAULT NULL,
    "major_org" TEXT DEFAULT NULL,
    "organization_id" TEXT DEFAULT NULL,
    "organization_level" TEXT DEFAULT NULL,
    "organization_sort" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_assignable_other_bucket" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "fclt_major_org_key" TEXT DEFAULT NULL,
    "fclt_org_parent_key" TEXT DEFAULT NULL,
    "major_org" TEXT DEFAULT NULL,
    "organization_id" TEXT DEFAULT NULL,
    "organization_level" TEXT DEFAULT NULL,
    "organization_sort" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_assignable_snapshot" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "course" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "organization_number" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_description_records" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "dlc_name" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_major_org_keys" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "fclt_major_org_key" TEXT DEFAULT NULL,
    "fclt_org_parent_key" TEXT DEFAULT NULL,
    "major_org" TEXT DEFAULT NULL,
    "organization" TEXT DEFAULT NULL,
    "organization_id" TEXT DEFAULT NULL,
    "org_parent" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_organization_history" (
    "fclt_organization_hist_key" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "fclt_organization_key" TEXT DEFAULT NULL,
    "organization_id" TEXT DEFAULT NULL,
    "organization" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "fclt_org_parent_key" TEXT DEFAULT NULL,
    "org_parent" TEXT DEFAULT NULL,
    "fclt_major_org_key" TEXT DEFAULT NULL,
    "major_org" TEXT DEFAULT NULL,
    "organization_level" TEXT DEFAULT NULL,
    "organization_number" TEXT DEFAULT NULL,
    "organization_sort" TEXT DEFAULT NULL,
    "assignable" TEXT DEFAULT NULL,
    "course" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "dlc_name" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_access_levels" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_room" TEXT DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "fclt_room_key" TEXT DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "room" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_dept_codes_dof" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fclt_minor_organization_key" TEXT DEFAULT NULL,
    "fclt_organization_key" TEXT DEFAULT NULL,
    "minor_organization" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_dept_codes_reside" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fclt_minor_organization_key" TEXT DEFAULT NULL,
    "fclt_organization_key" TEXT DEFAULT NULL,
    "minor_organization" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_dept_codes_selected_orgs" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fclt_minor_organization_key" TEXT DEFAULT NULL,
    "fclt_organization_key" TEXT DEFAULT NULL,
    "minor_organization" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_dept_codes_other_bucket" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "dept_code" TEXT DEFAULT NULL,
    "fclt_minor_organization_key" TEXT DEFAULT NULL,
    "fclt_organization_key" TEXT DEFAULT NULL,
    "minor_organization" TEXT DEFAULT NULL,
    "organization_name" TEXT DEFAULT NULL,
    "room_full_name" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_spatial_coordinates" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "easting_spcs" REAL DEFAULT NULL,
    "latitude_wgs" REAL DEFAULT NULL,
    "longitude_wgs" REAL DEFAULT NULL,
    "northing_spcs" REAL DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_access_levels_extended" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL,
    "building_room" TEXT DEFAULT NULL,
    "fclt_building_key" TEXT DEFAULT NULL,
    "fclt_floor_key" TEXT DEFAULT NULL,
    "fclt_room_key" TEXT DEFAULT NULL,
    "fclt_use_key" TEXT DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "room" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_rooms_major_use_keys" (
    "space_id" TEXT DEFAULT NULL,
    "area" REAL DEFAULT NULL,
    "fclt_major_use_key" TEXT DEFAULT NULL,
    "fclt_minor_use_key" TEXT DEFAULT NULL,
    "fclt_use_key" TEXT DEFAULT NULL,
    "major_use_description" TEXT DEFAULT NULL,
    "minor_use_description" TEXT DEFAULT NULL,
    "use_description" TEXT DEFAULT NULL
);

CREATE TABLE "fiscal_calendar_periods" (
    "time_month_key" TEXT DEFAULT NULL,
    "calendar_period_description" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "hr_faculty_roster_admin_titles" (
    "mit_id" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "admin_job_title" TEXT DEFAULT NULL,
    "admin_position_title" TEXT DEFAULT NULL,
    "appointment_type" TEXT DEFAULT NULL,
    "emeritus_status" TEXT DEFAULT NULL,
    "endowed_chair" TEXT DEFAULT NULL,
    "job_title" TEXT DEFAULT NULL,
    "position_title" TEXT DEFAULT NULL,
    "terminal_degree" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_faculty_roster_admin_org_units" (
    "mit_id" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "admin_org_unit_title" TEXT DEFAULT NULL,
    "directory_org_unit_title" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL
);

CREATE TABLE "hr_faculty_roster_appointments_middle_initials_group" (
    "mit_id" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "appointment_type" TEXT DEFAULT NULL,
    "emeritus_status" TEXT DEFAULT NULL,
    "endowed_chair" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "terminal_degree" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_faculty_roster_appointments_middle_initials_other" (
    "mit_id" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "appointment_type" TEXT DEFAULT NULL,
    "emeritus_status" TEXT DEFAULT NULL,
    "endowed_chair" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "terminal_degree" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_dlc_key_master" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "dlc_name" TEXT DEFAULT NULL,
    "hr_department_code" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "hr_department_id" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL,
    "hr_department_name_alpha" TEXT DEFAULT NULL,
    "hr_department_name_long" TEXT DEFAULT NULL,
    "hr_org_unit_key" TEXT DEFAULT NULL,
    "hr_org_unit_level" TEXT DEFAULT NULL,
    "org_hier_root_name" TEXT DEFAULT NULL,
    "org_hier_school_area_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_hr_ids" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "hr_department_id" TEXT DEFAULT NULL,
    "hr_org_level1_id" TEXT DEFAULT NULL,
    "hr_org_level1_name" TEXT DEFAULT NULL,
    "hr_org_level2_id" TEXT DEFAULT NULL,
    "hr_org_level3_id" TEXT DEFAULT NULL,
    "hr_org_level4_id" TEXT DEFAULT NULL,
    "hr_org_level5_id" TEXT DEFAULT NULL,
    "hr_org_level6_id" TEXT DEFAULT NULL,
    "hr_org_level7_id" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_dlc_names" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "dlc_name" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL,
    "hr_department_name_alpha" TEXT DEFAULT NULL,
    "hr_department_name_long" TEXT DEFAULT NULL,
    "hr_org_level1_name" TEXT DEFAULT NULL,
    "hr_org_level2_name" TEXT DEFAULT NULL,
    "hr_org_level3_name" TEXT DEFAULT NULL,
    "hr_org_level4_name" TEXT DEFAULT NULL,
    "hr_org_level5_name" TEXT DEFAULT NULL,
    "hr_org_level6_name" TEXT DEFAULT NULL,
    "hr_org_level7_name" TEXT DEFAULT NULL,
    "org_hier_root_name" TEXT DEFAULT NULL,
    "org_hier_school_area_name" TEXT DEFAULT NULL,
    "org_hier_top_level_name" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_hierarchy_sorts" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "hr_org_level1_sort" TEXT DEFAULT NULL,
    "hr_org_level2_sort" TEXT DEFAULT NULL,
    "hr_org_level3_sort" TEXT DEFAULT NULL,
    "hr_org_level4_sort" TEXT DEFAULT NULL,
    "hr_org_level5_sort" TEXT DEFAULT NULL,
    "hr_org_level6_sort" TEXT DEFAULT NULL,
    "hr_org_level7_sort" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_dlc_key_departments_group" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "hr_department_code" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "hr_org_unit_key" TEXT DEFAULT NULL,
    "hr_org_unit_level" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL,
    "org_hier_top_level_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_dlc_key_varied_levels_group" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "hr_department_code" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "hr_org_unit_key" TEXT DEFAULT NULL,
    "hr_org_unit_level" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL,
    "org_hier_top_level_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_dlc_key_departments" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "hr_org_unit_key" TEXT DEFAULT NULL,
    "hr_org_unit_level" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_dlc_key_varied_levels" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "hr_org_unit_key" TEXT DEFAULT NULL,
    "hr_org_unit_level" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_dlc_key_extended" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "hr_department_abbr" TEXT DEFAULT NULL,
    "hr_department_code" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL,
    "hr_department_name_alpha" TEXT DEFAULT NULL,
    "hr_department_name_long" TEXT DEFAULT NULL,
    "hr_org_level1_name" TEXT DEFAULT NULL,
    "org_hier_root_name" TEXT DEFAULT NULL,
    "org_hier_school_area_name" TEXT DEFAULT NULL,
    "org_hier_top_level_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_hierarchy_ids" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "hr_org_level1_id" TEXT DEFAULT NULL,
    "hr_org_level2_id" TEXT DEFAULT NULL,
    "hr_org_level3_id" TEXT DEFAULT NULL,
    "hr_org_level4_id" TEXT DEFAULT NULL,
    "hr_org_level5_id" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_old_department_code_history" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL,
    "hr_department_name_alpha" TEXT DEFAULT NULL,
    "hr_department_name_long" TEXT DEFAULT NULL,
    "hr_org_level1_name" TEXT DEFAULT NULL,
    "hr_org_level2_name" TEXT DEFAULT NULL,
    "hr_org_level3_name" TEXT DEFAULT NULL,
    "hr_org_level4_name" TEXT DEFAULT NULL,
    "hr_org_level5_name" TEXT DEFAULT NULL,
    "hr_org_unit_level" TEXT DEFAULT NULL,
    "hr_org_unit_title" TEXT DEFAULT NULL,
    "org_hier_root_name" TEXT DEFAULT NULL,
    "org_hier_school_area_name" TEXT DEFAULT NULL,
    "org_hier_top_level_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "hr_org_unit_hierarchy_sort_keys" (
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "hr_org_level1_sort" TEXT DEFAULT NULL,
    "hr_org_level2_sort" TEXT DEFAULT NULL,
    "hr_org_level3_sort" TEXT DEFAULT NULL,
    "hr_org_level4_sort" TEXT DEFAULT NULL,
    "hr_org_level5_sort" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_categories" (
    "iap_subject_category_key" TEXT DEFAULT NULL,
    "iap_category_name" TEXT DEFAULT NULL,
    "iap_category_description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_person_staff_affiliations" (
    "iap_subject_person_key" TEXT DEFAULT NULL,
    "person_role" TEXT DEFAULT NULL,
    "person_mit_affiliation" TEXT DEFAULT NULL,
    "person_name" TEXT DEFAULT NULL,
    "person_location" TEXT DEFAULT NULL,
    "person_email" TEXT DEFAULT NULL,
    "person_organization" TEXT DEFAULT NULL,
    "person_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_person_non_mit_affiliations" (
    "iap_subject_person_key" TEXT DEFAULT NULL,
    "person_role" TEXT DEFAULT NULL,
    "person_mit_affiliation" TEXT DEFAULT NULL,
    "person_name" TEXT DEFAULT NULL,
    "person_location" TEXT DEFAULT NULL,
    "person_email" TEXT DEFAULT NULL,
    "person_organization" TEXT DEFAULT NULL,
    "person_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_person_research_prof_grad" (
    "iap_subject_person_key" TEXT DEFAULT NULL,
    "person_role" TEXT DEFAULT NULL,
    "person_mit_affiliation" TEXT DEFAULT NULL,
    "person_name" TEXT DEFAULT NULL,
    "person_location" TEXT DEFAULT NULL,
    "person_email" TEXT DEFAULT NULL,
    "person_organization" TEXT DEFAULT NULL,
    "person_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_person_other_mit_instructors" (
    "iap_subject_person_key" TEXT DEFAULT NULL,
    "person_role" TEXT DEFAULT NULL,
    "person_mit_affiliation" TEXT DEFAULT NULL,
    "person_name" TEXT DEFAULT NULL,
    "person_location" TEXT DEFAULT NULL,
    "person_email" TEXT DEFAULT NULL,
    "person_organization" TEXT DEFAULT NULL,
    "person_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_person_other_bucket" (
    "iap_subject_person_key" TEXT DEFAULT NULL,
    "person_role" TEXT DEFAULT NULL,
    "person_mit_affiliation" TEXT DEFAULT NULL,
    "person_name" TEXT DEFAULT NULL,
    "person_location" TEXT DEFAULT NULL,
    "person_email" TEXT DEFAULT NULL,
    "person_organization" TEXT DEFAULT NULL,
    "person_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_sessions" (
    "iap_subject_session_key" TEXT DEFAULT NULL,
    "session_sequence" INTEGER DEFAULT NULL,
    "session_title" TEXT DEFAULT NULL,
    "session_description" TEXT DEFAULT NULL,
    "session_location" TEXT DEFAULT NULL,
    "session_date" TEXT DEFAULT NULL,
    "session_start_time" TEXT DEFAULT NULL,
    "session_end_time" TEXT DEFAULT NULL,
    "has_session_info" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_sponsors_academic_department" (
    "iap_subject_sponsor_key" TEXT DEFAULT NULL,
    "sponsor_name" TEXT DEFAULT NULL,
    "sponsor_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "iap_subject_sponsors_centers_and_labs_other" (
    "iap_subject_sponsor_key" TEXT DEFAULT NULL,
    "sponsor_name" TEXT DEFAULT NULL,
    "sponsor_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "ir_institution_alternate_us" (
    "institution_id" TEXT DEFAULT NULL,
    "alternate_institution_name" TEXT DEFAULT NULL,
    "country" TEXT DEFAULT NULL,
    "country_code" TEXT DEFAULT NULL,
    "institution_category_label" TEXT DEFAULT NULL,
    "institution_name" TEXT DEFAULT NULL,
    "institution_sort_order" TEXT DEFAULT NULL,
    "record_created_date" TEXT DEFAULT NULL,
    "street_address" TEXT DEFAULT NULL
);

CREATE TABLE "ir_institution_alternate_selected_countries" (
    "institution_id" TEXT DEFAULT NULL,
    "alternate_institution_name" TEXT DEFAULT NULL,
    "country" TEXT DEFAULT NULL,
    "country_code" TEXT DEFAULT NULL,
    "institution_category_label" TEXT DEFAULT NULL,
    "institution_name" TEXT DEFAULT NULL,
    "institution_sort_order" TEXT DEFAULT NULL,
    "record_created_date" TEXT DEFAULT NULL,
    "street_address" TEXT DEFAULT NULL
);

CREATE TABLE "ir_institution_alternate_other_countries" (
    "institution_id" TEXT DEFAULT NULL,
    "alternate_institution_name" TEXT DEFAULT NULL,
    "country" TEXT DEFAULT NULL,
    "country_code" TEXT DEFAULT NULL,
    "institution_category_label" TEXT DEFAULT NULL,
    "institution_name" TEXT DEFAULT NULL,
    "institution_sort_order" TEXT DEFAULT NULL,
    "record_created_date" TEXT DEFAULT NULL,
    "street_address" TEXT DEFAULT NULL
);

CREATE TABLE "ir_institution_city_records" (
    "institution_id" TEXT DEFAULT NULL,
    "city" TEXT DEFAULT NULL,
    "country_code" TEXT DEFAULT NULL,
    "institution_category_label" TEXT DEFAULT NULL,
    "institution_category_value" INTEGER DEFAULT NULL,
    "institution_sort_order" TEXT DEFAULT NULL,
    "record_created_date" TEXT DEFAULT NULL,
    "state" TEXT DEFAULT NULL,
    "street_address" TEXT DEFAULT NULL,
    "zip" TEXT DEFAULT NULL
);

CREATE TABLE "library_course_instructor_course_names" (
    "library_course_instructor_key" TEXT DEFAULT NULL,
    "course_name" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "instructor_name" TEXT DEFAULT NULL,
    "unit" TEXT DEFAULT NULL,
    "unit_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_course_instructor_course_dates_set_a" (
    "library_course_instructor_key" TEXT DEFAULT NULL,
    "course_name" TEXT DEFAULT NULL,
    "date_from" TEXT DEFAULT NULL,
    "date_to" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "unit_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_course_instructor_course_dates_set_b" (
    "library_course_instructor_key" TEXT DEFAULT NULL,
    "course_name" TEXT DEFAULT NULL,
    "date_from" TEXT DEFAULT NULL,
    "date_to" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "unit_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_course_instructor_course_dates_other" (
    "library_course_instructor_key" TEXT DEFAULT NULL,
    "course_name" TEXT DEFAULT NULL,
    "date_from" TEXT DEFAULT NULL,
    "date_to" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "unit_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_material_status_lookup" (
    "library_material_status_key" TEXT DEFAULT NULL,
    "library_material_status_code" TEXT DEFAULT NULL,
    "library_material_status" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_reserve_catalog" (
    "library_reserve_catalog_key" TEXT DEFAULT NULL,
    "catalog_title" TEXT DEFAULT NULL,
    "catalog_author_name" TEXT DEFAULT NULL,
    "catalog_year" TEXT DEFAULT NULL,
    "catalog_publisher" TEXT DEFAULT NULL,
    "catalog_call_number" TEXT DEFAULT NULL,
    "catalog_isbn" TEXT DEFAULT NULL,
    "catalog_system_number" TEXT DEFAULT NULL,
    "catalog_record_create_date" TEXT DEFAULT NULL,
    "catalog_record_update_date" TEXT DEFAULT NULL,
    "record_counter" INTEGER DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_subject_offered_course_numbers" (
    "library_subject_offered_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "course_number_sort" TEXT DEFAULT NULL,
    "master_course_number" TEXT DEFAULT NULL,
    "master_course_number_description" TEXT DEFAULT NULL,
    "master_course_number_sort" TEXT DEFAULT NULL
);

CREATE TABLE "library_subject_offered_course_number_sorts" (
    "library_subject_offered_key" TEXT DEFAULT NULL,
    "course_number_sort" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_id_sort" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_id_sort" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_subject_enrollment_quartile_low" (
    "library_subject_offered_key" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_subject_enrollment_quartile" (
    "library_subject_offered_key" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_subject_enrollment_quartile_high" (
    "library_subject_offered_key" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_parent_dschool_eng" (
    "dept_id" INTEGER DEFAULT NULL,
    "d_code" TEXT DEFAULT NULL,
    "d_name" TEXT DEFAULT NULL,
    "parent_id" INTEGER DEFAULT NULL,
    "parent_d_code" TEXT DEFAULT NULL,
    "parent_d_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_parent_d_vpres" (
    "dept_id" INTEGER DEFAULT NULL,
    "d_code" TEXT DEFAULT NULL,
    "d_name" TEXT DEFAULT NULL,
    "parent_id" INTEGER DEFAULT NULL,
    "parent_d_code" TEXT DEFAULT NULL,
    "parent_d_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_parent_execvp_finance_provost_mix" (
    "dept_id" INTEGER DEFAULT NULL,
    "d_code" TEXT DEFAULT NULL,
    "d_name" TEXT DEFAULT NULL,
    "parent_id" INTEGER DEFAULT NULL,
    "parent_d_code" TEXT DEFAULT NULL,
    "parent_d_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_parent_dsl_provost_area" (
    "dept_id" INTEGER DEFAULT NULL,
    "d_code" TEXT DEFAULT NULL,
    "d_name" TEXT DEFAULT NULL,
    "parent_id" INTEGER DEFAULT NULL,
    "parent_d_code" TEXT DEFAULT NULL,
    "parent_d_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_parent_d_due_school_sci" (
    "dept_id" INTEGER DEFAULT NULL,
    "d_code" TEXT DEFAULT NULL,
    "d_name" TEXT DEFAULT NULL,
    "parent_id" INTEGER DEFAULT NULL,
    "parent_d_code" TEXT DEFAULT NULL,
    "parent_d_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_parent_other_bucket" (
    "dept_id" INTEGER DEFAULT NULL,
    "d_code" TEXT DEFAULT NULL,
    "d_name" TEXT DEFAULT NULL,
    "parent_id" INTEGER DEFAULT NULL,
    "parent_d_code" TEXT DEFAULT NULL,
    "parent_d_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_hierarchy_school_of_engineering" (
    "dlc_code" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "dlc_name" TEXT DEFAULT NULL,
    "hierarchy_type" TEXT DEFAULT NULL,
    "master_dept_hier_level_1_code" TEXT DEFAULT NULL,
    "master_dept_hier_level_1_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_2_code" TEXT DEFAULT NULL,
    "master_dept_hier_level_2_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_3_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_4_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_5_name" TEXT DEFAULT NULL
);

CREATE TABLE "master_dept_hierarchy_other_bucket" (
    "dlc_code" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "dlc_name" TEXT DEFAULT NULL,
    "hierarchy_type" TEXT DEFAULT NULL,
    "master_dept_hier_level_1_code" TEXT DEFAULT NULL,
    "master_dept_hier_level_1_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_2_code" TEXT DEFAULT NULL,
    "master_dept_hier_level_2_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_3_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_4_name" TEXT DEFAULT NULL,
    "master_dept_hier_level_5_name" TEXT DEFAULT NULL
);

CREATE TABLE "mit_holiday_closing_emergencies" (
    "holiday_closing_date" TEXT DEFAULT NULL,
    "holiday_closing_description" TEXT DEFAULT NULL,
    "holiday_closing_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_holiday_closing_shol_veterans" (
    "holiday_closing_date" TEXT DEFAULT NULL,
    "holiday_closing_description" TEXT DEFAULT NULL,
    "holiday_closing_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_holiday_closing_christmas_labor_day" (
    "holiday_closing_date" TEXT DEFAULT NULL,
    "holiday_closing_description" TEXT DEFAULT NULL,
    "holiday_closing_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_holiday_closing_independence_new_year" (
    "holiday_closing_date" TEXT DEFAULT NULL,
    "holiday_closing_description" TEXT DEFAULT NULL,
    "holiday_closing_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_holiday_closing_thanksgiving_indigenous" (
    "holiday_closing_date" TEXT DEFAULT NULL,
    "holiday_closing_description" TEXT DEFAULT NULL,
    "holiday_closing_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_holiday_closing_other_bucket" (
    "holiday_closing_date" TEXT DEFAULT NULL,
    "holiday_closing_description" TEXT DEFAULT NULL,
    "holiday_closing_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_student_directory_department_affiliations" (
    "full_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL
);

CREATE TABLE "mit_student_directory_emails_grad_only" (
    "full_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name_uppercase" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "student_year" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_student_directory_emails_junior_senior" (
    "full_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name_uppercase" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "student_year" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_student_directory_emails_sophomore_freshman_or_null" (
    "full_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name_uppercase" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL,
    "student_year" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "mit_student_directory_emails_extended" (
    "full_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name_uppercase" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "student_year" TEXT DEFAULT NULL
);

CREATE TABLE "moira_mailing_lists" (
    "moira_list_key" TEXT DEFAULT NULL,
    "moira_list_name" TEXT DEFAULT NULL,
    "moira_list_description" TEXT DEFAULT NULL,
    "is_active" TEXT DEFAULT NULL,
    "is_moira_mailing_list" TEXT DEFAULT NULL,
    "is_moira_group" TEXT DEFAULT NULL,
    "is_nfs_group" TEXT DEFAULT NULL,
    "is_public" TEXT DEFAULT NULL,
    "is_hidden" TEXT DEFAULT NULL
);

CREATE TABLE "moira_list_members_counters" (
    "moira_list_member_full_name" TEXT DEFAULT NULL,
    "moira_list_member_mit_id" TEXT DEFAULT NULL,
    "counter" INTEGER DEFAULT NULL,
    "moira_list_key" TEXT DEFAULT NULL,
    "moira_list_member" TEXT DEFAULT NULL,
    "moira_list_owner_key" TEXT DEFAULT NULL
);

CREATE TABLE "moira_list_members_last_update_selected_dates" (
    "moira_list_member_full_name" TEXT DEFAULT NULL,
    "moira_list_member_mit_id" TEXT DEFAULT NULL,
    "counter" INTEGER DEFAULT NULL,
    "last_update_date" TEXT DEFAULT NULL,
    "moira_list_member" TEXT DEFAULT NULL,
    "moira_list_owner_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "moira_list_members_last_update_other_bucket" (
    "moira_list_member_full_name" TEXT DEFAULT NULL,
    "moira_list_member_mit_id" TEXT DEFAULT NULL,
    "counter" INTEGER DEFAULT NULL,
    "last_update_date" TEXT DEFAULT NULL,
    "moira_list_member" TEXT DEFAULT NULL,
    "moira_list_owner_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "moira_list_owners" (
    "moira_list_owner_key" TEXT DEFAULT NULL,
    "owner" TEXT DEFAULT NULL,
    "owner_type" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "opa_person_current_profiles" (
    "mit_id" TEXT DEFAULT NULL,
    "full_name" TEXT DEFAULT NULL,
    "form_of_address_short" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "krb_name_uppercase" TEXT DEFAULT NULL,
    "email_address" TEXT DEFAULT NULL,
    "job_id" TEXT DEFAULT NULL,
    "job_title" TEXT DEFAULT NULL,
    "admin_employee_type" TEXT DEFAULT NULL,
    "hr_department_code_old" TEXT DEFAULT NULL,
    "hr_department_name" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "admin_org_unit_title" TEXT DEFAULT NULL,
    "admin_position_title" TEXT DEFAULT NULL,
    "payroll_rank" TEXT DEFAULT NULL,
    "is_faculty" TEXT DEFAULT NULL,
    "employment_percent" INTEGER DEFAULT NULL,
    "is_consult_priv" TEXT DEFAULT NULL,
    "is_paid_appt" TEXT DEFAULT NULL,
    "is_summer_session_appt" TEXT DEFAULT NULL,
    "summer_session_months" INTEGER DEFAULT NULL,
    "is_sabbatical" TEXT DEFAULT NULL,
    "sabbatical_begin_date" TEXT DEFAULT NULL,
    "sabbatical_end_date" TEXT DEFAULT NULL,
    "is_opa_required" TEXT DEFAULT NULL,
    "is_6mo_appt" TEXT DEFAULT NULL,
    "personnel_subarea" TEXT DEFAULT NULL,
    "personnel_subarea_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "person_authorization_areas" (
    "user_name" TEXT DEFAULT NULL,
    "has_financial_auth" TEXT DEFAULT NULL,
    "has_hr_full_auth" TEXT DEFAULT NULL,
    "has_hr_limited_auth" TEXT DEFAULT NULL,
    "has_payroll_auth" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "profit_center_group_hierarchy" (
    "profit_center_key" TEXT DEFAULT NULL,
    "profit_center_id" TEXT DEFAULT NULL,
    "profit_center_name" TEXT DEFAULT NULL,
    "pc_level1_sort" INTEGER DEFAULT NULL,
    "pc_level1_category" TEXT DEFAULT NULL,
    "pc_level2_sort" INTEGER DEFAULT NULL,
    "pc_level2_category" TEXT DEFAULT NULL,
    "pc_level3_sort" INTEGER DEFAULT NULL,
    "pc_level3_category" TEXT DEFAULT NULL,
    "pc_level4_sort" INTEGER DEFAULT NULL,
    "pc_level4_category" TEXT DEFAULT NULL,
    "pc_level5_sort" INTEGER DEFAULT NULL,
    "pc_level5_category" TEXT DEFAULT NULL,
    "pc_level6_sort" INTEGER DEFAULT NULL,
    "pc_level6_category" TEXT DEFAULT NULL,
    "pc_level7_sort" INTEGER DEFAULT NULL,
    "pc_level7_category" TEXT DEFAULT NULL,
    "pc_level8_sort" INTEGER DEFAULT NULL,
    "pc_level8_category" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "dlc_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL,
    "profit_center_group_code" TEXT DEFAULT NULL,
    "profit_center_group_name" TEXT DEFAULT NULL
);

CREATE TABLE "se_person_employee_types_middle_initials_selected" (
    "mit_id" TEXT DEFAULT NULL,
    "employee_type" TEXT DEFAULT NULL,
    "is_active" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "organization" TEXT DEFAULT NULL,
    "payroll_rank" TEXT DEFAULT NULL,
    "position_title" TEXT DEFAULT NULL
);

CREATE TABLE "se_person_employee_types_middle_initials_other" (
    "mit_id" TEXT DEFAULT NULL,
    "employee_type" TEXT DEFAULT NULL,
    "is_active" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "organization" TEXT DEFAULT NULL,
    "payroll_rank" TEXT DEFAULT NULL,
    "position_title" TEXT DEFAULT NULL
);

CREATE TABLE "se_person_name_records" (
    "mit_id" TEXT DEFAULT NULL,
    "name" TEXT DEFAULT NULL,
    "full_name" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "middle_name" TEXT DEFAULT NULL,
    "office_location" TEXT DEFAULT NULL,
    "organization" TEXT DEFAULT NULL,
    "position_title" TEXT DEFAULT NULL
);

CREATE TABLE "sis_admin_department_phone_selected_numbers" (
    "warehouse_load_date" TEXT DEFAULT NULL,
    "sis_admin_department_code" TEXT DEFAULT NULL,
    "sis_admin_department_name" TEXT DEFAULT NULL,
    "department_phone_area_code" TEXT DEFAULT NULL,
    "department_phone_number" TEXT DEFAULT NULL,
    "clearing_cost_collector" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_admin_department_phone_other_bucket" (
    "warehouse_load_date" TEXT DEFAULT NULL,
    "sis_admin_department_code" TEXT DEFAULT NULL,
    "sis_admin_department_name" TEXT DEFAULT NULL,
    "department_phone_area_code" TEXT DEFAULT NULL,
    "department_phone_number" TEXT DEFAULT NULL,
    "clearing_cost_collector" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_course_description_cip_programs" (
    "sis_course_description_key" TEXT DEFAULT NULL,
    "cip_program_code" TEXT DEFAULT NULL,
    "course" TEXT DEFAULT NULL,
    "course_description" TEXT DEFAULT NULL,
    "course_description_long" TEXT DEFAULT NULL,
    "course_level" TEXT DEFAULT NULL,
    "course_option" TEXT DEFAULT NULL,
    "default_ultimate_degree" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "is_degree_granting" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_course_description_cip_programs_extended" (
    "sis_course_description_key" TEXT DEFAULT NULL,
    "cip_program_code" TEXT DEFAULT NULL,
    "course_level" TEXT DEFAULT NULL,
    "course_option" TEXT DEFAULT NULL,
    "default_ultimate_degree" TEXT DEFAULT NULL,
    "gradaute_level" TEXT DEFAULT NULL,
    "graduate_level" TEXT DEFAULT NULL,
    "is_degree_granting" TEXT DEFAULT NULL,
    "last_activity_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_course_description_long_selected_departments" (
    "sis_course_description_key" TEXT DEFAULT NULL,
    "course_description_long" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "dept_name_in_commencement_book" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "school_name_in_commencement_book" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_course_description_long_other_bucket" (
    "sis_course_description_key" TEXT DEFAULT NULL,
    "course_description_long" TEXT DEFAULT NULL,
    "department" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "dept_name_in_commencement_book" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "school_name_in_commencement_book" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_course_description_term_range" (
    "sis_course_description_key" TEXT DEFAULT NULL,
    "from_term" TEXT DEFAULT NULL,
    "from_term_description" TEXT DEFAULT NULL,
    "thru_term" TEXT DEFAULT NULL,
    "thru_term_description" TEXT DEFAULT NULL
);

CREATE TABLE "sis_department_budget_codes_group_a" (
    "department_code" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_name_history" TEXT DEFAULT NULL,
    "dept_budget_code" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "is_degree_granting" TEXT DEFAULT NULL
);

CREATE TABLE "sis_department_budget_codes_group_b" (
    "department_code" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_name_history" TEXT DEFAULT NULL,
    "dept_budget_code" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "is_degree_granting" TEXT DEFAULT NULL
);

CREATE TABLE "sis_department_budget_codes_other_bucket" (
    "department_code" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_name_history" TEXT DEFAULT NULL,
    "dept_budget_code" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "is_degree_granting" TEXT DEFAULT NULL
);

CREATE TABLE "sis_department_last_activity" (
    "department_code" TEXT DEFAULT NULL,
    "department_last_activity_date" TEXT DEFAULT NULL,
    "dept_budget_code" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "is_degree_granting" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_department_commencement_names" (
    "department_code" TEXT DEFAULT NULL,
    "dept_name_in_commencement_book" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "school_name_in_commencement_book" TEXT DEFAULT NULL
);

CREATE TABLE "sis_lookup_registration_status" (
    "lookup_type" TEXT DEFAULT NULL,
    "code" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_lookup_enrollment_status" (
    "lookup_type" TEXT DEFAULT NULL,
    "code" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_lookup_load_level" (
    "lookup_type" TEXT DEFAULT NULL,
    "code" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_lookup_registration_group" (
    "lookup_type" TEXT DEFAULT NULL,
    "code" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_lookup_registration_type_or_hgn" (
    "lookup_type" TEXT DEFAULT NULL,
    "code" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_subject_code_wellesley_cross_enroll" (
    "course_number" TEXT DEFAULT NULL,
    "subject_code" TEXT DEFAULT NULL,
    "subject_code_description" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_subject_code_non_institute_mfa_mca" (
    "course_number" TEXT DEFAULT NULL,
    "subject_code" TEXT DEFAULT NULL,
    "subject_code_description" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_subject_code_selected_departments" (
    "course_number" TEXT DEFAULT NULL,
    "subject_code" TEXT DEFAULT NULL,
    "subject_code_description" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "sis_subject_code_other_bucket" (
    "course_number" TEXT DEFAULT NULL,
    "subject_code" TEXT DEFAULT NULL,
    "subject_code_description" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "space_detail_building_component_selected_codes" (
    "building_room" TEXT DEFAULT NULL,
    "room_square_footage" INTEGER DEFAULT NULL,
    "building_component" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "floor_key" TEXT DEFAULT NULL,
    "space_unit_key" TEXT DEFAULT NULL,
    "space_usage_key" INTEGER DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "space_detail_building_component_other_bucket" (
    "building_room" TEXT DEFAULT NULL,
    "room_square_footage" INTEGER DEFAULT NULL,
    "building_component" TEXT DEFAULT NULL,
    "building_key" TEXT DEFAULT NULL,
    "floor_key" TEXT DEFAULT NULL,
    "space_unit_key" TEXT DEFAULT NULL,
    "space_usage_key" INTEGER DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "space_detail_building_component_counts" (
    "building_room" TEXT DEFAULT NULL,
    "room_square_footage" INTEGER DEFAULT NULL,
    "building_component" TEXT DEFAULT NULL,
    "building_room_name" TEXT DEFAULT NULL,
    "room_counter" INTEGER DEFAULT NULL,
    "room_number" TEXT DEFAULT NULL,
    "space_unit_key" TEXT DEFAULT NULL,
    "space_usage_key" INTEGER DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "space_floor_definitions" (
    "floor_key" TEXT DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "floor_name" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "space_supervisor_usage_dept_selected_resdev_alum_lfee" (
    "mit_id" TEXT DEFAULT NULL,
    "dept_count" INTEGER DEFAULT NULL,
    "dept_names" TEXT DEFAULT NULL,
    "num_of_supervisees" INTEGER DEFAULT NULL,
    "research_volume" REAL DEFAULT NULL,
    "sqft" REAL DEFAULT NULL,
    "sqft_per_supervisee" REAL DEFAULT NULL
);

CREATE TABLE "space_supervisor_usage_dept_selected_libraries_sloan" (
    "mit_id" TEXT DEFAULT NULL,
    "dept_count" INTEGER DEFAULT NULL,
    "dept_names" TEXT DEFAULT NULL,
    "num_of_supervisees" INTEGER DEFAULT NULL,
    "research_volume" REAL DEFAULT NULL,
    "sqft" REAL DEFAULT NULL,
    "sqft_per_supervisee" REAL DEFAULT NULL
);

CREATE TABLE "space_supervisor_usage_dept_selected_academic_groups" (
    "mit_id" TEXT DEFAULT NULL,
    "dept_count" INTEGER DEFAULT NULL,
    "dept_names" TEXT DEFAULT NULL,
    "num_of_supervisees" INTEGER DEFAULT NULL,
    "research_volume" REAL DEFAULT NULL,
    "sqft" REAL DEFAULT NULL,
    "sqft_per_supervisee" REAL DEFAULT NULL
);

CREATE TABLE "space_supervisor_usage_dept_other_bucket" (
    "mit_id" TEXT DEFAULT NULL,
    "dept_count" INTEGER DEFAULT NULL,
    "dept_names" TEXT DEFAULT NULL,
    "num_of_supervisees" INTEGER DEFAULT NULL,
    "research_volume" REAL DEFAULT NULL,
    "sqft" REAL DEFAULT NULL,
    "sqft_per_supervisee" REAL DEFAULT NULL
);

CREATE TABLE "space_supervisor_usage_dept_names_metrics" (
    "mit_id" TEXT DEFAULT NULL,
    "dept_names" TEXT DEFAULT NULL,
    "research_volume" REAL DEFAULT NULL,
    "res_vol_per_sqft" REAL DEFAULT NULL,
    "sqft" REAL DEFAULT NULL,
    "sqft_per_res_vol" REAL DEFAULT NULL,
    "sqft_per_supervisee" REAL DEFAULT NULL
);

CREATE TABLE "space_unit_definitions" (
    "fclt_organization_key" TEXT DEFAULT NULL,
    "space_unit_key" TEXT DEFAULT NULL,
    "space_unit_code" TEXT DEFAULT NULL,
    "space_unit" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "space_unit_definitions_secondary" (
    "space_unit_key" TEXT DEFAULT NULL,
    "space_unit_code" TEXT DEFAULT NULL,
    "space_unit" TEXT DEFAULT NULL,
    "dlc_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "space_usage_lookup" (
    "space_usage_key" INTEGER DEFAULT NULL,
    "space_usage" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "student_department_school_e" (
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL
);

CREATE TABLE "student_department_school_h" (
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL
);

CREATE TABLE "student_department_school_z" (
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL
);

CREATE TABLE "student_department_school_s_y" (
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL
);

CREATE TABLE "student_department_school_a_w_m_t" (
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL
);

CREATE TABLE "subject_enrollable_cluster_list_haa_primary" (
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "ult_master_subject_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_enrollable_cluster_list_haa_mixed" (
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "ult_master_subject_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_enrollable_cluster_list_hak_waf_war_mixed" (
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "ult_master_subject_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_enrollable_cluster_list_other_bucket" (
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "ult_master_subject_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_enrollable_cluster_list_variant_b" (
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_school_code" TEXT DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_enrollable_titles" (
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "subject_title_long" TEXT DEFAULT NULL
);

CREATE TABLE "subject_grouping_department_fullname_management_eap_usp" (
    "subject_grouping_key" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL
);

CREATE TABLE "subject_grouping_department_fullname_eecs_architecture" (
    "subject_grouping_key" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL
);

CREATE TABLE "subject_grouping_department_fullname_civil_mech_chem_math" (
    "subject_grouping_key" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL
);

CREATE TABLE "subject_grouping_department_fullname_other_bucket" (
    "subject_grouping_key" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_full_name" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL
);

CREATE TABLE "subject_grouping_school_names" (
    "subject_grouping_key" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_iap_schedule" (
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "session_number" INTEGER DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "meet_start_time" TEXT DEFAULT NULL,
    "meet_end_time" TEXT DEFAULT NULL,
    "iap_day" TEXT DEFAULT NULL,
    "iap_date" TEXT DEFAULT NULL,
    "remarks" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_cluster_enrollment_numbers" (
    "subject_key" TEXT DEFAULT NULL,
    "cluster_enrollment_number" INTEGER DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "section_enrollment_number" TEXT DEFAULT NULL,
    "subject_enrollment_number" INTEGER DEFAULT NULL
);

CREATE TABLE "subject_offered_cluster_list_partset_a" (
    "subject_key" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "composite_subject_key" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_key" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL,
    "subject_grouping_key" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "subject_summary_key" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_cluster_list_partset_b" (
    "subject_key" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "composite_subject_key" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_key" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL,
    "subject_grouping_key" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "subject_summary_key" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_cluster_list_other_bucket" (
    "subject_key" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "composite_subject_key" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_key" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL,
    "subject_grouping_key" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "subject_summary_key" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_cluster_list_variant_b" (
    "subject_key" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "cluster_type" TEXT DEFAULT NULL,
    "cluster_type_description" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "evaluate_this_subject" TEXT DEFAULT NULL,
    "form_type" TEXT DEFAULT NULL,
    "form_type_description" TEXT DEFAULT NULL,
    "hgn_code" TEXT DEFAULT NULL,
    "hgn_code_description" TEXT DEFAULT NULL,
    "is_created_by_data_warehouse" TEXT DEFAULT NULL,
    "is_ose_subject" TEXT DEFAULT NULL,
    "is_repeatable_subject" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "meet_time" TEXT DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_course_numbers" (
    "subject_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "course_number_sort" TEXT DEFAULT NULL,
    "master_course_number" TEXT DEFAULT NULL,
    "master_course_number_description" TEXT DEFAULT NULL,
    "master_course_number_sort" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_id_sort" TEXT DEFAULT NULL,
    "master_subject_key" TEXT DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_id_sort" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_evaluation_flags" (
    "subject_key" TEXT DEFAULT NULL,
    "evaluate_this_subject" TEXT DEFAULT NULL,
    "hgn_code" TEXT DEFAULT NULL,
    "is_created_by_data_warehouse" TEXT DEFAULT NULL,
    "is_design_section" TEXT DEFAULT NULL,
    "is_lab_section" TEXT DEFAULT NULL,
    "is_lecture_section" TEXT DEFAULT NULL,
    "is_master_section" TEXT DEFAULT NULL,
    "is_ose_subject" TEXT DEFAULT NULL,
    "is_recitation_section" TEXT DEFAULT NULL,
    "is_repeatable_subject" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "meet_time" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_summary_cluster_enrollment_quartile_low" (
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "cluster_enrollment_number" INTEGER DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "cluster_type" TEXT DEFAULT NULL,
    "cluster_type_description" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "subject_enrollment_number" INTEGER DEFAULT NULL,
    "subject_grouping_key" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_summary_cluster_enrollment_quartile" (
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "cluster_enrollment_number" INTEGER DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "cluster_type" TEXT DEFAULT NULL,
    "cluster_type_description" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "subject_enrollment_number" INTEGER DEFAULT NULL,
    "subject_grouping_key" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_summary_cluster_enrollment_quartile_high" (
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "cluster_enrollment_number" INTEGER DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "cluster_type" TEXT DEFAULT NULL,
    "cluster_type_description" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "subject_enrollment_number" INTEGER DEFAULT NULL,
    "subject_grouping_key" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_summary_cluster_list" (
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "composite_subject_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_id_sort" TEXT DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_grouping_key" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_id_sort" TEXT DEFAULT NULL,
    "subject_summary_key" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_summary_composite_subject" (
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "composite_subject_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lecture_units" INTEGER DEFAULT NULL,
    "preparation_units" INTEGER DEFAULT NULL,
    "subject_summary_key" TEXT DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_offered_summary_hgn_codes" (
    "subject_offered_summary_key" TEXT DEFAULT NULL,
    "hgn_code" TEXT DEFAULT NULL,
    "hgn_code_description" TEXT DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL
);

CREATE TABLE "subject_selector_index" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_id_sort" TEXT DEFAULT NULL,
    "subject_or_cluster" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "ult_master_subject_id" TEXT DEFAULT NULL,
    "cluster_type" TEXT DEFAULT NULL,
    "cluster_type_description" TEXT DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_summary_cluster_enrollment_and_week" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "CLUSTER_ENROLLMENT_1ST_CREDIT" INTEGER DEFAULT NULL,
    "CLUSTER_ENROLLMENT_1ST_LISTEN" INTEGER DEFAULT NULL,
    "CLUSTER_ENROLLMENT_5TH_CREDIT" INTEGER DEFAULT NULL,
    "CLUSTER_ENROLLMENT_5TH_LISTEN" INTEGER DEFAULT NULL,
    "cluster_enrollment_credit" INTEGER DEFAULT NULL,
    "CLUSTER_ENROLLMENT_FIFTH_WEEK" INTEGER DEFAULT NULL,
    "cluster_enrollment_week" INTEGER DEFAULT NULL,
    "cluster_enrollment_listen" INTEGER DEFAULT NULL,
    "cluster_enrollment_number" INTEGER DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "SUBJECT_ENROLLMENT_1ST_CREDIT" INTEGER DEFAULT NULL,
    "SUBJECT_ENROLLMENT_1ST_LISTEN" INTEGER DEFAULT NULL,
    "SUBJECT_ENROLLMENT_5TH_CREDIT" INTEGER DEFAULT NULL,
    "SUBJECT_ENROLLMENT_5TH_LISTEN" INTEGER DEFAULT NULL,
    "subject_enrollment_credit" INTEGER DEFAULT NULL,
    "SUBJECT_ENROLLMENT_FIFTH_WEEK" INTEGER DEFAULT NULL,
    "subject_enrollment_week" INTEGER DEFAULT NULL,
    "subject_enrollment_listen" INTEGER DEFAULT NULL,
    "subject_enrollment_number" INTEGER DEFAULT NULL
);

CREATE TABLE "subject_summary_cluster_enrollment_listen" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "cluster_enrollment_listen" INTEGER DEFAULT NULL,
    "cluster_enrollment_number" INTEGER DEFAULT NULL,
    "cluster_list" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_id_sort" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "subject_enrollment_listen" INTEGER DEFAULT NULL,
    "subject_enrollment_number" INTEGER DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_id_sort" TEXT DEFAULT NULL,
    "subject_or_cluster" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "ult_master_subject_id" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_summary_cluster_types" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "cluster_type" TEXT DEFAULT NULL,
    "cluster_type_description" TEXT DEFAULT NULL,
    "department_code" TEXT DEFAULT NULL,
    "school_code" TEXT DEFAULT NULL,
    "subject_enrollment_credit" INTEGER DEFAULT NULL,
    "subject_enrollment_week" INTEGER DEFAULT NULL,
    "subject_group_id" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_or_cluster" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "subject_summary_cluster_types_with_titles" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "cluster_type" TEXT DEFAULT NULL,
    "cluster_type_description" TEXT DEFAULT NULL,
    "department_name" TEXT DEFAULT NULL,
    "school_name" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL
);

CREATE TABLE "subject_summary_design_units_lab_low" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "design_units" INTEGER DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lecture_units" INTEGER DEFAULT NULL,
    "prep_units" INTEGER DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL
);

CREATE TABLE "subject_summary_design_units_lab_middle" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "design_units" INTEGER DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lecture_units" INTEGER DEFAULT NULL,
    "prep_units" INTEGER DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL
);

CREATE TABLE "subject_summary_design_units_lab_high_or_null" (
    "subject_summary_key" TEXT DEFAULT NULL,
    "design_units" INTEGER DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lecture_units" INTEGER DEFAULT NULL,
    "prep_units" INTEGER DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL
);

CREATE TABLE "time_day_academic_term_codes" (
    "calendar_date" TEXT DEFAULT NULL,
    "academic_term_code" TEXT DEFAULT NULL,
    "academic_term_description" TEXT DEFAULT NULL,
    "academic_year" TEXT DEFAULT NULL,
    "calendar_period_description" TEXT DEFAULT NULL,
    "calendar_year" TEXT DEFAULT NULL,
    "financial_aid_year" TEXT DEFAULT NULL,
    "financial_aid_year_description" TEXT DEFAULT NULL,
    "fiscal_year" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_academic_term_codes_extended" (
    "calendar_date" TEXT DEFAULT NULL,
    "academic_term_code" TEXT DEFAULT NULL,
    "academic_term_description" TEXT DEFAULT NULL,
    "calendar_period" TEXT DEFAULT NULL,
    "calendar_period_description" TEXT DEFAULT NULL,
    "calendar_year" TEXT DEFAULT NULL,
    "financial_aid_year_description" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "fiscal_period_description" TEXT DEFAULT NULL,
    "fiscal_year" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_day_of_week_friday" (
    "calendar_date" TEXT DEFAULT NULL,
    "day_of_week" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_day_of_week_monday" (
    "calendar_date" TEXT DEFAULT NULL,
    "day_of_week" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_day_of_week_saturday" (
    "calendar_date" TEXT DEFAULT NULL,
    "day_of_week" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_day_of_week_sunday" (
    "calendar_date" TEXT DEFAULT NULL,
    "day_of_week" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_day_of_week_thursday" (
    "calendar_date" TEXT DEFAULT NULL,
    "day_of_week" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_day_of_week_tuesday" (
    "calendar_date" TEXT DEFAULT NULL,
    "day_of_week" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_day_day_of_week_wednesday_or_null" (
    "calendar_date" TEXT DEFAULT NULL,
    "day_of_week" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_month_academic_term_mapping" (
    "time_month_key" TEXT DEFAULT NULL,
    "academic_term" TEXT DEFAULT NULL,
    "academic_term_description" TEXT DEFAULT NULL,
    "academic_year" TEXT DEFAULT NULL
);

CREATE TABLE "time_month_calendar_months" (
    "time_month_key" TEXT DEFAULT NULL,
    "calendar_month" TEXT DEFAULT NULL,
    "calendar_month_name" TEXT DEFAULT NULL,
    "calendar_period" TEXT DEFAULT NULL,
    "calendar_period_description" TEXT DEFAULT NULL,
    "calendar_year" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "fiscal_year" TEXT DEFAULT NULL,
    "is_closing_period" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_month_academic_years" (
    "time_month_key" TEXT DEFAULT NULL,
    "academic_year" TEXT DEFAULT NULL,
    "calendar_year" TEXT DEFAULT NULL,
    "financial_aid_year" TEXT DEFAULT NULL,
    "financial_aid_year_description" TEXT DEFAULT NULL,
    "fiscal_year" TEXT DEFAULT NULL
);

CREATE TABLE "time_month_calendar_month_names" (
    "time_month_key" TEXT DEFAULT NULL,
    "calendar_month_name" TEXT DEFAULT NULL,
    "calendar_period" TEXT DEFAULT NULL,
    "end_date" TEXT DEFAULT NULL,
    "fiscal_period" TEXT DEFAULT NULL,
    "fiscal_period_description" TEXT DEFAULT NULL,
    "fiscal_period_selector" TEXT DEFAULT NULL,
    "fiscal_year_quarter" TEXT DEFAULT NULL,
    "fy_quarter_code" TEXT DEFAULT NULL,
    "start_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_month_fiscal_selector_not_closing" (
    "time_month_key" TEXT DEFAULT NULL,
    "fiscal_period_selector" TEXT DEFAULT NULL,
    "is_closing_period" TEXT DEFAULT NULL,
    "is_current_fiscal_period" TEXT DEFAULT NULL,
    "is_current_fiscal_year" TEXT DEFAULT NULL,
    "is_previous_fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "time_month_fiscal_selector_closing_or_null" (
    "time_month_key" TEXT DEFAULT NULL,
    "fiscal_period_selector" TEXT DEFAULT NULL,
    "is_closing_period" TEXT DEFAULT NULL,
    "is_current_fiscal_period" TEXT DEFAULT NULL,
    "is_current_fiscal_year" TEXT DEFAULT NULL,
    "is_previous_fiscal_period" TEXT DEFAULT NULL
);

CREATE TABLE "time_quarter_calendar_and_fiscal" (
    "cy_quarter_code" TEXT DEFAULT NULL,
    "calendar_year" TEXT DEFAULT NULL,
    "cy_quarter_name" TEXT DEFAULT NULL,
    "fiscal_year" TEXT DEFAULT NULL,
    "fy_quarter_code" TEXT DEFAULT NULL,
    "fy_quarter_name" TEXT DEFAULT NULL,
    "payroll_edacca_cert_sched_key" TEXT DEFAULT NULL
);

CREATE TABLE "time_quarter_is_not_future" (
    "cy_quarter_code" TEXT DEFAULT NULL,
    "is_current_quarter" TEXT DEFAULT NULL,
    "is_future_quarter" TEXT DEFAULT NULL,
    "is_next_quarter" TEXT DEFAULT NULL,
    "is_past_quarter" TEXT DEFAULT NULL,
    "is_previous_quarter" TEXT DEFAULT NULL
);

CREATE TABLE "time_quarter_is_future_or_null" (
    "cy_quarter_code" TEXT DEFAULT NULL,
    "is_current_quarter" TEXT DEFAULT NULL,
    "is_future_quarter" TEXT DEFAULT NULL,
    "is_next_quarter" TEXT DEFAULT NULL,
    "is_past_quarter" TEXT DEFAULT NULL,
    "is_previous_quarter" TEXT DEFAULT NULL
);

CREATE TABLE "time_quarter_calendar_future_flags" (
    "cy_quarter_code" TEXT DEFAULT NULL,
    "calendar_year" TEXT DEFAULT NULL,
    "is_future_quarter" TEXT DEFAULT NULL,
    "payroll_edacca_cert_sched_key" TEXT DEFAULT NULL,
    "quarter_cert_due" TEXT DEFAULT NULL,
    "quarter_cert_expected" TEXT DEFAULT NULL,
    "quarter_cert_open" TEXT DEFAULT NULL,
    "quarter_end_date" TEXT DEFAULT NULL,
    "quarter_start_date" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "time_quarter_fiscal_mappings" (
    "cy_quarter_code" TEXT DEFAULT NULL,
    "fy_quarter_code" TEXT DEFAULT NULL,
    "quarter_cert_open" TEXT DEFAULT NULL,
    "quarter_end_date" TEXT DEFAULT NULL,
    "quarter_end_fp" TEXT DEFAULT NULL,
    "quarter_start_date" TEXT DEFAULT NULL,
    "quarter_start_fp" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "tip_subject_offered_course_numbers_group_a" (
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "course_number_sort" TEXT DEFAULT NULL,
    "is_no_course_material" TEXT DEFAULT NULL,
    "master_course_number" TEXT DEFAULT NULL,
    "master_course_number_description" TEXT DEFAULT NULL,
    "master_course_number_sort" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "tip_subject_offered_course_numbers_group_b" (
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "course_number_sort" TEXT DEFAULT NULL,
    "is_no_course_material" TEXT DEFAULT NULL,
    "master_course_number" TEXT DEFAULT NULL,
    "master_course_number_description" TEXT DEFAULT NULL,
    "master_course_number_sort" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "tip_subject_offered_course_numbers_group_c" (
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "course_number_sort" TEXT DEFAULT NULL,
    "is_no_course_material" TEXT DEFAULT NULL,
    "master_course_number" TEXT DEFAULT NULL,
    "master_course_number_description" TEXT DEFAULT NULL,
    "master_course_number_sort" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "tip_subject_offered_course_numbers_other_bucket" (
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "course_number" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "course_number_sort" TEXT DEFAULT NULL,
    "is_no_course_material" TEXT DEFAULT NULL,
    "master_course_number" TEXT DEFAULT NULL,
    "master_course_number_description" TEXT DEFAULT NULL,
    "master_course_number_sort" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "tip_subject_offered_master_subjects" (
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "master_subject_id" TEXT DEFAULT NULL,
    "master_subject_id_sort" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "subject_id_sort" TEXT DEFAULT NULL
);

CREATE TABLE "tip_subject_offered_course_desc" (
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "course_number_description" TEXT DEFAULT NULL,
    "is_no_course_material" TEXT DEFAULT NULL,
    "num_enrolled_students" INTEGER DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "responsible_faculty_mit_id" TEXT DEFAULT NULL,
    "responsible_faculty_name" TEXT DEFAULT NULL,
    "subject_title" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "tip_subject_offered_offer_department_info" (
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "offer_dept_code" TEXT DEFAULT NULL,
    "offer_dept_name" TEXT DEFAULT NULL,
    "offer_school_name" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL
);

CREATE TABLE "zpm_rooms_load_import" (
    "building_room" TEXT DEFAULT NULL,
    "building_component" TEXT DEFAULT NULL,
    "floor" TEXT DEFAULT NULL,
    "space_usage" TEXT DEFAULT NULL,
    "space_unit_code" TEXT DEFAULT NULL,
    "hr_org_unit_id" TEXT DEFAULT NULL,
    "access_level" TEXT DEFAULT NULL
);

CREATE TABLE "library_reserve_material_status_dates_group_a" (
    "library_course_instructor_key" TEXT DEFAULT NULL,
    "library_reserve_catalog_key" TEXT DEFAULT NULL,
    "library_material_status_key" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "library_reserve_material_status_dates_group_b" (
    "library_course_instructor_key" TEXT DEFAULT NULL,
    "library_reserve_catalog_key" TEXT DEFAULT NULL,
    "library_material_status_key" TEXT DEFAULT NULL,
    "term_code" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);

CREATE TABLE "tip_material_isbn_details" (
    "tip_material_key" TEXT DEFAULT NULL,
    "subject_id" TEXT DEFAULT NULL,
    "isbn" TEXT DEFAULT NULL,
    "record_count" INTEGER DEFAULT NULL,
    "tip_subject_offered_key" TEXT DEFAULT NULL,
    "warehouse_load_date" TEXT DEFAULT NULL
);