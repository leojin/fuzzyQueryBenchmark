#!/usr/bin/env bash

set -u

PATH_ROOT=`dirname $0`/..
SRC_ROOT=$PATH_ROOT/src

CASE_NODEJS_ROOT=$SRC_ROOT/nodejs
CASE_PHP_ROOT=$SRC_ROOT/php
CASE_PYTHON_ROOT=$SRC_ROOT/python
CASE_WEBBROWSER_ROOT=$SRC_ROOT/webbrowser

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

<TEST PROJECT> php、nodejs、python、webbrowser

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
                executeCmd "$CASE_NODEJS_ROOT/testIndexOf.js"
                executeCmd "$CASE_NODEJS_ROOT/testRegexAll.js"
                executeCmd "$CASE_NODEJS_ROOT/testRegexCompileAll.js"
                executeCmd "$CASE_NODEJS_ROOT/testRegexHead.js"
                executeCmd "$CASE_NODEJS_ROOT/testRegexCompileHead.js"
                ;;
            "php")  
                echo -e "\033[34m【   PHP   】\033[0m"
                executeCmd "php $CASE_PHP_ROOT/testStrPos.php"
                executeCmd "php $CASE_PHP_ROOT/testRegexAll.php"
                executeCmd "php $CASE_PHP_ROOT/testRegexHead.php"
                ;;
            "python")
                echo -e "\033[34m【   Python   】\033[0m"
                executeCmd "$CASE_PYTHON_ROOT/testFind.py"
                executeCmd "$CASE_PYTHON_ROOT/testRegexAll.py"
                executeCmd "$CASE_PYTHON_ROOT/testRegexCompileAll.py"
                executeCmd "$CASE_PYTHON_ROOT/testRegexHead.py"
                executeCmd "$CASE_PYTHON_ROOT/testRegexCompileHead.py"
                ;;
            "webbrowser")
                echo -e "\033[34m【   WebBrowser   】\033[0m"
                cd $CASE_WEBBROWSER_ROOT
                echo "Please View {Your Host}:8989/?queryWord=$arg_query_word&times=$arg_times&needDetail=$arg_need_detail"
                npm run start
        esac 
    done 
}

main "$@"

exit $?
