var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    var query = req.query;
    var varSet = {};
    if ('queryWord' in query) {
        varSet['queryWord'] = query['queryWord'];
    } else {
        varSet['queryWord'] = 'queryWord';
    }
    if ('times' in query && parseInt(query['times'], 10)) {
        varSet['times'] = parseInt(query['times'], 10);
    } else {
        varSet['times'] = 10;
    }
    if ('needDetail' in query) {
        varSet['needDetail'] = query['needDetail'];
    } else {
        varSet['needDetail'] = 'on';
    }
  res.render('index', varSet);
});

module.exports = router;
