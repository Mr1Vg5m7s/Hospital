-- 1.
SELECT w.Name, w.Places
FROM Wards w
JOIN Departments d ON w.DepartmentId = d.Id
WHERE d.Building = 5
  AND w.Places >= 5
  AND EXISTS (
      SELECT 1
      FROM Wards war
      JOIN Departments dep ON war.DepartmentId = dep.Id
      WHERE dep.Building = 5 AND war.Places > 15
  );

-- 2
SELECT DISTINCT d.Name
FROM Departments d
JOIN Wards w ON w.DepartmentId = d.Id
JOIN DoctorsExaminations de ON de.WardId = w.Id
 WHERE de.Date >= DATEADD(DAY, -7, GETDATE());

-- 3
SELECT di.Name
FROM Diseases di
LEFT JOIN DoctorsExaminations de ON de.DiseaseId = di.Id
 WHERE de.Id IS NULL;

SELECT d.Name  + d.Surname AS FullName
FROM Doctors d
LEFT JOIN DoctorsExaminations de ON de.DoctorId = d.Id
 WHERE de.Id IS NULL;

-- 5
SELECT d.Name
FROM Departments d
LEFT JOIN Wards w ON w.DepartmentId = d.Id
LEFT JOIN DoctorsExaminations docE ON docE.WardId = w.Id
 WHERE docE.Id IS NULL;

-- 6
SELECT d.Surname
FROM Doctors d
JOIN Interns i ON i.DoctorId = d.Id;

-- 7.
SELECT d.Surname
FROM Doctors d
JOIN Interns i ON i.DoctorId = d.Id
 WHERE d.Salary > (SELECT Salary FROM Doctors);

-- 8. 
SELECT w.Name
FROM Wards w
 WHERE w.Places > ALL (
     SELECT w2.Places
     FROM Wards w2
     JOIN Departments d ON w2.DepartmentId = d.Id
     WHERE d.Building = 3
);

-- 9.
SELECT DISTINCT d.Surname
FROM Doctors d
JOIN DoctorsExaminations de ON de.DoctorId = d.Id
JOIN Wards w ON de.WardId = w.Id
JOIN Departments dep ON w.DepartmentId = dep.Id
 WHERE dep.Name IN ('Ophthalmology', 'Physiotherapy');

-- 10. 
SELECT DISTINCT dep.Name
FROM Departments dep
JOIN Wards w ON w.DepartmentId = dep.Id
JOIN DoctorsExaminations de ON de.WardId = w.Id
JOIN Doctors d ON de.DoctorId = d.Id
 WHERE d.Id IN (SELECT DoctorId FROM Interns)
   AND d.Id IN (SELECT DoctorId FROM Professors);

-- 11. 
SELECT d.Name + d.Surname AS FullName, dep.Name AS Department
FROM Doctors d
JOIN DoctorsExaminations de ON de.DoctorId = d.Id
JOIN Wards w ON de.WardId = w.Id
JOIN Departments dep ON w.DepartmentId = dep.Id
 WHERE dep.Financing > 20000;

-- 12. 

-- 13. 
SELECT di.Name, COUNT(de.Id) AS ExaminationsCount
FROM Diseases di
LEFT JOIN DoctorsExaminations de ON de.DiseaseId = di.Id
GROUP BY di.Name;
