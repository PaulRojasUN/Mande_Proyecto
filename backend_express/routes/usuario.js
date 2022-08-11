var express = require('express');
var bodyParser = require('body-parser')

var router = express.Router();

const connect = require('./db_pool_connect');
const { application } = require('express');

/*
function logger(req, res, next){
  console.log(`Request received: ${req.protocol}://${req.get('host')}${req.originalUrl}`);
  next();
}

router.use(logger);
*/


/**
 * Listar todos los usuarios
 */
router.get('/', function (req, res, next) {
  connect(function (err, client, done) {
    if (err) {
      return console.error('error fetching client from pool', err);
    }

    //use the client for executing the query
    client.query('SELECT * FROM pg_catalog.pg_tables;', function (err, result) {
      //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
      done(err);

      if (err) {
        return console.error('error running query', err);
      }
      res.send(JSON.stringify(result.rows));
    });
  });

})

/**
 * Buscar un usuario dado su id_usuario
 */
router.get('/:id', function (req, res, next) {
  connect(function (err, client, done) {
    if (err) {
      return console.error('error fetching client from pool', err);
    }
    var numId  = req.params.id;

    //use the client for executing the query
    client.query(`SELECT * FROM usuario WHERE numIdentificacion=${req.params.id};`, function (err, result) {
      //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
      done(err);

      if (err) {
        return console.error('error running query', err);
      }

      res.send(JSON.stringify(result.rows[0]));
      var tel = JSON.parse(JSON.stringify(result.rows[0])).numtelefono;
      console.log("Este es el telefono: " + tel);
     // console.log(getNumTelefono(JSON.stringify(result.rows),req.params.id));
 
    });
  }
  );

})

/**
 * Crear un usuario dados su nombre de usuario y password. 
 * !Antes de crearlo debería verificar si ya existe.
 */
router.post('/', function (req, res, next) {
  connect(function (err, client, done) {
    if (err) {
      return console.error('error fetching client from pool', err);
    }

    //use the client for executing the query
    client.query(`INSERT INTO  usuario(nombre_usuario, password) VALUES ('${req.body.nombre_usuario}', '${req.body.password}');`, function (err, result) {
      //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
      done(err);
      if (err) {
        return console.error('error running query', err);
      }
      res.send(JSON.stringify(result));
    });
  });

})

module.exports = router;