DROP TABLE IF EXISTS property_info;

CREATE TABLE property_info(
id SERIAL PRIMARY KEY,
address VARCHAR(255),
value INT,
bedrooms INT,
year_built INT
);
