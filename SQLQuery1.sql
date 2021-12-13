------------------------------CREAR------------------------------
USE master
GO

IF DB_ID (N'GestionTrabajoTFC') is not null
DROP DATABASE GestionTrabajoTFC
GO

CREATE DATABASE GestionTrabajoTFC
ON 
( NAME = GestionTrabajoTFC_dat,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS1\MSSQL\DATA\GestionTrabajoTFC.mdf',
	SIZE = 10,
	MAXSIZE = 50,
	FILEFROWTH = 5 )
LOG ON 
(NAME = GestionTrabajoTFC_log,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS1\MSSQL\DATA\GestionTrabajoTFC.ldf',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEFROWTH = 5MB )
GO
USE GestionTrabajoTFC
GO

------------------------------TABLAS------------------------------
CREATE TABLE Usuario
(
	idUsuario int IDENTITY(1,1),
	apellidoPaterno varchar (50) not null,
	apellidoMaterno varchar (50) not null,
	nombre varchar (50) not null,
	correo varchar (50) not null,
	clave varchar (50) not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKUsuario PRIMARY KEY(idUsuario)
)

CREATE TABLE Alumno
(
	idAlumno int IDENTITY(1,1),
	matricula varchar (50) UNIQUE not null,
	apellidoPaterno varchar (50) not null,
	apellidoMaterno varchar (50) not null,
	nombre varchar(50) not null,
	RFC varchar(13) not null,
	idGrupo int not null,
	idProfesor int not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKAlumno PRIMARY KEY(idAlumno) 
)

CREATE TABLE Grupo
(
	idGrupo int IDENTITY(1,1),
	nombre varchar (50) not null,
	numeroComponentes int default null,
	fechaIngreso datetime not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKGrupo PRIMARY KEY(idGrupo) 
)

CREATE TABLE Profesor
(
	idProfesor int IDENTITY(1,1),
	apellidoPaterno varchar (50) not null,
	apellidoMaterno varchar (50) not null,
	nombre varchar(50) not null,
	RFC varchar(13) not null,
	idTribunal int not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKProfesor PRIMARY KEY(idProfesor) 
)

CREATE TABLE TFC
(
	idTFC int IDENTITY(1,1),
	orden int not null,
	fecha datetime not null,
	tema varchar (50) not null,
	idAlumno int not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKTFC PRIMARY KEY(idTFC)
)

CREATE TABLE Tribunal
(
	idTribunal int IDENTITY(1,1),
	componentes int not null,
	edificio char (5) not null,
	salon char (5) not null,
	fecha datetime not null,
	idAlumno int not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKTribunal PRIMARY KEY(idTribunal)
)

CREATE TABLE AlumnoProfesor
(
	idAlumnoProfesor int IDENTITY(1,1),
	idAlumno int not null,
	idProfesor int not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKAlumnoProfesor PRIMARY KEY(idAlumnoProfesor)
)

CREATE TABLE ProfesorTribunal
(
	idProfesorTribunal int IDENTITY(1,1),
	idProfesor int not null,
	idTribunal int not null,
	estatus bit default 1,
	idUsuarioCrea int not null,
	fechaCrea datetime not null,
	idUsuarioModifica int default null,
	fechaModifica datetime default null
	CONSTRAINT PKProfesorTribunal PRIMARY KEY(idProfesorTribunal)
)

------------------------------INDEX------------------------------
CREATE INDEX IX_Usuario ON Usuario(idUsuario)
GO
CREATE INDEX IX_Alumno ON Alumno(idAlumno)
GO
CREATE INDEX IX_Grupo ON Grupo(idGrupo)
GO
CREATE INDEX IX_Profesor ON Profesor(idProfesor)
GO
CREATE INDEX IX_TFC ON TFC(idTFC)
GO
CREATE INDEX IX_Tribunal ON Tribunal(idTribunal)
GO
CREATE INDEX IX_AlumnoProfesor ON AlumnoProfesor(idAlumnoProfesor)
GO
CREATE INDEX IX_ProfesorTribunal ON ProfesorTribunal(idProfesorTribunal)
GO

------------------------------RELACIONES------------------------------

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Alumno 
ADD CONSTRAINT FKAlumnoGrupo 
FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo)
GO

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoProfesor 
FOREIGN KEY (idProfesor) REFERENCES Profesor(idProfesor)
GO

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Grupo
ADD CONSTRAINT FKGrupoUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Grupo
ADD CONSTRAINT FKGrupoUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorTribunal
FOREIGN KEY (idTribunal) REFERENCES Tribunal(idTribunal)
GO

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE TFC
ADD CONSTRAINT FKTFCAlumno 
FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)
GO

ALTER TABLE TFC
ADD CONSTRAINT FKTFCUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE TFC
ADD CONSTRAINT FKTFCUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Tribunal
ADD CONSTRAINT FKTribunalAlumno 
FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)
GO

ALTER TABLE Tribunal
ADD CONSTRAINT FKTribunalUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE Tribunal
ADD CONSTRAINT FKTribunalUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorAlumno 
FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)
GO

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorProfesor 
FOREIGN KEY (idProfesor) REFERENCES Profesor(idProfesor)
GO

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalProfesor 
FOREIGN KEY (idProfesor) REFERENCES Profesor(idProfesor)
GO

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalTribunal 
FOREIGN KEY (idTribunal) REFERENCES Tribunal(idTribunal)
GO

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO

---------------POBLAR
------------------------------Insertar Registros------------------------------
INSERT INTO Usuario (apellidoPaterno, apellidoMaterno, nombre)
VALUES ('Garcia',' Munoz', 'Daniela'),
	   ('Garcia',' Munoz', 'Andrea'),
	   ('Garcia',' Munoz', 'Luis')

INSERT INTO Alumno (apellidoPaterno, apellidoMaterno, nombre)
VALUES ('Marmolejo',' Ibarra',' Santiago'),
	   ('Velazquez',' Juarez',' Alonso'),
	   ('Fernandez',' Lopez',' Maria')

--Seleccionar la informacion de las tablas, para verificar que los datos en los reg sean correctos--
SELECT * FROM Alumno
SELECT * FROM Profesor
SELECT * FROM Tribunal

--Actualizar algunos datos--
UPDATE Alumno set nombre = 'cambio' WHERE idAlumno = 1

--Seleccionar la informacion de las tablas, para verificar que los datos en los reg sean correctos--
SELECT * FROM Alumno
SELECT * FROM Profesor
SELECT * FROM Tribunal

--Para cambiar el valor de un campo de IDentity--
--DBCC CHECKIDENT (Profesor, RESED, 0)

--Borrar Registros CUIDADO!!!!!!!!!!!!!!--
DELETE FROM Alumno WHERE idAlumno = 1
DELETE FROM Grupo WHERE idGrupo = 1

--Seleccionar la informacion de las tablas, para verificar que los datos en los reg sean correctos--
SELECT * FROM Alumno
SELECT * FROM Grupo

select GETDATE()
GO

------------------------------VISTA------------------------------
CREATE VIEW vwListaProfesores as 
select idProfesor,  CONCAT(nombre, '', apellidoPaterno, '', apellidoMaterno) as 'Nombre Completo' from Profesor where estatus = 1
GO

SELECT * FROM vwListaProfesores

USE [GestionTrabajoTFC]
GO