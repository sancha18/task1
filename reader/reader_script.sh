#!/bin/bash         

#mysql -h mariadb-master -u root -pmasterqwerty -D test -e  "SELECT count(*) FROM test.new_table; " | nc -l -d -p 4444 &>/dev/null &
#mysql -h mariadb-master -u root -pmasterqwerty -D test -vvv -e  "SELECT count(*) FROM test.new_table; " | nc -l -p 4444 &

/bin/bash /app/server.sh &>/dev/null &

while true ;
do

z=$(mysql -h mariadb-master -u root -pmasterqwerty -D test -vvv -e  "SELECT count(*) FROM test.new_table;" | grep "sec" | awk '{ print $5 }' | cut -f2 -d"(")
while read -r z
do
var=$(echo "reader $z");
echo $var;
curl -X POST -H "Content-Type: text/plain" --data "$var
" http://pushgateway-server:9091/metrics/job/readerscript/instance/reader-server
done <<< $z
sleep 1
done

# while true ; 
# do  mysql -h mariadb-master -u root -pmasterqwerty -D test -e  "SELECT count(*) FROM test.new_table; " | nc -l -p 4444  ;
# done