#!/bin/sh
# deps:
#  * curl
#  * https://github.com/orf/html-query
#  

curl -s "https://rebelog.ie/wp-admin/admin-ajax.php?action=fixtures&club_id=8943&competition_id=&team_id=&displayResults=" | \
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
        if .hometeam | test("Kiltha"; "i") then
        .opposition = .awayteam
        elif .awayteam | test("Kiltha"; "i") then
        .opposition = .hometeam
        else
        .
        end        
)'
