create database library1;
use library1;
-- customer table =>
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,     
    Name VARCHAR(255) NOT NULL,    
    Email VARCHAR(255) UNIQUE,     
    PhoneNumber VARCHAR(15),       
    Address TEXT                  
);

-- book table =>
create table books (
bookid int primary key,
Title VARCHAR(255) NOT NULL,  
    Author VARCHAR(255),       
    Price DECIMAL(10, 2),        
    Availability BOOLEAN,        
    PublisherID int
);

-- publisher table =>
CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY,   
    Name VARCHAR(255) NOT NULL,  
    Address TEXT,                  
    Parts INT,                    
    Ratings DECIMAL(3, 2)          
);
-- transaction table =>
CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY, 
    CustomerID INT,               
    BookID INT,                    
    IssueDate DATE NOT NULL,       
    ReturnDate DATE,               
    Status VARCHAR(50),            
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
-- Relationships
-- 	Customer &Transaction: One customer can perform many transactions.
-- 	Books &Transaction: One book can appear in many transactions.
-- 	Books &Publisher: One publisher can publish many books.
