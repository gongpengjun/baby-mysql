#!/bin/bash

script_name=`basename "$0"`
if [ $# -gt 1 ] ; then
  echo "USAGE: ./${script_name} [optional_query.sql]"
  exit;
fi

if [ $# = 1 ] ; then
  # --batch (-B) --skip-column-names (-N) --execute (-e)
  # echo "--execute: $1"
  MYSQL_PWD=g1p2j3 mysql -h127.0.0.1 -P3307 -ugongpengjun baby_database -BNe "SOURCE $1"
else
  MYSQL_PWD=g1p2j3 mysql -h127.0.0.1 -P3307 -ugongpengjun baby_database
fi

exit 0;
