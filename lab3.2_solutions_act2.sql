CREATE TABLE `actor` (
  `actor_id` smallint UNIQUE PRIMARY KEY,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `last_update` timestamp
);

CREATE TABLE `address` (
  `address_id` smallint UNIQUE PRIMARY KEY,
  `address` varchar(50),
  `address2` varchar(50),
  `district` varchar(20),
  `city_id` smallint UNIQUE,
  `postal_code` varchar(10),
  `phone` varchar(20),
  `location` geometry,
  `last_update` timestamp
);

CREATE TABLE `category` (
  `category_id` tinyint UNIQUE PRIMARY KEY,
  `name` varchar(25),
  `last_update` timestamp
);

CREATE TABLE `city` (
  `city_id` smallint PRIMARY KEY,
  `city` varchar(50),
  `country_id` smallint UNIQUE,
  `last_update` timestamp
);

CREATE TABLE `country` (
  `country_id` tinyint UNIQUE PRIMARY KEY,
  `country` varchar(50),
  `last_update` timestamp
);

CREATE TABLE `customer` (
  `customer_id` tinyint UNIQUE PRIMARY KEY,
  `store_id` tinyint UNIQUE,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `email` varchar(50),
  `address_id` smallint UNIQUE,
  `active` tinyint(1),
  `create_date` date,
  `last_update` timestamp
);

CREATE TABLE `film` (
  `film_id` tinyint UNIQUE PRIMARY KEY,
  `title` varchar(128),
  `description` text,
  `release_year` year,
  `language_id` tinyint UNIQUE,
  `original_language_id` tinyint UNIQUE,
  `rental_duration` tinyint UNIQUE,
  `rental_rate` decimal(4,2),
  `length` smallint UNIQUE,
  `replacement_cost` decimal(5,2),
  `rating` ENUM ('G', 'PG', 'PG-13', 'R', 'NC-17'),
  `special_features` set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'),
  `last_update` timestamp
);

CREATE TABLE `film_actor` (
  `actor_id` smallint UNIQUE,
  `film_id` smallint UNIQUE,
  `last_update` timestamp,
  PRIMARY KEY (`actor_id`, `film_id`)
);

CREATE TABLE `film_category` (
  `actor_id` smallint UNIQUE,
  `category_id` tinyint UNIQUE,
  `last_update` timestamp,
  PRIMARY KEY (`actor_id`, `category_id`)
);

CREATE TABLE `film_text` (
  `film_id` smallint PRIMARY KEY,
  `title` varchar(255),
  `description` text
);

CREATE TABLE `inventory` (
  `inventory_id` mediumint UNIQUE PRIMARY KEY,
  `film_id` smallint UNIQUE,
  `store_id` tinyint UNIQUE,
  `last_update` timestamp
);

CREATE TABLE `language` (
  `language_id` tinyint UNIQUE PRIMARY KEY,
  `name` char(20),
  `last_update` timestamp
);

CREATE TABLE `payment` (
  `payment_id` smallint UNIQUE PRIMARY KEY,
  `customer_id` smallint UNIQUE,
  `staff_id` tinyint UNIQUE,
  `rental_id` int UNIQUE,
  `amount` decimal(5,2),
  `payment_date` date,
  `last_update` timestamp
);

CREATE TABLE `rental` (
  `rental_id` int PRIMARY KEY,
  `rental_date` date,
  `inventory_id` mediumint UNIQUE,
  `customer_id` smallint UNIQUE,
  `return_date` date,
  `staff_id` tinyint UNIQUE,
  `last_update` timestamp
);

CREATE TABLE `staff` (
  `staff_id` tinyint UNIQUE PRIMARY KEY,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `address_id` smallint UNIQUE,
  `picture` blob,
  `email` varchar(50),
  `store_id` tinyint UNIQUE,
  `active` tinyint(1),
  `username` varchar(16),
  `password` varchar(40),
  `last_update` timestamp
);

CREATE TABLE `store` (
  `store_id` tinyint UNIQUE PRIMARY KEY,
  `manager_staff_id` tinyint UNIQUE,
  `address_id` smallint UNIQUE,
  `last_update` timestamp
);

ALTER TABLE `address` ADD FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

ALTER TABLE `city` ADD FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `film` ADD FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`);

ALTER TABLE `film_actor` ADD FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`);

ALTER TABLE `film_actor` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `film_category` ADD FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`);

ALTER TABLE `film_category` ADD FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

ALTER TABLE `film_text` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `inventory` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `inventory` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `staff` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `staff` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `store` ADD FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`);
