# Banking-Credit-Risk-Analysis
End-to-end banking credit risk analysis using SQL, Python, Machine Learning and Power BI.
# Banking Credit Risk Analysis

## Project Overview

This project focuses on the analysis of banking customer data and credit risk classification.

The project combines SQL, Python, statistical analysis, Machine Learning and Power BI in an end-to-end Data Analytics workflow.

## Dataset

The dataset contains 6,646 customer observations.

The main variables include:

* Age
* Gender
* Education level
* Region
* Monthly income
* Account balance
* Credit score
* Number of overdue days
* Requested loan amount
* Income category
* Risk category

## Technologies

* MySQL
* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* SciPy
* Scikit-learn
* Jupyter Notebook
* Power BI

## Methodology

SQL → Data Cleaning → Exploratory Data Analysis → Statistical Analysis → PCA → Machine Learning → ROC/AUC → Power BI

## Statistical Analysis

The project includes:

* Descriptive statistics
* Correlation analysis
* Outlier detection
* Chi-square test
* ANOVA
* Tukey HSD
* Principal Component Analysis (PCA)

## Machine Learning

Five classification models were developed and evaluated:

* Logistic Regression
* Decision Tree
* Random Forest
* KNN
* SVM

The models were evaluated using:

* Accuracy
* Precision
* Recall
* F1-score
* ROC/AUC

## ROC/AUC Results

| Model               |   AUC |
| ------------------- | ----: |
| Logistic Regression | 0.883 |
| Decision Tree       | 0.743 |
| Random Forest       | 0.894 |
| KNN                 | 0.863 |
| SVM                 | 0.890 |

## Power BI Dashboard

An interactive Power BI dashboard was developed to present:

* General customer indicators
* Credit risk distribution
* Financial characteristics
* Variable importance
* Comparison of model performances

## Project Structure

```text
Banking-Credit-Risk-Analysis/
│
├── README.md
├── data/
├── sql/
├── notebooks/
├── powerbi/
└── images/
```

## Objective

The objective of this project is to demonstrate an end-to-end Data Analytics workflow applied to a banking and credit-risk context, combining SQL, Python, statistics, Machine Learning and Business Intelligence.
