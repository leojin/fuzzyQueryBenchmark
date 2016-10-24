var BenchMark = function () {
    var self = this;
    var detail = true;
    self.setDetailOn = function () {
        detail = true;
    };
    self.setDetailOff = function () {
        detail = false;
    };
    self.execute = function (name, title, cb, time, args) {
        if ('function' !== typeof cb) {
            return false;
        }
        console.log('BenchMark For ' + name);
        console.log('\t' + title.join('\t'));
        var rec = [];
        for (var i = 0; i < time; i++) {
            var tmp = cb.apply(cb, args);
            if (detail) {
                console.log((i + 1) + '/' + time + ':\t' + tmp.join('\t'));
            }
            rec.push(tmp);
        }
        var rst = rec.reduce(function (x, y) {
            var tar = [];
            for (var i = 0; i < x.length; i++) {
                tar.push(x[i] + y[i]);
            }
            return tar;
        }).map(function (obj, idx) {
            return Math.round(obj / time * 10000) / 10000;
        });
        console.log('AVE:\t' + rst.join('\t'));
        return rst;
    }
};

var TimeRecord = function () {
    var recordList = [];
    var self = this;
    self.tag = function () {
        var curTime = (new Date()).getTime();
        recordList.push(curTime);
    }
    self.report = function (extInfo) {
        var recordLength = recordList.length;
        var rst = [];
        for (var i = 1; i < recordLength; i++) {
            rst.push((recordList[i] - recordList[i - 1]) / 1000);
        }
        if ('number' == typeof extInfo) {
            rst.push(extInfo);
        }
        return rst;
    }
};

var preg_quote = function (str, delimiter) {
  return (str + '').replace(new RegExp('[.\\\\+*?\\[\\^\\]$(){}=!<>|:\\' + (delimiter || '') + '-]', 'g'), '\\$&');
};