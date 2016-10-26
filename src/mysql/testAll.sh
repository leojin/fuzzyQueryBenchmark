#!/usr/bin/env bash

if [[ $# -lt 3 ]]; then
    exit 1
fi

PATH_ROOT=`dirname $0`/../..
DATA_ROOT=$PATH_ROOT/data

queryWord=$1
times=$2
needDetail=$3

mysql_bin="mysql"
mysql_socket="$DATA_ROOT/mysql/var/mysqld.sock"
mysql_user="root"
mysql_db="fuzzy_query"
name="MYSQL %str% NO INDEX ($times times)"

field="noIndex"
fuzzy="%$queryWord%"

sql="set profiling=1;select SQL_NO_CACHE count(*) from fuzzy_query where $field like \"$fuzzy\";SHOW PROFILES;"


echo "BenchMark For $name"
echo -e "\tfound\ttime(s)"
list=""
for((i=0; i < $times; i++))
do
    rst=`$mysql_bin -S $mysql_socket -u$mysql_user -D$mysql_db -e "$sql"|tail -n 5|awk 'NR % 2 == 0'|sed 's/\t/\n/g'|awk 'NR % 2 == 1'|sed '$!N;s/\n/\t/g'`
    if [ "$needDetail" == "on" ]; then
        echo -e $[ $i + 1 ]/$times":\t$rst"
    fi
    if [ x"$list" == x"" ]; then
        list=$rst
    else
        list=$list"\n"$rst
    fi
done
echo -e $list|awk '{ sum1 += $1;sum2 += $2 } END { print "AVE:\t"sum1/NR"\t"sum2/NR}'