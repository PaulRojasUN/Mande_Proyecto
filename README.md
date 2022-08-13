LINK DEL VIDEO EN YOUTUBE: https://youtu.be/RlKzX15FRPk

# Para Windows 10: 
- En la consola PowerShell, ubicarse en la carpeta database_postgres y ejecutar:

docker build -t mande_db .

- Luego ejecutar el siguiente:

docker run --name mande_db -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d mande_db

- Luego, en la consola PowerShell, nos ubicamos en la carpeta backend_express. Ejecutar:

docker build -t mande_backend .

- Luego:

docker run -it --rm -v ${pwd}:/usr/src/app mande_backend /bin/bash

-Después, ejecutar:

npm install
   exit

- Finalmente, ejecutar:

docker run -it --rm -p 3000:3000 -v ${pwd}:/usr/src/app --link mande_db:postgres --name mande_app mande_backend

# El inicio de la aplicación está en: 
http://localhost:3000/inicio



# PUEDE PROBAR COMANDOS SOBRE LA BASE DE DATOS DE SQL CON:
http://localhost:3000/realizarQuery/(comando sql)

# POR EJEMPLO: 
http://localhost:3000/realizarQuery/SELECT * FROM Cliente