# Final Project Relational Database & SQL

## Description
Lorem ipsum dolor

## Entity Relation Diagram (ERD)
![ERD](./assets/images/ERD.png "ERD")

## Syntax DDL
```sql
-- Location Table
CREATE TABLE location (
  location_id SERIAL PRIMARY KEY,
  city_name VARCHAR(50) NOT NULL,
  latitude FLOAT NOT NULL,
  longitude FLOAT NOT NULL
);

-- Car Table
CREATE TABLE car (
  car_id SERIAL PRIMARY KEY,
  brand VARCHAR(100) NOT NULL,
  model VARCHAR(255) NOT NULL,
  body_type VARCHAR(25) NOT NULL,
  car_type VARCHAR(25) NOT NULL,
  year INT NOT NULL,
  price INT NOT NULL
);

-- User Account Table
CREATE TABLE user_account (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  contact VARCHAR(15) NOT NULL,
  location_id INT NOT NULL,
  FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- Advertisement Table
CREATE TABLE advertisement (
  ad_id SERIAL PRIMARY KEY,
  car_id INT NOT NULL,
  user_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  FOREIGN KEY (car_id) REFERENCES car(car_id),
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);


-- Bid Table
CREATE TABLE bid (
  bid_id SERIAL PRIMARY KEY,
  car_id INT NOT NULL,
  user_id INT NOT NULL,
  date_bid DATE NOT NULL,
  bid_price INT NOT NULL,
  bid_status VARCHAR(25) NOT NULL,
  FOREIGN KEY (car_id) REFERENCES car(car_id),
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);



```

## Dummy dataset
Dummy dataset created using Python and additional libraries. Once dummy dataset created successfully, it will import to database using Python. Check complete code in [here 🧑‍💻](/generate-dummy-dataset/) and results in [here 🚀](/assets/dummy-dateset)
## Transactional Query
1. Looking for cars from 2015 and up

```sql
SELECT * FROM car WHERE year >= 2015;
```
![Result](assets/images/4-1.png "Looking for cars from 2015 and up")

2. Added one new product bid record
  
```sql
INSERT INTO bid (car_id, user_id, date_bid, bid_price, bid_status) VALUES (1,2,'2023-03-04',355500000,'Sent');
```
![Result](assets/images/4-2.png "Added one new product bid record")

3. View all cars sold 1 account from the most recent
  
```sql
SELECT c.car_id, c.brand, c.model, c.year, c.price, a.date_post
FROM car c
JOIN advertisement a ON c.car_id = a.car_id
JOIN user_account u ON a.user_id = u.user_id
WHERE u.name = 'Febi Mustofa';
```
![Result](assets/images/4-3.png "View all cars sold 1 account from the most recent")

4. Search for the cheapest used cars based on keywords
  
```sql
SELECT car_id, brand, model, year, price
FROM Car
WHERE LOWER(model) LIKE '%yaris%'
ORDER BY price ASC;
```
![Result](assets/images/4-4.png "Search for the cheapest used cars based on keywords")

5. Looking for the nearest used car based on a city id, the shortest distance is calculated based on latitude longitude. Distance calculations can be calculated using the euclidean distance formula based on latitude and longitude
  
```sql
SELECT c.car_id, c.brand, c.model, c.year, c.price
FROM car c
JOIN advertisement a ON c.car_id = a.car_id
JOIN user_account u ON a.user_id = u.user_id
JOIN location l ON u.location_id = l.location_id
WHERE l.location_id = 3171
ORDER BY SQRT(POW(l.latitude - (-6.186486), 2) + POW(l.longitude - 106.834091, 2));
```
![Result](assets/images/4-5.png "Looking for the nearest used car based on a city id, the shortest distance is calculated based on latitude longitude. Distance calculations can be calculated using the euclidean distance formula based on latitude and longitude")
## Analytical Query
