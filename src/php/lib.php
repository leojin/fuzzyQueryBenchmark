<?php
class Temp_Storage {
    public static $data = array();
    public static function set ($key, $value) {
        self::$data[$key] = $value;
    }
    public static function get ($key) {
        return self::$data[$key];
    }
}

class BenchMark {
    private $detail;
    function __construct () {
        $this->detail = true;
    }
    public function setDetailOn () {
        $this->detail = true;
    }
    public function setDetailOff () {
        $this->detail = false;
    }
    public function execute ($name, $title, $cb, $time, $args = array()) {
        echo "BenchMark For $name\n";
        echo "\t" . implode("\t", $title) . "\n";
        $rec = array();
        for ($i = 0; $i < $time; $i++) {
            $tmp = call_user_func_array($cb, $args);
            if ($this->detail) {
                echo ($i + 1) . '/' . $time . ":\t" . implode("\t", $tmp) . "\n";
            }
            $rec[] = $tmp;
        }
        $rst = array();
        $initial = array();
        if (!empty($rec)) {
            for ($i = 0; $i < count($rec[0]); $i++) {
                $initial[] = 0;
            }
        }
        Temp_Storage::set('time', $time);
        function rstReduceFunc ($x, $y) {
            $tar = array();
            for ($i = 0; $i < count($x); $i++) {
                $tar[] = $x[$i] + $y[$i];
            }
            return $tar;
        }
        function rstMapFunc ($v) {
            $time = Temp_Storage::get('time');
            return round(($v / $time), 6);
        }
        $rst = array_reduce($rec, 'rstReduceFunc', $initial);
        $rst = array_map('rstMapFunc', $rst);
        echo "AVE:\t" . implode("\t", $rst) . "\n";
        return $rst;
    }
}

class TimeRecord {
    private $recordList;
    function __construct() {
        $this->recordList = array();
    }
    public function tag () {
        $curTime = microtime(true);
        $this->recordList[] = $curTime;
    }
    public function report ($extInfo = null) {
        $recordLength = count($this->recordList);
        $rst = array();
        for ($i = 1; $i < $recordLength; $i++) {
            $rst[] = $this->recordList[$i] - $this->recordList[$i - 1];
        }
        if (is_numeric($extInfo)) {
            $rst[] = $extInfo;
        }
        return $rst;
    }
}
