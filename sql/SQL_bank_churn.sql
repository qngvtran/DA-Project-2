-----------------------------------------------------------------
-- Q1. What is our overall churn rate, and how many customers have we lost?
--
SELECT
COUNT(*) AS total_customers,
COUNT(*) FILTER (
    WHERE churned
) AS churned_customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers;
-----------------------------------------------------------------
-- Q2. Which country has the highest churn rate?
--
SELECT
country,
COUNT(*) AS customers,
COUNT(*) FILTER (
    WHERE churned
) AS churned,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers
GROUP BY country
ORDER BY churn_rate_pct DESC;
-- -----------------------------------------------------------------
-- Q3. Does an inactive membership status predict churn? (a key retention/engagement question)
--
SELECT is_active_member,
COUNT(*) AS customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers
GROUP BY is_active_member;
-- -----------------------------------------------------------------
-- Q4. How does churn rate vary by number of products held? (classic "cross-sell reduces churn" hypothesis check)
--
SELECT num_products,
COUNT(*) AS customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers
GROUP BY num_products
ORDER BY num_products;
-- -----------------------------------------------------------------
-- Q5. Churn rate by age band — which life stage is most at risk?
--
SELECT age_band,
COUNT(*) AS customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers
GROUP BY age_band
ORDER BY age_band;
-- -----------------------------------------------------------------
-- Q6. Churn rate by credit score band (uses a JOIN against the reference table for the human-readable description).
--
SELECT b.band,
b.description,
COUNT(*) AS customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE c.churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers c
    JOIN credit_score_bands b ON b.band = c.credit_score_band
GROUP BY b.band,
    b.description,
    b.min_score
ORDER BY b.min_score;
-- -----------------------------------------------------------------
-- Q7. Which card type has the most satisfied and most likely to churn customers?
--
SELECT card_type,
COUNT(*) AS customers,
ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers
GROUP BY card_type
ORDER BY churn_rate_pct DESC;
-- -----------------------------------------------------------------
-- Q8. Zero-balance customers: how many are there, and are they more likely to churn than customers who keep a balance?
--
SELECT balance_tier,
COUNT(*) AS customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers
GROUP BY balance_tier
ORDER BY churn_rate_pct DESC;
-- -----------------------------------------------------------------
-- Q9. Does gender show a meaningfully different churn pattern?
--
SELECT gender,
COUNT(*) AS customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct,
ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction
FROM customers
GROUP BY gender;
-- -----------------------------------------------------------------
-- Q10. The engagement score (0-3) vs. churn rate — does higher
--      engagement really protect against churn?
--
SELECT engagement_score,
COUNT(*) AS customers,
ROUND(
    100.0 * COUNT(*) FILTER (
        WHERE churned
    ) / COUNT(*),
    2
) AS churn_rate_pct
FROM customers
GROUP BY engagement_score
ORDER BY engagement_score;
-----------------------------------------------------------------
-- Q11. Top 5 highest-salary customers within each country
--
SELECT country,
customer_id,
estimated_salary,
churned,
salary_rank_in_country
FROM (
        SELECT country,
            customer_id,
            estimated_salary,
            churned,
            RANK() OVER (
                PARTITION BY country
                ORDER BY estimated_salary DESC
            ) AS salary_rank_in_country
        FROM customers
    ) ranked
WHERE salary_rank_in_country <= 5
ORDER BY country,
    salary_rank_in_country;
-----------------------------------------------------------------
-- Q12. Running (cumulative) count of churned customers by credit
--      score band, ordered from riskiest to safest
--
SELECT b.band,
b.min_score,
COUNT(*) FILTER (
    WHERE c.churned
) AS churned_in_band,
SUM(
    COUNT(*) FILTER (
        WHERE c.churned
    )
) OVER (
    ORDER BY b.min_score
) AS cumulative_churned
FROM customers c
    JOIN credit_score_bands b ON b.band = c.credit_score_band
GROUP BY b.band,
    b.min_score
ORDER BY b.min_score;