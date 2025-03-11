#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <TeamName>"
    exit 1
fi

TEAM_NAME="$1"

cat <<- EOF
<?xml version="1.0" encoding="UTF-8"?>
    <rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
    <channel>
        <atom:link href="https://www.apps.searon.org/feeds/fixtures.xml" rel="self" type="application/rss+xml"/>
        <title>Fixtures</title>
        <link>https://gaacork.ie/</link>
        <description>Latest fixtures</description>
EOF

cat docs/"$TEAM_NAME".json | jq -r '.fixtures[] | 
    "<item>
        <title><![CDATA[" + .hometeam + " v " + .awayteam + "]]></title>
        <guid isPermaLink=\"false\"><![CDATA[https://gaacork.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=2822]]></guid>
        <link><![CDATA[https://gaacork.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=2822]]></link>
        <pubDate>" + (.unix | strftime("%a, %d %b %Y %H:%M:%S %z")) + "</pubDate>
        <description><![CDATA[
            <div>
                <img src=\"" + .crest + "\"/>
            </div>
            " + .venue + ", " + .date + " " + .time + "<br />
            " + .compname + "
        ]]></description>
    </item>"' 

cat <<- EOF
    </channel>
    </rss>
EOF