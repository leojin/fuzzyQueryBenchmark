var fs = require('fs');
var path = require('path');
var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
    var dataFile = path.resolve(__dirname, '../../../data/list');
    var dataArr = fs.readFileSync(dataFile, 'utf-8').split('\n');
    res.send(dataArr);
});

module.exports = router;
