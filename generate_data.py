import psycopg2
from faker import Faker
import random
from datetime import datetime, timedelta


conn = psycopg2.connect(
    dbname="lms_db",  
    user="postgres", 
    password="Vipin@0808", 
    host="localhost", 
    port="5432"  
)
cursor = conn.cursor()

# Initialize Faker for generating fake data
fake = Faker()

# Generate and insert authors
authors = []
for _ in range(10):  # Generating 10 authors
    authors.append((fake.first_name(), fake.last_name(), fake.date_of_birth()))

cursor.executemany(
    "INSERT INTO authors (first_name, last_name, birth_date) VALUES (%s, %s, %s)",
    authors,
)

# Generate and insert books
books = []
for _ in range(20):  # Generating 20 books
    books.append((fake.word(), random.choice(['Fantasy', 'Sci-Fi', 'Romance']), random.randint(1900, 2025), random.randint(1, 10)))

cursor.executemany(
    "INSERT INTO books (title, genre, publication_year, author_id) VALUES (%s, %s, %s, %s)",
    books,
)

# Generate and insert customers
customers = []
for _ in range(15):  # Generating 15 customers
    customers.append((fake.first_name(), fake.last_name(), fake.email(), fake.phone_number(), fake.date_this_decade()))

cursor.executemany(
    "INSERT INTO customers (first_name, last_name, email, phone_number, join_date) VALUES (%s, %s, %s, %s, %s)",
    customers,
)

# Generate and insert book transactions
transactions = []
for _ in range(30):  # Generating 30 transactions
    issue_date = fake.date_this_year()
    return_date = None if random.choice([True, False]) else fake.date_this_year()
    transactions.append(
        (random.randint(1, 20), random.randint(1, 15), issue_date, return_date)
    )

cursor.executemany(
    "INSERT INTO book_transactions (book_id, customer_id, issue_date, return_date) VALUES (%s, %s, %s, %s)",
    transactions,
)

# Commit changes and close the connection
conn.commit()
cursor.close()
conn.close()