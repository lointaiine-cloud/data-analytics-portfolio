WITH account_base AS (
  SELECT
    a.id AS account_id,
    a.send_interval,
    a.is_verified,
    a.is_unsubscribed,
    MIN(s.date) AS date,
    ARRAY_AGG(
      sp.country IGNORE NULLS
      ORDER BY s.date
      LIMIT 1
    )[SAFE_OFFSET(0)] AS country
  FROM `data-analytics-mate.DA.account` AS a
  JOIN `data-analytics-mate.DA.account_session` AS acs
    ON a.id = acs.account_id
  JOIN `data-analytics-mate.DA.session` AS s
    ON acs.ga_session_id = s.ga_session_id
  JOIN `data-analytics-mate.DA.session_params` AS sp
    ON acs.ga_session_id = sp.ga_session_id
  GROUP BY
    a.id,
    a.send_interval,
    a.is_verified,
    a.is_unsubscribed
),

account_metrics AS (
  SELECT
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed,
    COUNT(DISTINCT account_id) AS account_cnt,
    0 AS sent_msg,
    0 AS open_msg,
    0 AS visit_msg
  FROM account_base
  WHERE country IS NOT NULL
    AND date IS NOT NULL
  GROUP BY
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed
),

email_metrics AS (
  SELECT
    DATE_ADD(ab.date, INTERVAL es.sent_date DAY) AS date,
    ab.country,
    ab.send_interval,
    ab.is_verified,
    ab.is_unsubscribed,
    0 AS account_cnt,
    COUNT(DISTINCT es.id_message) AS sent_msg,
    COUNT(DISTINCT eo.id_message) AS open_msg,
    COUNT(DISTINCT ev.id_message) AS visit_msg
  FROM account_base AS ab
  JOIN `data-analytics-mate.DA.email_sent` AS es
    ON ab.account_id = es.id_account
  LEFT JOIN `data-analytics-mate.DA.email_open` AS eo
    ON es.id_message = eo.id_message
  LEFT JOIN `data-analytics-mate.DA.email_visit` AS ev
    ON es.id_message = ev.id_message
  WHERE ab.country IS NOT NULL
    AND ab.date IS NOT NULL
  GROUP BY
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed
),

combined AS (
  SELECT
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed,
    account_cnt,
    sent_msg,
    open_msg,
    visit_msg
  FROM account_metrics

  UNION ALL

  SELECT
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed,
    account_cnt,
    sent_msg,
    open_msg,
    visit_msg
  FROM email_metrics
),

metrics AS (
  SELECT
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed,
    SUM(account_cnt) AS account_cnt,
    SUM(sent_msg) AS sent_msg,
    SUM(open_msg) AS open_msg,
    SUM(visit_msg) AS visit_msg
  FROM combined
  GROUP BY
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed
),

country_totals AS (
  SELECT
    *,
    SUM(account_cnt) OVER (
      PARTITION BY country
    ) AS total_country_account_cnt,

    SUM(sent_msg) OVER (
      PARTITION BY country
    ) AS total_country_sent_cnt
  FROM metrics
),

country_ranks AS (
  SELECT
    *,
    DENSE_RANK() OVER (
      ORDER BY total_country_account_cnt DESC
    ) AS rank_total_country_account_cnt,

    DENSE_RANK() OVER (
      ORDER BY total_country_sent_cnt DESC
    ) AS rank_total_country_sent_cnt
  FROM country_totals
)

SELECT
  date,
  country,
  send_interval,
  is_verified,
  is_unsubscribed,
  account_cnt,
  sent_msg,
  open_msg,
  visit_msg,
  total_country_account_cnt,
  total_country_sent_cnt,
  rank_total_country_account_cnt,
  rank_total_country_sent_cnt
FROM country_ranks
WHERE
  rank_total_country_account_cnt <= 10
  OR rank_total_country_sent_cnt <= 10
ORDER BY
  date,
  country;
