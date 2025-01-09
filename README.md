
# S&P 500 Data Projects
This project demonstrates how to build an end-to-end data pipeline for processing S&P 500 data using AWS S3, Snowflake, Python, and Terraform. The pipeline extracts raw data, transforms it, and loads it into Snowflake for analysis.

## Prerequisites

- Python 3.x
- Snowflake account
- AWS account with access to S3
- Terraform (if using for infrastructure)

## Folder Structure

- `data/` - Contains raw and processed data files.
- `scripts/` - Python scripts for data loading, cleaning, and transformation.
- `terraform/` - Terraform configuration for infrastructure setup.
- `notebooks/` - Jupyter notebooks for exploratory analysis.

## Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/ada5tra/sp500-data-pipeline.git

# Part 1. S&P 500 Data Pipeline Project 09/01/2025

This project demonstrates how to set up a Snowflake data pipeline using AWS S3 as a staging area for loading data.

## Files and Scripts

- `data/sp500_data.csv`: Example S&P 500 data (this file is hosted on AWS S3).
- `scripts/create_stage.sql`: SQL to create a Snowflake stage linked to the S3 bucket.
- `scripts/create_table.sql`: SQL to create the table in Snowflake for storing the data.
- `scripts/data_loading.sql`: SQL to load the data from the stage into the table.

## Setup Instructions

1. Clone this repository.

2. Set up your own Snowflake instance and S3 bucket.

3. Run the SQL scripts in order:
- `create_stage.sql`
- `create_table.sql`
- `data_loading.sql`

4. Ensure the AWS credentials and S3 bucket information are correctly configured in the Snowflake stage creation script.

---

## Future Improvements

- Add additional data transformations.
- Integrate with a data pipeline tool (e.g., Airflow, dbt) for automated ETL.


   
