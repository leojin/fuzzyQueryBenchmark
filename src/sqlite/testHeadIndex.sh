#!/usr/bin/env bash

if [[ $# -lt 3 ]]; then
    exit 1
fi

PATH_ROOT=`dirname $0`/../..
DATA_ROOT=$PATH_ROOT/data

queryWord=$1
times=$2
needDetail=$3

sqlite_bin="sqlite3"
sqlite_db="$DATA_ROOT/list.lite"
name="SQLITE str% WITH INDEX ($times times)"

field="withIndex"
fuzzy="$queryWord%"

sql="select count(*) from fuzzy_query where $field like \"$fuzzy\";"


echo "BenchMark For $name"
echo -e "\tfound\ttime(s)"
list=""
for((i=0; i < $times; i++))
do
    rst=`echo "
.timer on
$sql"|sqlite3 $sqlite_db|sed 'N;s/\n/\t/g'|awk '{print $1"\t"$5}'`
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