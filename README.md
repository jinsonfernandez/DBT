# End-to-End DBT Project with Snowflake

## Introduction
This project demonstrates an end-to-end data transformation pipeline using DBT (Data Build Tool) connected with Snowflake. It covers the setup, configuration, and execution of DBT models to transform and load data within Snowflake, showcasing best practices for data modeling and pipeline management.

## Prerequisites
- Snowflake account with necessary permissions
- DBT installed on your local machine or development environment
- Basic knowledge of SQL and data modeling concepts

## Getting Started

### Setting Up Your Environment
1. **Install DBT:**
   Ensure DBT is installed and properly configured on your machine. Refer to the [official DBT installation guide](https://docs.getdbt.com/dbt-cli/installation) for instructions.

2. **Configure DBT Profile:**
   Set up your `~/.dbt/profiles.yml` to connect to your Snowflake account. Here's an example configuration:
   ```yaml
   your_project_name:
     target: dev
     outputs:
       dev:
         type: snowflake
         account: your_snowflake_account
         user: your_username
         password: your_password
         role: your_role
         database: your_database
         warehouse: your_warehouse
         schema: your_schema
         threads: 4
         client_session_keep_alive: False
