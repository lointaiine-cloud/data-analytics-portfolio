-- ============================================================
-- Customer Email Engagement Summary
-- ============================================================
-- Business question:
-- How engaged are customers with email campaigns,
-- and how do engagement segments differ?
-- ============================================================

WITH customer_email_metrics AS (

  SELECT
    a.id AS account_id,
    a.send_interval,
    a.is_verified,

    COUNT(DISTINCT es.id_message) AS sent_msg,
    COUNT(DISTINCT eo.id_message) AS open_msg,
    COUNT(DISTINCT ev.id_message) AS visit_msg

  FROM `data-analytics-mate.DA.account` AS a

  JOIN `data-analytics-mate.DA.email_sent` AS es
    ON a.id = es.id_account

  LEFT JOIN `data-analytics-mate.DA.email_open` AS eo
    ON es.id_message = eo.id_message

  LEFT JOIN `data-analytics-mate.DA.email_visit` AS ev
    ON es.id_message = ev.id_message

  WHERE a.is_unsubscribed = 0

  GROUP BY
    a.id,
    a.send_interval,
    a.is_verified
),

engagement_metrics AS (

  SELECT
    account_id,
    send_interval,
    is_verified,
    sent_msg,
    open_msg,
    visit_msg,

    SAFE_DIVIDE(open_msg, sent_msg) * 100 AS open_rate,

    SAFE_DIVIDE(visit_msg, sent_msg) * 100 AS click_rate,

    SAFE_DIVIDE(visit_msg, open_msg) * 100 AS ctor

  FROM customer_email_metrics
),

segmented_customers AS (

  SELECT
    *,
    
    (
      COALESCE(open_rate, 0) * 0.5
      +
      COALESCE(click_rate, 0) * 0.5
    ) AS engagement_score,

    NTILE(3) OVER (
      ORDER BY
        (
          COALESCE(open_rate, 0) * 0.5
          +
          COALESCE(click_rate, 0) * 0.5
        )
    ) AS engagement_group

  FROM engagement_metrics
),

final_segments AS (

  SELECT
    *,
    
    CASE
      WHEN engagement_group = 3 THEN 'High engagement'
      WHEN engagement_group = 2 THEN 'Medium engagement'
      WHEN engagement_group = 1 THEN 'Low engagement'
    END AS engagement_level

  FROM segmented_customers
)

SELECT
  engagement_level,

  COUNT(*) AS customers,

  ROUND(AVG(sent_msg), 2) AS avg_sent_msg,

  ROUND(AVG(open_rate), 2) AS avg_open_rate,

  ROUND(AVG(click_rate), 2) AS avg_click_rate,

  ROUND(AVG(ctor), 2) AS avg_ctor,

  ROUND(AVG(engagement_score), 2) AS avg_engagement_score

FROM final_segments

GROUP BY
  engagement_level

ORDER BY
  avg_engagement_score DESC;
