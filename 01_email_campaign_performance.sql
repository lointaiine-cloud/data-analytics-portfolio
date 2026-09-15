-- ============================================================
-- Email Campaign Performance by Operating System
-- ============================================================
-- Business question:
-- How does email campaign performance differ
-- across operating systems?
-- ============================================================

WITH account_os AS (

  -- Determine the operating system for each account.
  SELECT
    a.id AS account_id,
    sp.operating_system

  FROM `data-analytics-mate.DA.account` AS a

  JOIN `data-analytics-mate.DA.account_session` AS acs
    ON a.id = acs.account_id

  JOIN `data-analytics-mate.DA.session_params` AS sp
    ON acs.ga_session_id = sp.ga_session_id

  WHERE a.is_unsubscribed = 0

  GROUP BY
    a.id,
    sp.operating_system
),

email_metrics AS (

  -- Calculate email engagement metrics
  -- for each operating system.
  SELECT
    ao.operating_system,

    COUNT(DISTINCT es.id_message) AS sent_msg,

    COUNT(DISTINCT eo.id_message) AS open_msg,

    COUNT(DISTINCT ev.id_message) AS visit_msg

  FROM account_os AS ao

  JOIN `data-analytics-mate.DA.email_sent` AS es
    ON ao.account_id = es.id_account

  LEFT JOIN `data-analytics-mate.DA.email_open` AS eo
    ON es.id_message = eo.id_message

  LEFT JOIN `data-analytics-mate.DA.email_visit` AS ev
    ON es.id_message = ev.id_message

  GROUP BY
    ao.operating_system
)

SELECT
  operating_system,
  sent_msg,
  open_msg,
  visit_msg,

  -- Percentage of sent emails that were opened.
  ROUND(
    SAFE_DIVIDE(open_msg, sent_msg) * 100,
    2
  ) AS open_rate,

  -- Percentage of sent emails that resulted in a visit.
  ROUND(
    SAFE_DIVIDE(visit_msg, sent_msg) * 100,
    2
  ) AS click_rate,

  -- Percentage of opened emails that resulted in a visit.
  ROUND(
    SAFE_DIVIDE(visit_msg, open_msg) * 100,
    2
  ) AS ctor

FROM email_metrics

ORDER BY
  operating_system;
