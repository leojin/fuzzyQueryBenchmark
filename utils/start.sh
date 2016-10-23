#!/usr/bin/env bash

PATH_ROOT=`dirname $0`/..
SRC_ROOT=$PATH_ROOT/src

# nodejs
$SRC_ROOT/nodejs/testIndexOf.js "$1" "$2" "$3"
$SRC_ROOT/nodejs/testRegexAll.js "$1" "$2" "$3"
$SRC_ROOT/nodejs/testRegexCompileAll.js "$1" "$2" "$3"
$SRC_ROOT/nodejs/testRegexHead.js "$1" "$2" "$3"
$SRC_ROOT/nodejs/testRegexCompileHead.js "$1" "$2" "$3"

# php
php $SRC_ROOT/php/testStrPos.php "$1" "$2" "$3"
php $SRC_ROOT/php/testRegexAll.php "$1" "$2" "$3"
php $SRC_ROOT/php/testRegexHead.php "$1" "$2" "$3"