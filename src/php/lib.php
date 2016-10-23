<?php
class BenchMark {
    private $detail;
    function __construct () {
        $this->detail true;
    }
    public function setDetailOn () {
        $this->detail = true;
    }
    public function setDetailOff () {
        $this->detail = false;
    }
    public function execute ($name, $title, $cb, $time, $args) {
        echo "BenchMark For $name\n";
        echo "\t" . implode("\t", $title) . "\n";
        $rec = array();
        for ($i = 0; $i < $time; $i++) {
            $tmp = 
        }
    }
      
}
class TimeRecord {

}