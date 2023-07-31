#!/usr/bin/env bash

IFS='
'
export $(egrep -v '^#' .env | xargs -0)
IFS=
prodDir=$PWD
branch=$@
if [  -z "$@" ]
  then
    if [  -z "$PROJECTS_BRANCH" ]
      then
        branch=main
      else
        branch=$PROJECTS_BRANCH
      fi
fi
echo "Working branch " $branch

curl -F chat_id=$TELEGRAM_ADMIN_CHAT -F text="start deploy ${BASE_DOMAIN} ${branch}" \
https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage

git pull origin $PROJECTS_BRANCH

cd $prodDir && docker-compose up -d --build

curl -F chat_id=$TELEGRAM_ADMIN_CHAT -F text="finish deploy ${BASE_DOMAIN}" \
https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage