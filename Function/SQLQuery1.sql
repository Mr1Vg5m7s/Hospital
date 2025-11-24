--use HospitalDB_12_MrV
--go

create function DateOfWeek(@day datetime)
returns nvarchar(15)
as 
begin
	declare @wday nvarchar(15)
	if (DATENAME (dw,@day)='Monday')
		set @wday = 'Понеділок'
	return @wday
end
Thuesday
select [dbo].DateOfWeek(GETDATE()) as 'Day of week';

create function MaxSalaryDoc()
returns money
as
begin
	declare @maxSal money
	set @maxSal = (select MAX(Salary) from Doctors)
	return @maxSal --dd
end

select [dbo].MaxSalaryDoc()
--
create function DoctorsExaminationsS()
returns table
as
return(select d.Surname, d.Name, count(de.DoctorId) as 'Count exam' 
		from Doctors D
		LEFT JOIN DoctorsExaminations de 
		on d.Id = de.DoctorId
		group by d.Surname, d.Name)

select * from dbo.DoctorsExaminationsS()
where [Count exam] =  (select MAX([Count exam]) from dbo.DoctorsExaminationsS())

--
create function DoctorExamDiseases(@nameDisaeses nvarchar(50))
returns @tableDocExamDiseases table(FullName nvarchar(50), [Count] int)
as
begin
	insert @tableDocExamDiseases select d.Surname + ' ' + d.Name, count(di.Id)
								 from Doctors d
								 JOIN DoctorsExaminations de on d.Id=de.DoctorId
								 JOIN Diseases di on de.DiseaseId=di.Id
								 where di.Name = @nameDisaeses
								 group by d.Surname + ' ' + d.Name, di.Name
	return
end

select * from dbo.DoctorExamDiseases('COVID-19')
--имена докторив яки працюют в пeвном видиленни как парамент
create function DoctorsInDepartmnets(@nameDep nvarchar(50))
returns table
as
	return (select D.Surname, D.Name
			from Doctors D
			join DoctorsExaminations de on d.Id=de.DoctorId
			join Wards W on W.Id=de.WardId
			join Departments dep on W.DepartmentId=dep.Id
			where dep.Name = @nameDep)


--select * from dbo.DoctorsInDepartmnets('----')

--
create proc sp_summa
@a int, @b int
as
	declare @res int
	set @res = @a + @b
	return @res

declare @s int
exec @s = sp_summa @a=5,@b=6
print(@s)