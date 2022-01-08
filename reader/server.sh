#!/bin/bash         

while true ;
do
mysql -h mariadb-master -u root -pmasterqwerty -D test -e  "SELECT count(*) FROM test.new_table; " | nc -l -p 4444
done