--1
SELECT D.Name, D.Surname, S.Name AS Specialization
FROM Doctors D
JOIN DoctorsSpecializations DS ON D.Id = DS.DoctorId
JOIN Specializations S ON DS.SpecializationId = S.Id;
--2
SELECT D.Surname, (D.Salary + D.Premium) AS TotalSalary
 FROM Doctors D
 LEFT JOIN Vacations V ON D.Id = V.DoctorId
WHERE V.Id IS NULL;

--3
SELECT W.Name
FROM Wards W
JOIN Departments D ON W.DepartmentId = D.Id
WHERE D.Name = 'Stark Industries';

--4
SELECT DISTINCT Dep.Name
FROM Departments Dep
JOIN Donations Don ON Dep.Id = Don.DepartmentId
JOIN Sponsors S ON Don.SponsorId = S.Id
WHERE S.Name = 'Umbrella';
--5
--
--6
SELECT DISTINCT Doc.Surname, Dep.Name AS Department
FROM Doctors Doc
JOIN DoctorsSpecializations DS ON Doc.Id = DS.DoctorId
JOIN Specializations S ON DS.SpecializationId = S.Id
JOIN Wards W ON W.DepartmentId = (SELECT TOP 1 DepartmentId FROM Wards) 
JOIN Departments Dep ON W.DepartmentId = Dep.Id;

--7
SELECT W.Name AS Ward, Dep.Name AS Department
 FROM Doctors Doc
 JOIN DoctorsSpecializations DS ON Doc.Id = DS.DoctorId
 JOIN Wards W ON W.DepartmentId = (SELECT TOP 1 DepartmentId FROM Wards)
 JOIN Departments Dep ON Dep.Id = W.DepartmentId
 WHERE Doc.Name = 'Tyler' AND Doc.Surname = 'Durden';

--8
SELECT DISTINCT Dep.Name AS Department, Doc.Surname AS Doctor
FROM Departments Dep
JOIN Donations Don ON Dep.Id = Don.DepartmentId
JOIN Doctors Doc ON 1 = 1
WHERE Don.Amount > 100000;

--9
SELECT DISTINCT Dep.Name
FROM Departments Dep
JOIN Wards W ON Dep.Id = W.DepartmentId
JOIN Doctors Doc ON 1 = 1
WHERE Doc.Premium = 0;

--10
SELECT S.Name AS Specialization
FROM Specializations S
WHERE S.Id IN (SELECT SpecializationId FROM DoctorsSpecializations);
--11
SELECT DISTINCT Dep.Name AS Department, S.Name AS Disease
FROM Departments Dep
JOIN Specializations S ON 1 = 1
WHERE 1 = 1;
--
SELECT DISTINCT Dep.Name AS Department, W.Name AS Ward
FROM Departments Dep
JOIN Wards W ON Dep.Id = W.DepartmentId;
