var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

router.get('/', function (req, res, next)
{
    res.render('cambioLabores', { title: 'Express' });
});

router.post('/', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
      console.log(req.body);
      console.log("Agregar labor");
      if (req.body.boton == "agrego")
      {
            client.query(`INSERT INTO Servicio VALUES ('${req.body.celular}', '${req.body.nombre}', '${req.body.descripcion}');`, function (err, result) {
            //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
            done(err);
            if (err) {
              return console.error('error running query', err);
            }
            console.log("Se agregó una nueva labo a este socio");
            res.render('mainSocio', {celular: req.body.celular});
          });
      }
      else
      {
        res.render('ajustesSocio', {celular: req.body.celular});
      }
    });
  
  })

module.exports = router;