CREATE SCHEMA sistema_db;

CREATE  TABLE calificaciones ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	parcial1             INT UNSIGNED      ,
	parcial2             INT UNSIGNED      ,
	parcial3             INT UNSIGNED      ,
	extraordinario       INT UNSIGNED      ,
	id_materia           INT UNSIGNED NOT NULL     ,
	id_alumno            INT UNSIGNED NOT NULL     
 ) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE domicilio ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	calle                VARCHAR(255)       ,
	colonia              VARCHAR(255)       ,
	numero               VARCHAR(10)       
 ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE materias ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	clave_materia        VARCHAR(10)  NOT NULL     ,
	nombre               VARCHAR(255)  NOT NULL     ,
	cuatrimestre         INT UNSIGNED NOT NULL     
 ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE usuarios ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	nombre_completo      VARCHAR(255)  NOT NULL     ,
	correo_electronico   VARCHAR(255)  NOT NULL     ,
	password             VARCHAR(255)  NOT NULL     ,
	id_rol               INT UNSIGNED NOT NULL     
 ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE alumnos ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	matricula            VARCHAR(10)  NOT NULL     ,
	nombre               VARCHAR(255)  NOT NULL     ,
	apellido_paterno     VARCHAR(255)  NOT NULL     ,
	apellido_materno     VARCHAR(255)  NOT NULL     ,
	genero               INT  NOT NULL     ,
	fecha_nacimiento     DATE  NOT NULL     ,
	id_domicilio         INT UNSIGNED NOT NULL     
 ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE INDEX fk_alumnos_domicilio ON alumnos ( id_domicilio );

ALTER TABLE alumnos ADD CONSTRAINT fk_alumnos_domicilio FOREIGN KEY ( id_domicilio ) REFERENCES domicilio( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 100, 100, null, null, 1, 1);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 90, 100, null, null, 1, 2);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 80, 99, null, null, 1, 3);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 80, 99, null, null, 1, 4);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 70, 80, null, null, 1, 5);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 100, 80, null, null, 1, 6);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 100, null, null, null, 2, 1);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 90, null, null, null, 2, 2);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 90, null, null, null, 2, 3);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 80, null, null, null, 2, 4);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 70, null, null, null, 2, 5);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 100, null, null, null, 2, 6);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 100, null, null, null, 3, 1);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 80, null, null, null, 3, 2);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 90, null, null, null, 3, 3);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 80, null, null, null, 3, 4);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 70, null, null, null, 3, 5);
INSERT INTO calificaciones( parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno ) VALUES ( 80, null, null, null, 3, 6);
INSERT INTO domicilio( calle, colonia, numero ) VALUES ( 'Principal', 'Benito Juarez', '13');
INSERT INTO domicilio( calle, colonia, numero ) VALUES ( 'Avenida 1', 'Pedro Juarez', '14');
INSERT INTO domicilio( calle, colonia, numero ) VALUES ( 'Avenida 2', 'Benito Juarez', '11');
INSERT INTO domicilio( calle, colonia, numero ) VALUES ( 'Avenida 2', 'Benito Juarez', '11');
INSERT INTO domicilio( calle, colonia, numero ) VALUES ( 'Principal 2', 'Quintano Roo', '123');
INSERT INTO domicilio( calle, colonia, numero ) VALUES ( 'Principal 3', 'Quintano Roo 2', '321');
INSERT INTO domicilio( calle, colonia, numero ) VALUES ( 'Central', 'Benito Juarez', '23');
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '001-01', 'Español 1', 1);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '002-01', 'Matemáticas 1', 1);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '003-01', 'Programación 1', 1);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '001-02', 'Español 2', 2);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '002-02', 'Matemáticas 2', 2);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '003-02', 'Programación 2', 2);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '001-03', 'Español 3', 3);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '002-03', 'Matemáticas 3', 3);
INSERT INTO materias( clave_materia, nombre, cuatrimestre ) VALUES ( '003-03', 'Programación 3', 3);
INSERT INTO usuarios( nombre_completo, correo_electronico, password, id_rol ) VALUES ( 'Juan Perez', 'juan.perez@email.com', '$2b$10$LZ4ehwSwSb/TGbgETwXxcuR1AW5hm0jCE11cqVk3H5tMraxXuPQX.', 1);
INSERT INTO alumnos( matricula, nombre, apellido_paterno, apellido_materno, genero, fecha_nacimiento, id_domicilio ) VALUES ( '15356564', 'Alexis J.', 'Cortes', 'del Carmen', 1, '1999-11-13', 1);
INSERT INTO alumnos( matricula, nombre, apellido_paterno, apellido_materno, genero, fecha_nacimiento, id_domicilio ) VALUES ( '15335623', 'Juan', 'Hernandez', 'Hernandez', 1, '1998-01-11', 2);
INSERT INTO alumnos( matricula, nombre, apellido_paterno, apellido_materno, genero, fecha_nacimiento, id_domicilio ) VALUES ( '15335624', 'Pedro', 'Gomez', 'Gomez', 1, '2000-11-12', 4);
INSERT INTO alumnos( matricula, nombre, apellido_paterno, apellido_materno, genero, fecha_nacimiento, id_domicilio ) VALUES ( '15353524', 'Luna', 'Hernandez', 'Hernandez', 2, '1999-02-11', 5);
INSERT INTO alumnos( matricula, nombre, apellido_paterno, apellido_materno, genero, fecha_nacimiento, id_domicilio ) VALUES ( '15126564', 'Juan Pablo', 'Gutierrez', 'Gutierrez', 1, '1998-12-12', 1);
INSERT INTO alumnos( matricula, nombre, apellido_paterno, apellido_materno, genero, fecha_nacimiento, id_domicilio ) VALUES ( '15256522', 'Karla', 'Hernandez', 'Arvizu', 2, '1999-02-11', 7);
