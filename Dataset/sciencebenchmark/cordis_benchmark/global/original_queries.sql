SELECT T1.total_cost FROM projects AS T1 WHERE T1.title = 'Theseus';

SELECT acronym FROM projects WHERE start_year = 2018;

SELECT title FROM projects WHERE start_year < 2016;

SELECT T1.institutions_name FROM institutions AS T1 JOIN eu_territorial_units AS T2 ON T1.geocode_regions_3 = T2.geocode_regions WHERE T2.description = 'Nordjylland';

SELECT T2.full_name FROM projects AS T1 join people as T2 on T1.principal_investigator = T2.unics_id WHERE T1.start_year = 2014;

SELECT t1.title FROM projects AS T1 join project_subject_areas as psa on T1.unics_id = psa.project join subject_areas as sa on psa.subject_area = sa.code WHERE sa.title = 'Mathematics and Statistics';

SELECT t1.acronym, sa.description FROM projects AS T1 join project_subject_areas as psa on T1.unics_id = psa.project join subject_areas as sa on psa.subject_area = sa.code WHERE sa.title = 'Mathematics and Statistics';

SELECT distinct t.title FROM projects AS T1 join project_topics as pt on T1.unics_id = pt.project join topics as t on pt.topic = t.code where t1.end_year = 2014;

Select p.acronym from projects as p join project_members as pm on p.unics_id = pm.project join institutions as i on pm.institution_id = i.unics_id join countries as c on i.country_id = c.unics_id where c.country_name = 'Greece';

Select i.institutions_name from institutions as i join countries as c on i.country_id = c.unics_id where c.country_name = 'France' or c.country_name = 'Germany';

Select i.institutions_name from institutions as i join countries as c on i.country_id = c.unics_id where c.country_name != 'France';

Select count(p.unics_id) from projects as p where start_year = 2016;

Select p.title from projects as p where total_cost = (select max(p2.total_cost) from projects as p2);

SELECT T1.member_name FROM project_members AS T1 JOIN projects AS T2 ON T1.project = T2.unics_id WHERE T2.total_cost < (SELECT AVG(T23.total_cost) FROM projects AS T23);

select p.unics_id from projects as p join project_members as pm on p.unics_id = pm.project group by p.unics_id having count(p.unics_id) >= 100;

select s.code, s.title from funding_schemes as s where s.code = (select s2.code from funding_schemes as s2 join projects as p on s2.code = p.ec_fund_scheme group by s2.code order by count(*) desc LIMIT 1);

SELECT sum(total_cost) FROM projects;

select title from projects where start_year > 2006 and end_year > 2006;

select title, end_year - start_year from projects order by end_year - start_year desc limit 1;

select title from topics where title like 'Raw materials%';

select title from topics where title like '%climate%';

select count(*) from projects as p join people as peep on p.principal_investigator = peep.unics_id where peep.full_name = 'Thomas Bell';

select distinct full_name from people;

select p.acronym from projects as p where p.total_cost between 100000 and 200000;

select p.title from projects as p where p.total_cost > 1000000;

select title, member_name from projects as p join project_members as pm on p.unics_id = pm.project join project_member_roles as pmr on pm.member_role = pmr.code where pmr.code = 'partner';

select distinct description from erc_research_domains;

select c.country_name from countries as c join institutions as i on c.unics_id = i.country_id;

select country_code2, country_code3 from countries where country_name = 'Andorra';

select code from funding_schemes where title = 'Framework Partnership Agreement';

select title from programmes where short_name = 'Transport';

select pm.member_name, pr.code from project_members as pm join projects as p on pm.project = p.unics_id join project_member_roles as pr on pm.member_role = pr.code where p.acronym = 'GTBB';

select title from programmes where parent = 'FP7';

select p.description from erc_panels as p join erc_research_domains as erd on p.part_of = erd.code where erd.description = 'Life Sciences';

select member_name from project_members as mb join activity_types as a on a.code = mb.activity_type where a.description = 'Research Organisations';

select objective from projects where acronym = 'DEEPCARBON';

select title from projects where objective like '%carbon capturing%';

select count(*) from projects where objective like '%carbon capturing%';

select i.institutions_name from institutions as i join countries as c on c.unics_id = i.country_id where country_name = 'France' except select i.institutions_name from institutions as i join countries as c on c.unics_id = i.country_id join eu_territorial_units as etu on i.geocode_regions_3 = etu.geocode_regions where country_name = 'France' and etu.description = 'Paris';

SELECT distinct member_name from project_members WHERE member_name NOT in (SELECT member_name from project_members where member_role = 'coordinator');

SELECT t1.full_name, count(p.title) FROM people as t1 join projects as p on t1.unics_id = p.principal_investigator group by t1.full_name HAVING count(p.title) > 1;

SELECT t1.title, MAX(t3.ec_max_contribution) from subject_areas as t1 join project_subject_areas as t2 on t1.code = t2.subject_area join projects as t3 on t2.project = t3.unics_id  group by t1.title order by  MAX(t3.ec_max_contribution) DESC LIMIT 1;

SELECT t1.title, MIN(t3.ec_max_contribution) from subject_areas as t1 join project_subject_areas as t2 on t1.code = t2.subject_area join projects as t3 on t2.project = t3.unics_id  group by t1.title order by  MIN(t3.ec_max_contribution) DESC LIMIT 1;

Select i.institutions_name, Count(distinct project) From project_members join institutions as i on project_members.institution_id = i.unics_id GROUP BY i.institutions_name order by count(distinct project) desc limit 1;

Select t2.institutions_name, Count(distinct project) From project_members as t1 join institutions as t2 on t1.institution_id = t2.unics_id GROUP BY t2.institutions_name order by count(distinct project) asc limit 1;

SELECT t1.title, sum(ec_max_contribution) from funding_schemes as t1 join projects as t2 on t1.code = t2.ec_fund_scheme group by t1.title ORDER BY sum(ec_max_contribution) DESC LIMIT 1;

SELECT t1.title, sum(ec_max_contribution) from funding_schemes as t1 join projects as t2 on t1.code = t2.ec_fund_scheme group by t1.title ORDER BY sum(ec_max_contribution) ASC LIMIT 1;

SELECT t1.member_name, p.ec_max_contribution FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code join projects as p on t1.project = p.unics_id WHERE t2.code = 'PRC' ORDER BY ec_max_contribution DESC;

SELECT p.title, p.start_year from projects as p order by start_year DESC;

SELECT p.title, p.start_year from projects as p order by start_year ASC;

SELECT p.start_date from projects as p order by start_date ASC;

SELECT t3.title from subject_areas as t1 join project_subject_areas as t2 on t1.code = t2.subject_area join projects as t3 on t2.project = t3.unics_id WHERE t1.title = 'Climate change and Carbon cycle research';

SELECT pmr.description from project_member_roles as pmr;

SELECT count(t1.description) from erc_panels as t1 join erc_research_domains as t2 on t2.code = t1.part_of WHERE t2.description = 'Life Sciences';

SELECT count(t1.description) from erc_panels as t1 join erc_research_domains as t2 on t2.code = t1.part_of WHERE t2.code = 'LS';

SELECT t1.description from erc_panels as t1 join erc_research_domains as t2 on t2.code = t1.part_of WHERE t2.code = 'SH';

SELECT count(t1.description) from erc_panels as t1 join erc_research_domains as t2 on t2.code = t1.part_of WHERE t2.code = 'SH';

SELECT member_name FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code WHERE t2.code = 'PRC';

SELECT count(member_name) FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code WHERE t2.code = 'PRC';

SELECT count (distinct member_name) FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code WHERE t2.code = 'HES';

SELECT count (distinct member_name) FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code WHERE t2.description = 'Higher or Secondary Education Establishments';

SELECT count(t3.title) from subject_areas as t1 join project_subject_areas as t2 on t1.code = t2.subject_area join projects as t3 on t2.project = t3.unics_id WHERE t1.title = 'Robotics';

SELECT t1.member_name, p.ec_max_contribution FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code join projects as p on t1.project = p.unics_id WHERE t1.geocode_regions_3 = 'NONEU' ORDER BY ec_max_contribution DESC LIMIT 1;

SELECT t1.member_name, p.ec_max_contribution FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code join projects as p on t1.project = p.unics_id WHERE t1.geocode_regions_3 = 'NONEU' ORDER BY ec_max_contribution ASC LIMIT 1;

SELECT count(distinct t1.member_name) FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code join projects as p on t1.project = p.unics_id  WHERE t1.geocode_regions_3 = 'NONEU';

SELECT distinct t1.member_name FROM project_members as t1 join activity_types as t2 on t1.activity_type = t2.code join projects as p on t1.project = p.unics_id WHERE t1.geocode_regions_3 = 'NONEU';

SELECT p.title from programmes as p WHERE p.title like '%climate%';

SELECT t1.title, sum(t3.ec_max_contribution) from programmes as t1 join project_programmes as t2 on t1.code = t2.programme join projects as t3 on t3.unics_id = t2.project group by t1.title;

