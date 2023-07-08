-- User Account Table
CREATE TABLE user_account (
  user_id INT PRIMARY KEY,
  name VARCHAR(255),
  contact VARCHAR(255),
  location_id INT,
  FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- Location Table
CREATE TABLE location (
  location_id INT PRIMARY KEY,
  city_name VARCHAR(255),
  longitude FLOAT,
  latitude FLOAT
);

-- Advertisement Table
CREATE TABLE advertisement (
  ad_id INT PRIMARY KEY,
  car_id INT,
  user_id INT,
  title VARCHAR(255),
  FOREIGN KEY (car_id) REFERENCES car(car_id),
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

-- Car Table
CREATE TABLE car (
  car_id INT PRIMARY KEY,
  user_id INT,
  brand VARCHAR(255),
  model VARCHAR(255),
  body_type VARCHAR(255),
  car_type VARCHAR(255),
  year INT,
  price INT,
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);
