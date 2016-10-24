#!/usr/bin/env bash

PATH_ROOT=`dirname $0`/..
SRC_ROOT=$PATH_ROOT/src

# nodejs
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
php $SRC_ROOT/php/testStrPos.php "$1" "$2" "$3"
echo ""
php $SRC_ROOT/php/testRegexAll.php "$1" "$2" "$3"
echo ""
php $SRC_ROOT/php/testRegexHead.php "$1" "$2" "$3"
echo ""

# python
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
