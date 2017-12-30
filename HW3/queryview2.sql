--Query View 2
SELECT m1.MgrName
        FROM ManagerSummary m1, ManagerSummary m2
        WHERE m1.EmpCount > m2.EmpCount;

