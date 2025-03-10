cp html/app.js docs/
cp html/kilthaog_512.png docs/
cp html/manifest.json docs/

cat html/kilta_header.html > docs/kiltha.html

cat docs/kog.json | jq -r '.fixtures[] | 
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
    </li>"' >> docs/kiltha.html

cat html/kilta_footer.html >> docs/kiltha.html
