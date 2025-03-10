#!/bin/sh
# deps:
#  * curl
#  * https://github.com/orf/html-query
#  

curl -s "https://gaacork.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=2822&competition_id=201557&team_id=327608&displayResults=1" | \
    hq "{fixtures: .fixtures | [{
            date: @(data-date),
            time: @(data-time),
            hometeam: @(data-hometeam),
            awayteam: @(data-awayteam),
            referee: @(data-referee),
            comment: @(data-comment),
            venue: @(data-venue),
            compname: @(data-compname)
    }]
}"
