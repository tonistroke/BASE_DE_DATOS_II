-- Database: biblioteca;
-- DROP DATABASE IF EXISTS biblioteca;

CREATE IF NOT EXISTS DATABASE biblioteca;

--TABLAS
CREATE TABLE PUBLIC."usuario" (
	usuario_id SERIAL UNIQUE, 
	us_nombre VARCHAR(50),
	us_rol ENUM('lector','admin'),

	PRIMARY KEY (usuario_id)
);

CREATE TABLE PUBLIC."libro" (
	libro_id SERIAL UNIQUE,
	lib_nombre VARCHAR(100),
	lb_autor VARCHAR(100), 
	genero VARCHAR(50),

	PRIMARY KEY (libro_id)
);

CREATE TABLE PUBLIC."calificacion" (
	calificacion_id SERIAL UNIQUE,
	usuario_id INT,
	libro_id INT,

	PRIMARY KEY (calificacion_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id),
	FOREIGN KEY ((libro_id)) REFERENCES "libro"(libro_id)
);

CREATE TABLE PUBLIC."estanteria" ();

--STORED PROCEDURES

-- INSERTING DATA

--VIEWS