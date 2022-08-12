\c mande_db

--Agregando datos a las tablas a modo de ejemplo.

--CREANDO USUARIO


INSERT INTO Coordenadas (coorX, coorY) VALUES (16, 13);

INSERT INTO Direccion (calle, carrera, infoAdicional, idCoordenada) VALUES ('Cl 9', 'Cr 20', 'Segundo piso', 1);

INSERT INTO Persona VALUES (123456, 'Alfredo Ramirez', 45, 1, 'Alfredo@gmail.com');

INSERT INTO Tarjeta(codigoTarjeta, tipoTarjeta) VALUES (encriptar(12345), 'DEBITO');

INSERT INTO Usuario VALUES (123456, 31643424, 1,'dirección imagen');

INSERT INTO PasswordPersona VALUES (123456, 'contraseña1');

--CREANDO TRABAJADOR
INSERT INTO Coordenadas (coorX, coorY) VALUES (32, 36);

INSERT INTO Direccion (calle, carrera, infoAdicional, idCoordenada) VALUES ('Cl 17', 'Cr 39', 'Al fondo de un callejón', 2);

INSERT INTO Persona VALUES (98765, 'Sara Nieves', 24, 2, 'sara@gmail.com');

INSERT INTO Tarjeta(codigoTarjeta, tipoTarjeta) VALUES (encriptar(32123), 'CRÉDITO');

INSERT INTO Trabajador VALUES (98765, 3214567, 'dirección foto perfil', 'dirección documento', 1.5, true);

INSERT INTO precioServicio(valor, cantHoras) VALUES (30000, 1);

INSERT INTO Servicio(nombreServicio, tipo, idPrecio, numIdentificacion) VALUES ('Paseadora de mascotas', 'mascotas', 1, 98765);

INSERT INTO PasswordPersona VALUES (98765, 'contraseña2');

