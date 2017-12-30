/* Problem 1  */
SELECT DISTINCT s.sname
FROM suppliers s, parts p, catalog c
WHERE p.color='Red' AND c.pid=p.pid AND c.sid=s.sid;

/* Problem 2 */
SELECT DISTINCT c.sid
FROM parts p, catalog c
WHERE (p.color='Red' OR p.color='Green') AND c.pid=p.pid;

/* Problem 3 */
SELECT DISTINCT s.sid
FROM suppliers s, parts p, catalog c
WHERE (p.color='Red' OR s.address='221 Packer Ave.')  AND c.pid=p.pid AND c.sid=s.sid;

/* Problem 4  */
SELECT c.sid
FROM parts p, catalog c
WHERE p.color='Red'  AND c.pid=p.pid
INTERSECT
SELECT c.sid
FROM parts p, catalog c
WHERE p.color='Green'  AND c.pid=p.pid;


/* Problem 9 */
SELECT DISTINCT c1.sid, c2.sid
FROM catalog c1, catalog c2
WHERE c1.pid=c2.pid AND c1.sid<>c2.sid AND c1.cost > c2.cost;

/* Problem 10 */
SELECT c.pid
FROM catalog c, catalog c1
WHERE c.sid<>c1.sid AND c1.pid=c.pid;


/* problem 11 */
SELECT c.pid
FROM catalog c, suppliers s
WHERE s.sname='Yosemite Sham' AND c.sid=s.sid
INTERSECT
SELECT c1.pid
FROM catalog c1, suppliers s1
WHERE s1.sname='Yosemite Sham' AND c1.sid=s1.sid;


