# MS_BI_SSIS_SSAS_SSRS_Project

This repository contains a project related to Microsoft Business Intelligence (MS BI) technologies, specifically focusing on SQL Server Integration Services (SSIS), SQL Server Analysis Services (SSAS), and SQL Server Reporting Services (SSRS). The project appears to involve data integration, analysis, and reporting components, potentially aimed at building a comprehensive business intelligence solution.

## Table of Contents
1.  [Features](#features)
2.  [Installation](#installation)
3.  [Usage](#usage)
4.  [Dependencies](#dependencies)

## Features

*   SQL scripts for database creation and manipulation.
*   Data transformation and loading processes using SSIS packages.
*   Data modeling and analysis using SSAS cubes and dimensions.
*   Report creation and deployment using SSRS.
*   Sample data in various formats (txt, xlsx) for testing and demonstration.
*   Project files for SSIS, SSAS, and SSRS components.
*   Potential integration with Excel for data analysis.

## Installation

1.  Clone the repository to your local machine:

    ```bash
    git clone https://github.com/panoschron97/MS_BI_SSIS_SSAS_SSRS_Project.git
    cd MS_BI_SSIS_SSAS_SSRS_Project
    ```

2.  Set up the required SQL Server environment with the necessary components (SSIS, SSAS, SSRS).

3.  Create a database named `MSBI` in SQL Server, or configure the connection strings in the project files to point to your existing database.

## Usage

1.  Execute the SQL scripts located in the root directory to create the necessary database tables and relationships. Example:

    ```sql
    -- Execute 1.sql in SQL Server Management Studio
    USE MASTER;
    GO
    CREATE DATABASE MSBI;
    GO
    USE MSBI;
    -- ... rest of the script
    ```

2.  Deploy and execute the SSIS packages to load data into the database. Ensure the connection strings in the SSIS packages are correctly configured.

3.  Deploy the SSAS project to your SQL Server Analysis Services instance. Process the cube and dimensions to enable data analysis.

4.  Deploy the SSRS reports to your SQL Server Reporting Services instance. Configure the data sources to point to your SSAS cube or SQL Server database.

## Dependencies

*   **Microsoft SQL Server:** Database management system.
*   **SQL Server Integration Services (SSIS):**  Platform for building data integration and transformation solutions.
*   **SQL Server Analysis Services (SSAS):**  Provides online analytical processing (OLAP) and data mining capabilities.
*   **SQL Server Reporting Services (SSRS):**  A server-based report generating system.
*   **SQL Server Management Studio (SSMS):**  Tool for managing SQL Server and its components.
*   **Microsoft Excel:** (Optional) May be required for interaction with Excel data sources.
