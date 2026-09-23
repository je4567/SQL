create database audit_db;
use audit_db;
CREATE TABLE transactions_17(
    transaction_id INT PRIMARY KEY,
    account_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

INSERT INTO transactions_17 VALUES
(1001, 'Bank Account', 'Deposit', 75000, '2025-01-01'),
(1002, 'cash Account', 'Withdrawal', 17000, '2025-01-20'),
(1003, 'Sales Account', 'Credit', 36000, '2025-02-25');

CREATE TABLE audit_transactions_17 (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    account_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    action_type VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_transaction_insert
AFTER INSERT ON transactions_17
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions_17
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (NEW.transaction_id, NEW.account_name, NEW.transaction_type,
     NEW.amount, 'INSERT');
END //

DELIMITER ;

INSERT INTO transactions_17
VALUES (1004, 'Purchase Account', 'Debit', 15000, '2025-02-10');

SELECT * FROM audit_transactions_17;

DELIMITER //

CREATE TRIGGER after_transaction_update
AFTER UPDATE ON transactions_17
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions_17
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (NEW.transaction_id, NEW.account_name, NEW.transaction_type,
     NEW.amount, 'UPDATE');
END //

DELIMITER ;

UPDATE transactions_17
SET amount = 18000
WHERE transaction_id = 1004;

SELECT * FROM audit_transactions_17;

DELIMITER //

CREATE TRIGGER after_transaction_delete
AFTER DELETE ON transactions_17
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions_17
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (OLD.transaction_id, OLD.account_name, OLD.transaction_type,
     OLD.amount, 'DELETE');
END //

DELIMITER ;
DELETE FROM transactions_17
WHERE transaction_id = 1004;

SELECT * FROM audit_transactions_17;