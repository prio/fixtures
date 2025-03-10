# If today is Monday, from today until next Monday, otherwise from last Monday until next Monday
START="$(date -d "$( [ "$(date +%u)" -eq 1 ] && echo 'today' || echo 'last Monday' )" +%s)"
END="$(date -d 'next Monday' +%s)"

jq --argjson start "$START" --argjson list_end "$END" '.fixtures |= map(select(.unix >= $start and .unix <= $list_end))' docs/kog.json
