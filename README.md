# BaseDatosMySQL

Este repositorio contiene la configuración y los scripts necesarios para desplegar una base de datos MySQL utilizando Docker. La base de datos está diseñada para un sistema de comercio electrónico.

## Contenido

- `docker-compose.yml`: Archivo de configuración para Docker Compose.
- `Dockerfile`: Archivo de configuración para construir la imagen de Docker.
- `BaseDeDatos.sql`: Script SQL para crear la estructura de la base de datos.
- `datosPrueba.sql`: Script SQL para insertar datos de prueba en la base de datos.
- `Comandos docker.txt`: Archivo de texto con comandos útiles para interactuar con Docker y MySQL.

## Requisitos

- Docker
- Docker Compose

## Instrucciones

### 1. Clonar el repositorio

```sh
git clone https://github.com/E-commerce-pr/BaseDatosMySQL.git
cd BaseDatosMySQL
```
### 2. Construir y levantar los contenedores
```sh
docker-compose up --build
```
### 3. Acceder a la consola del contenedor MySQL
```sh
docker exec -it mysql_mercado_libre bash
```
### 4. Conectarse a MySQL
```sh
mysql -u root -p
```
Usa la contraseña rootpassword cuando se te solicite.

### 5. Comandos SQL útiles
Mostrar bases de datos
```sql
SHOW DATABASES;
```
Usar la base de datos mercado_libre
```sql
USE mercado_libre;
```
Mostrar tablas
```sql
SHOW TABLES;
```
Ver contenido de una tabla
```sql
SELECT * FROM Usuario;
```
### Estructura de la Base de Datos

La base de datos `mercado_libre` está diseñada para un sistema de comercio electrónico y contiene las siguientes tablas:

### Tablas

1. **Usuario**
2. **Tienda**
3. **Producto**
4. **Venta**
5. **DetalleVenta**
6. **Factura**
7. **Pago**
8. **Reporte**
9. **Historial_Compra**
10. **Categoria**
11. **Producto_Categoria**
12. **Comentario**
13. **Calificacion**
14. **Direccion_Envio**
15. **Metodo_Pago**
16. **Carrito**
17. **Carrito_Producto**

---
---

**Autor:**  
Andrés Felipe Melo Avellaneda  
**Correo:** andrespipemelo@gmail.com
