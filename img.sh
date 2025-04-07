cp ScheduleTemplate.png schedule.png


jq -c '.[]' "$JSON_FILE" | while read -r fixture; do



convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-420-245" "Sat 22nd" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-230-245" "U14" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-60-245" "Aghada" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "18" -font "DejaVu-Sans" -fill "black" -annotate "+260-255" "Castlemartyr" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "18" -font "DejaVu-Sans" -fill "black" -annotate "+260-235" "Premier 2 Section 1 Football League" "schedule.png"
convert "schedule.png" -gravity "Center" -stroke "rgb(200,200,200)" -strokewidth 2 -draw "line 100,325 900,325" "schedule.png"

convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-420-190" "Sun 23rd" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-230-190" "U16" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "24" -font "DejaVu-Sans" -fill "black" -annotate "-60-190" "Dunmanway" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "18" -font "DejaVu-Sans" -fill "black" -annotate "+260-200" "Dungourney" "schedule.png"
convert "schedule.png" -gravity "Center" -pointsize "18" -font "DejaVu-Sans" -fill "black" -annotate "+260-180" "Premier 2 Section 2 Hurling League" "schedule.png"
convert "schedule.png" -gravity "Center" -stroke "rgb(200,200,200)" -strokewidth 2 -draw "line 100,380 900,380" "schedule.png"