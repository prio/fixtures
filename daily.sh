# Download Fixtures
/bin/bash src/get_fixtures.sh "https://www.eastcorkgaa.com/wp-admin/admin-ajax.php?action=fixtures&club_id=8256" "Dungourney" > docs/Dungourney.json
/bin/bash src/get_fixtures.sh "https://gaacork.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=2822&competition_id=201557&team_id=327608&displayResults=1" "Dungourney" > docs/dg_gaa.json
/bin/bash src/get_fixtures.sh "https://rebelog.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=8943" "Kiltha" > docs/Kiltha.json

# Generate RSS
/bin/bash src/fx_to_rss.sh "Kiltha" > docs/Kiltha.rss
/bin/bash src/fx_to_rss.sh "Dungourney" > docs/Dungourney.rss

# Generate Kiltha Web Page
/bin/bash src/kiltha_to_html.sh
cp html/app.js docs/

# Not yet in use
/bin/bash src/kog_filter.sh

echo "Hi" > docs/index.html