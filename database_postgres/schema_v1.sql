-- Database: mande_db

-- DROP DATABASE mande_db;

CREATE DATABASE mande_db
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    TEMPLATE template0;

\c mande_db


CREATE TABLE Coordenadas (idCoordenada SERIAL PRIMARY KEY, coorX INT,coorY INT);

CREATE TABLE Direccion (idDireccion SERIAL PRIMARY KEY,calle VARCHAR(64),carrera VARCHAR(64),infoAdicional VARCHAR(64),idCoordenada INT,CONSTRAINT fk_direccion_coordenadas FOREIGN KEY (idCoordenada) REFERENCES Coordenadas (idCoordenada));

CREATE TABLE Persona 
(
    numIdentificacion INT PRIMARY KEY,
    nombre VARCHAR(64),
    edad INT,
    idDireccion INT,
    email VARCHAR(128),
    CONSTRAINT fk_persona_direccion FOREIGN KEY (idDireccion) REFERENCES Direccion (idDireccion)
);

CREATE TABLE Tarjeta
(
    idTarjeta SERIAL PRIMARY KEY,
    codigoTarjeta VARCHAR(128),
    tipoTarjeta VARCHAR(32)
);

CREATE TABLE Usuario 
(
    numIdentificacion INT PRIMARY KEY,
    numTelefono INT,
    idTarjeta INT,
  	fotoServiciosPublicos VARCHAR(128),
    CONSTRAINT fk_usuario_tarjeta FOREIGN KEY (idTarjeta) REFERENCES Tarjeta (idTarjeta),
    CONSTRAINT fk_usuario_persona FOREIGN KEY (numIdentificacion) REFERENCES Persona (numIdentificacion)
);

CREATE TABLE Pago 
(
    idPago INT,
    numIdentificacion INT,
    medioDePago VARCHAR(32),
    montoAPagar FLOAT,
  	PRIMARY KEY (idPago, numIdentificacion),
    CONSTRAINT fk_pago_usuario FOREIGN KEY (numIdentificacion) REFERENCES Usuario(numIdentificacion)
);

CREATE TABLE Trabajador 
(
    numIdentificacion INT PRIMARY KEY,
    numTelefono INT,
    fotoDePerfilTrab VARCHAR(128),
    fotoDocumentoID VARCHAR(128),
    estrellas FLOAT,
    disponible BOOLEAN,
  	CONSTRAINT fk_trabajador_persona FOREIGN KEY (numIdentificacion) REFERENCES Persona (numIdentificacion)
);


CREATE TABLE precioServicio
(
    idPrecio SERIAL PRIMARY KEY,
    valor FLOAT,
    cantHoras FLOAT
);

CREATE TABLE Servicio 
(
    idServicio SERIAL PRIMARY KEY,
    nombreServicio VARCHAR(64),
    tipo VARCHAR(32),
    idPrecio INT,
    numIdentificacion INT,
 	CONSTRAINT fk_servicio_precio FOREIGN KEY (idPrecio) REFERENCES precioServicio (idPrecio),
    CONSTRAINT fk_servicio_trabajador FOREIGN KEY (numIdentificacion) REFERENCES Trabajador (numIdentificacion)
);

CREATE TABLE PasswordPersona
(
    numIdentificacion INT PRIMARY KEY,
    password VARCHAR(128),
  	CONSTRAINT fk_passwordPersona_persona FOREIGN KEY (numIdentificacion) REFERENCES Persona (numIdentificacion)
);