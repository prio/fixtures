# Download Fixtures
bash src/get_fixtures.sh "https://www.eastcorkgaa.com/wp-admin/admin-ajax.php?action=fixtures&club_id=8256" "Dungourney" > docs/Dungourney.json
bash src/get_fixtures.sh "https://gaacork.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=2822&competition_id=201557&team_id=327608&displayResults=1" "Dungourney" > docs/dg_gaa.json
bash src/get_fixtures.sh "https://rebelog.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=8943" "Kiltha" > docs/Kiltha.json

# Generate RSS
cat docs/Kiltha.json | bash src/upcoming_filter.sh | bash src/fx_to_rss.sh > docs/Kiltha.rss
cat docs/Dungourney.json |bash src/fx_to_rss.sh > docs/Dungourney.rss

# Generate Kiltha Web Page
cat docs/Kiltha.json | bash src/kiltha_to_html.sh > docs/kiltha.html
cp html/* docs/

echo "Hi" > docs/index.html