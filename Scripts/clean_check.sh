#!/bin/bash 
#
# This script checks whether was Xcode project cleaned up or not
# @piechart
#

APP_NAME=CHMeetupApp
PROJECT_TITLE_BEGIN=$APP_NAME-
DERIVED=$HOME/Library/Developer/Xcode/DerivedData/

# Result: `true` if CHMeetupApp.app file NOT found (project is cleaned) or any dir not found
projectIsClean() {
    if [ -d $DERIVED ]; then
        cd $DERIVED
        DERIVED_DIRS=($(ls | grep $PROJECT_TITLE_BEGIN))
        if (( ${#DERIVED_DIRS[@]} > 0 )); then # checks count of found dirs
            PRODUCTS_DIR=$DERIVED${DERIVED_DIRS[0]}/Build/Products/
            if [ -d $PRODUCTS_DIR ]; then
                cd $PRODUCTS_DIR
                DIRS=($( ls -t ))
                if (( ${#DIRS[@]} > 0 )); then
                    cd ${DIRS[0]} # we're in Debug-iphonesimulator for example
                    APP_FILE=$APP_NAME.app
                    if [ -e $APP_FILE ]; then # if exists, checking its size
                        SIZE=$(du -hsk $APP_FILE | cut -f1)
                        if [ $SIZE -gt 0 ] ; then
                            return 1
                        fi
                    fi
                fi
            fi
        else
            echo Project dir with name starting with $PROJECT_TITLE_BEGIN not found in $DERIVED
        fi
    else
        echo $DERIVED not found
    fi
}

if projectIsClean; then
    echo 1
else
    echo 0
fi