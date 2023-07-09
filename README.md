# Final Project Relational Database & SQL

## Description
Lorem ipsum dolor

## Entity Relation Diagram (ERD)
![ERD](./assets/ERD.jpeg "ERD")

## Syntax DDL
```sql
-- User Account Table
CREATE TABLE user_account (
  user_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  contact VARCHAR(15) NOT NULL,
  location_id INT NOT NULL,
  FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- Location Table
CREATE TABLE location (
  location_id INT PRIMARY KEY,
  city_name VARCHAR(50) NOT NULL,
  longitude FLOAT NOT NULL,
  latitude FLOAT NOT NULL
);

-- Advertisement Table
CREATE TABLE advertisement (
  ad_id INT PRIMARY KEY,
  car_id INT NOT NULL,
  user_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  FOREIGN KEY (car_id) REFERENCES car(car_id),
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

-- Car Table
CREATE TABLE car (
  car_id INT PRIMARY KEY,
  brand VARCHAR(100) NOT NULL,
  model VARCHAR(255) NOT NULL,
  body_type VARCHAR(25) NOT NULL,
  car_type VARCHAR(25) NOT NULL,
  year INT NOT NULL,
  price INT NOT NULL
);

CREATE TYPE bid_status AS ENUM ('Not Sent', 'Sent');

-- Bid Table
CREATE TABLE bid (
  bid_id INT PRIMARY KEY,
  car_id INT NOT NULL,
  user_id INT NOT NULL,
  date_bid DATE NOT NULL,
  bid_price INT NOT NULL,
  bid_status bid_status NOT NULL,
  FOREIGN KEY (car_id) REFERENCES car(car_id),
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);


```

## Dummy dataset
Dummy dataset created using Python and additional libraries. Once dummy dataset created successfully, it will import to database using Python. Check complete code and results in [here](/generate-dummy-dataset/)
## Transactional Query

## Analytical Query
