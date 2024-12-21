# Author: Andres Felipe Melo Avellaneda
# Correo: andrespipemelo@gmail.com
# Utiliza la imagen oficial de MySQL
FROM mysql:latest

# Establece las variables de entorno para la base de datos
ENV MYSQL_DATABASE=mercado_libre
ENV MYSQL_ROOT_PASSWORD=rootpassword

# Copia los scripts SQL en el contenedor
COPY BaseDeDatos.sql /docker-entrypoint-initdb.d/
COPY datosPrueba.sql /docker-entrypoint-initdb.d/

# Exponer el puerto 3306 para MySQL
EXPOSE 3306