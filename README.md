Realizar una base de datos relacional de la imagen adjuntada a continuación, en el cuál aplique los conceptos aprendidos durante la clase sobre **Lenguaje de manipulación de datos** (DML) y  **Lenguaje de definición de datos** (DDL).
En cuál se le solicita:  
1. Realizar el diagrama entidad relación.
2. Realizar la base de datos de videojuegos.
3. Realizar el proceso de DML y DDL en la base de datos.

## Diagrama de relación de entidades base de datos `food_and_furniture`

```mermaid
---
title: Food and furnitures
---
erDiagram
	Order ||--o{ order_line : has
	Order { 
		int OrderID
	}
	order_line o{--|| Product : has
	order_line {
		int order_lineID
		int Cuantity
		int ProductID
		int OrderID
	}
	Product o{--|| Category : has
	Product ||--o{ Furniture : has_some
	Product ||--o{ Food : has_some
	Product{
		int ProductId
		string name
		float price
		int CategoryID
	}
	Category{
		int CategoryID
		string name
	}
	Furniture{
		int FurnitureID
		date manufacture_date
		int ProductID
	}
	Food{
		int Food
		date expiration_date
		float calories
		int ProductID
	}

```

Se le solicita:  
1. Realizar el diagrama entidad relación.
2. Realizar la base de datos de videojuegos.
3. Realizar el proceso de DML y DDL en la base de datos.

## Base de datos `hunter_cliker`

#### Diagrama entidad relación
```mermaid
---
title: Videojuego hunter_cliker
---
erDiagram
	jugadores ||--o{ logros_obtenidos : tiene
	logros_obtenidos }o--|| logros : tiene
	jugadores ||-- o{ no_jugables : companieros
	jugadores ||--o{ inventarios : tiene
	inventarios }o--|| armas_y_herramientas : tiene
	no_jugables ||--o{ armas_y_herramientas : tiene
	
	
	
```

#### Procesos DML utilizados:
`INSERT`: Al insertar datos en las distintas tablas
```sql
INSERT INTO hunter_cliker.`logros`(`nombre_del_logro`,`experiencia`) VALUES
	("Consigue tu primera arma", 20),
	("Derrota tu primer enemigo", 50),
	("Abrir el inventario", NULL),
	("Primer nivel desbloqueado", 100);
```

`SELECT`: Al inspeccionar las tablas y columnas
```sql
SELECT jugador_id FROM hunter_clicker.jugadores ;
```
#### Procesos DDL utilizados:
Uso del `CREATE`  en:
1. La creación de la base de datos
```sql
CREATE DATABASE `hunter_clicker` ;
```

2. La creación de tablas
```sql
CREATE TABLE hunter_clicker.`jugadores` (
	`jugador_id` INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`jugador_id`)
) ;
```

