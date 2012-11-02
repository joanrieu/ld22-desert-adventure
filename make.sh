#!/bin/bash

exec 1>alone.html

cat alone_header.html

(
        cd rooms
        start=boulder-desert
        for room in $start $(ls|egrep -v ^$start\$) ; do (
                cd "$room"
                theme=theme
                [ -f theme ] || theme="../${room%%-*}/theme"
                echo "<div data-role=page data-theme=$(cat $theme) id=$room><div data-role=header data-theme=$(cat $theme)><h1>$(cat title)</h1><a data-icon=star data-rel=dialog class=\"ui-btn-right deathbutton\" href=\"#deaths\">Deaths</a></div><div data-role=content>$(cat text |xargs -d "\n" -I{} echo "<p>{}</p>")<div data-role=controlgroup>$(cat options |awk -F'\t' "{ print \"<a data-role=button data-theme=$(cat $theme) href=\\\"#\"\$2\"\\\">\"\$1\"</a>\" }")</div></div></div>"
                [ -f death ] && echo "<script>setupDeathTrigger(\"$(cat death)\", '$room');</script>"
        ) ; done
)

cat alone_footer.html
