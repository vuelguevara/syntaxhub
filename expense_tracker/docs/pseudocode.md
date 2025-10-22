# Main Menu Flow (CLI)

FUNCTION main():
    CONNECT to database

    LOOP:
        DISPLAY main menu:
            [1] Add Expense
            [2] View Expenses
            [3] Edit Expense
            [4] Delete Expense
            [5] Manage Categories
            [6] Reports / Summary
            [0] Exit

        choice ← INPUT("Enter choice: ")

        SWITCH (choice):
            CASE "1": add_expense()
            CASE "2": view_expenses()
            CASE "3": edit_expense()
            CASE "4": delete_expense()
            CASE "5": category_menu()
            CASE "6": show_summary()
            CASE "0": EXIT loop
            DEFAULT: PRINT("Invalid option.")
    
    DISCONNECT database
END FUNCTION


# Add Expense

FUNCTION add_expense():
    PRINT("=== Add New Expense ===")
    description ← INPUT("Description: ")
    amount ← INPUT("Amount: ")
    category_id ← SELECT_CATEGORY()
    expense_date ← INPUT("Date (YYYY-MM-DD): ")

    IF NOT VALIDATE_AMOUNT(amount):
        PRINT("Invalid amount. Try again.")
        RETURN

    QUERY ← "INSERT INTO expenses (user_id, category_id, description, amount, expense_date)
              VALUES (?, ?, ?, ?, ?)"
    EXECUTE QUERY with (1, category_id, description, amount, expense_date)

    PRINT("Expense added successfully.")
END FUNCTION


# View Expenses

FUNCTION view_expenses():
    PRINT("=== View Expenses ===")
    QUERY ← """
        SELECT e.id, c.name AS category, e.description, e.amount, e.expense_date
        FROM expenses e
        LEFT JOIN categories c ON e.category_id = c.id
        ORDER BY e.expense_date DESC
    """
    results ← EXECUTE QUERY
    DISPLAY results in table format
END FUNCTION


# Edit Expense

FUNCTION edit_expense():
    id ← INPUT("Enter expense ID to edit: ")
    record ← FETCH("SELECT * FROM expenses WHERE id = ?", id)

    IF record IS NULL:
        PRINT("Expense not found.")
        RETURN

    new_desc ← INPUT("New Description (leave blank to keep): ")
    new_amount ← INPUT("New Amount (leave blank to keep): ")
    new_cat ← SELECT_CATEGORY()
    new_date ← INPUT("New Date (leave blank to keep): ")

    UPDATE_QUERY ← "UPDATE expenses SET 
        description = COALESCE(?, description),
        amount = COALESCE(?, amount),
        category_id = COALESCE(?, category_id),
        expense_date = COALESCE(?, expense_date)
        WHERE id = ?"

    EXECUTE UPDATE_QUERY with (new_desc, new_amount, new_cat, new_date, id)
    PRINT("Expense updated successfully.")
END FUNCTION


# Delete Expense

FUNCTION delete_expense():
    id ← INPUT("Enter expense ID to delete: ")
    CONFIRM ← INPUT("Are you sure? (y/n): ")
    IF CONFIRM != "y": RETURN
    EXECUTE "DELETE FROM expenses WHERE id = ?", id
    PRINT("Expense deleted.")
END FUNCTION


# Category Menu

FUNCTION category_menu():
    LOOP:
        PRINT("[1] Add Category")
        PRINT("[2] View Categories")
        PRINT("[3] Delete Category")
        PRINT("[0] Back")

        choice ← INPUT("Choice: ")

        SWITCH (choice):
            CASE "1": add_category()
            CASE "2": view_categories()
            CASE "3": delete_category()
            CASE "0": RETURN
            DEFAULT: PRINT("Invalid option.")
END FUNCTION


# Show Summary

FUNCTION show_summary():
    PRINT("=== Expense Summary by Category ===")
    QUERY ← """
        SELECT c.name AS category, SUM(e.amount) AS total
        FROM expenses e
        LEFT JOIN categories c ON e.category_id = c.id
        GROUP BY c.name
        ORDER BY total DESC
    """
    results ← EXECUTE QUERY
    DISPLAY results in table format
END FUNCTION


# Helper: SELECT_CATEGORY()

FUNCTION SELECT_CATEGORY():
    results ← FETCH_ALL("SELECT id, name FROM categories ORDER BY name")
    DISPLAY categories with IDs
    choice ← INPUT("Select category ID (or leave blank for None): ")
    IF choice IS EMPTY:
        RETURN NULL
    RETURN choice
END FUNCTION


