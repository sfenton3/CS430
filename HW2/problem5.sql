/* Problem 1 */
SELECT DISTINCT p.pname
FROM catalog c, parts p
WHERE c.pid=p.pid;

/* Problem 4  subquery*/
SELECT p.pname
FROM catalog c, parts p, suppliers s
WHERE c.pid=p.pid AND c.sid=s.sid AND s.sname='Acme Widget Suppliers' 
AND   NOT EXISTS (SELECT * FROM catalog c1, suppliers s1
			WHERE c1.pid=p.pid AND c1.sid=s1.sid AND s1.sname<>'Acme Widget Suppliers');

/* Problem 5 */
SELECT DISTINCT c.sid
FROM catalog c
WHERE c.cost > (SELECT AVG (c0.cost) FROM catalog c0 WHERE c0.pid=c.pid);

/* Problem 7 */
SELECT DISTINCT c.sid
FROM catalog c
WHERE NOT EXISTS (SELECT * FROM parts p WHERE c.pid=p.pid AND p.color<>'Red');

/* Problem 11. output sname, pname, cost */
SELECT s.sname, p.pname,  MAX(c.cost)
FROM catalog c, parts p, suppliers s
WHERE c.pid=p.pid AND c.sid=s.sid AND p.color='red' AND EXISTS (SELECT p1.pid FROM  parts p1, catalog c1 WHERE p1.color='green' AND c1.sid=c.sid AND p1.pid=c1.pid)
GROUP BY s.sname, p.pname;
