#!/bin/bash         

while true ;
do

    #$(mysql -h mariadb-master -u root -pmasterqwerty -D test -e  "SELECT count(*) FROM test.new_table; ") | nc -l -p 4444
    a=$(mysql -h mariadb-master -u root -pmasterqwerty -D test -e  "SELECT count(*) FROM test.new_table; ")
    b=$(hostname)
    z="$a $b"
    # echo $a $b
    #echo $z
    # nc -l -p 1500 -c 'echo -e "HTTP/1.1 200 OK\n\n $(date)"';
    echo $z | nc -l -p 4444
    
done