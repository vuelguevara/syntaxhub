# 🧮 SyntaxHub Project 1: Expense Tracker

A simple CLI-based expense tracking system built for learning and syntax comparison across multiple programming languages — Python, JavaScript, Java, and C#.  
It helps beginners see how different languages solve the same problem using similar logic.

## **Project Objectives**
- Practice syntax and structure of multiple languages.
- Understand database-driven CLI apps.
- Learn modular project organization (models, services, controllers).
- Demonstrate reusable app logic through pseudocode.

## **Folder Structure**

/docs/  
 ├── project_guide.md → this file (overview, usage, explanation)  
 ├── pseudocode.md → shared app logic in pseudocode form  
 ├── database_schema.sql → SQL schema for tables  

/python_version/ → Python implementation  
/javascript_version/ → JavaScript (Node.js) implementation  
/java_version/ → Java implementation  
/csharp_version/ → C# implementation  

## **Database Schema Overview**

The app uses a simple relational structure:

- `users` → holds user data (for multi-user expansion)
- `categories` → stores expense categories (e.g., Food, Travel)
- `expenses` → stores all user expenses with category link

Refer to: [`database_schema.sql`](./database_schema.sql)

## **Application Logic**

All versions of this app follow the same pseudocode structure.  
This ensures consistent logic across different languages.

View the shared logic here:  
👉 [`pseudocode.md`](./pseudocode.md)

## **Menu Options**
1. Add Expense  
2. View Expenses  
3. Edit Expense  
4. Delete Expense  
5. Manage Categories  
6. View Summary  
0. Exit

## **Technologies**

- **Database:** SQLite (default)
- **Python:** sqlite3, argparse
- **JavaScript:** Node.js + better-sqlite3
- **Java:** JDBC (SQLite Driver)
- **C#:** System.Data.SQLite

## **Setup Instructions**

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/syntaxhub.git
   cd syntaxhub/projects/expense_tracker

2. Import the database:
    sqlite3 expense_tracker.db < docs/database_schema.sql

3. Open your preferred version (Python, JS, Java, or C#) and run it.


---

### 9️⃣ **🧩 Learning Notes**
```markdown
## **Learning Focus**
- Observe syntax differences (loops, input handling, error management).
- Study how each language handles database I/O.
- Learn how structure and logic remain consistent across all languages.

