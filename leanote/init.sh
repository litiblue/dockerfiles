#!/bin/sh
mongorestore -h db -d leanote --dir /usr/local/leanote/mongodb_backup/leanote_install_data/
sh /usr/local/leanote/bin/run.sh
