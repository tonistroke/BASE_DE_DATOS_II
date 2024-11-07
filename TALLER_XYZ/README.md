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
- Un usuario tiene muchos inisio de secion.
- Un usuario tiene muchas fidelizaciones.
- Un usuario tiene muchas participaciones.
- Una actividad tiene muchas participaciones.
- Una actividad tiene muchas fidelizaciones.

## Desarrollo
