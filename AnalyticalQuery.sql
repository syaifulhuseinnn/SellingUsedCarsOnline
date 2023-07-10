-- Nomor 1: Ranking popularitas model mobil berdasarkan jumlah bid
SELECT c.model, COUNT(distinct c.car_id) as count_product, COUNT(b.bid_id) as count_bid
FROM car c
LEFT JOIN advertisement a ON c.car_id = a.car_id
LEFT JOIN bid b ON a.car_id = b.car_id
GROUP BY c.model
ORDER BY count_bid DESC;

-- Nomor 2: Membandingkan harga mobil berdasarkan harga rata-rata per kota
SELECT l.city_name, c.brand, c.model, c.year, c.price, avg_price.avg_car_city
FROM car c
JOIN (
    SELECT u.location_id, AVG(c.price) AS avg_car_city
    FROM advertisement a
    JOIN user_account u ON a.user_id = u.user_id
    JOIN car c ON a.car_id = c.car_id
    JOIN location l ON u.location_id = l.location_id
    GROUP BY u.location_id
) AS avg_price ON avg_price.location_id = c.car_id
JOIN Location l ON avg_price.location_id = l.location_id
ORDER BY avg_price.avg_car_city ASC;

-- Nomor 3
SELECT c.model, b1.user_id, b1.date_bid AS first_bid_date, b2.date_bid AS next_bid_date, b1.bid_price AS first_bid_price, b2.bid_price AS next_bid_price
FROM bid b1
JOIN bid b2 ON b1.car_id = b2.car_id AND b1.date_bid < b2.date_bid
JOIN car c ON b1.car_id = c.car_id
WHERE c.model = 'Toyota Yaris'
ORDER BY b1.date_bid ASC;

-- Nomor 4
WITH avg_car_price AS (
    SELECT
        brand,
        model,
        AVG(price) AS avg_price
    FROM
        car
    GROUP BY
        brand, model
),
avg_bid_6month AS (
    SELECT
        c.brand,
        c.model,
        AVG(b.bid_price) AS avg_bid_6month
    FROM
        bid b
    JOIN
        advertisement a ON b.car_id = a.car_id
    JOIN
        car c ON a.car_id = c.car_id
    WHERE
        b.date_bid >= current_date - interval '6 months'
    GROUP BY
        c.brand, c.model
)
SELECT
    acp.brand,
    acp.model,
    acp.avg_price,
    COALESCE(ab.avg_bid_6month, 0) AS avg_bid_6month,
    acp.avg_price - COALESCE(ab.avg_bid_6month, 0) AS difference,
    (acp.avg_price - COALESCE(ab.avg_bid_6month, 0)) / acp.avg_price * 100 AS difference_percent
FROM
    avg_car_price acp
LEFT JOIN
    avg_bid_6month ab ON acp.brand = ab.brand AND acp.model = ab.model;


-- Nomor 5
SELECT
    brand,
    model,
    AVG(CASE WHEN extract(month FROM b.date_bid) = extract(month FROM current_date) - 6 THEN b.bid_price ELSE NULL END) AS m_min_6,
    AVG(CASE WHEN extract(month FROM b.date_bid) = extract(month FROM current_date) - 5 THEN b.bid_price ELSE NULL END) AS m_min_5,
    AVG(CASE WHEN extract(month FROM b.date_bid) = extract(month FROM current_date) - 4 THEN b.bid_price ELSE NULL END) AS m_min_4,
    AVG(CASE WHEN extract(month FROM b.date_bid) = extract(month FROM current_date) - 3 THEN b.bid_price ELSE NULL END) AS m_min_3,
    AVG(CASE WHEN extract(month FROM b.date_bid) = extract(month FROM current_date) - 2 THEN b.bid_price ELSE NULL END) AS m_min_2,
    AVG(CASE WHEN extract(month FROM b.date_bid) = extract(month FROM current_date) - 1 THEN b.bid_price ELSE NULL END) AS m_min_1
FROM
    car c
    JOIN advertisement a ON c.car_id = a.car_id
    JOIN bid b ON a.car_id = b.car_id
WHERE
    c.brand = 'Toyota' AND c.model = 'Toyota Agya'
    AND b.date_bid >= current_date - interval '6 months'
GROUP BY
    c.brand, c.model
ORDER BY
    c.brand, c.model;

















