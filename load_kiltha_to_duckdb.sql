-- Create a table to store the fixtures data with an additional instime field
CREATE OR REPLACE TABLE fixtures AS
SELECT 
    awaycrest,
    awayteam,
    comment,
    compname,
    date AS fixdate,
    homecrest,
    hometeam,
    referee,
    time AS fixtime,
    venue,
    dt,
    unix,
    opposition,
    crest,
    age,
    CURRENT_TIMESTAMP AS instime
FROM 
    read_json_auto('docs/fixtures.json', format='auto');

-- Display the table schema
DESCRIBE fixtures;

SELECT *
FROM fixtures f
INNER JOIN (
  SELECT compname, opposition, MAX(instime) as max_unix
  FROM fixtures
  GROUP BY compname, opposition
) AS latest_fixtures
ON f.compname = latest_fixtures.compname
AND f.opposition = latest_fixtures.opposition
AND f.instime = latest_fixtures.max_unix
ORDER BY f.instime DESC;