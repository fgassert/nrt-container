#!/bin/bash

export $(cat .env)

NRT_REPO=${TARGET_REPO:-https://github.com/resource-watch/nrt-scripts.git}
NRT_DIR=$(basename $NRT_REPO .git)
LOG=udp://logs6.papertrailapp.com:37123

# fetch repo
echo "pulling repository"
if [ -d "$NRT_DIR" ]; then
    cd $NRT_DIR
    git pull origin master
else
    git clone $NRT_REPO
    cd $NRT_DIR
fi

cp ../.env .env

# set up crontab
echo "Creating cronfile"
rm -f crontab
find . -name "*.cron" | while read fname; do
    cp -f .env $(basename $(dirname $fname))
    echo "$(cat $fname) cd $(pwd)/$(basename $(dirname $fname)) && LOG=$LOG ./start.sh  " >> cron.tmp
done

cat cron.tmp
crontab cron.tmp

echo "Finished"
