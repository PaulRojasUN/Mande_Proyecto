var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

router.get('/', function (req, res, next)
{
    res.render('ajustes', { title: 'Express' });
});

router.post('/', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
      console.log("ajustes");
      console.log(req.body);

      if (req.body.boton == "cambioP")
      {
          res.render('cambioPassword', {celular: req.body.celular });
      }
      else if (req.body.boton == "cambioD")
      {
        res.render('cambioDireccion', { celular: req.body.celular});
      }
      else if (req.body.boton == "cambioM")
      {
        res.render('cambioMedioPago', { celular: req.body.celular});
      }
      else if (req.body.boton == "volver")
      {
        res.render('mainCliente', { celular: req.body.celular});
      }
    });
  
  })

module.exports = router;
