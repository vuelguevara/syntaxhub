-- =============================================
-- SyntaxHub Project: Expense Tracker
-- Database Schema (SQLite)
-- =============================================

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Expenses Table
CREATE TABLE IF NOT EXISTS expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    category_id INTEGER,
    description TEXT NOT NULL,
    amount REAL NOT NULL CHECK (amount >= 0),
    expense_date DATE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL
);

-- Optional Sample Data
INSERT INTO users (username, password) VALUES
('demo', 'demo123');  -- (for testing only)

INSERT INTO categories (name, description) VALUES
('Food', 'Meals, groceries, snacks'),
('Transport', 'Bus, gas, parking, etc.'),
('Utilities', 'Electricity, water, phone'),
('Entertainment', 'Movies, subscriptions');

INSERT INTO expenses (user_id, category_id, description, amount, expense_date)
VALUES (1, 1, 'Lunch at cafe', 250.00, '2025-10-22');
