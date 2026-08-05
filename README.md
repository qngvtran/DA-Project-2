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

### 2. SQL analysis (PostgreSQL)

### 3. Excel dashboard

### 4. Power BI dashboard

---

## Key findings
