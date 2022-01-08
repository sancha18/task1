#!/bin/bash         

while true ;
do
z=$(mysql -h mariadb-master -u root -pmasterqwerty -D test -vvv -e  "INSERT INTO test.new_table (name, address) VALUES ('aaa333', 'bbb2333'); " | grep "sec" | awk '{ print $6 }' | cut -f2 -d"(")
while read -r z
do
var=$(echo "writer $z");
echo $var;
curl -X POST -H "Content-Type: text/plain" --data "$var
" http://pushgateway-server:9091/metrics/job/writerscript/instance/writer-server
done <<< $z
sleep 1
done