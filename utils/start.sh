#!/usr/bin/env bash

PATH_ROOT=`dirname $0`/..
SRC_ROOT=$PATH_ROOT/src

# nodejs
echo -e "\033[34m【     NodeJs     】\033[0m"
$SRC_ROOT/nodejs/testIndexOf.js "$1" "$2" "$3"
echo ""
$SRC_ROOT/nodejs/testRegexAll.js "$1" "$2" "$3"
echo ""
$SRC_ROOT/nodejs/testRegexCompileAll.js "$1" "$2" "$3"
echo ""
$SRC_ROOT/nodejs/testRegexHead.js "$1" "$2" "$3"
echo ""
$SRC_ROOT/nodejs/testRegexCompileHead.js "$1" "$2" "$3"
echo ""

# php
echo -e "\033[34m【     PHP     】\033[0m"
php $SRC_ROOT/php/testStrPos.php "$1" "$2" "$3"
echo ""
php $SRC_ROOT/php/testRegexAll.php "$1" "$2" "$3"
echo ""
php $SRC_ROOT/php/testRegexHead.php "$1" "$2" "$3"
echo ""

# python
echo -e "\033[34m【     Python     】\033[0m"
$SRC_ROOT/python/testFind.py "$1" "$2" "$3"
echo ""
$SRC_ROOT/python/testRegexAll.py "$1" "$2" "$3"
echo ""
$SRC_ROOT/python/testRegexCompileAll.py "$1" "$2" "$3"
echo ""
$SRC_ROOT/python/testRegexHead.py "$1" "$2" "$3"
echo ""
$SRC_ROOT/python/testRegexCompileHead.py "$1" "$2" "$3"
echo ""

# webbrowser
echo -e "\033[34m【     WebBrowser     】\033[0m"
cd $SRC_ROOT/webbrowser
echo "Please View {Your Host}:8989/?queryWord=$1&times=$2&needDetail=$3"
npm run start