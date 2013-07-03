#!/bin/bash

WEBDIR="/mnt/whome/data/web/guayaba-ng"
ORIGDIR="$WEBDIR/_site/"
URL="31.170.165.158"

# Generation step
cd $WEBDIR
jekyll build

# Transfer step
#lftp -e "'mirror -R -v $ORIGDIR . ; bye' $URL"
lftp -e 'mirror -R -v --only-newer /mnt/whome/data/web/guayaba-ng/_site . ; bye' $URL