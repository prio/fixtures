# Download Fixtures
/bin/bash src/dg.sh > docs/dg.json
/bin/bash src/dg_gaa.sh > docs/dg_gaa.json
/bin/bash src/kog.sh > docs/kog.json

# Generate Kiltha WEb Page
/bin/bash src/kiltha_to_html.sh
cp html/app.js docs/

# Not yet in use
/bin/bash src/dg_to_html.sh
/bin/bash src/kog_filter.sh

echo "Hi" > docs/index.html