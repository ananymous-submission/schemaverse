select p.objid from photoobj as p JOIN photo_type as pt on p.type = pt.value where pt.name = 'STAR';

select p.objid, p.ra, p.dec from photoobj as p join specobj as s on s.bestobjid = p.objid join photo_type as pt on p.type = pt.value where pt.name = 'STAR';

select p.objid from photoobj as p JOIN photo_type as pt on p.type = pt.value where pt.name = 'GALAXY';

select p.objid, p.ra, p.dec from photoobj as p join specobj as s on s.bestobjid = p.objid join photo_type as pt on p.type = pt.value where  pt.name = 'GALAXY';

select p.objid, p.ra, p.dec from photoobj as p JOIN photo_type as pt on p.type = pt.value where p.ra > 185 and p.ra < 186 and p.dec > 15 and p.dec < 16 and pt.name = 'GALAXY';

select p.objid, p.ra, p.dec from photoobj as p JOIN photo_type as pt on p.type = pt.value where p.ra > 185 and p.ra < 186 and p.dec > 15 and p.dec < 16 and pt.name = 'STAR';

select p.objid, p.ra, p.dec, s.z from Photoobj as p join specobj as s on s.bestobjid = p.objid where s.ra > 185 and s.ra < 186 AND s.dec > 15 and s.dec < 16 and s.class = 'STAR';

select p.objID, p.ra, p.dec, s.z from Photoobj as p join specobj as s on s.bestobjid = p.objid where s.ra > 185 and s.ra < 186 AND s.dec > 15 and s.dec < 16 and s.class = 'GALAXY';

select p.objid from photoobj as p JOIN photo_type as pt on p.type = pt.value where pt.name = 'STAR' and p.u - p.g < 0.4  and p.g - p.r < 0.7 and p.r - p.i > 0.4 and p.i - p.z > 0.4;

select p.objid from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'STAR' and (p.u - p.g) < 0.4 and (p.g - p.r) < 0.7 and  (p.r - p.i) > 0.4 and (p.i - p.z) > 0.4 and p.objid in (select n.objid from neighbors as n join photo_type as pt on n.neighbortype = pt.value where n.distance < 0.05 and pt.name = 'STAR');

select count(*) from photoobj as p join photo_type as pt on p.type = pt.value where p.r < 17 and p.extinction_r > 0.2 and pt.name = 'GALAXY';

select p.objid, p.g from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'GALAXY' and p.g <= 22 and p.u - p.g >= -0.27 and p.u - p.g < 0.71 and p.g - p.r  >= -0.24 and p.g - p.r < 0.35 and p.r - p.i >= -0.27 and p.r - p.i < 0.57 and p.i - p.z  >= -0.35 and p.i - p.z < 0.7 order by p.g desc;

SELECT p.objid, p.ra, p.dec from photoobj AS p JOIN photo_type AS pt ON p.type = pt.value where pt.name = 'STAR' and i < 19 and i > 0 and g - r > 2.26 and i - z < 0.25 and u - g > 2.0  or  u > 22.3;

select objid, ra, dec from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'GALAXY' and p.ra between 140.9 and 141.1 and p.g < 18.0 and p.u - p.g > 2.2;

select p.objid, p.ra, p.dec from photoobj as p join specobj as s on s.bestobjid = p.objid where s.class = 'GALAXY' and p.g between 17 and 18 and s.z < 0.05;

select p.objid, p.ra, p.dec from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'STAR' and p.u - p.g < 0.5;

select p.u, p.g, p.r, p.i, p.z from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'STAR' and  p.u - p.g < 0.5;

select p.u, p.g, p.r, p.i, p.z from photoobj as p join specobj as s on s.bestobjid = p.objid where s.class = 'GALAXY' and p.g between 17 and 18 and s.z < 0.05;

select p.objid, n.neighborobjid, n.distance, n.type from neighbors as n join  photoobj as p on n.objid = p.objid;

select distinct p.type from photoobj as p where p.ra > 100 and p.dec < 100;

select count(*) from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'STAR';

select distinct pt.name from photo_type as pt join photoobj as p on p.type = pt.value;

select * from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'GALAXY';

select p.objid, p.ra, p.dec, pt.name from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'STAR';

select p.objid, s.specobjid from photoobj as p join specobj as s on s.bestobjid = p.objid where s.class = 'GALAXY' and p.u - p.r > 2.22 and p.g - p.i > 1;

SELECT T2.objid, T1.mjd FROM specobj AS T1 JOIN photoobj as T2 ON T1.bestobjid = T2.objid WHERE T1.class = 'STAR' and T1.subclass like '%K%';

SELECT T1.z, T1.ra, T1.dec FROM specobj AS T1 JOIN photoobj AS T2 ON T1.bestobjid = T2.objid JOIN photo_type AS T3 ON T2.type = T3.value WHERE T1.subclass = 'STARFORMING' AND T3.name = 'GALAXY';

SELECT min( T1.extinction_r), T1.run FROM photoobj AS T1 JOIN photo_type AS T2 ON T1.type = T2.value WHERE T2.name = 'GALAXY' GROUP BY T1.run;

SELECT T1.b, T1.l FROM photoobj AS T1 JOIN specobj AS T2 ON T1.objid = T2.bestobjid where T2.class = 'QSO';

SELECT count( T1.objid ) FROM neighbors AS T1 JOIN photoobj AS T2 ON T1.objid = T2.objid JOIN photo_type AS T3 ON T2.type = T3.value WHERE T3.name = 'STAR' and T1.neighbortype = T2.type and T1.distance < 0.05 and T2.u - T2.g < 0.4 and T2.g - T2.r < 0.7 and T2.r - T2.i > 0.4 and T2.i - T2.z > 0.4;

SELECT COUNT(p.objid) FROM photoobj AS p JOIN photo_type AS pt ON p.type = pt.value WHERE pt.name = 'STAR' AND (p.u - p.g) < 0.4 AND (p.g - p.r) < 0.7 AND  (p.r - p.i) > 0.4 AND (p.i - p.z) > 0.4 AND p.objid in (SELECT n.objid FROM neighbors AS n JOIN photo_type AS pt ON n.neighbortype = pt.value WHERE n.distance < 0.05 AND pt.name = 'STAR');

select s.specobjid from specobj as s JOIN photoobj as p ON s.bestobjid = p.objid JOIN photo_type as pt ON p.type = pt.value WHERE s.class = 'STAR' and pt.name = 'STAR' and s.subclass = 'Carbon';

select COUNT(*) from photoobj as p join photo_type as pt on p.type = pt.value where pt.name = 'GALAXY';

select s.specobjid, s.class, s.subclass from specobj as s join photoobj as p on s.bestobjid = p.objid join photo_type as pt on p.type = pt.value where s.subclass like '%AGN%' and s.class = 'GALAXY' and pt.name = 'GALAXY';

SELECT min(n.distance) FROM neighbors AS n JOIN photo_type AS pt ON n.neighbortype = pt.value JOIN photoobj AS p ON p.objid = n.objid WHERE pt.name = 'STAR' and p.objid in (SELECT p.objid FROM photoobj AS p JOIN photo_type AS pt ON p.type = pt.value WHERE pt.name = 'STAR');

SELECT max(n.distance) FROM neighbors AS n JOIN photo_type AS pt ON n.neighbortype = pt.value JOIN photoobj AS p ON p.objid = n.objid WHERE pt.name = 'GALAXY' and p.objid in (SELECT p.objid FROM photoobj AS p JOIN photo_type AS pt ON p.type = pt.value WHERE pt.name = 'GALAXY');

SELECT p.b, p.l, n.distance from photoobj as p join neighbors n on p.objid = n.objid where n.distance = (select min(n.distance) from neighbors as n);

SELECT p.b, p.l, n.distance from photoobj as p join neighbors as n on p.objid = n.objid order by n.distance asc limit 1;

SELECT s.z from specobj as s join photoobj as p on s.bestobjid = p.objid join neighbors as n on p.objid = n.objid where n.distance = (select min(n.distance) from neighbors as n);

SELECT s.z from specobj as s join photoobj as p on s.bestobjid = p.objid join neighbors as n on p.objid = n.objid order by n.distance asc limit 1;

select distinct p.run from photoobj as p;

select count(distinct p.run) from photoobj as p;

select pt.name, count(*) from photoobj as p join photo_type as pt on pt.value = p.type group by pt.name;

select p.ra, p.dec, p.type from spplines as sp join specobj as s on sp.specobjid = s.specobjid join photoobj as p on p.objid = s.bestobjid;

select p.objid, pt.name from photoobj as p join photo_type as pt on p.type = pt.value where p.ra > 100 and p.dec < 100;

select p.objid, p.ra, p.dec from photoobj as p join specobj as s on s.bestobjid = p.objid join galspecline as g on s.specobjid = g.specobjid;

select sp.specobjid from spplines as sp join specobj as s on sp.specobjid = s.specobjid;

select count(sp.specobjid) from spplines as sp join specobj as s on sp.specobjid = s.specobjid;

select * from specobj as s join galspecline as g on s.specobjid = g.specobjid;

