#!/bin/sh

cat <<- EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags-->
    <meta  name="js-widget-title" content="Kiltha Og Fixtures">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kiltha Og Fixtures</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-family: 'Poppins', sans-serif;
            font-size: clamp(10px, 1.5vw, 32px);
        }
        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 80%;
            padding-top: 5%;
            padding-bottom: 5%;
        }
        .left, .right {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .center {
            display: flex;
            align-items: flex-start;
            flex-direction: column;
        }
        .circular-img {
            width: 100%;
            max-width: 12vw;
            border-radius: 50%;
            object-fit: cover;
        }
        .rounded-img {
            border-radius: 10px;
            width: 100%;
            max-width: 12vw;
        }    
        .center-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .text-content {
            margin-left: 10px;
        }         
        .corner {
            width: 10vw;
        }   
        .top-left { 
            top: 10px; 
            left: 10px; 
        }
        .top-right { 
            top: 1vw; 
            right: 1vw; 
        }
        .bottom-left { 
            bottom: 1vw; 
            left: 1vw; 
        }        
        .top-left, .top-right, .bottom-left, .bottom-right {
            position: absolute;
        }
        .label {            
            color: green;
        }
        .date {            
            margin: 5px 0;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="top-right"><img src="kilthaog_512.png" class="corner"></div>
    <div class="container">
EOF

gomplate -d fixtures=stdin:///dev/stdin -i '
{{ $data := (datasource "fixtures" | data.JSON) }}
{{ $first := index $data.fixtures 0 }}
{{ $second := index $data.fixtures 1 }}
{{ $third := index $data.fixtures 2 }}

        <div class="left">            
            <img src="{{ $first.crest }}" class="circular-img">
            <div class="label">{{ $first.age }}</div>
            <div class="date">{{ $first.date }}, {{ $first.time }}</div>
            <div class="opponent">{{ $first.opposition }}</div>
            <div class="venue">in {{ $first.venue }}</div>
        </div>
        <div class="center">
            <div class="center-item">
                <img src="{{ $second.crest }}" class="rounded-img">
                <div class="text-content">
                    <div class="date">{{ $second.date }}, {{ $second.time }}</div>
                    <div class="opponent">{{ $second.opposition }} in {{ $second.venue }}</div>
                    <div class="label">{{ $second.age }}</div>
                </div>
            </div>
            <div class="center-item">
                <img src="{{ $third.crest }}" class="rounded-img">
                <div class="text-content">
                    <div class="date">{{ $third.date }}, {{ $third.time }}</div>
                    <div class="opponent">{{ $third.opposition }} in {{ $third.venue }}</div>
                    <div class="label">{{ $third.age }}</div>
                </div>
            </div>
        </div>'

cat <<- EOF
    </div>
</body>
</html>
EOF