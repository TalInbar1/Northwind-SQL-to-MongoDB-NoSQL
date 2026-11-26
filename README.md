# Northwind: From SQL Server to MongoDB

### Project Overview
Northwind is a well-known sample database of a food import and export company, with customers, orders, products, suppliers and employees. In this project I wrote business-driven SQL queries on the relational model and then redesigned and migrated the database to a NoSQL document model in MongoDB.

### What I Did
* **Business SQL queries (SQL Server):** Answered real business questions, such as:
  * Which employees generate the most net revenue after discounts (support for bonus decisions)
  * Who are the top 5 customers in selected target markets (support for local marketing campaigns)
  * Logistics and shipping analysis
* **Choosing a NoSQL model:** Compared Key-Value, Column, Graph and Document databases and chose a Document DB, since an order with its details, customer and products is naturally one aggregate.
* **Migration:** Converted the relational tables into nested JSON documents with `FOR JSON` in SQL Server (`sql/relational_to_json.sql`) and loaded them into MongoDB.
* **Query translation:** Rewrote the business queries for MongoDB.
* **Big Data analysis:** Evaluated the dataset against the 5V characteristics (Volume, Velocity, Variety, Veracity, Value).

### Repository Structure
```
sql/            SQL Server script that builds the JSON documents
data/json/      Exported documents: customers, orders, products, employees
data/source/    Original Northwind CSV files
diagrams/       Relational ERD and the document model
docs/           Part 1 and Part 2 reports and the final presentation (Hebrew, PDF)
```

### Tech Stack
SQL Server (T-SQL), MongoDB, JSON

*Course project ("NoSQL", grade 100/100), individual work.*
