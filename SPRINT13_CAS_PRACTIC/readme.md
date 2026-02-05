# Healthcare Data Analysis

Exploratory Data Analysis (EDA) & Unstructured Text Processing

Date: February 2026

# Project Overview

This project explores a synthetic healthcare dataset to identify patterns between patients, treatments, hospital operations, and medical costs. The main goal is to understand which variables are most associated with the total cost of care per patient (TotalBill). 

HealthcareDataAnalysisENG

The analysis combines:

Clinical patient data

Hospital operational data

Structured variables (age, diagnosis, cost, etc.)

Unstructured text (prescription details)

# Objectives

The primary objective is to determine which demographic, clinical, and operational variables influence hospital costs.

Key analysis goals include: 


- Understanding patient distribution by age, gender, diagnosis, and treatment

- Exploring hospital usage patterns

- Identifying relationships between costs and medical conditions

- Studying readmission and recurrence patterns

- Extracting insights from free-text prescription data

# Datasets

Two synthetic datasets (from Kaggle) were used for educational purposes: 

HealthcareDataAnalysisENG

** Clinical Dataset (Patients)**

1000 records – 11 variables

Includes:

Demographics: Age, Gender, Blood Type

Clinical: Diagnosis, Treatment

Dates: Admission & Discharge

Financial: TotalBill

Text: Full Prescription Details (unstructured)

** Operational Dataset (Hospitals)**

1000 records – 7 variables

Includes:

Hospital & Doctor

Room Number

Daily Cost

Treatment Type

Recovery Rating

After cleaning and transformation, both datasets were merged into one dataset with 1000 records and 32 variables. 


# Data Cleaning & Feature Engineering

Main preprocessing steps: 

Handling missing values (imputation for key cost variables)

Date validation (no discharge before admission)

Creation of Days of Stay (DoS) variable

Extraction of year, quarter, month, and day from admission/discharge dates

NLP processing of prescriptions → up to 4 medication variables per patient

Blood type simplified into Rh factor (+ / −)

# Exploratory Data Analysis (EDA)

EDA focused on:

Distribution of numerical variables

Relationships between cost and demographic/clinical variables

Comparison of categorical vs numerical variables

Medication frequency after text processing

Due to the synthetic nature of the dataset, most variables showed weak or no strong statistical relationships. 



# Statistical Analysis
** Correlation **

Spearman correlation used (non-normal distributions)

Very weak correlations overall

Highest observed correlation ≈ 0.035 (practically negligible) 


** t-Test (Numerical vs Cost)**

Only Age showed a statistically significant difference in cost when split above/below the mean 


** Chi-Square (Categorical vs Cost)**

Only Diagnosis showed significant association with total cost 



# Key Insights

Despite limitations, several patterns were observed:

Older patients show higher incidence of chronic diseases (diabetes, hypertension)

General decline in disease incidence in 2023, especially COVID-19

Growth in mental health medication prescriptions over time

Small group of recurrent patients accounts for multiple hospital visits

Cost variability is poorly explained by most available variables 

HealthcareDataAnalysisENG

# Limitations

This dataset is synthetic, which leads to:

Unrealistic variable distributions

Weak correlations

Limited predictive power

Therefore, results are educational, not clinically applicable. 



# Future Work

Possible next steps: 



Apply Machine Learning models to predict:

- TotalBill

- RecoveryRating

Use advanced NLP techniques on prescriptions

Incorporate richer clinical variables:

- Comorbidities

-Lab results

Validate methods using real clinical datasets

# Tools & Techniques

Data Cleaning & Transformation

Exploratory Data Analysis (EDA)

Statistical Testing (t-test, Chi²)

Spearman Correlation

Natural Language Processing (NLP)

# References

Includes academic literature on healthcare data analytics and public health data sources such as WHO and CDC. Full list available in the project report. 

HealthcareDataAnalysisENG
