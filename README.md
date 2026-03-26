# 📊 Layoff Data Cleaning using SQL

## 📌 Project Overview

- This project focuses on cleaning raw layoff data using SQL (MySQL). The dataset contained inconsistencies such as duplicates, null values, and incorrect formats.

- 👉 The goal was to transform messy data into a clean, structured, and analysis-ready dataset.

## 🗂️ Dataset Information

| Table Name        | Description           |
| ----------------- | --------------------- |
| `layoffs`         | Raw dataset           |
| `layoff_staging`  | Initial staging table |
| `layoff_staging2` | Final cleaned dataset |

## ⚙️ Data Cleaning Workflow
### 🧱 1. Creating Staging Table
- Created a duplicate table to avoid modifying raw data
- Inserted all records into staging

```sql
CREATE TABLE layoff_staging LIKE layoffs;
INSERT INTO layoff_staging SELECT * FROM layoffs;
```

### 🧹 2. Removing Duplicates
- Used ROW_NUMBER() with CTE
- Identified duplicate rows
- Removed duplicates using row_num > 1

### 3. Data Standardization

- ✔ Removed extra spaces using TRIM()
- ✔ Standardized inconsistent values
- ✔ Fixed industry values (e.g., crypto% → crypto)
- ✔ Cleaned country names (removed trailing .)

### 📅 4. Date Formatting

- Converted date from TEXT → DATE format
```sql
UPDATE layoff_staging2
SET date = STR_TO_DATE(date, '%m/%d/%Y');
```

### 🔍 5. Handling Missing Values

- Replaced blank values with NULL.
- Used self join to fill missing industries.
- Removed rows where both key layoff metrics were NULL.

### 🧾 6. Final Cleanup

- ✔ Dropped helper column (row_num)
- ✔ Removed unnecessary records
- ✔ Ensured clean dataset



## 🛠️ Tech Stack
- 💾 MySQL
- 🧠 SQL (CTEs, Window Functions, Joins)

## ✅ Final Outcome
- Cleaned and structured dataset ready for analysis
- Improved data consistency and accuracy
- Removed duplicates and handled missing values effectively

## 📁 Project Structure
### 📦 Layoff-SQL-Project
<pre> ┣ 📜 clean_data.sql
 ┗ 📄 README.md
      </pre>
