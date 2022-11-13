#!/bin/bash

script_name=`basename "$0"`
if [ $# -gt 1 ] ; then
  echo "USAGE: ./${script_name} [optional_query.sql]"
  exit;
fi

if [ $# = 1 ] ; then
	# --batch (-B) --skip-column-names (-N) --execute (-e)
	# echo "--execute: $1"
	MYSQL_PWD=root mysql -h127.0.0.1 -P3307 -uroot -BNe "SOURCE $1"
else
	MYSQL_PWD=root mysql -h127.0.0.1 -P3307 -uroot
fi

