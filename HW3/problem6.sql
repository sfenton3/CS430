create view ManagerSummary (DeptName, MgrID, MgrName, MgrSalary, EmpCount)
	AS SELECT d.dname, d.managerid, e.ename, e.salary, COUNT(e.eid)
	FROM dept d, works w, emp e
	WHERE e.eid=w.eid AND d.did=w.did
	GROUP BY d.dname, d.managerid, e.ename, e.salary;

