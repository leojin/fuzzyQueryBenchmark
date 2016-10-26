#!/usr/bin/env bash

set -u

PATH_ROOT=`dirname $0`/..
SRC_ROOT=$PATH_ROOT/src
DATA_ROOT=$PATH_ROOT/data

BIN_NODE="node"
BIN_PHP="php"
BIN_PYTHON="python"

CASE_NODEJS="$BIN_NODE $SRC_ROOT/nodejs"
CASE_PHP="$BIN_PHP $SRC_ROOT/php"
CASE_PYTHON="$BIN_PYTHON $SRC_ROOT/python"
CASE_WEBBROWSER="$SRC_ROOT/webbrowser"
CASE_MYSQL="$SRC_ROOT/mysql"

EXPRESS_PORT="8989"

arg_query_word="abc"
arg_times=10
arg_need_detail="off"

function executeCmd() {
    $1 $arg_query_word $arg_times $arg_need_detail
    echo ""
}

function entry_help() {
    local scriptname="`dirname $0`/`basename $0`"
    cat << EOF

This tool will make a benchmark about 'fuzzy query' in different way.
Every test will find the matched strings within 10,000 lines(data/list, this resource was created randomly, you can replace it)

usage $scriptname [options] [args] <TEST PROJECT1> <TEST PROJECT2> ...

<TEST PROJECT> php、nodejs、python、webbrowser、mysql

-w ARG     query word, default: abc
-t ARG     times in every test, default: 10
-d ARG     [on/off] need detail info in every test, default: off
EOF
}

function main() {
    while getopts "w:t:d:h" opt; do
        case $opt in
            w )
                arg_query_word=$OPTARG
                ;;
            t )
                arg_times=$OPTARG
                ;;
            d )
                arg_need_detail=$OPTARG
                ;;
            h )
                entry_help
                exit 0
                ;;
            ＊ )
                ;;
        esac
    done
    shift $(($OPTIND - 1))
    if [[ $# -lt 1 ]]; then
        entry_help
    fi
    for testName in $@; do
        case "$testName" in   
            "nodejs")
                echo -e "\033[34m【   NodeJs   】\033[0m"
                executeCmd "$CASE_NODEJS/testIndexOf.js"
                executeCmd "$CASE_NODEJS/testRegexAll.js"
                executeCmd "$CASE_NODEJS/testRegexCompileAll.js"
                executeCmd "$CASE_NODEJS/testRegexHead.js"
                executeCmd "$CASE_NODEJS/testRegexCompileHead.js"
                ;;
            "php")
                echo -e "\033[34m【   PHP   】\033[0m"
                executeCmd "$CASE_PHP/testStrPos.php"
                executeCmd "$CASE_PHP/testRegexAll.php"
                executeCmd "$CASE_PHP/testRegexHead.php"
                ;;
            "python")
                echo -e "\033[34m【   Python   】\033[0m"
                executeCmd "$CASE_PYTHON/testFind.py"
                executeCmd "$CASE_PYTHON/testRegexAll.py"
                executeCmd "$CASE_PYTHON/testRegexCompileAll.py"
                executeCmd "$CASE_PYTHON/testRegexHead.py"
                executeCmd "$CASE_PYTHON/testRegexCompileHead.py"
                ;;
            "mysql")
                echo -e "\033[34m【   Mysql   】\033[0m"
                mysqlDbDir=$DATA_ROOT/mysql
                mysqld_safe --defaults-file=$mysqlDbDir/cnf/mysql.cnf &
                sleep 5
                executeCmd "$CASE_MYSQL/testAll.sh"
                executeCmd "$CASE_MYSQL/testHead.sh"
                executeCmd "$CASE_MYSQL/testAllIndex.sh"
                executeCmd "$CASE_MYSQL/testHeadIndex.sh"
                kill `cat $mysqlDbDir/var/mysqld.pid`
                ;;
            "webbrowser")
                echo -e "\033[34m【   WebBrowser   】\033[0m"
                cd $CASE_WEBBROWSER
                echo "TIP:Please open the console"
                echo "Please View {Your Host}:$EXPRESS_PORT/?queryWord=$arg_query_word&times=$arg_times&needDetail=$arg_need_detail"
                $BIN_NODE bin/www $EXPRESS_PORT
        esac 
    done 
}

main "$@"

exit $?
