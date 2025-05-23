# Library Management System

## Project Description

This Library Management System is a comprehensive relational database designed to manage all aspects of a library's operations. The database supports:

- Book inventory management
- Member registration and tracking
- Book lending and return processing
- Fine management for late returns
- Multiple library branches
- Staff management
- Event organization

## ERD (Entity Relationship Diagram)



*Note: Replace with your actual ERD screenshot or link*

## Setup Instructions

1. **Prerequisites**:
   - MySQL Server 8.0 or higher
   - MySQL Workbench or other MySQL client

2. **Database Import**:
   ```bash
   # Option 1: Using the command line
   mysql -u username -p < library_management_system.sql
   
   # Option 2: Using MySQL Workbench
   # Open MySQL Workbench → File → Open SQL Script → select library_management_system.sql → Execute
   ```

3. **Verify Installation**:
   ```sql
   USE library_management_system;
   SHOW TABLES;
   ```

## Database Structure

The database consists of 13 tables:
- `branch` - Library branch information
- `staff` - Library employees
- `category` - Book categories/genres
- `publisher` - Book publishers
- `author` - Book authors
- `book` - Core book information
- `book_author` - Many-to-many relationship between books and authors
- `book_category` - Many-to-many relationship between books and categories
- `book_item` - Physical copies of books
- `member` - Library members/patrons
- `loan` - Records of borrowed books
- `fine` - Late return fines
- `reservation` - Book reservations
- `event` - Library events

## Relationships

The database implements various relationship types:
- One-to-Many: Branch to Staff, Publisher to Book, etc.
- Many-to-Many: Books to Authors, Books to Categories
- One-to-One: Loan to Fine

## Features

- Full referential integrity through foreign key constraints
- Data validation with CHECK constraints
- Proper use of ENUMs for status fields
- Comprehensive tracking of book lifecycle
- Support for multi-author books
- Fine calculation system