-- Active: 1715669363981@@127.0.0.1@3306

-- 1. Analyse the data
-- ****************************************************************
SELECT * FROM progress LIMIT 100;


-- 2. What are the Top 25 schools (.edu domains)?
-- ****************************************************************
SELECT COUNT(u.email_domain) AS `Number of Users`, u.email_domain
FROM users u
GROUP BY email_domain
ORDER BY `Number of Users` DESC
LIMIT 25;

-- How many .edu learners are located in New York? 
-- ****************************************************************
SELECT COUNT(*)
FROM users
WHERE email_domain LIKE '%.edu'
AND city = 'New York';

-- The mobile_app column contains either mobile-user or NULL. 
-- How many of these Codecademy learners are using the mobile app?
-- ****************************************************************
SELECT COUNT(*)
FROM users
WHERE mobile_app LIKE 'mobile-user';

-- 3. Query for the sign up counts for each hour.
-- Refer to CodeAcademy to solve this question
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************

SELECT 
    strftime('%H', sign_up_at) AS sign_up_hour,
    COUNT(*) AS sign_up_count
FROM users
GROUP BY sign_up_hour
ORDER BY sign_up_hour;

-- 4. Do different schools (.edu domains) prefer different courses?
SELECT email_domain, 
SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "C++",
SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",
SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",
SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "JS",
SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "JAVA",
COUNT(email_domain) AS "NUMBER OF LEARNERS"
FROM progress
JOIN users ON progress.user_id = users.user_id
GROUP BY email_domain
ORDER BY email_domain ASC;

SELECT
  u.email_domain,
  SUM(p.learn_cpp) AS num_cpp_students,
  SUM(p.learn_sql) AS num_sql_students,
  SUM(p.learn_html) AS num_html_students,
  SUM(p.learn_javascript) AS num_javascript_students,
  SUM(p.learn_java) AS num_java_students
FROM users u
INNER JOIN progress p ON u.user_id = p.user_id
GROUP BY u.email_domain;

-- What courses are the New Yorker Students taking?
-- ****************************************************************
SELECT p.user_id,
       p.learn_cpp,
       p.learn_sql,
       p.learn_html,
       p.learn_javascript,
       p.learn_java
FROM progress p
INNER JOIN users u ON p.user_id = u.user_id
WHERE u.city = 'New York';

-- What courses are the Chicago Students taking?
-- ****************************************************************
SELECT p.user_id,
       p.learn_cpp,
       p.learn_sql,
       p.learn_html,
       p.learn_javascript,
       p.learn_java
FROM progress p
INNER JOIN users u ON p.user_id = u.user_id
WHERE u.city = 'Chicago';

-- ***********************************************

-- ****************************************************************
-- 4. METHOD #1: Do different schools (.edu domains) prefer different courses?
-- Calculate the users from each email domain that have non-empty entries learning C++, SQL, HTML, JavaScript, Java
-- Count the total number of users per email domain, sorted by the email domain in descending order.
-- ****************************************************************
SELECT email_domain, 
SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "C++",
SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",
SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",
SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "JS",
SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "JAVA",
COUNT(email_domain) AS "NUMBER OF LEARNERS"
FROM progress
JOIN users ON progress.user_id = users.user_id
GROUP BY email_domain
ORDER BY email_domain ASC;