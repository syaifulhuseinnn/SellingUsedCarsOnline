-- Mencari mobil keluaran 2015 ke atas
SELECT * FROM car WHERE year >= 2015;

-- Menambahkan satu data bid produk baru
INSERT INTO bid (car_id, user_id, date_bid, bid_price, bid_status) VALUES (1,2,'2023-03-04',355500000,'Sent');

-- Mobil yang dijual oleh akun “Febi Mustofa”
SELECT c.car_id, c.brand, c.model, c.year, c.price, a.date_post
FROM car c
JOIN advertisement a ON c.car_id = a.car_id
JOIN user_account u ON a.user_id = u.user_id
WHERE u.name = 'Febi Mustofa';

-- Mencari mobil bekas yang termurah berdasarkan keyword "Yaris"
SELECT car_id, brand, model, year, price
FROM Car
WHERE LOWER(model) LIKE '%yaris%'
ORDER BY price ASC;

-- Mencari mobil bekas yang terdekat berdasarkan sebuah id kota
SELECT c.car_id, c.brand, c.model, c.year, c.price
FROM car c
JOIN advertisement a ON c.car_id = a.car_id
JOIN user_account u ON a.user_id = u.user_id
JOIN location l ON u.location_id = l.location_id
WHERE l.location_id = 3171
ORDER BY SQRT(POW(l.latitude - (-6.186486), 2) + POW(l.longitude - 106.834091, 2));
