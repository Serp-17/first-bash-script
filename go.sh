FILE=./site.txt;
ERROR_LINKS=./error_links.txt;
LINK_COUNTER=`cat ./site.txt | wc -l`;
MAIN_LIINK=$1;
USER=YGSeattle:WP9qk!3w

function getMessageEnd {
    if [[ -f $ERROR_LINKS ]]; then
        echo "Bro, you have problem(((";
    else
        echo "All links good";
        echo "Cool!";
    fi
}

function getStatus {
    while ((i++)); read -r line;
    do
        sleep 1;
        STATUS=`curl -u YGSeattle:WP9qk!3w -Is -k $line | grep "HTTP"`
        echo "$LINK_COUNTER -> $i"
        if [[ $STATUS == *"404"* ]]; then
            echo "${line} ${STATUS}" >> $ERROR_LINKS;
        elif [[ $STATUS == *"500"* ]]; then
            echo "$LINK_COUNTER -> $i";
            echo "${line} ${STATUS}" >> $ERROR_LINKS;
        fi
    done < $FILE
    getMessageEnd;
}

function myFunc {
    if [[ -f "$ERROR_LINKS" ]]; then rm -r $ERROR_LINKS; fi;
    
    if [[ -f "$FILE" ]]; then
        getStatus
    else
        curl -u $USER $MAIN_LIINK | \
        grep -e loc | sed 's|<loc>\(.*\)<\/loc>$|\1|g' > $FILE;
        getStatus;
    fi
}

myFunc