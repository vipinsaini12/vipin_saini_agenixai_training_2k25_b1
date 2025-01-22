  Library Management System   =>                                       

# Overview =>

The **Library Management System** is designed to efficiently manage library operations, including tracking books, customers, publishers, and transactions. The goal of this project is to build a robust relational data model that ensures data integrity, handles large datasets, and supports complex queries for the management of library resources.

This project includes:
- An **Entity-Relationship (ER) Diagram** to visualize the system's structure.
- A **Relational Schema** for implementing the database.
- SQL scripts to create and manage the system.



#  Objectives =>

1. To design a relational data model for a **Library Management System**.
2. To ensure the database supports efficient management of books, authors, publishers, and transactions.
3. To demonstrate practical skills in database design, normalization, and implementation.
4. To upload and document this project on GitHub for evaluation and future development.


# Features =>

- **Customer Management**: Add, update, and manage customer details, including name, contact information, and address.
- **Book Management**: Track book details, including title, author, publisher, price, and availability.
- **Publisher Management**: Manage publisher data and associate books with their respective publishers.
- **Transaction Tracking**: Record book borrowing and return transactions with issue and return dates.



# ER Diagram =>

The **Entity-Relationship (ER) Diagram** provides a visual representation of the library's data structure, showing entities, attributes, and relationships between them.

# Key Components:
1. Customer:
   - Attributes: CustomerID, Name, Email, PhoneNumber, Address.
   - Relationships: Customers perform transactions.

2. Books:
   - Attributes: BookID, Title, Author, Price, Availability, PublisherID.
   - Relationships: Books are borrowed by customers and published by publishers.

3. Publisher:
   - Attributes: PublisherID, Name, Address, Parts, Ratings.
   - Relationships: Publishes books.

4. Transaction:
   - Attributes: TransactionID, CustomerID, BookID, IssueDate, ReturnDate, Status.
   - Relationships: Links customers and books.

---

#  Relational Schema

The relational schema derived from the ER diagram ensures proper normalization, referential integrity, and efficient data handling.
