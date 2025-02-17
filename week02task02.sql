-- Create a table to store the Apache log data
CREATE TABLE apache_logs (
    ip_address VARCHAR(50),
    timestamp TIMESTAMP,
    http_method VARCHAR(10),
    url_path VARCHAR(255),
    status_code INT,
    browser VARCHAR(100),
    os VARCHAR(100),
    user_agent TEXT
);
SELECT COUNT(*) FROM apache_logs;
SELECT COUNT(DISTINCT ip_address) FROM apache_logs;
-- To find the Top 10 Most Frequent IP Addresses:
SELECT ip_address, COUNT(*) AS request_count
FROM apache_logs
GROUP BY ip_address
ORDER BY request_count DESC
LIMIT 10;
-- To find the Top 10 Most Requested URL Paths:
SELECT url_path, COUNT(*) AS request_count
FROM apache_logs
GROUP BY url_path
ORDER BY request_count DESC
LIMIT 10;
--To find the Busiest Hour of the Day based on the number of requests:
SELECT EXTRACT(HOUR FROM timestamp) AS hour, COUNT(*) AS request_count
FROM apache_logs
GROUP BY hour
ORDER BY request_count DESC
LIMIT 1;