CREATE DATABASE library_management_system;

USE library_management_system;

CREATE TABLE branch (
    branch_id INT AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    PRIMARY KEY (branch_id),
    UNIQUE (branch_name),
    UNIQUE (email)
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT,
    branch_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    PRIMARY KEY (staff_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    UNIQUE (email)
);

CREATE TABLE category (
    category_id INT AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    description TEXT,
    PRIMARY KEY (category_id),
    UNIQUE (category_name)
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(100),
    PRIMARY KEY (publisher_id),
    UNIQUE (publisher_name),
    UNIQUE (email)
);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    death_date DATE,
    biography TEXT,
    PRIMARY KEY (author_id)
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT,
    isbn VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    publication_date DATE NOT NULL,
    edition VARCHAR(20),
    pages INT,
    language VARCHAR(50) DEFAULT 'English',
    summary TEXT,
    PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    UNIQUE (isbn)
);

CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    author_order INT NOT NULL DEFAULT 1,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE book_category (
    book_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE book_item (
    book_item_id INT AUTO_INCREMENT,
    book_id INT NOT NULL,
    branch_id INT NOT NULL,
    barcode VARCHAR(50) NOT NULL,
    status ENUM('Available', 'Loaned', 'Reserved', 'Lost', 'Maintenance') DEFAULT 'Available',
    acquisition_date DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    condition ENUM('New', 'Good', 'Fair', 'Poor') DEFAULT 'New',
    PRIMARY KEY (book_item_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    UNIQUE (barcode)
);

CREATE TABLE member (
    member_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    join_date DATE NOT NULL,
    membership_expiry DATE NOT NULL,
    membership_status ENUM('Active', 'Expired', 'Suspended', 'Cancelled') DEFAULT 'Active',
    PRIMARY KEY (member_id),
    UNIQUE (email)
);

CREATE TABLE loan (
    loan_id INT AUTO_INCREMENT,
    book_item_id INT NOT NULL,
    member_id INT NOT NULL,
    staff_id_out INT NOT NULL,
    staff_id_in INT,
    loan_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    due_date DATE NOT NULL,
    return_date DATETIME,
    status ENUM('Active', 'Returned', 'Overdue', 'Lost') DEFAULT 'Active',
    PRIMARY KEY (loan_id),
    FOREIGN KEY (book_item_id) REFERENCES book_item(book_item_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (staff_id_out) REFERENCES staff(staff_id),
    FOREIGN KEY (staff_id_in) REFERENCES staff(staff_id)
);

CREATE TABLE fine (
    fine_id INT AUTO_INCREMENT,
    loan_id INT NOT NULL,
    fine_amount DECIMAL(10,2) NOT NULL,
    fine_date DATE NOT NULL,
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    status ENUM('Pending', 'Paid', 'Waived') DEFAULT 'Pending',
    PRIMARY KEY (fine_id),
    FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

CREATE TABLE reservation (
    reservation_id INT AUTO_INCREMENT,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Fulfilled', 'Cancelled', 'Expired') DEFAULT 'Pending',
    fulfillment_date DATETIME,
    PRIMARY KEY (reservation_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE event (
    event_id INT AUTO_INCREMENT,
    branch_id INT NOT NULL,
    event_name VARCHAR(100) NOT NULL,
    event_date DATETIME NOT NULL,
    duration INT NOT NULL,
    description TEXT,
    max_attendees INT,
    PRIMARY KEY (event_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);