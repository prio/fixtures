API_KEY=AIzaSyAB0XP3I2QB-WTiMxjMwTcZeIABICc7nZQ
SPREADSHEET_ID=1MH8hYBY8j1OVN7VFqnvH8N9Y8FXp2_yvcmkI1dRNQ34
SHEET_NAME1=RebelOg
SHEET_NAME2=GoGames

START="$(date -d "$( [ "$(date +%u)" -eq 1 ] && echo 'today' || echo 'last Monday' )" +%s)"
#END="$(date -d 'next Monday' +%s)"
END="$(date -d 'next Wednesday' +%s)"

SPREADSHEET_URL="https://sheets.googleapis.com/v4/spreadsheets/$SPREADSHEET_ID/values/$SHEET_NAME1?key=$API_KEY"
RESPONSE_1=$(curl -s "$SPREADSHEET_URL")

SPREADSHEET_URL="https://sheets.googleapis.com/v4/spreadsheets/$SPREADSHEET_ID/values/$SHEET_NAME2?key=$API_KEY"
RESPONSE_2=$(curl -s "$SPREADSHEET_URL")

#echo "Filtering data from $(date -d @$START) and $(date -d @$END)"
jq -n --argjson data1 "$RESPONSE_1" --argjson data2 "$RESPONSE_2" '
  # Extract headers and data from both sheets
  $data1.values[0] as $headers1 |
  $data1.values[1:] as $rows1 |
  
  $data2.values[0] as $headers2 |
  $data2.values[1:] as $rows2 |
  
  # Create items from first sheet
  ($rows1 | map(
    [[$headers1, .] | transpose[] | {key: .[0], value: .[1]}] | from_entries |
    .unix |= tonumber |
    .Competition |= try (sub("^.*Fe[0-9]+\\s+"; "")) catch("")
  )) as $items1 |
  
  # Create items from second sheet
  ($rows2 | map(
    [[$headers2, .] | transpose[] | {key: .[0], value: .[1]}] | from_entries |
    .unix |= tonumber |
    .Competition |= try (sub("^.*Fe[0-9]+\\s+"; "")) catch("")
  )) as $items2 |
  
  # Combine both sets of items
  {
    fixtures: ($items1 + $items2)
  }
' | jq --argjson start "$START" --argjson list_end "$END" '.fixtures |= map(select(.unix >= $start and .unix <= $list_end))'