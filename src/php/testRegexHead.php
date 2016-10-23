<?php

include 'lib.php';

if ($argc < 4) {
    exit(1);
}
$queryWord = $argv[1];
$times = intval($argv[2]);
$needDetail = ('on' == $argv[3]) ? true : false;

$basePath = dirname(dirname(dirname(__FILE__)));
$dataFile = $basePath . '/data/list';
$dataSource = file_get_contents($dataFile);
$dataArr = explode("\n", $dataSource);

$reg = '/^' . preg_quote($queryWord) . '/';

$bM = new BenchMark();
if ($needDetail) {
    $bM->setDetailOn();
} else {
    $bM->setDetailOff();
}
function callback ($reg, $dataArr) {
    $dataLen = count($dataArr);
    $tR = new TimeRecord();
    $rst = 0;
    $tR->tag();
    for ($i = 0; $i < $dataLen; $i++) {
        if (preg_match($reg, $dataArr[$i])) {
            $rst++;
        }
    }
    $tR->tag();
    return $tR->report($rst);
}
$bM->execute("PHP Regex Head ($times times)", array('time(s)', 'found'), 'callback', $times, array(
    $reg,
    $dataArr
));