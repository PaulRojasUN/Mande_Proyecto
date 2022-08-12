var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

router.get('/', function (req, res, next)
{
    res.render('cambioMedioPago', { title: 'Express' });
});

router.post('/', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
      console.log(req.body);
      console.log("Cambio Medio Pago");
      if (req.body.boton == "cambio")
      {
            client.query(`UPDATE Tarjeta SET tipo = '${req.body.radioB}' WHERE celular = '${req.body.celular}';
            UPDATE Tarjeta SET noTarjeta = '${req.body.numero}' WHERE celular = '${req.body.celular}';
            UPDATE Tarjeta SET codigoSeguridad = '${req.body.codigo}' WHERE celular = '${req.body.celular}';`, function (err, result) {
            //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
            done(err);
            if (err) {
              return console.error('error running query', err);
            }
            console.log("Se cambió el medio pago");
            res.render('mainCliente', {celular: req.body.celular});
          });
      }
      else
      {
        res.render('ajustes', {celular: req.body.celular});
      }
    });
  
  })

module.exports = router;