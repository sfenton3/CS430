--Parts supplied by all suplliers
SELECT p.pid, p.pname, p.color
FROM Parts p
WHERE NOT EXISTS(
	(SELECT s.sid FROM Suppliers s)
	MINUS
	(SELECT c.sid FROM Catalog c
	WHERE c.pid=p.pid));

--Parts supllied by all suplliers
SELECT p.pid, p.pname, p.color
FROM Parts p
Where NOT EXISTS(
	(SELECT s.sid FROM Suppliers s
	WHERE p.pname LIKE 'a%')
	MINUS 
	(SELECT c.sid FROM Catalog c
	WHERE c.pid=p.pid));

--Find employees certified for all aircraft of crusing 
--range under 2000
SELECT e.eid, e.salary
FROM employees e
WHERE NOT EXISTS(
	(SELECT a.aid FROM aircraft a
	WHERE a.cruisingrange < 2000)
	MINUS
	(SELECT c.eid FROM Certified c
	WHERE c.eid=e.eid));

--Find max salary.
SELECT e.eid, MAX(e.salary)
FROM employees e
WHERE NOT EXISTS(
      (SELECT a.aid FROM aircraft a
       WHERE a.cruisingrange < 2000)
       MINUS
       (SELECT c.eid FROM Certified c
       WHERE c.eid=e.eid))
GROUP BY e.eid;
--HAVING MAX(e.salary);
                                        
