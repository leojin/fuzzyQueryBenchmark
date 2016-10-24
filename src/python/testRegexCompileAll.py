#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import re
import lib

def main ():
    args = sys.argv[1:]
    if len(args) < 3:
        exit(1)

    queryWord = args[0]
    times = int(args[1])
    needDetail = 'on' == args[2] and True or False

    basePath = os.path.realpath(sys.path[0] + '/../..')
    dataFile = basePath + '/data/list'
    dataArr = []
    for line in open(dataFile, 'r'):
        dataArr.append(line)

    reg = re.compile(re.escape(queryWord))

    bM = lib.BenchMark();
    if needDetail:
        bM.setDetailOn()
    else:
        bM.setDetailOff()
    def callback (reg, dataArr):
        tR = lib.TimeRecord()
        rst = 0;
        tR.tag()
        for ins in dataArr:
            if reg.search(ins):
                rst = rst + 1
        tR.tag()
        return tR.report(rst)
    bM.execute("Python Regex Compile All (%d times)" % times, ['time(s)', 'found'], callback, times, [reg, dataArr])

if __name__ == "__main__":
    main()