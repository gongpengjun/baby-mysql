#!/bin/sh
# count_rows.sh - count rows in database table

# require two arguments on the command line
if [ $# -ne 2 ]; then
  echo "Usage: ./count_rows.sh {database_name} {table_name}";
  exit 1;
fi

database_name=$1
table_name=$2

# use argument (${table_name}) in the query string
MYSQL_PWD=g1p2j3 mysql -h127.0.0.1 -P3307 -ugongpengjun ${database_name} <<MYSQL_INPUT
SELECT COUNT(*) AS 'Rows in table: ${database_name}.${table_name}' FROM ${table_name};
MYSQL_INPUT
