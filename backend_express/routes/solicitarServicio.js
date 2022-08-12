var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

router.get('/', function (req, res, next)
{
    res.render('solicitarServicio', { title: 'Express' });
});

router.post('/', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
      console.log("El botón funciona");
      console.log(req.body);
      if (req.body.boton == "filtrar")
      {
        client.query(`SELECT celular, nombreServicio, descPagos FROM Servicio WHERE nombreServicio LIKE CONCAT('%','${req.body.filtro}','%');`, function (err, result) {
          //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
          console.log(req.body.filtro);
          console.log(result);

          done(err);
          if (err) {
            return console.error('error running query', err);
          }
          res.render('solicitarServicio', { lista: JSON.stringify(result.rows)});
        });
      }
    });
  
  })

module.exports = router;