CREATE DATABASE `hunter_cliker`
;

CREATE TABLE hunter_cliker.logros (
	`logro_id` INT NOT NULL AUTO_INCREMENT,
	`nombre_del_logro` VARCHAR(255) NOT NULL,
	`experiencia` INT,
	
    PRIMARY KEY (`logro_id`)
);

CREATE TABLE hunter_cliker.jugadores (
	`jugador_id` INT NOT NULL AUTO_INCREMENT,
    `jugador_nombre` VARCHAR(55) NOT NULL,
    `jugador_nivel` INT,
    
    PRIMARY KEY (`jugador_id`)
);

CREATE TABLE hunter_cliker.logros_obtenidos (
	`logros_obtenidos_id` INT NOT NULL AUTO_INCREMENT,
    `jugador_id` INT,
    `logro_id` INT,
    
    PRIMARY KEY (`logros_obtenidos_id`),
    FOREIGN KEY (`jugador_id`) REFERENCES `jugadores`(`jugador_id`),
    FOREIGN KEY (`logro_id`) REFERENCES `logros`(`logro_id`)
);

CREATE TABLE hunter_cliker.no_jugables (
	`npc_id` INT NOT NULL AUTO_INCREMENT,
	`npc_nombre` VARCHAR(55) NOT NULL,
	`npc_tipo` ENUM('enemigo','neutral'),
	`daño_base` INT,
	`jugador_companiero` INT,
	
    PRIMARY KEY (`npc_id`),
	FOREIGN KEY (`jugador_companiero`) REFERENCES `jugadores`(`jugador_id`)
);

CREATE TABLE hunter_cliker.armas_y_herramientas (
	`ar_her_id` INT NOT NULL AUTO_INCREMENT,
    `ar_her_nombre` VARCHAR(55) NOT NULL,
    `ar_her_daño` INT,
    `npc_id` INT,
    
    PRIMARY KEY (`ar_her_id`)
);

CREATE TABLE hunter_cliker.inventarios (
	`inventario_id` INT NOT NULL AUTO_INCREMENT,
    `jugador_id` INT,
    `ar_her_id` INT,
    
    PRIMARY KEY (`inventario_id`),
    FOREIGN KEY (`jugador_id`) REFERENCES `jugadores`(`jugador_id`),
    FOREIGN KEY (`ar_her_id`) REFERENCES `armas_y_herramientas`(`ar_her_id`)
);


# --------------------------------------

select * from hunter_cliker.logros;
INSERT INTO hunter_cliker.`logros`(`nombre_del_logro`,`experiencia`) VALUES
("Consigue tu primera arma", 20),
("Derrota tu primer enemigo", 50),
("Abrir el inventario", NULL),
("Primer nivel desbloqueado", 100);

INSERT INTO `jugadores`(`jugador_nombre`, `jugador_nivel`) VALUES
("Adam", 30),
("John", 1);
