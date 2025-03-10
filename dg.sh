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
}" | jq '.fixtures |= map(
        .dt = (.date + " " + .time | strptime("%d %b %Y %H:%M") | strftime("%Y-%m-%d %H:%M")) |
        .unix = (.date + " " + .time | strptime("%d %b %Y %H:%M") | mktime) |
        if .hometeam | test("Dungourney"; "i") then
        .opposition = .awayteam
        elif .awayteam | test("Dungourney"; "i") then
        .opposition = .hometeam
        else
        .
        end        
)'