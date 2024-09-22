Realizar una base de datos relacional de la imagen adjuntada a continuación, en el cuál aplique los conceptos aprendidos durante la clase sobre **Lenguaje de manipulación de datos** (DML) y  **Lenguaje de definición de datos** (DDL).
En cuál se le solicita:  
1. Realizar el diagrama entidad relación.
2. Realizar la base de datos de videojuegos.
3. Realizar el proceso de DML y DDL en la base de datos.

### Diagrama de relación de entidades base de datos **food_and_furniture**

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

