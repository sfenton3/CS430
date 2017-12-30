/* Problem 1 */
SELECT e.ename, e.age
FROM emp e, works w1, works w2, dept d1, dept d2
WHERE e.eid=w1.eid AND w1.did=d1.did 
	AND d1.dname='Hardware' AND d2.dname='Software' 
	AND e.eid=w2.eid AND w2.did=d2.did;

/* problem 2 */
SELECT w.did, COUNT(w.eid)
FROM works w
GROUP BY w.did
HAVING 2000 < (SELECT SUM(w1.pct_time) FROM works w1 WHERE w1.did=w.did);

/* problem 3 */
SELECT e.ename
FROM emp e
WHERE e.salary > ALL(SELECT d.budget FROM works w, dept d WHERE w.eid=e.eid AND w.did=d.did);

/* problem 6 */
SELECT d.managerid
FROM dept d
WHERE 5000000 < (SELECT SUM(d1.budget) FROM dept d1 WHERE d1.managerid=d.managerid);

