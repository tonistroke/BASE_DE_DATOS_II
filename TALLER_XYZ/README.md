# TALLER XYZ
Se solicita implementar una base de datos para la empresa XYZ, en cuál se debe realizar el diagrama entidad relación e inserta la información basándonos en el siguiente criterio:
1. El sistema cuenta con los módulos de: Usuarios, Perfiles, Fidelización, Login u otras tablas intermedias.
2. La empresa cuenta muchos colaboradores, en el cuál cada usuario tiene (nombre, apellido, estado, contraseña, cargo, salario, fecha_ingreso y un perfil)
3. La empresa necesita que el sistema de base de datos maneje un sistema login y guarde cada inicio de sesión de cada usuario en la tabla de login
4. En el módulo “fideliza a tu personal”, en el cual busca manejar todos los registros de los usuarios con base en las diferentes actividades realizadas por la empresa.
5. La empresa cada 15 días hace actividades en el cual sus colaboradores participan y acumulan puntos. En dicha actividades se le solicita y se guarda información de los usuarios.
6. Los perfiles de los usuarios están basados en roles (nombre, fecha de vigencia, descripción y un encargado).
7. La información de fidelización está relacionada con los perfiles y los usuarios.    
8. Agregar Vista y Procedimiento Almacenados.

## Planeamiento


![Modelo relacional BD XYZ](XYZ-DER.png)

Modelo Relacional

Donde las relaciones son:
- Un usuario tiene un perfil.
- Un usuario tiene muchos inicio de sesión..
- Un usuario tiene muchas fidelizaciones.
- Un usuario tiene muchas participaciones.
- Una actividad tiene muchas participaciones.
- Una actividad tiene muchas fidelizaciones.

## Desarrollo
Tabla principal `usuario`
```sql
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
```

Tabla login
```sql
CREATE TABLE "login" (
	login_id SERIAL UNIQUE,
	usuario_id INT,
	log_fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (login_id),
	FOREIGN KEY (usuario_id) REFERENCES "usuario"(usuario_id)
);
```
Al insertar un nuevo **inicio de sesión** se guardará en la tabla `login`, el id de usuario junto con la fecha y hora actual.

Stored procedure `nuevo_usuario` la cual funcionara para insertar nuevos usuarios en la base de datos.
```sql
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
```

SP `nuevo_usuario` siendo utilizado para insertar un usuario en la tabla `usuario`
```sql
CALL nuevo_usuario('Raquel', 'Diaz', FALSE, 'CONTASENIA_ENCRIPTADA10', 'Administrador', 2600.00, '2019-09-29', 5);
```

Vistas fidelizados los cuales serán los usuarios con más de 99 puntos
```sql
CREATE OR REPLACE VIEW v_fidelizados_anuales AS
SELECT US.us_nombre AS Nombre, US.us_apellido AS Apellido
FROM "usuario" US
INNER JOIN participacion PART ON US.usuario_id = PART.usuario_id
WHERE EXTRACT(YEAR FROM PART.part_fecha) = EXTRACT(YEAR FROM NOW())
GROUP BY US.usuario_id
HAVING SUM(PART.part_puntos) >= 100;

```

Vista para mostrar los inicios de sesión del día:
```sql
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
```