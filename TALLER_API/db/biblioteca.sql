-- Database: biblioteca;
-- DROP DATABASE IF EXISTS biblioteca;

-- CREATE IF NOT EXISTS DATABASE biblioteca;

-- DROPPING TABLES DEBUG
	-- DROP TABLE "estanteria";
	-- DROP TABLE "calificacion";
	-- DROP TABLE "usuario";
	-- DROP TABLE "libro";

-- _____________________________________________ TABLES _____________________________________________
--DROP TYPE user_rol;
CREATE TYPE user_rol AS ENUM('lector','admin');
CREATE TABLE PUBLIC."usuario" (
	usuario_id SERIAL UNIQUE, 
	us_nombre VARCHAR(50),
	us_rol user_rol DEFAULT 'lector',
	us_pass TEXT,
	us_activo BOOL DEFAULT true,

	PRIMARY KEY (usuario_id)
);

CREATE TABLE PUBLIC."libro" (
	libro_id SERIAL UNIQUE,
	lib_nombre VARCHAR(100),
	lib_autor VARCHAR(100), 
	lib_genero VARCHAR(50),

	PRIMARY KEY (libro_id)
);

-- DROP TYPE cal_rating;
CREATE TYPE cal_rating AS ENUM('Quémenlo!', 'Malo', 'Decente', 'Bueno', 'Exelente');
CREATE TABLE PUBLIC."calificacion" (
	calificacion_id SERIAL UNIQUE,
	usuario_id INT,
	libro_id INT,
	cal_us_review TEXT,
	calificacion cal_rating,
	
	PRIMARY KEY (calificacion_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id),
	FOREIGN KEY (libro_id) REFERENCES "libro"(libro_id)
);

CREATE TABLE PUBLIC."estanteria" (
	estanteria_id SERIAL UNIQUE,
	usuario_id INT,
	libro_id INT,

	PRIMARY KEY (estanteria_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id),
	FOREIGN KEY (libro_id) REFERENCES "libro"(libro_id)
);


-- FUNCTION HASHING PASSWORD
CREATE EXTENSION pgcrypto; -- Extension pgcrypto para funcion gen_random_bytes
CREATE OR REPLACE FUNCTION hash_password(password TEXT)
RETURNS TEXT AS $$
DECLARE
    salt TEXT;
    hashed_password TEXT;
BEGIN
    SELECT gen_random_bytes(16) INTO salt;
    hashed_password := crypt(password, salt);
    RETURN hashed_password;
END;
$$ LANGUAGE 'plpgsql';

-- _____________________________________________STORED PROCEDURES_____________________________________________

-- SP insertar nuevo usuario
CREATE OR REPLACE PROCEDURE nuevo_usuario(VARCHAR(50), VARCHAR(50)) -- character varying
LANGUAGE 'plpgsql'
AS $$

BEGIN
INSERT INTO "usuario" (us_nombre, us_pass)VALUES
($1, hash_password($2));
END;
$$;
-- USO --> CALL nuevo_usuario('toni', 'pass123');

-- SP es usuario admin?

-- SP iniciar sesion

-- SP insertar libro
CREATE OR REPLACE FUNCTION insertar_libro(
    p_lib_nombre VARCHAR(100),
    p_lib_autor VARCHAR(100),
    p_lib_genero VARCHAR(50)
) RETURNS VOID 
LANGUAGE 'plpgsql'
AS $$
BEGIN
    INSERT INTO "libro" (lib_nombre, lib_autor, lib_genero)
    VALUES (p_lib_nombre, p_lib_autor, p_lib_genero);
END;
$$;
-- USO --> SELECT insert_libro('Book Title', 'Author Name', 'Genre');

-- ADMIN SP eliminar libro
CREATE OR REPLACE FUNCTION delete_libro (p_libro_id INT) RETURNS VOID
 LANGUAGE 'plpgsql'
AS $$
BEGIN
    DELETE FROM "libro"
    WHERE libro_id = p_libro_id;
END;
$$;
-- USO --> SELECT delete_libro(1);


-- SP Libros por genero
CREATE OR REPLACE FUNCTION libros_by_genero(p_lib_genero VARCHAR(50)) 
RETURNS TABLE (
    libro_id INT,
    lib_nombre VARCHAR,
    lib_autor VARCHAR,
    lib_genero VARCHAR
) AS $$
BEGIN
    RETURN QUERY 
    SELECT libro_id, lib_nombre, lib_autor, lib_genero
    FROM "libro"
    WHERE lib_genero = p_lib_genero;
END;
$$ LANGUAGE plpgsql;


-- _____________________________________________ VIEWS _____________________________________________

-- Vista lista de usuarios
CREATE VIEW lista_usuarios AS 
SELECT us_nombre FROM "usuario";
-- USO --> SELECT * FROM lista_usuarios;

CREATE VIEW lista_libros AS 
SELECT lib_nombre, lib_autor, lib_genero FROM "libro";
-- USO --> SELECT * FROM lista_libros;


-- _____________________________________________ INSERT DATOS _____________________________________________

-- Libros
SELECT insertar_libro('Cien años de soledad', 'Gabriel García Márquez', 'Realismo mágico');
SELECT insertar_libro('Don Quijote de la Mancha', 'Miguel de Cervantes', 'Novela picaresca');
SELECT insertar_libro('Rayuela', 'Julio Cortázar', 'Literatura latinoamericana');
SELECT insertar_libro('Los Miserables', 'Victor Hugo', 'Realismo');
SELECT insertar_libro('El Aleph', 'Jorge Luis Borges', 'Ficción');
SELECT insertar_libro('El túnel', 'Ernesto Sábato', 'Novela existencialista');
SELECT insertar_libro('La metamorfosis', 'Franz Kafka', 'Existencialismo');
SELECT insertar_libro('One Hundred Years of Solitude', 'Gabriel García Márquez', 'Magical realism');

-- Usuarios
-- _____________________________________________ INSERTING DATA _____________________________________________
-- Insertando usuarios administradores
INSERT INTO "usuario" (us_nombre, us_rol, us_pass) VALUES
('toni', 'admin', 'Tpass123'),
('John', 'admin', 'Jpass'),
('K', 'admin', 'Kpass')
;