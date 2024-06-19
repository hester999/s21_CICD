#!/bin/bash

STAGE=$1
CHAT_ID="387888779"
BOT_TOKEN="6993236110:AAFyUbJ1hXfIOl3nqSrbeyR9hcO9qwShBcY"

sleep 5

if [ "$CI_JOB_STATUS" == "success" ]; then
	    MESSAGE="Stage $STAGE -> $CI_JOB_NAME done successfully! $CI_PROJECT_URL/pipelines"
    else
	        MESSAGE="Stage $STAGE -> $CI_JOB_NAME failed! $CI_PROJECT_URL/pipelines"
fi

curl -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$MESSAGE"

