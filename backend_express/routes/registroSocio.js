var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

router.get('/', function (req, res, next)
{
    res.render('registroSocio', { title: 'Express' });
});

router.post('/', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
      console.log("Ha pasado por aquí");
      console.log(req.body);
      if (req.body.boton == "registro")
      {
        client.query(`INSERT INTO Trabajador VALUES ('${req.body.celular}', '${req.body.nombres}', '${req.body.apellidos}', '${req.body.password}', '${req.body.direccion}');
                        INSERT INTO Servicio VALUES ('${req.body.celular}', '${req.body.labor}', '${req.body.descripcion}');`, function (err, result) {
          //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
          
          done(err);
          if (err) {
            return console.error('error running query', err);
          }
          res.render('loginSocio', { title: 'Express' });
        });
      }
      else
      {
        res.render('inicio', { title: 'Express' });
      }
    });
  
  })

module.exports = router;