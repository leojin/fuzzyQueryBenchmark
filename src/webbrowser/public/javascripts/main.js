var dataArr = [];

var queryWord;
var times;
var needDetail;
var dataLen;
var bM;

var testIndexOf = function () {
    bM.execute('WebBrowser IndexOf (' + times + ' times)', ['time(s)', 'found'], function () {
        var tR = new TimeRecord();
        var rst = 0;
        tR.tag();
        for (var i = 0; i < dataLen; i++) {
            if (-1 !== dataArr[i].indexOf(queryWord)) {
                rst++
            }
        }
        tR.tag();
        return tR.report(rst);
    }, times, []);
};

var testRegexAll = function () {
    bM.execute('WebBrowser Regex All (' + times + ' times)', ['time(s)', 'found'], function () {
        var tR = new TimeRecord();
        var rst = 0;
        var reg = new RegExp(preg_quote(queryWord));
        tR.tag();
        for (var i = 0; i < dataLen; i++) {
            if (reg.test(dataArr[i])) {
                rst++;
            }
        }
        tR.tag();
        return tR.report(rst);
    }, times, []);
};

var testRegexCompileAll = function () {
    bM.execute('WebBrowser Regex Compile All (' + times + ' times)', ['time(s)', 'found'], function () {
        var tR = new TimeRecord();
        var rst = 0;
        var reg = new RegExp(preg_quote(queryWord));
        reg.compile(preg_quote(queryWord));
        tR.tag();
        for (var i = 0; i < dataLen; i++) {
            if (reg.test(dataArr[i])) {
                rst++;
            }
        }
        tR.tag();
        return tR.report(rst);
    }, times, []);
};

var testRegexHead = function () {
    bM.execute('WebBrowser Regex Head (' + times + ' times)', ['time(s)', 'found'], function () {
        var tR = new TimeRecord();
        var rst = 0;
        var reg = new RegExp('^' + preg_quote(queryWord));
        tR.tag();
        for (var i = 0; i < dataLen; i++) {
            if (reg.test(dataArr[i])) {
                rst++;
            }
        }
        tR.tag();
        return tR.report(rst);
    }, times, []);
};

var testRegexCompileHead = function () {
    bM.execute('WebBrowser Regex Compile Head (' + times + ' times)', ['time(s)', 'found'], function () {
        var tR = new TimeRecord();
        var rst = 0;
        var reg = new RegExp('^' + preg_quote(queryWord));
        reg.compile('^' + preg_quote(queryWord));
        tR.tag();
        for (var i = 0; i < dataLen; i++) {
            if (reg.test(dataArr[i])) {
                rst++;
            }
        }
        tR.tag();
        return tR.report(rst);
    }, times, []);
};

var loadData = function (dtd) {
    $.get('/data', function (ret) {
        dataArr = ret;
        dataLen = dataArr.length;
        dtd.resolve();
    }, 'json');
};

var loadExe = function (dtd) {
    testIndexOf();
    testRegexAll();
    testRegexCompileAll();
    testRegexHead();
    testRegexCompileHead();
};

var deferred_1 = $.Deferred();
var deferred_2 = $.Deferred();

deferred_1.done(function () {
    loadExe(deferred_2);
});

deferred_2.done(function () {
});

$(function () {
    queryWord = $('input[name=queryWord]').val();
    times = parseInt($('input[name=times]').val(), 10);
    needDetail = ('on' == $('input[name=needDetail]').val()) ? true : false;
    bM = new BenchMark();
    if (needDetail) {
        bM.setDetailOn();
    } else {
        bM.setDetailOff();
    }
    loadData(deferred_1);
});
