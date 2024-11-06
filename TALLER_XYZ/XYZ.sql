CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    estado ENUM('activo', 'inactivo'),
    contrasena VARCHAR(255),
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    fecha_ingreso DATE,
    id_perfil INT,
    FOREIGN KEY (id_perfil) REFERENCES Perfiles(id_perfil)
);

CREATE TABLE Perfiles (
    id_perfil INT PRIMARY KEY,
    nombre VARCHAR(50),
    fecha_vigencia DATE,
    descripcion TEXT,
    id_encargado INT,
    FOREIGN KEY (id_encargado) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Logins (
    id_login INT PRIMARY KEY,
    id_usuario INT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Actividades (
    id_actividad INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Participaciones (
    id_participacion INT PRIMARY KEY,
    id_usuario INT,
    id_actividad INT,
    puntos INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_actividad) REFERENCES Actividades(id_actividad)
);


ALTER TABLE Participaciones ADD COLUMN fecha DATE;

CREATE TABLE Fidelizados (
    id_fidelizado INT PRIMARY KEY,
    id_usuario INT,
    fecha_fidelizacion DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

