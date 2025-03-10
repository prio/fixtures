#!/bin/sh
# deps:
#  * curl
#  * https://github.com/orf/html-query
#  

curl -s "https://www.eastcorkgaa.com/wp-admin/admin-ajax.php?action=fixtures&club_id=8256" | \
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
