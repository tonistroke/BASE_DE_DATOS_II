-- BASE DE DATOS XYZ
CREATE DATABASE "xyz";

-- TABLAS
DROP TABLE IF EXISTS public."perfil";
CREATE TABLE "perfil" (
    perfil_id SERIAL UNIQUE,
    perf_nombre VARCHAR(50),
    perf_fecha_vigencia DATE,
    perf_descripcion TEXT,

	PRIMARY KEY (perfil_id)
);

DROP TABLE IF EXISTS public."usuario";
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

DROP TABLE IF EXISTS public."login";
CREATE TABLE "login" (
	login_id SERIAL UNIQUE,
	usuario_id INT,
	log_fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (login_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id)
);

DROP TABLE IF EXISTS public."actividad";
CREATE TABLE "actividad" (
	actividad_id SERIAL UNIQUE,
    act_nombre VARCHAR(100),
    atc_fecha_inicio DATE,
    act_fecha_fin DATE,

	PRIMARY KEY (actividad_id)
);

DROP TABLE IF EXISTS public."fidelizado";
CREATE TABLE "fidelizado" (
	fidelizado_id SERIAL UNIQUE,
    usuario_id INT,
    fid_fecha DATE,
    
	PRIMARY KEY (fidelizado_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id)
);

DROP TABLE IF EXISTS public."participacion";
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

-- STORE PROCEDURES && VISTAS
CREATE PROCEDURE nuevo_usuario()
LANGUAGE 'plpgsql'
AS $$

BEGIN

INSERT INTO public."usuario"()

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

/*
us_nombre` VARCHAR(60),
	`us_estado` ENUM ('Activo', 'Inactivo'),
	`us_contraseña` BIN(16),
	`` ,
	``FLOAT(3,4),
	``


CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO "usuario" (us_email, us_contra) VALUES
('email', pg_sym_encrypt('contraseñiaaaa','secret-key'))