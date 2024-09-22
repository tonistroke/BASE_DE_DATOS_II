CREATE DATABASE `food_and_furniture`
;


CREATE TABLE food_and_furniture.`Order` (
	`OrderID` int NOT NULL AUTO_INCREMENT,
primary key (`OrderID`)
);

CREATE TABLE food_and_furniture.`Category` (
	`CategoryID` int NOT NULL AUTO_INCREMENT,
    `name` varchar(60),
primary key (`CategoryID`)
);

CREATE TABLE food_and_furniture.`Product` (
	`ProductID` int NOT NULL AUTO_INCREMENT,
    `name` varchar(60),
    `price` float,
    `CategoryID` int,
    primary key (`ProductID`),
    FOREIGN KEY (`CategoryID`) references `Category`(`CategoryID`)
);

CREATE TABLE food_and_furniture.`Food` (
	`FoodID` int NOT NULL AUTO_INCREMENT,
    `expiration_date` date,
    `calories` float,
    `ProductID` int,
    primary key (`FoodID`),
    foreign key (`ProductID`) references `Product`(`ProductID`)
);

CREATE TABLE food_and_furniture.`Furniture` (
	`FurnitureID` int NOT NULL AUTO_INCREMENT,
    `manufacture_date` date,
    `ProductID` int,
    primary key (`FurnitureID`),
    foreign key (`ProductID`) references `Product`(`ProductID`)
);

CREATE TABLE food_and_furniture.`order_line` (
	`OrderLineID` int NOT NULL AUTO_INCREMENT,
    `Cuantity` int,
    `ProductID` int,
    `OrderID` int,
    PRIMARY KEY (`OrderLineID`),
    foreign key (`ProductID`) references `Product`(`ProductID`),
    FOREIGN KEY (`OrderID`) REFERENCES `Order`(`OrderID`)
);
