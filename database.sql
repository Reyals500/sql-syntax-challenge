-- Delete the table if needed
DROP TABLE "accounts";

-- Create "accounts" Table
CREATE TABLE "accounts" (
"id" SERIAL PRIMARY KEY,
"username" varchar(12) NOT NULL,
"city" varchar(128),
"transactions_completed" INTEGER,
"transactions_attempted" INTEGER,
"account_balance" NUMERIC(12, 2)
);

-- Insert data into 'accounts' Table
INSERT INTO "accounts" ("username", "city", "transactions_completed", "transactions_attempted", "account_balance") VALUES
('Shawn', 'Chicago', 5, 10, 355.80),
('Cherise', 'Minneapolis', 9, 9, 4000.00),
('Larry', 'Minneapolis', 3, 4, 77.01),
('Dorothy', 'New York', 6, 12, 0.99),
('Anthony', 'Chicago', 0, 0, 0.00),
('Travis', 'Miami', 10, 100, 500000.34),
('Davey', 'Chicago', 9, 99, 98.04),
('Ora', 'Phoenix', 88, 90, 3.33),
('Grace', 'Miami', 7, 9100, 34.78),
('Hope', 'Phoenix', 4, 10, 50.17);

--------------------------------------------------------------------------------------------------------------------------------------------------

-- 0. How do you get all users?
SELECT * FROM accounts;

-- 1. How do you get all users from Chicago?
SELECT * FROM "accounts"
WHERE "city" = 'Chicago';

-- 2. How do you get all users with usernames that contain the letter 'a'?
SELECT * FROM "accounts"
WHERE "username" Like '%a%';

-- 3. The bank is giving a new customer bonus! How do you update all records with an account balance of $0.00 and a transactions_attempted of $0? Give them a new account balance of $10.00.
UPDATE "accounts" SET "account_balance" = 10.00 
WHERE ("account_balance" = 0.00 AND "transactions_attempted" = 0);

-- 4. How do you select all users that have attempted 9 or more transactions?
SELECT * FROM "accounts"
WHERE "transactions_attempted" >= 9;

-- 5. How do you get the username and account balance of the 3 users with the highest balances, sorted highest to lowest balance? NOTE: Research LIMIT
SELECT "username", "account_balance" FROM "accounts"
ORDER BY "account_balance" DESC LIMIT 3;

-- 6. How do you get the username and account balance of the 3 users with the lowest balances, sorted lowest to highest balance?
SELECT "username", "account_balance" FROM "accounts"
ORDER BY "account_balance" ASC LIMIT 3;

-- 7. How do you get all users with account balances that are more than $100?
SELECT * FROM "accounts"
WHERE "account_balance" > 100.00;

-- 8. How do you add a new account?
INSERT INTO "accounts" ("username", "city", "transactions_completed", "transactions_attempted", "account_balance")
VALUES ('Dusty', 'Minneapolis', 0, 0, 0.00);

-- 9. The bank is losing money in Miami and Phoenix and needs to unload low transaction customers. How do you delete users that reside in Miami OR Phoenix and have completed fewer than 5 transactions?
DELETE FROM "accounts"
WHERE "transactions_completed" < 5 AND ("city" = 'Miami' OR "city" = 'Phoenix');

-- Stretch Question 1: Anthony moved to Santa Fe. Update his location in the table.
UPDATE "accounts" SET "city" = 'Santa Fe' WHERE "username" = 'Anthony';

-- Stretch Question 2: Grace closed her account. Remove her from the database.
DELETE FROM "accounts" WHERE "username" = 'Grace';
-- Stretch Question 3: Travis made a withdrawal of $20,000. What's their new balance? NOTE: Research `RETURNING`
UPDATE "accounts" SET "account_balance" = ((SELECT "account_balance" FROM "accounts" WHERE "username" = 'Travis') - 20000), "transactions_completed" = "transactions_completed" + 1, "transactions_attempted" = transactions_attempted + 1 WHERE "username" = 'Travis' RETURNING "account_balance";
-- Stretch Question 4: The Bank needs to track all last names. NOTE: Research `ALTER TABLE`
ALTER TABLE "accounts"
ADD "lastname" varchar(80);

-- Question 5: What is the total amount of money held by the bank? NOTE: Research `SUM`
SELECT SUM('account_balance')
FROM "accounts";

-- Question 6: What is the total amount of money held by the bank at each location? NOTE: Research `GROUP BY`
SELECT SUM('account_balance'), "city"
FROM "accounts"
GROUP BY "city";
