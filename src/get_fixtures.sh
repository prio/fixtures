#!/bin/sh
# deps:
#  * curl
#  * https://github.com/orf/html-query
#  

# Check if correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <URL> <TeamName>"
    exit 1
fi

URL="$1"
TEAM_NAME="$2"

curl -s "$URL" | \
    hq "{fixtures: .fixtures | [{
            date: @(data-date),
            time: @(data-time),
            hometeam: @(data-hometeam),
            awayteam: @(data-awayteam),
            homecrest: li.flogo1 > a > img | @(src),
            awaycrest: li.flogo2 > a > img | @(src),
            referee: @(data-referee),
            comment: @(data-comment),
            venue: @(data-venue),
            compname: @(data-compname)            
    }]
}" | jq --arg team "$TEAM_NAME" '
  def ordinal:
    if . == 1 or . == 21 or . == 31 then . | tostring + "st"
    elif . == 2 or . == 22 then . | tostring + "nd"
    elif . == 3 or . == 23 then . | tostring + "rd"
    else . | tostring + "th"
    end;

    .fixtures |= map(
        .dt = try (.date + " " + .time | strptime("%d %b %Y %H:%M") | strftime("%Y-%m-%d %H:%M")) catch ("") |
        .unix = try (.date + " " + .time | strptime("%d %b %Y %H:%M") | mktime) catch ("") |
        .date |= (strptime("%d %b %Y") | strftime("%a") as $dayOfWeek |  strftime("%-d") | tonumber as $dayNum | $dayOfWeek + " " + ($dayNum | ordinal)) |
        if .hometeam | test($team; "i") then
                .opposition = .awayteam |
                .crest = .awaycrest
        elif .awayteam | test($team; "i") then
                .opposition = .hometeam |
                .crest = .homecrest
        else
                .                
        end | 
        .age = if .compname | test("Fe12"; "i") then 
                "U12" 
        elif .compname | test("Fe13"; "i") then 
                "U13" 
        elif .compname | test("Fe14"; "i") then 
                "U14" 
        elif .compname | test("Fe14"; "i") then 
                "U15" 
        elif .compname | test("Fe16"; "i") then 
                "U16" 
        elif .compname | test("Fe17"; "i") then 
                "U17" 
        elif .compname | test("Fe18"; "i") then 
                "Minor" 
        else
                "Adult" 
        end          
)'
