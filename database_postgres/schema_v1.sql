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

--CREACIÓN DE LAS TABLAS 

--Almacena coordenadas en dos dimensiones.
CREATE TABLE Coordenadas 
(
    idCoordenada SERIAL PRIMARY KEY,
    coorX INT,
    coorY INT
);

--Almacena información sobre las dirección.
CREATE TABLE Direccion 
(
    idDireccion SERIAL PRIMARY KEY,
    calle VARCHAR(64),
    carrera VARCHAR(64),
    infoAdicional VARCHAR(64),
    idCoordenada INT,
    CONSTRAINT fk_direccion_coordenadas FOREIGN KEY (idCoordenada) REFERENCES Coordenadas (idCoordenada)
);

--Almacena los datos básicos de las personas que utilicen la aplicación, ya sea como usuario o como trabajador.
CREATE TABLE Persona 
(
    numIdentificacion INT PRIMARY KEY,
    nombre VARCHAR(64),
    edad INT,
    idDireccion INT,
    email VARCHAR(128),
    CONSTRAINT fk_persona_direccion FOREIGN KEY (idDireccion) REFERENCES Direccion (idDireccion)
);

--Almancena la información de las tarjetas utilizadas como medio de pago de los usuarios. El atributo codigoTarjeta representa
--un numero que es encriptado en una cadena de caracteres por una función.
CREATE TABLE Tarjeta
(
    idTarjeta SERIAL PRIMARY KEY,
    codigoTarjeta VARCHAR(128),
    tipoTarjeta VARCHAR(32)
);

--Representa los usuarios que utilizan la aplicación para contratar algún trabajador para diligenciar un servicio.
CREATE TABLE Usuario 
(
    numIdentificacion INT PRIMARY KEY,
    numTelefono INT,
    idTarjeta INT,
  	fotoServiciosPublicos VARCHAR(128),
    CONSTRAINT fk_usuario_tarjeta FOREIGN KEY (idTarjeta) REFERENCES Tarjeta (idTarjeta),
    CONSTRAINT fk_usuario_persona FOREIGN KEY (numIdentificacion) REFERENCES Persona (numIdentificacion)
);

--Representa la información de los pagaos realizados por los usuarios.
CREATE TABLE Pago 
(
    idPago INT,
    numIdentificacion INT,
    medioDePago VARCHAR(32),
    montoAPagar FLOAT,
    fecha VARCHAR(32),
  	PRIMARY KEY (idPago, numIdentificacion),
    CONSTRAINT fk_pago_usuario FOREIGN KEY (numIdentificacion) REFERENCES Usuario(numIdentificacion)
);


--Representa la información de los trabajadores que prestan los servicios a los usuarios.
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

--Representa la información relacionada con las formas de pagar.
CREATE TABLE precioServicio
(
    idPrecio SERIAL PRIMARY KEY,
    valor FLOAT,
    cantHoras FLOAT
);

--Contiene la información de los servicios que son ofrecidos en la plataforma por los trabajadores. Notar que están conectados con 
--los trabajadores y los precios, permitiendo que dos trabajadores puedan ofrecer servicios iguales bajo distintas condiciones.
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

--Esta tabla contiene la información de las contraseñas que tiene las entidades "Persona", ya sea un usuario o un trabajador.
CREATE TABLE PasswordPersona
(
    numIdentificacion INT PRIMARY KEY,
    password VARCHAR(128),
  	CONSTRAINT fk_passwordPersona_persona FOREIGN KEY (numIdentificacion) REFERENCES Persona (numIdentificacion)
);


--CREACION DE FUNCIONES

--Esta función recibe un número entero y transforma cada cifra a su equivalente posición en el abecedario, representando un proceso de
--encriptado,
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

--Esta función revierte el proceso hecho por la función encriptar(INT), recibiendo una cadena de carácteres y con base a la posición
--del carácter en el abecedario, lo convierte en un número entero.
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