var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

router.get('/', function (req, res, next)
{
    res.render('politica', { title: 'Express' });
});

router.post('/', function (req, res, next) {
    connect(function (err, client, done) {
        console.log("Leído");
        console.log(req.body);
        res.render('mainCliente', { celular: req.body.celular});
    });
  
  })


module.exports = router;