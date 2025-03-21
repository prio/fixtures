cat <<- EOF
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags-->
    <meta  name="js-widget-title" content="Kiltha Og Fixtures">
    <link rel="manifest" href="manifest.json" />
    <meta charset="utf-8">
    <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, viewport-fit=cover">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <!-- Your app title -->
    <title>Fixtures</title>
    <!-- Path to Framework7 Library Bundle CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/framework7@8.3.4/framework7-bundle.min.css">
    <style>
/* Navbar Styling */
.navbar .navbar-inner {
    display: flex;
}

/* Logo Styling */
.navbar-logo {
    height: auto;
    padding: 10px; /* Add some space */
}        
    </style>    
</head>

<body>
    <!-- App root element -->
    <div id="app">

        <!-- Your main view, should have "view-main" class -->
        <div class="view view-main">
            <!-- Initial Page, "data-name" contains page name -->
            <div data-name="home" class="page">

                <!-- Top Navbar -->
                <div class="navbar">
                    <div class="navbar-bg"></div>
                    <div class="navbar-inner">
                        <img src="https://kilthaog.com/wp-content/uploads/2023/02/kiltha-bar-5.png" class="navbar-logo">
                    </div>
                </div>

                <!-- Bottom Toolbar -->
                <div class="toolbar toolbar-bottom">
                    <div class="toolbar-inner">
                        <!-- Toolbar links -->
                    </div>
                </div>

                <!-- Scrollable page content -->
                <div class="page-content">
                    <div class="list media-list list-dividers">
                        <ul>
                        <!-- Inserted -->
EOF

jq -r '.fixtures[] | 
    "<li class=\"custom-media-item\">
        <div class=\"item-content\">
            <div class=\"item-media\">
                <img width=\"70\" style=\"border-radius: 8px\" src=\"" + .crest + "\" />
            </div>
            <div class=\"item-inner\">
                <div class=\"item-title-row\">
                    <div class=\"item-title\">" + .date + ", " + .time + "</div>
                    <div class=\"item-after\">" + .age + "</div>
                </div>
                <div class=\"item-subtitle\">" + .opposition + " in " + .venue + "</div>
                <div class=\"item-text\">" + .compname + "</div>
            </div>                                    
        </div>                                          
    </li>"'

cat <<- EOF
                <!-- End Of Inserted -->
            </div>
        </div>
    </div>
    <!-- Path to Framework7 Library Bundle JS-->
    <script src="https://cdn.jsdelivr.net/npm/framework7@8.3.4/framework7-bundle.min.js"></script>
    <!-- Path to your app js-->
    <script type="text/javascript" src="app.js"></script>
</body>
</html>
EOF