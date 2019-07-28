/*Helia Mozaffari*/

/*1. List the name of each officer who has reported more than the average number of crimes officers have reported.*/
SELECT o.first||' '||o.last AS Name
FROM crime_officers co JOIN officers o
ON co.officer_id = o.officer_id
GROUP BY o.first, o.last
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT officer_id) FROM crime_officers);

/*2.List the names of all criminals who have committed less than average number of crimes and aren’t listed as violent offenders.*/
SELECT c.first||' '||c.last AS Name
FROM criminals c JOIN crimes cr
ON c.criminal_id = cr.criminal_id
WHERE c.v_status ='N'
GROUP BY c.first, c.last
HAVING COUNT(*) < (SELECT COUNT(*) / COUNT(DISTINCT cr.criminal_id) FROM crimes);

/*3.List appeal information for each appeal that has a less than average number of days between the filing and hearing dates.*/
SELECT *
FROM appeals
where(filing_date - hearing_date) < (SELECT AVG(filing_date - hearing_date)from appeals);

/*4. List the names of probation officers who have had a less than average number of criminals assigned.*/
SELECT p.last||' '||p.first AS Name 
FROM prob_officers p
JOIN sentences s
ON p.prob_id = s.prob_id
group by p.last, p.first
HAVING COUNT(*) < (SELECT COUNT(*) / COUNT(DISTINCT prob_id) FROM sentences);

/*5.List each crime that has had the highest number of appeals recorded.*/
select crime_id
from appeals
group by crime_id
having count(*) = (select max(count(appeal_id))from appeals group by appeal_id);



