var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

router.get('/', function (req, res, next)
{
    res.render('mainCliente', { title: 'Express' });
});

router.post('/', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
      console.log(req.body);

      if (req.body.boton == "solicitar")
      {
          res.render('solicitarServicio', {celular: req.body.celular });
      }
      else if (req.body.boton == "ajustes")
      {
        res.render('ajustes', { celular: req.body.celular});
      }
      else if (req.body.boton == "ayuda")
      {
        res.render('ayuda', { celular: req.body.celular});
      }
      else if (req.body.boton == "politica")
      {
        res.render('politica', { celular: req.body.celular});
      }
    });
  
  })

module.exports = router;