DROP TABLE properties;

CREATE TABLE properties(
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  bedrooms INT,
  year INT
);
