import random
import csv
import uuid
import psycopg2
from psycopg2 import sql
from faker import Faker

# Instantiate Faker object
fake = Faker('id_ID')


def generate_dummy_user():
    # Generate dummy data
    num_records = 100  # Number of records to generate
    header = ['user_id', 'name', 'contact', 'location_id']
    data = []

    # Read city data from city.csv
    with open('../assets/city.csv', 'r') as city_file:
        city_reader = csv.DictReader(city_file)
        cities = list(city_reader)

        # Generate dummy data with location_id from city data
        for i in range(num_records):
            city = random.choice(cities)
            location_id = city['kota_id']
            data.append([i+1, fake.name(), fake.msisdn(), location_id])

    # Export data to CSV file
    filename = '../assets/user_dummy_dataset.csv'
    with open(filename, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(header)
        writer.writerows(data)

    print(f"Dummy dataset created and exported as {filename}")


def generate_dummy_ads():
    # Read car_product.csv
    car_data = []
    with open('../assets/car_product.csv', 'r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            car_data.append(row)

    # Read user_dummy_dataset.csv
    user_data = []
    with open('../assets/user_dummy_dataset.csv', 'r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            user_data.append(row)

    # Instantiate Faker object
    fake = Faker('id_ID')

    # Generate dummy dataset
    header = ['ad_id', 'car_id', 'user_id', 'title', 'date_post']
    data = []
    for i in range(1, 101):  # Generate 50 records
        ad_id = i
        car_id = random.randint(1, 50)
        user_id = random.choice(user_data)['user_id']
        title = f"Dijual {car_data[car_id - 1]['model']} transmisi {car_data[car_id - 1]['car_type']} tahun {car_data[car_id - 1]['year']}"
        date_post = fake.date_between(start_date='-1y', end_date='today')
        data.append([ad_id, car_id, user_id, title, date_post])

    # Export data to CSV file
    filename = '../assets/ads_dummy_dataset.csv'
    with open(filename, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(header)
        writer.writerows(data)

    print(f"Dummy dataset created and exported as {filename}")


def generate_dummy_bid():
    # Read car_product.csv
    car_data = []
    with open('../assets/car_product.csv', 'r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            car_data.append(row)

    # Read user_dummy_dataset.csv
    user_data = []
    with open('../assets/user_dummy_dataset.csv', 'r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            user_data.append(row)

    # Instantiate Faker object
    fake = Faker('id_ID')

    # Generate dummy dataset
    header = ['bid_id', 'car_id', 'user_id',
              'date_bid', 'bid_price', 'bid_status']
    data = []
    for i in range(1, 151):  # Generate 150 records
        bid_id = i
        car_id = random.choice(car_data)['product_id']
        user_id = random.choice(user_data)['user_id']
        date_bid = fake.date_between(start_date='-1y', end_date='today')
        bid_price = random.randint(90_000_000, 500_000_000)
        bid_status = random.choice(['Sent'])
        data.append([bid_id, car_id, user_id, date_bid, bid_price, bid_status])

    # Export data to CSV file
    filename = '../assets/bid_dummy_dataset.csv'
    with open(filename, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(header)
        writer.writerows(data)

    print(f"Dummy dataset created and exported as {filename}")


def import_dummy_dataset(connection, filename, table_name, column_names):
    path = f'/Users/syaifulhusein/Documents/codes/PACMANN/SQL/Final Project/assets/{filename}'

    with open(path, 'r') as file:
        cursor = connection.cursor()

        # Create the COPY SQL statement
        copy_sql = sql.SQL("COPY {} ({}) FROM STDIN WITH (FORMAT CSV, HEADER)").format(
            sql.Identifier(table_name),
            sql.SQL(', ').join(map(sql.Identifier, column_names))
        )

        # Execute the COPY command
        cursor.copy_expert(copy_sql, file)

        connection.commit()
        cursor.close()

    print(f"{table_name} data imported successfully!")
