--paso1
if not exists (SELECT 1 FROM sys.databases WHERE name = 'Trabajos')
begin
	create database Trabajos
end
go

--paso2
if exists (SELECT 1 FROM sys.databases WHERE name = 'Trabajos' )
begin
	SELECT *
	INTO Trabajos.dbo.Departamentos
	FROM HumanResources.Department;

	SELECT *
	INTO Trabajos.dbo.Cultura
	FROM Production.Culture;
end

if exists (SELECT 1 FROM sys.databases WHERE name='Trabajos')
begin

	SELECT *
	INTO Trabajos.dbo.Cultura
	FROM Production.Culture;
end


--paso3
SET IDENTITY_INSERT Trabajos.dbo.Departamentos ON;
insert into Trabajos.dbo.Departamentos (DepartmentID,Name,GroupName,ModifiedDate)
select DepartmentID,Name,GroupName,ModifiedDate 
FROM HumanResources.Department
WHERE DepartmentID NOT IN (SELECT DepartmentID FROM Trabajos.dbo.Departamentos);
SET IDENTITY_INSERT Trabajos.dbo.Departamentos Off;



insert into Trabajos.dbo.Cultura ( CultureID,Name,ModifiedDate)
select CultureID,Name,ModifiedDate
FROM Production.Culture
WHERE CultureID NOT IN (SELECT CultureID FROM Trabajos.dbo.Cultura );

