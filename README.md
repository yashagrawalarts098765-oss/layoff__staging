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

```sql
CREATE TABLE layoff_staging LIKE layoffs;
INSERT INTO layoff_staging SELECT * FROM layoffs;
```

