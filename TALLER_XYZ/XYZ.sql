-- BASE DE DATOS XYZ
CREATE DATABASE "xyz";

-- DROP TABLES
DROP TABLE IF EXISTS public."participacion";
DROP TABLE IF EXISTS public."fidelizado";
DROP TABLE IF EXISTS public."actividad";
DROP TABLE IF EXISTS public."login";
DROP TABLE IF EXISTS public."usuario";
DROP TABLE IF EXISTS public."perfil";
DROP PROCEDURE nuevo_usuario;

-- TABLAS

CREATE TABLE "perfil" (
    perfil_id SERIAL UNIQUE,
    perf_nombre VARCHAR(50),
    perf_fecha_vigencia DATE,
    perf_descripcion TEXT,

	PRIMARY KEY (perfil_id)
);

CREATE TABLE "usuario" (
    usuario_id SERIAL UNIQUE,
    us_nombre VARCHAR(50),
    us_apellido VARCHAR(50),
    us_estado BOOL,
    us_contra VARCHAR(255),
    us_cargo VARCHAR(50),
    us_salario DECIMAL(10,2),
    us_fecha_ingreso DATE,
    perfil_id INT,

	PRIMARY KEY (usuario_id),
	FOREIGN KEY (perfil_id) REFERENCES perfil(perfil_id)
);

CREATE TABLE "login" (
	login_id SERIAL UNIQUE,
	usuario_id INT,
	log_fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (login_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id)
);

CREATE TABLE "actividad" (
	actividad_id SERIAL UNIQUE,
    act_nombre VARCHAR(100),
    atc_fecha_inicio DATE,
    act_fecha_fin DATE,

	PRIMARY KEY (actividad_id)
);

CREATE TABLE "fidelizado" (
	fidelizado_id SERIAL UNIQUE,
    usuario_id INT,
    fid_fecha DATE,
    
	PRIMARY KEY (fidelizado_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id)
);


CREATE TABLE "participacion" (
	participacion_id SERIAL UNIQUE,
    usuario_id INT,
    actividad_id INT,
    part_puntos INT,
	part_fecha DATE,

	PRIMARY KEY (participacion_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id),
    FOREIGN KEY (actividad_id) REFERENCES "actividad"(actividad_id)
);

-- STORE PROCEDURES
-- SP Nuevo Usuario
CREATE PROCEDURE nuevo_usuario(
		nombre VARCHAR(50), 
		apellido VARCHAR(50),
		estado BOOL,
		contrasenia VARCHAR(255),
		cargo VARCHAR(50),
		salario DECIMAL(10,2),
		fecha_de_ingreso DATE,
		perfil INT
	)
LANGUAGE 'plpgsql'
AS $$

BEGIN
INSERT INTO "usuario" (us_nombre, us_apellido, us_estado, us_contra, us_cargo, us_salario, us_fecha_ingreso, perfil_id) VALUES
($1, $2, $3, $4, $5, $6, $7, $8);
END;
$$;

-- PROCEDURE INICIO DE SESION
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE OR REPLACE PROCEDURE inicio_de_sesion(
    IN usuario_nombre VARCHAR(50),
	IN usuario_apellido VARCHAR(50),
    IN usuario_contras VARCHAR(255),
    OUT login_estado BOOLEAN
)
LANGUAGE 'plpgsql'
AS $$
DECLARE
    v_usuario_id INT;
    v_us_contra VARCHAR(255);
BEGIN
    -- Busca del usuario
    SELECT usuario_id, us_contra INTO v_usuario_id, v_us_contra
    FROM usuario
    WHERE us_nombre = p_username;

    -- Existe o no el usuario
    IF v_usuario_id IS NULL THEN
        login_estado := FALSE;  -- Usuario no encontrado
        RETURN;
    END IF;

    -- Validacion de contrasenia
    IF crypt(p_password, v_us_contra) = v_us_contra THEN
        -- Contraseña es correcta
        login_estado := TRUE;

        -- Registro de inicio de sesion
        INSERT INTO "login" (usuario_id)
        VALUES (v_usuario_id);
    ELSE
        -- Contra. incorrecta
        login_estado := FALSE;
    END IF;
END;
$$;

-- INSERCION DE DATOS
INSERT INTO perfil (perf_nombre, perf_fecha_vigencia, perf_descripcion) VALUES
  ('Gerente', '2024-12-31', 'Lidera equipos'),
  ('Analista de Datos', '2024-12-31', 'Extrae, limpia y analiza datos para generar insights'),
  ('Ingeniero de DevOps', '2024-12-31', 'Automatiza procesos de desarrollo y despliegue'),
  ('Arquitecto de Software', '2024-12-31', 'Diseña la estructura general de las aplicaciones'),
  ('Tester de Software', '2024-12-31', 'Asegura la calidad del software a través de pruebas'),
  ('Ciberseguridad', '2024-12-31', 'Protege los sistemas informáticos de amenazas'),
  ('Marketing', '2024-12-31', 'Planifica y ejecuta estrategias de marketing'),
  ('Ventas', '2024-12-31', 'Genera y cierra negocios'),
  ('Contabilidad', '2024-12-31', 'Gestiona los registros financieros de la empresa'),
  ('Recursos Humanos', '2024-12-31', 'Gestiona el capital humano de la empresa'),
  ('Soporte Técnico', '2024-12-31', 'Brinda asistencia técnica a los usuarios')
;


CALL nuevo_usuario('Juan', 'Perez', TRUE, 'CONTASENIA_ENCRIPTADA1', 'Gerente', 3000.00, '2022-01-15', 1);
CALL nuevo_usuario('Maria', 'Lopez', TRUE, 'CONTASENIA_ENCRIPTADA2', 'Analista', 1500.00, '2021-03-20', 2);
CALL nuevo_usuario('Carlos', 'Gomez', FALSE, 'CONTASENIA_ENCRIPTADA3', 'Desarrollador', 2000.00, '2023-07-10', 3);
CALL nuevo_usuario('Ana', 'Martinez', TRUE, 'CONTASENIA_ENCRIPTADA4', 'Contador', 1800.00, '2020-05-25', 4);
CALL nuevo_usuario('Luis', 'Fernandez', TRUE, 'CONTASENIA_ENCRIPTADA5', 'Administrador', 2500.00, '2019-11-02', 5);
CALL nuevo_usuario('Sofia', 'Gonzalez', TRUE, 'CONTASENIA_ENCRIPTADA6', 'Gerente', 3200.00, '2022-09-15', 1);
CALL nuevo_usuario('Javier', 'Hernandez', FALSE, 'CONTASENIA_ENCRIPTADA7', 'Analista', 1550.00, '2021-12-12', 2);
CALL nuevo_usuario('Clara', 'Mendoza', TRUE, 'CONTASENIA_ENCRIPTADA8', 'Desarrollador', 2100.00, '2023-01-22', 3);
CALL nuevo_usuario('Pedro', 'Vega', TRUE, 'CONTASENIA_ENCRIPTADA9', 'Contador', 1900.00, '2020-04-18', 4);
CALL nuevo_usuario('Raquel', 'Diaz', FALSE, 'CONTASENIA_ENCRIPTADA10', 'Administrador', 2600.00, '2019-09-29', 5);
CALL nuevo_usuario('Lucas', 'Alvarez', TRUE, 'CONTASENIA_ENCRIPTADA11', 'Gerente', 3300.00, '2022-03-03', 1);
CALL nuevo_usuario('Daniela', 'Romero', TRUE, 'CONTASENIA_ENCRIPTADA12', 'Analista', 1600.00, '2021-06-06', 2);
CALL nuevo_usuario('Alejandro', 'Sanchez', FALSE, 'CONTASENIA_ENCRIPTADA13', 'Desarrollador', 2200.00, '2023-08-16', 3);
CALL nuevo_usuario('Monica', 'Castro', TRUE, 'CONTASENIA_ENCRIPTADA14', 'Contador', 2000.00, '2020-02-20', 4);
CALL nuevo_usuario('Oscar', 'Ortega', TRUE, 'CONTASENIA_ENCRIPTADA15', 'Administrador', 2700.00, '2019-05-24', 5);
CALL nuevo_usuario('Liliana', 'Reyes', FALSE, 'CONTASENIA_ENCRIPTADA16', 'Gerente', 3400.00, '2022-10-08', 1);
CALL nuevo_usuario('David', 'Ruiz', TRUE, 'CONTASENIA_ENCRIPTADA17', 'Analista', 1650.00, '2021-11-14', 2);
CALL nuevo_usuario('Elena', 'Navarro', TRUE, 'CONTASENIA_ENCRIPTADA18', 'Desarrollador', 2300.00, '2023-05-09', 3);
CALL nuevo_usuario('Andres', 'Silva', FALSE, 'CONTASENIA_ENCRIPTADA19', 'Contador', 2100.00, '2020-12-30', 4);
CALL nuevo_usuario('Carolina', 'Rojas', TRUE, 'CONTASENIA_ENCRIPTADA20', 'Administrador', 2800.00, '2019-08-21', 5);


INSERT INTO "login" (usuario_id, log_fecha_hora) VALUES
(1, '2023-11-01 08:15:00'),
(2, '2023-11-01 09:20:00'),
(3, '2023-11-01 10:35:00'),
(4, '2023-11-01 11:45:00'),
(5, '2023-11-01 12:55:00'),
(6, '2023-11-01 13:05:00'),
(7, '2023-11-01 14:25:00'),
(8, '2023-11-01 15:45:00'),
(9, '2023-11-01 16:00:00'),
(10, '2023-11-01 16:15:00'),
(11, '2023-11-02 08:10:00'),
(12, '2023-11-02 09:30:00'),
(13, '2023-11-02 10:25:00'),
(14, '2023-11-02 11:40:00'),
(15, '2023-11-02 12:50:00'),
(16, '2023-11-02 13:20:00'),
(17, '2023-11-02 14:35:00'),
(18, '2023-11-02 15:55:00'),
(19, '2023-11-02 16:10:00'),
(20, '2023-11-02 17:20:00'),
(20, '2023-11-03 08:05:00'),
(12, '2023-11-03 09:15:00'),
(13, '2023-11-03 10:50:00'),
(14, '2023-11-03 11:25:00'),
(5, '2023-11-03 12:45:00'),
(6, '2023-11-03 13:35:00'),
(12, '2023-11-03 14:05:00'),
(18, '2023-11-03 15:15:00'),
(19, '2023-11-03 16:25:00'),
(11, '2023-11-03 17:10:00'),
(3, '2023-11-04 08:30:00'),
(2, '2023-11-04 09:40:00'),
(13, '2023-11-04 10:15:00'),
(4, '2023-11-04 11:20:00'),
(5, '2023-11-04 12:00:00'),
(16, '2023-11-04 13:10:00'),
(7, '2023-11-04 14:40:00'),
(8, '2023-11-04 15:20:00'),
(9, '2023-11-04 16:35:00'),
(10, '2023-11-04 17:25:00'),
(12, '2023-11-05 08:25:00'),
(12, '2023-11-05 09:55:00'),
(3, '2023-11-05 10:45:00'),
(9, '2023-11-05 11:15:00'),
(5, '2023-11-05 12:30:00'),
(16, '2023-11-05 13:45:00'),
(7, '2023-11-05 14:50:00'),
(18, '2023-11-05 15:30:00'),
(9, '2023-11-05 16:00:00'),
(2, '2023-11-05 17:00:00'),
(11, '2023-11-06 08:40:00'),
(2, '2023-11-06 09:25:00'),
(3, '2023-11-06 10:05:00'),
(14, '2023-11-06 11:45:00'),
(5, '2023-11-06 12:20:00'),
(5, '2023-11-06 13:55:00'),
(17, '2023-11-06 14:35:00'),
(18, '2023-11-06 15:10:00'),
(9, '2023-11-06 16:50:00'),
(6, '2023-11-06 17:35:00'),
(1, '2023-11-07 08:15:00'),
(12, '2023-11-07 09:05:00'),
(3, '2023-11-07 10:10:00'),
(4, '2023-11-07 11:00:00'),
(15, '2023-11-07 12:10:00'),
(13, '2023-11-07 13:40:00'),
(17, '2023-11-07 14:55:00'),
(8, '2023-11-07 15:05:00'),
(9, '2023-11-07 16:45:00'),
(7, '2023-11-07 17:15:00'),
(7, '2023-11-08 08:50:00'),
(20, '2023-11-08 09:45:00'),
(3, '2023-11-08 10:35:00'),
(4, '2023-11-08 11:25:00'),
(7, '2023-11-08 12:45:00'),
(4, '2023-11-08 13:55:00'),
(7, '2023-11-08 14:20:00'),
(18, '2023-11-08 15:25:00'),
(9, '2023-11-08 16:15:00'),
(10, '2023-11-08 17:05:00'),
(11, '2023-11-09 08:55:00'),
(2, '2023-11-09 09:35:00'),
(8, '2023-11-09 10:05:00'),
(3, '2023-11-09 11:55:00'),
(5, '2023-11-09 12:35:00'),
(16, '2023-11-09 13:45:00'),
(7, '2023-11-09 14:55:00'),
(8, '2023-11-09 15:35:00'),
(8, '2023-11-09 16:10:00'),
(9, '2023-11-09 17:30:00'),
(9, '2023-11-10 08:45:00'),
(2, '2023-11-10 09:55:00'),
(3, '2023-11-10 10:50:00'),
(2, '2023-11-10 11:25:00'),
(14, '2023-11-10 12:15:00'),
(14, '2023-11-10 13:40:00'),
(20, '2023-11-10 14:05:00'),
(13, '2023-11-10 15:10:00'),
(1, '2023-11-10 16:55:00'),
(1, '2023-11-10 17:20:00');



-- VISTAS
-- VISTA Fidelizados los cuales seran usuarios con mas de 99 puntos de participacion
CREATE OR REPLACE VIEW v_fidelizados_anuales AS
SELECT US.us_nombre AS Nombre, US.us_apellido AS Apellido
FROM "usuario" US
INNER JOIN participacion PART ON US.usuario_id = PART.usuario_id
WHERE EXTRACT(YEAR FROM PART.part_fecha) = EXTRACT(YEAR FROM NOW())
GROUP BY US.usuario_id
HAVING SUM(PART.part_puntos) >= 100;


-- vista de logins del dia
CREATE OR REPLACE VIEW v_sesiones_del_dia AS
SELECT 
    LO.login_id,
    US.usuario_id,
    US.us_nombre AS USUARIO,
    LO.log_fecha_hora AS TIEMPO_DE_LA_SESION
FROM 
    login LO
JOIN usuario US ON LO.usuario_id = US.usuario_id
WHERE LO.log_fecha_hora >= CURRENT_DATE
    	AND LO.log_fecha_hora < CURRENT_DATE + INTERVAL '1 day'
ORDER BY LO.log_fecha_hora
;

/*
CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO "usuario" (us_email, us_contra) VALUES
('email', pg_sym_encrypt('contraseñiaaaa','secret-key'))