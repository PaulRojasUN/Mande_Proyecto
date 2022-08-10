var express = require('express');
var bodyParser = require('body-parser');

var router = express.Router();

const connect = require('./db_pool_connect');

router.get('/', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
  
      //use the client for executing the query
      client.query('SELECT * FROM Persona;', function (err, result) {
      console.log("Pasó por aquí");
        //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
        done(err);
  
        if (err) {
          return console.error('error running query', err);
        }
        res.send(JSON.stringify(result.rows));
      });
    });
  
  })

  router.get('/:id', function (req, res, next) {
    connect(function (err, client, done) {
      if (err) {
        return console.error('error fetching client from pool', err);
      }
  
      //use the client for executing the query
      client.query(`SELECT * FROM Persona where numIdentificacion=${req.params.id};`, function (err, result) {
      console.log("Pasó por aquí");
        //call `done(err)` to release the client back to the pool (or destroy it if there is an error)
        done(err);
  
        if (err) {
          return console.error('error running query', err);
        }
        res.send(JSON.stringify(result.rows[0]).nombre);
      });
    });
  
  })

  module.exports = router;