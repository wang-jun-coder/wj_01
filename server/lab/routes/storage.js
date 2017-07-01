/**
 * Created by sjg on 2017/6/19.
 */
var express = require('express');
var router = express.Router();

/* GET storage page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'storage' });
});


// cookie demo
function cookie(req, res, next) {

    res.render('./storage/cookie');
}
router.get('/cookie', cookie);
router.post('/cookie', cookie);


function sessionStorage(req, res, next) {

}
router.get('/sessionStorage', sessionStorage);
router.post('/sessionStorage', sessionStorage);

function localStorage(req, res, next) {

}
router.get('/localStorage', localStorage);
router.post('/localStorage', localStorage);

module.exports = router;
