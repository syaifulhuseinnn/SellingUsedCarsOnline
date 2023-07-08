from generate_dummy_dataset import *

# Establish a connection to the PostgreSQL database
connection = psycopg2.connect(
    host="localhost",
    database="PACMANN_FINAL_PROJECT",
    user="postgres",
    password="onyu$rcu"
)

dummy_dataset_dict = [
    {
        "filename": "user_dummy_dataset.csv",
        "table_name": "user_account",
        "column_names": ["user_id", "name", "contact", "location_id"]
    },
    {
        "filename": "ads_dummy_dataset.csv",
        "table_name": "advertisement",
        "column_names": ["ad_id", "car_id", "user_id", "title"]
    },
    {
        "filename": "bid_dummy_dataset.csv",
        "table_name": "bid",
        "column_names": ["bid_id", "car_id", "user_id",
                         "date_bid", "bid_price", "bid_status"]
    }
]

# Generate dummy dataset
generate_dummy_user()
generate_dummy_ads()
generate_dummy_bid()

# Import dummy dataset to database
for i in range(len(dummy_dataset_dict)):
    import_dummy_dataset(connection, dummy_dataset_dict[i]["filename"],
                         dummy_dataset_dict[i]["table_name"], dummy_dataset_dict[i]["column_names"])


# Close the database connection
connection.close()
