#!/usr/bin/env node
var fs = require('fs');
var path = require('path');
var lib = require('./lib.js');
var args = process.argv.splice(2);

if (args.length < 3) {
    process.exit();
}

var queryWord = args[0];
var time = parseInt(args[1], 10);
var needDetail = ('on' == args[2]) ? true : false;

var dataFile = path.resolve(__dirname, '../../data/list');
var dataArr = fs.readFileSync(dataFile, 'utf-8').split('\n');
var dataLen = dataArr.length;
var reg = new RegExp('^' + lib.preg_quote(queryWord));
reg.compile('^' + lib.preg_quote(queryWord));

var bM = new lib.BenchMark();
if (needDetail) {
    bM.setDetailOn();
} else {
    bM.setDetailOff();
}
bM.execute('NodeJs Regex Compile Head (' + time + ' times)', ['time(s)', 'found'], function () {
    var tR = new lib.TimeRecord();
    var rst = 0;
    tR.tag();
    for (var i = 0; i < dataLen; i++) {
        if (reg.test(dataArr[i])) {
            rst++;
        }
    }
    tR.tag();
    return tR.report(rst);
}, time, []);
