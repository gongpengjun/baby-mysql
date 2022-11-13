#!/bin/sh
# mysql_uptime2.sh - report server uptime

MYSQL_PWD=g1p2j3 mysql -h127.0.0.1 -P3307 -ugongpengjun -e STATUS | grep "^Uptime"
