/* Exercise 5.2 Problem 10 */
SELECT s.sname, COUNT(*)
FROM suppliers s, parts p, catalog c
WHERE p.pid=c.pid AND c.sid=s.sid AND p.color='Green' AND NOT p.color='green'
GROUP BY s.sname;

/* Part b */
SELECT s.major, AVG(s.age)
FROM student s
GROUP BY s.major;

/* Part c */
SELECT c.room, COUNT(f.deptid)
FROM class c, faculty f
WHERE c.fid=f.fid 
GROUP BY c.room;

/* part d */
SELECT c.room, COUNT(f.deptid)
FROM class c, faculty f
WHERE c.fid=f.fid
GROUP BY c.room
HAVING COUNT(f.deptid) > 1;

/* part e */
SELECT c.name, s.major, COUNT(s.snum)
FROM class c, student s, enrolled e
WHERE e.cname=c.name AND e.snum=s.snum
GROUP BY c.name, s.major;
