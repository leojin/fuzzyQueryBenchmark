# -*- coding: utf-8 -*-

import time
import numpy as np

class BenchMark (object):
    def __init__(self):
        self.__detail = True
    def setDetailOn(self):
        self.__detail = True
    def setDetailOff(self):
        self.__detail = False
    def execute(self, name, title, cb, time, args = ()):
        print "BenchMark For %s" % name;
        print "\t" + "\t".join(title)
        rec = []
        for i in range(time):
            tmp = cb(*args)
            if self.__detail:
                print "%d/%d:\t%s" % (i + 1, time, "\t".join(map(lambda x: str(x), tmp)))
            rec.append(tmp)
        rst = map(lambda x: str(round(x / time, 5)), np.sum(rec, 0))
        print "AVE:\t" + "\t".join(rst)
        return rst

class TimeRecord (object):
    def __init__(self):
        self.__recordList = []
    def tag(self):
        curTime = time.time()
        self.__recordList.append(curTime)
    def report(self, extInfo = None):
        recordLength = len(self.__recordList)
        rst = []
        for idx, val in enumerate(self.__recordList[1:]):
            rst.append(val - self.__recordList[idx])
        if isinstance(extInfo, int) or isinstance(extInfo, float):
            rst.append(extInfo)
        return rst
