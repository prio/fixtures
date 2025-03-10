echo "<html>
    <head>
    <meta  name=\"js-widget-title\" content=\"Dungourney Fixtures\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Fixtures Table</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    </head>
    <body>
        <table>
            <tr>
                <th>Date</th>
                <th>Versus</th>
                <th>Competition Name</th>
                <th>Venue</th>
            </tr>" > docs/dungourney.html

cat docs/dg.json | jq -r '.fixtures[] | 
    "<tr>
        <td>" + .date + " " + .time + "</td>
        <td>" + .opposition + "</td>
        <td>" + .compname + "</td>
        <td>" + .venue + "</td>
    </tr>"
' >> docs/dungourney.html

echo "</table></body></html>" >> docs/dungourney.html
