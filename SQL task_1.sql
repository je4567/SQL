CREATE DATABASE FinancialDB;
USE FinancialDB;
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Accounts(	
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountNumber VARCHAR(30) NOT NULL UNIQUE,
    AccountType VARCHAR(30) NOT NULL,
    Balance DECIMAL(15,2) DEFAULT 0.00,
    Currency CHAR(3) DEFAULT 'INR',
    OpenedDate DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Active',
	  CONSTRAINT FK_Accounts_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
CREATE TABLE Ledgers (
    LedgerID INT AUTO_INCREMENT PRIMARY KEY,
    LedgerName VARCHAR(100) NOT NULL,
    LedgerType VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    LedgerID INT NOT NULL,
    TransactionType VARCHAR(30) NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Description VARCHAR(255),
    Status VARCHAR(20) DEFAULT 'Completed',

    CONSTRAINT FK_Transactions_Accounts
        FOREIGN KEY (AccountID)
        REFERENCES Accounts(AccountID),
	CONSTRAINT FK_Transactions_Ledgers
        FOREIGN KEY (LedgerID)
        REFERENCES Ledgers(LedgerID)
);
CREATE TABLE Invoices (
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    InvoiceNumber VARCHAR(30) NOT NULL UNIQUE,
    InvoiceDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    TotalAmount DECIMAL(15,2) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending',
      CONSTRAINT FK_Invoices_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,
    ReferenceNumber VARCHAR(50) UNIQUE,
    Status VARCHAR(20) DEFAULT 'Completed',

    CONSTRAINT FK_Payments_Invoices
        FOREIGN KEY (InvoiceID)
        REFERENCES Invoices(InvoiceID)
);
