-- Datos Prueba
-- Author: Andres Felipe Melo Avellaneda
-- Correo: andrespipemelo@gmail.com
USE mercado_libre;

-- Insertar un usuario que será solo comprador
INSERT INTO Usuario (id_Usuario, nombre, correo_electronico, contrasena, activo_como_vendedor)
VALUES (1, 'Comprador1', 'comprador1@example.com', 'password123', 0);

-- Insertar un usuario que será vendedor
INSERT INTO Usuario (id_Usuario, nombre, correo_electronico, contrasena, activo_como_vendedor)
VALUES (2, 'Vendedor1', 'vendedor1@example.com', 'password123', 1);

-- Crear una tienda para el vendedor
INSERT INTO Tienda (id_tienda, nombre_tienda, Usuario_id_Usuario)
VALUES (1, 'Tienda Vendedor1', 2);

-- Insertar productos para la tienda del vendedor
INSERT INTO Producto (id_producto, nombre_producto, descripcion, precio, stock, Usuario_id_Usuario, Tienda_id_tienda)
VALUES (1, 'Producto1', 'Descripción del Producto1', 10.99, 100, 2, 1),
        (2, 'Producto2', 'Descripción del Producto2', 15.99, 50, 2, 1);

-- Verificar los datos insertados
SELECT * FROM Usuario;
SELECT * FROM Tienda;
SELECT * FROM Producto;