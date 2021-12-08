CREATE TABLE people (
	name VARCHAR(30) NOT NULL,
	has_pet BOOLEAN DEFAULT false,
	pet_type VARCHAR(10) NOT NULL,
	pet_name VARCHAR (30),
	pet_age INT
);

INSERT INTO people (name, has_pet, pet_type, pet_name, pet_age)
VALUES ('Jacob', true, 'dog', 'Misty', 10),
	   ('Ahmed', true, 'rock', 'Rockington', 100),
	   ('Peter', true, 'cat', 'Franklin', 2),
	   ('Dave', true, 'dog', 'Queso', 1);

SELECT *
FROM people;

SELECT pet_name
FROM people;

SELECT pet_type, pet_name
FROM people
WHERE pet_type= 'dog' AND pet_age < 5;

CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	city VARCHAR(30) NOT NULL,
	state VARCHAR(30) NOT NULL,
	population INT
);

SELECT *
FROM cities;

INSERT INTO cities (city, state, population)
VALUES ('Alameda', 'California', 79177),
  ('Mesa', 'Arizona', 496401),
  ('Boerne', 'Texas', 16056),
  ('Boerne', 'Texas', 16056),
  ('Anaheim', 'Texas', 352497),
  ('Tucson', 'Arizona', 535677),
  ('Garland', 'Texas', 238002);

SELECT city
FROM cities
WHERE state='Texas';

SELECT city
FROM cities
WHERE (state='California' AND population < 100000);

-- Update the table to correct the state for the city of Anaheim.
UPDATE cities
SET state = 'California'
WHERE city = 'Anaheim';

DELETE FROM cities
WHERE id = 4;

-- Drop table if exists
DROP TABLE wordassociation;

-- Create table and view column datatypes
CREATE TABLE wordassociation (
	author INT,
	word1 VARCHAR,
	word2 VARCHAR,
	source VARCHAR
);

SELECT *
FROM wordassociation;

-- Collect all rows with the word 'stone' in the 'word1' column.
SELECT *
FROM wordassociation
WHERE word1 = 'stone';

-- Collect all rows where the author is within the 0-10 range
SELECT *
FROM wordassociation
WHERE author <= 10;

-- Search for the word "pie" in both "word1" and "word2" columns
SELECT *
FROM wordassociation
WHERE word1 = 'pie' OR word2 = 'pie';

-- BONUS
-- Select all rows with a source of "BC"
SELECT *
FROM wordassociation
WHERE source = 'BC'
AND author >= 333
AND author <= 335;