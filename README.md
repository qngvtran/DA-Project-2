# Bank Customer Churn & Retention Analytics

Another end-to-end data analysis project simulating a
retail-banking analyst role: understanding why customers leave, which
segments are most at risk, and what a healthy retention picture looks
like. Banking environment — regulated financial services,
which brings its own responsibilities (PII handling) and its own
analytical traps (target leakage) that don't show up in most beginner
datasets.

> **Dataset:** `bank_churn.csv` — 10,000 retail banking customers across
> France, Germany, and Spain, with account details, product holdings,
> engagement flags, and whether each customer churned.

---

## Project goals

Business questions:

1. What's our overall churn rate, and which country/segment loses the
   most customers?
2. Does being an active member, or holding more products, actually
   protect against churn?
3. Which age groups and credit-score bands are most at risk?
4. Are zero-balance or low-engagement customers a churn warning sign?
5. Who are our highest-value customers, and are any of them showing
   early warning signs?

---

## Tech stack

| Tool | Role in this project |
|---|---|
| **Python (Pandas)** — Google Colab | Clean the data, handle PII responsibly, detect a target-leakage issue, engineer retention-analysis features |
| **PostgreSQL (SQL)** | Structured storage + 12 queries including joins to a reference table and window functions |
| **Excel** | Formula-driven churn-rate dashboard using two-condition `COUNTIFS` ratios |
| **Power BI** | Interactive report across 4 pages, with an explicit reminder about leakage-safe measures |
| **GitHub** | Documentation and version control (this repo) |

---

## Project structure

```
.
├── data/
│   ├── raw/
│   └── processed/
│
├── excel/
│
├── images/     
│
├── notebooks/
│ 
├── sql/
│ 
└── README.md
```
---

## Workflow

### 1. Data cleaning (Python / Pandas, in Google Colab)
- Loads the raw 10,000-row CSV (already free of nulls/duplicates)
- Hashes the customer surname and drops the raw name column
- Renames columns, converts flag columns to proper booleans
- Checks and flags the `complained`/`churned` leakage pattern
- Engineers `credit_score_band`, `age_band`, `balance_tier`,
  `tenure_band`, `engagement_score`
- Builds a small `credit_score_bands` reference table

### 2. SQL analysis (PostgreSQL)

- churn rate by country/age/products/credit band
- an active-member comparison
- a "VIP customers per country" window-function query
- a running-total churn count across credit risk bands.

### 3. Excel dashboard

Customers sheet:
- all 10,000 customers as an Excel Table
Credit Score Bands sheet:
- the reference table
Dashboard sheet:
- KPI cards - Total Customers, Churned, Churn Rate, Avg Satisfaction, Avg Credit Score
- 4 `COUNTIFS`- driven churn-rat breakdown tables
- matching charts

### 4. Power BI dashboard

---

## Key findings

- Overall churn rate: 20.4% (2,038 of 10,000 customers)
- Germany's churn rate (32.4%) is roughly double France's and
  Spain's (~16-17% each) - the single biggest geographic signal in the
  data, and worth a dedicated slide in any retention story
