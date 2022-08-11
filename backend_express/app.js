const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');

const indexRouter = require('./routes/index');
const crearRouter = require('./routes/crear');

const queryRouter = require('./routes/query');
const usuarioRouter = require('./routes/usuario');
const personaRouter = require('./routes/persona');
const realizarQuery = require('./routes/ejecutarQuery');
//PARA EL PROYECTO
/*
const ajustesRouter = require('./routes/ajustes');
const ajustesSocioRouter = require('./routes/ajustesSocio');
const ayudaRouter = require('./routes/ayuda');
const cambioDireccionRouter = require('./routes/cambioDireccion');
const cambioMedioPagoRouter = require('./routes/cambioMedioPago');
const cambioPasswordRouter = require('./routes/cambioPassword');
const cambioPasswordSocioRouter = require('./routes/cambioPasswordSocio');
*/
const inicioRouter = require('./routes/inicio');
const registerRouter = require('./routes/register');
const registroClienteRouter = require('./routes/registroCliente');
/*
const loginRouter = require('./routes/login');
const loginClienteRouter = require('./routes/loginCliente');
const loginSocioRouter = require('./routes/loginSocio');
const mainClienteRouter = require('./routes/mainCliente');
const mainSocioRouter = require('./routes/mainSocio');
const politicaRouter = require('./routes/politica');


const registroCliente2Router = require('./routes/registroCliente2');
const registroSocioRouter = require('./routes/registroSocio');
const solicitarServicioRouter = require('./routes/solicitarServicio');
*/

const app = express();

// view engine setup

//app.set('views', path.join(__dirname, 'views'));



app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');


app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/crear', crearRouter);

app.use('/ejecutar_query', queryRouter);
app.use('/usuario', usuarioRouter);
app.use('/persona',personaRouter);
app.use('/realizarQuery',realizarQuery);
/*
app.use('/ajustes', ajustesRouter);
app.use('/ajustesSocio', ajustesSocioRouter);
app.use('/ayuda', ayudaRouter);
app.use('/cambioDireccion', cambioDireccionRouter);
app.use('/cambioLabores', cambioLaboresRouter);
app.use('/cambioMedioPago', cambioMedioPagoRouter);
app.use('/cambioPassword', cambioPasswordRouter);
app.use('/cambioPasswordSocio', cambioPasswordSocioRouter);
*/
app.use('/inicio', inicioRouter);
app.use('/register', registerRouter);
app.use('/registroCliente', registroClienteRouter);
/*
app.use('/login', loginRouter);
app.use('/loginCliente', loginClienteRouter);
app.use('/loginSocio', loginSocioRouter);
app.use('/mainCliente', mainClienteRouter);
app.use('/mainSocio', mainSocioRouter);
app.use('/politica', politicaRouter);


app.use('/registroCliente2', registroCliente2Router);
app.use('/registroSocio', registroSocioRouter);
app.use('/solicitarServicio', solicitarServicioRouter);
*/
// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
