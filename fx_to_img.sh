#!/bin/bash

# Configuration
INPUT_JSON="fixtures.json"
START_Y_POS=245  # Starting Y position for text
START_LINE_POS=325  # Starting Y position for line
Y_INCREMENT=55  # Amount to increment Y position for each fixture

# Make a copy of the template to start with a fresh image
cp ScheduleTemplate.png schedule.png

# Process the JSON fixtures and execute commands directly
jq -r '.fixtures[] | @json' "$INPUT_JSON" | while read -r fixture; do
    # Parse fixture data
    date=$(echo "$fixture" | jq -r '.Date')
    time=$(echo "$fixture" | jq -r '.Time')
    team=$(echo "$fixture" | jq -r '.Team')
    opponent=$(echo "$fixture" | jq -r '.Versus')
    venue=$(echo "$fixture" | jq -r '.Venue // "Home"')
    competition=$(echo "$fixture" | jq -r '.Competition')
    
    echo "Processing fixture: $date $time - $team vs $opponent"
    
    # Execute convert commands for this fixture
    convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-420-$START_Y_POS" "$date" "schedule.png"
    convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-320-$START_Y_POS" "$time" "schedule.png"

    convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-230-$START_Y_POS" "$team" "schedule.png"
    convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-60-$START_Y_POS" "$opponent" "schedule.png"
    convert "schedule.png" -gravity "Center" -pointsize "22" -font "DejaVu-Sans" -fill "black" -annotate "+260-$(($START_Y_POS+10))" "$venue" "schedule.png"
    convert "schedule.png" -gravity "Center" -pointsize "18" -font "DejaVu-Sans" -fill "black" -annotate "+260-$(($START_Y_POS-10))" "$competition" "schedule.png"
    convert "schedule.png" -gravity "Center" -stroke "rgb(200,200,200)" -strokewidth 2 -draw "line 100,$START_LINE_POS 900,$START_LINE_POS" "schedule.png"
    
    # Increment Y positions for next fixture
    START_Y_POS=$(($START_Y_POS - $Y_INCREMENT))
    START_LINE_POS=$(($START_LINE_POS + $Y_INCREMENT))
done

echo "Schedule image created as schedule.png"