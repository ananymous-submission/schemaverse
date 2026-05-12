SELECT SUM(donation_total) FROM donations WHERE donation_timestamp LIKE '2012%';

SELECT donation_timestamp, donation_total FROM donations WHERE donation_total = ( SELECT donation_total FROM donations ORDER BY donation_total DESC LIMIT 1 );

SELECT SUM(donation_total) FROM donations WHERE donation_timestamp LIKE '2011%' AND via_giving_page = 't' AND for_honoree = 't';

SELECT donor_acctid, donation_optional_support / donation_total FROM donations WHERE is_teacher_acct = 'f';

SELECT T1.title FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.primary_focus_subject = 'Literacy';

SELECT T1.title FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.poverty_level LIKE 'highest%';

SELECT T2.primary_focus_subject FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title = 'Toot Your Flute!';

SELECT T1.title FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.donation_message LIKE 'Donation on behalf of Matt Carpenter because I''m a strong believer in education.';

SELECT T1.title, T2.total_price_excluding_optional_support FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.students_reached = 320;

SELECT T2.donation_message, T1.title FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.donor_city = 'Texas City';

SELECT T1.vendor_name, T1.item_name, T1.item_unit_price FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN essays AS T3 ON T2.projectid = T3.projectid WHERE T3.title = 'Lights, Camera, Action!';

SELECT SUM(T2.donation_to_project) FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title = 'Whistle While We Work!';

SELECT T1.title, T1.short_description FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.teacher_ny_teaching_fellow = 't';

SELECT DISTINCT T2.title, T1.total_price_excluding_optional_support FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T1.students_reached >= 600 AND T1.poverty_level LIKE 'moderate poverty';

SELECT CAST(SUM(CASE WHEN T2.school_metro = 'rural' THEN T1.donation_to_project ELSE 0 END) AS REAL) * 100 / SUM(donation_to_project) FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid;

SELECT T1.title, SUM(T3.donation_to_project), CAST((T2.total_price_excluding_optional_support - SUM(T3.donation_to_project)) AS REAL) * 100 / SUM(T3.donation_to_project) FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid ORDER BY T2.total_price_excluding_optional_support DESC LIMIT 1;

SELECT COUNT(poverty_level) FROM projects WHERE school_district = 'West New York School District' AND poverty_level = 'highest poverty';

SELECT COUNT(donationid) FROM donations WHERE is_teacher_acct = 't' AND donor_state = 'CO';

SELECT projectid FROM projects ORDER BY total_price_including_optional_support DESC LIMIT 1;

SELECT DISTINCT donor_state FROM donations WHERE for_honoree = 't' AND payment_included_campaign_gift_card = 't' AND payment_method = 'paypal' AND donor_state = ( SELECT donor_state FROM donations GROUP BY donor_state ORDER BY SUM(donation_total) DESC LIMIT 1 );

SELECT donationid, donation_total FROM donations ORDER BY donation_total DESC LIMIT 1;

SELECT T1.projectid, T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid ORDER BY T2.total_price_including_optional_support - T2.total_price_excluding_optional_support DESC LIMIT 1;

SELECT DISTINCT T1.item_name, T1.item_quantity, T2.teacher_prefix FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.projectid = 'd6ef27c07c30c81f0c16c32b6acfa2ff';

SELECT SUM(T1.total_price_including_optional_support) FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title = 'Recording Rockin'' Readers';

SELECT T1.school_latitude, T1.school_longitude FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title = 'Smile for the Camera!!!';

SELECT T2.donation_total, T1.title FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.donation_total = ( SELECT MAX(donation_total) FROM donations );

SELECT project_resource_type FROM ( SELECT T1.donor_acctid, T3.project_resource_type FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN resources AS T3 ON T2.projectid = T3.projectid ORDER BY T1.donation_total DESC LIMIT 10 ) GROUP BY project_resource_type ORDER BY COUNT(project_resource_type) DESC LIMIT 1;

SELECT T2.date_posted, T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.date_posted = ( SELECT date_posted FROM projects ORDER BY date_posted ASC LIMIT 1 );

SELECT DISTINCT T1.vendor_name FROM resources AS T1 INNER JOIN essays AS T3 ON T1.projectid = T3.projectid WHERE T3.title = 'iMath';

SELECT T2.date_posted, T2.grade_level FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid ORDER BY T1.item_quantity DESC LIMIT 1;

SELECT AVG(T3.donation_to_project) FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T1.title = 'Recording Rockin'' Readers';

SELECT T1.title, T3.donor_acctid, CAST(T3.donation_to_project AS REAL) / T2.total_price_excluding_optional_support FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid ORDER BY T3.donation_to_project DESC LIMIT 1;

SELECT T1.school_state, T2.donor_acctid, AVG(T2.donation_optional_support), T1.resource_type FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid ORDER BY T2.donation_optional_support DESC LIMIT 5;

SELECT T1.projectid, T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_city LIKE 'Brooklyn' GROUP BY T1.item_name ORDER BY COUNT(T1.item_name) DESC LIMIT 1;

SELECT COUNT(T2.schoolid) FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.resource_type = 'Books' AND T2.school_metro = 'urban';

SELECT T2.schoolid FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.vendor_name LIKE 'Amazon' GROUP BY T2.schoolid ORDER BY COUNT(T1.vendor_name) DESC LIMIT 1;

SELECT COUNT(T2.schoolid) FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.donor_city = 'Los Angeles' AND T2.school_city NOT LIKE 'Los Angeles';

SELECT T2.teacher_prefix FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Reading About Other Cultures';

SELECT T2.students_reached FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Fit Firsties!';

SELECT T1.title, T3.donor_acctid FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T2.school_city LIKE 'Chicago';

SELECT T1.title FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.teacher_prefix LIKE 'Dr.' AND T2.students_reached > 300;

SELECT DISTINCT T1.vendor_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.primary_focus_subject LIKE 'Literacy';

SELECT T1.title FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.projectid = ( SELECT projectid FROM resources ORDER BY item_unit_price * item_quantity DESC LIMIT 1 );

SELECT COUNT(donationid) FROM donations WHERE is_teacher_acct = 't' AND donor_city = 'New York';

SELECT COUNT(donationid) FROM donations WHERE for_honoree = 't' AND donor_state = 'NJ';

SELECT donation_message FROM donations WHERE donationid = 'a84dace1ff716f6f0c7af8ef9090a5d5';

SELECT DISTINCT project_resource_type FROM resources WHERE vendor_name = 'Lakeshore Learning Materials';

SELECT item_name FROM resources WHERE vendor_name = 'Lakeshore Learning Materials' ORDER BY item_quantity DESC LIMIT 1;

SELECT COUNT(T1.projectid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.teacher_ny_teaching_fellow = 't' AND T2.donor_city = 'New York';

SELECT COUNT(T1.projectid) FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.vendor_name = 'Lakeshore Learning Materials' AND T2.teacher_prefix = 'Dr.';

SELECT T1.vendor_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.poverty_level = 'highest poverty';

SELECT T2.schoolid FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.vendor_name = 'Lakeshore Learning Materials' ORDER BY T2.fulfillment_labor_materials DESC LIMIT 1;

SELECT T1.vendor_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid ORDER BY T2.total_price_including_optional_support - T2.total_price_including_optional_support DESC LIMIT 1;

SELECT SUM(T2.donation_total) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.school_city = 'Brooklyn';

SELECT T2.donation_message FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.school_city = 'Brooklyn' AND T1.school_magnet = 't';

SELECT COUNT(T1.projectid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.payment_included_acct_credit = 't' AND T1.school_year_round = 't';

SELECT SUM(T2.dollar_amount) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.primary_focus_area = 'Literacy & Language';

SELECT T2.donor_acctid FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.primary_focus_area = 'Literacy & Language' ORDER BY T2.donation_total DESC LIMIT 1;

SELECT T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.primary_focus_area = 'Literacy & Language' AND T1.project_resource_type = 'Supplies' ORDER BY T1.item_quantity DESC LIMIT 1;

SELECT T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.primary_focus_area = 'Literacy & Language' ORDER BY T1.item_unit_price DESC LIMIT 1;

SELECT SUM(T2.donation_total) / COUNT(donationid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.school_city = 'Brooklyn';

SELECT DISTINCT donor_city FROM donations WHERE donor_acctid = '22cbc920c9b5fa08dfb331422f5926b5';

SELECT DISTINCT is_teacher_acct FROM donations WHERE donor_acctid = '22cbc920c9b5fa08dfb331422f5926b5';

SELECT CASE WHEN teacher_prefix = 'Dr.' THEN 'Yes' ELSE 'NO' END FROM projects WHERE teacher_acctid = '42d43fa6f37314365d08692e08680973';

SELECT teacher_ny_teaching_fellow end FROM projects WHERE teacher_acctid = '42d43fa6f37314365d08692e08680973';

SELECT T2.title FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T1.school_city LIKE 'Abington';

SELECT T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.teacher_acctid = '822b7b8768c17456fdce78b65abcc18e';

SELECT COUNT(T1.schoolid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.school_magnet = 't' AND T2.payment_included_acct_credit = 'f';

SELECT DISTINCT T1.project_resource_type FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T3.donationid LIKE 'b39547f29dfc25fb13c6e9e8d940dc43';

SELECT CAST(SUM(CASE WHEN T1.project_resource_type = 'Books' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.projectid) FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_magnet = 't';

SELECT COUNT(T2.schoolid) FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_magnet = 't' AND T1.vendor_name = 'ABC School Supply';

SELECT COUNT(T1.schoolid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.poverty_level = 'highest poverty' AND T2.donor_acctid = '000eebf28658900e63b538cf8a73afbd';

SELECT T2.short_description FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T1.schoolid = '301c9bf0a45d159d162b65a93fddd74e';

SELECT T1.school_city FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title LIKE 'iMath';

SELECT T2.payment_method FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.teacher_acctid = '822b7b8768c17456fdce78b65abcc18e';

SELECT T2.donation_total FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.teacher_acctid = '822b7b8768c17456fdce78b65abcc18e';

SELECT T2.is_teacher_acct FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.schoolid = 'd4af834b1d3fc8061e1ee1b3f1a77b85';

SELECT CAST(SUM(CASE WHEN T1.school_city LIKE 'Brooklyn' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.teacher_acctid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.is_teacher_acct = 't';

SELECT CAST(SUM(CASE WHEN T1.students_reached > 30 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.projectid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.is_teacher_acct = 't';

SELECT COUNT(schoolid) FROM projects WHERE school_city = 'Bethlehem' AND school_metro = 'suburban';

SELECT COUNT(school_year_round) FROM projects WHERE school_city = 'Los Angeles' AND school_year_round = 't';

SELECT COUNT(schoolid) FROM projects WHERE school_county = 'New York (Manhattan)' AND school_magnet = 't';

SELECT COUNT(teacher_acctid) FROM projects WHERE school_county = 'Twin Falls' AND primary_focus_area = 'Math & Science';

SELECT COUNT(teacher_acctid) FROM projects WHERE teacher_prefix = 'Mr.' AND primary_focus_subject = 'Literature & Writing';

SELECT COUNT(projectid) FROM projects WHERE school_district = 'Boston Public School District' AND grade_level = 'Grades 3-5';

SELECT T2.school_city FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title = 'ABC Read';

SELECT T2.teacher_prefix FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Creating Memories and Inspiring Dreams%';

SELECT T2.is_teacher_acct FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Calculate, Financial Security For Tomorrow Starts Today! ';

SELECT T1.title FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.donation_message LIKE 'Donation on behalf of Matt Carpenter because I''m a strong believer in education.';

SELECT SUM(T2.donation_total) FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'A Rug For Reaching Readers';

SELECT SUM(T2.donation_to_project) + SUM(T2.donation_optional_support) FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Engaging Young Readers with a Leveled Classroom Library ';

SELECT T2.donation_optional_support FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Armenian Genocide';

SELECT T1.short_description FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.donation_timestamp LIKE '2012-09-06 14:44:29';

SELECT T2.donation_included_optional_support FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'I Can''t See It...Can You Help Me???';

SELECT T1.teacher_acctid FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.donation_timestamp LIKE '2008-07-29 11:38:43.361';

SELECT T2.schoolid FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Virtual Aquarium Needs Help!';

SELECT T1.title FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.donation_total = ( SELECT MAX(donation_total) FROM donations );

SELECT CAST(SUM(T2.donation_optional_support) AS REAL) * 100 / SUM(T2.donation_total) FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Awesome Audiobooks Make Avid Readers';

SELECT CAST(SUM(CASE WHEN T2.payment_method LIKE 'creditcard' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(donationid) FROM essays AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Bringing Drama to Life';

SELECT short_description FROM essays WHERE title = 'Future Einsteins Of America';

SELECT need_statement FROM essays WHERE title = 'Family History Project';

SELECT COUNT(projectid) FROM projects WHERE school_district = 'Livingston Parish School Dist' AND school_metro = 'suburban';

SELECT DISTINCT vendor_name FROM resources WHERE item_name = 'Classroom Keepers Management Center';

SELECT DISTINCT project_resource_type FROM resources WHERE vendor_name = 'Sax Arts & Crafts';

SELECT school_county FROM projects WHERE poverty_level = 'low poverty' AND school_state = 'NY' GROUP BY school_state ORDER BY COUNT(poverty_level) DESC LIMIT 1;

SELECT T1.school_district FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title LIKE 'Future Einsteins Of America';

SELECT T3.payment_method FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T1.title = 'Needed Resource Materials For My Students';

SELECT COUNT(T1.projectid) FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.payment_method = 'creditcard' AND T2.school_district = 'Memphis City School District';

SELECT T2.school_district FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.vendor_name = 'Barnes and Noble';

SELECT T2.school_latitude, T2.school_longitude FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.item_name = 'R & A Plant Genetics' AND T1.vendor_name = 'Benchmark Education';

SELECT T1.payment_method FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_state = 'GA' GROUP BY T2.school_state ORDER BY COUNT(T1.payment_method) DESC LIMIT 1;

SELECT T2.school_latitude, T2.school_longitude, T2.resource_type FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Look, Look, We Need a Nook!';

SELECT T1.donation_message FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_latitude = 40.735332 AND T2.school_longitude = -74.196014 AND T2.school_district = 'Newark School District';

SELECT T1.date_posted FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title LIKE 'Lets Share Ideas';

SELECT T3.donation_message FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T1.title = 'Lets Share Ideas' AND T3.payment_method = 'creditcard';

SELECT T1.project_resource_type FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_district = 'Los Angeles Unif Sch Dist' GROUP BY T2.school_district ORDER BY COUNT(T1.project_resource_type) DESC LIMIT 1;

SELECT T2.school_city FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_district = 'Los Angeles Unif Sch Dist' AND T1.vendor_name = 'Quill.com';

SELECT T2.item_unit_price * T2.item_quantity price, T1.school_latitude, T1.school_longitude FROM projects AS T1 INNER JOIN resources AS T2 ON T1.projectid = T2.projectid WHERE T2.vendor_name = 'ABC School Supply' AND T2.project_resource_type = 'Other' AND T1.school_district = 'Hillsborough Co Pub Sch Dist';

SELECT SUM(T3.donation_total), school_city, poverty_level FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T1.title = 'Lets Share Ideas' AND T3.payment_method = 'paypal';

SELECT COUNT(donationid) FROM donations WHERE donor_city = 'Pocatello' AND is_teacher_acct = 'f';

SELECT COUNT(schoolid) FROM projects WHERE teacher_prefix = 'Dr.' AND school_county = 'Suffolk';

SELECT SUM(donation_to_project) + SUM(donation_optional_support) FROM donations WHERE payment_method = 'amazon';

SELECT COUNT(donationid) FROM donations WHERE dollar_amount = '100_and_up' AND for_honoree = 't';

SELECT vendorid FROM resources WHERE project_resource_type = 'Technology' AND item_unit_price <= 15;

SELECT COUNT(projectid) FROM resources WHERE vendor_name = 'Quill.com' AND item_quantity BETWEEN 5 AND 10;

SELECT schoolid FROM projects WHERE school_district = 'Union Pub School District I-9' AND teacher_ny_teaching_fellow = 't';

SELECT school_city FROM projects WHERE school_metro = 'suburban' AND school_county = 'Los Angeles';

SELECT DISTINCT vendorid, projectid FROM resources WHERE project_resource_type = 'Books';

SELECT CAST(SUM(CASE WHEN payment_included_campaign_gift_card = 't' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(donationid) FROM donations WHERE payment_method = 'no_cash_received';

SELECT CAST(SUM(CASE WHEN school_metro = 'suburban' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(projectid) FROM projects WHERE school_city = 'Santa Barbara';

SELECT payment_method , CAST(COUNT(donationid) AS REAL) * 100 / 51090 FROM donations WHERE donation_timestamp LIKE '2013-03%' GROUP BY payment_method;

SELECT SUM(item_unit_price) / SUM(item_quantity) FROM resources WHERE vendor_name = 'AKJ Books';

SELECT COUNT(T2.schoolid) FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T2.school_city = 'Brooklyn' AND T2.school_metro = 'urban' AND T3.for_honoree = 't' AND T1.item_name = 'TT992 - Refill Pack for Safety Name Tags';

SELECT COUNT(T1.schoolid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.payment_included_campaign_gift_card = 't' AND T1.poverty_level = 'highest poverty';

SELECT T2.school_city FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.dollar_amount = 'under_10' GROUP BY T2.school_city ORDER BY COUNT(T2.schoolid) DESC LIMIT 1;

SELECT T1.title FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_latitude = 42003718 AND T2.school_longitude = -87668289;

SELECT T2.teacher_ny_teaching_fellow FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.title LIKE 'Team More Books!';

SELECT T1.vendor_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.primary_focus_area LIKE 'Literacy%' GROUP BY T1.vendor_name ORDER BY COUNT(T2.primary_focus_area) DESC LIMIT 1;

SELECT DISTINCT T1.vendor_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.grade_level = 'Grades 9-12';

SELECT COUNT(DISTINCT T2.teacher_acctid) FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.is_teacher_acct = 't' AND T2.school_city = 'Chicago';

SELECT COUNT(DISTINCT T1.teacher_acctid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.school_city = 'Rock Hill' AND is_teacher_acct = 't';

SELECT SUM(T2.dollar_amount) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.students_reached > 300 AND t2.donation_included_optional_support = 't';

SELECT SUM(T1.item_quantity) FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.school_metro = 'urban' AND T2.school_district = 'Onslow Co School District';

SELECT SUM(T2.donation_optional_support + T2.donation_to_project) / COUNT(donationid) FROM projects AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T1.school_county = 'Fresno';

SELECT CAST(SUM(CASE WHEN T2.title LIKE 'ABC Read' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.school_county) FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid;

SELECT AVG(T1.item_quantity) FROM resources AS T1 INNER JOIN donations AS T2 ON T1.projectid = T2.projectid WHERE T2.for_honoree = 't';

SELECT T1.date_posted FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title LIKE 'Photojournalists Want to Exhibit Their Best Works';

SELECT T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T2.primary_focus_subject = 'Mathematics' ORDER BY T1.item_unit_price DESC LIMIT 1;

SELECT T2.school_city, T2.school_latitude, T2.school_longitude FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.item_name = 'Viewscreen LCD FROM Texas Instruments, TI-84 Plus';

SELECT SUM(T3.donation_total) FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN donations AS T3 ON T2.projectid = T3.projectid WHERE T1.title = 'Look, Look, We Need a Nook!';

SELECT DISTINCT T2.poverty_level FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.donor_zip = 7079;

SELECT T3.vendor_name FROM essays AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid INNER JOIN resources AS T3 ON T2.projectid = T3.projectid WHERE T1.title = 'Bloody Times';

SELECT T2.school_zip, T1.item_name FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.vendor_name = 'Sax Arts & Crafts';

SELECT T1.school_longitude, T1.school_latitude FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title LIKE 'Wiping Away Bad Grades';

SELECT DISTINCT T2.primary_focus_subject FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.payment_included_campaign_gift_card = 't';

SELECT T1.item_name, T2.short_description FROM resources AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T1.project_resource_type = 'Books' ORDER BY T1.item_unit_price DESC LIMIT 1;

SELECT T1.grade_level FROM projects AS T1 INNER JOIN essays AS T2 ON T1.projectid = T2.projectid WHERE T2.title LIKE 'Too Close for Comfort';

SELECT SUM(T2.students_reached) FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.donor_zip = 22205;

SELECT CAST(SUM(CASE WHEN T1.via_giving_page = 't' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(donation_total), ( SELECT T2.primary_focus_area FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.via_giving_page = 't' GROUP BY T2.primary_focus_area ORDER BY SUM(T1.donation_total) DESC LIMIT 1 ) result FROM donations AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid;

SELECT CAST(SUM(CASE WHEN T1.vendor_name = 'Best Buy for Business' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.projectid) FROM resources AS T1 INNER JOIN projects AS T2 ON T1.projectid = T2.projectid WHERE T1.project_resource_type = 'Technology' UNION ALL SELECT DISTINCT T1.date_posted FROM projects AS T1 INNER JOIN resources AS T2 ON T1.projectid = T2.projectid WHERE T2.vendor_name = 'Best Buy for Business' AND T2.project_resource_type = 'Technology';

