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

CREATE OR REPLACE FUNCTION encriptar(INT) RETURNS VARCHAR(128) AS $$
DECLARE
cant INT;
res VARCHAR(128);
auxLetter VARCHAR(2);
auxRes VARCHAR(2);
BEGIN
	cant:= LENGTH(CONCAT($1));
	res := '';
	
	FOR i IN 1..cant LOOP
		auxLetter:= SUBSTRING(CONCAT($1), i, 1);
		IF  (auxLetter = '1') THEN auxRes:='A'; END IF;
		IF (auxLetter = '2') THEN auxRes:='B'; END IF;
		IF (auxLetter = '3') THEN auxRes:='C'; END IF;
		IF (auxLetter = '4') THEN auxRes:='D'; END IF;
		IF (auxLetter = '5') THEN auxRes:='E'; END IF;
		IF (auxLetter = '6') THEN auxRes:='F'; END IF;
		IF (auxLetter = '7') THEN auxRes:='G'; END IF;
		IF (auxLetter = '8') THEN auxRes:='H'; END IF;
		IF (auxLetter = '9') THEN auxRes:='I'; END IF;
		IF (auxLetter = '0')THEN auxRes:='J'; END IF;
    	res:= CONCAT(res, auxRes);
   	END LOOP;
   RETURN res;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION desencriptar(VARCHAR(128)) RETURNS INT AS $$
DECLARE
cant INT;
res VARCHAR(128);
auxLetter VARCHAR(2);
auxRes VARCHAR(2);
BEGIN
	cant:= LENGTH(CONCAT($1));
	res := '';
	
	FOR i IN 1..cant LOOP
		auxLetter:= SUBSTRING(CONCAT($1), i, 1);
		IF  (auxLetter = 'A') THEN auxRes:='1'; END IF;
		IF (auxLetter = 'B') THEN auxRes:='2'; END IF;
		IF (auxLetter = 'C') THEN auxRes:='3'; END IF;
		IF (auxLetter = 'D') THEN auxRes:='4'; END IF;
		IF (auxLetter = 'E') THEN auxRes:='5'; END IF;
		IF (auxLetter = 'F') THEN auxRes:='6'; END IF;
		IF (auxLetter = 'G') THEN auxRes:='7'; END IF;
		IF (auxLetter = 'H') THEN auxRes:='8'; END IF;
		IF (auxLetter = 'I') THEN auxRes:='9'; END IF;
		IF (auxLetter = 'J')THEN auxRes:='0'; END IF;
    	res:= CONCAT(res, auxRes);
   	END LOOP;
   RETURN CAST(res AS INT);
END
$$ LANGUAGE plpgsql;