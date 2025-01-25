-- Customer Table
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(255) UNIQUE
);

-- Books Table
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2),
    availability BOOLEAN NOT NULL DEFAULT TRUE
);

-- Publisher Table
CREATE TABLE Publisher (
    pub_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    ratings INTEGER CHECK (ratings BETWEEN 1 AND 5)
);

-- Transaction Table
CREATE TABLE Transaction (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer(customer_id) ON DELETE CASCADE,
    book_id INT REFERENCES Books(book_id) ON DELETE CASCADE,
    issue_date DATE NOT NULL,
    return_date DATE
);

-- Relationship Between Books and Publisher
ALTER TABLE Books
ADD COLUMN pub_id INT REFERENCES Publisher(pub_id) ON DELETE SET NULL;
-- Insert into Customer
INSERT INTO Customer (name, phone_number, email)
VALUES ('vipin', '1234567890', 'john.doe@example.com'),
       ('ram', '0987654321', 'jane.smith@example.com');



-- Insert into Publisher
INSERT INTO Publisher (name, address, ratings)
VALUES ('TechBooks', '123 Library Lane', 5),
       ('DataWorld', '456 Knowledge Ave', 4);
	   -- View all Customers
SELECT * FROM Customer;

-- View all Books
SELECT * FROM Books;

-- Join Query: Find books issued to customers
SELECT c.name AS Customer, b.title AS Book, t.issue_date, t.return_date
FROM Transaction t
JOIN Customer c ON t.customer_id = c.customer_id
JOIN Books b ON t.book_id = b.book_id;
