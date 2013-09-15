#!/bin/bash

HOMEDIR="/home/iacusm"
WEBDIR="$HOMEDIR/data/web/guayaba-ng"
ORIGDIR="$WEBDIR/_site/"
LOGDIR="$HOMEDIR/data/logs"
URL="guayaba2600.com"
USER="iacus"

# Generation step
#cd $WEBDIR
#jekyll build

# Transfer step
#lftp -e "'mirror -R -v $ORIGDIR . ; bye' $URL"
#lftp -e 'mirror -R -v --only-newer /mnt/whome/data/web/guayaba-ng/_site . ; bye' $URL

rsync -avr -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --delete --delete-after --progress --log-file=$LOGDIR/rsync-guayaba.log $ORIGDIR $USER@$URL:/var/www/guayaba2600.com/