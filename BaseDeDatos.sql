-- MySQL Script generated by MySQL Workbench
-- Mon Dec 16 22:17:33 2024
-- Author: Andres Felipe Melo Avellaneda
-- Correo: andrespipemelo@gmail.com
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mercado_libre
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mercado_libre` ;
CREATE SCHEMA IF NOT EXISTS `mercado_libre` DEFAULT CHARACTER SET utf8 ;
USE `mercado_libre` ;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Usuario` (
  `id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `correo_electronico` VARCHAR(150) NOT NULL,
  `contrasena` VARCHAR(255) NOT NULL,
  `fecha_registro` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `activo_como_vendedor` TINYINT NULL,
  PRIMARY KEY (`id_Usuario`),
  UNIQUE INDEX `correo_electronico_UNIQUE` (`correo_electronico` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda` (
  `id_tienda` INT NOT NULL AUTO_INCREMENT,
  `nombre_tienda` VARCHAR(100) NOT NULL,
  `Usuario_id_Usuario` INT NOT NULL,
  PRIMARY KEY (`id_tienda`),
  CONSTRAINT `fk_Tienda_Usuario`
    FOREIGN KEY (`Usuario_id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Tienda_Usuario_idx` ON `Tienda` (`Usuario_id_Usuario` ASC) VISIBLE;
CREATE UNIQUE INDEX `Usuario_id_Usuario_UNIQUE` ON `Tienda` (`Usuario_id_Usuario` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stock` INT NOT NULL,
  `Usuario_id_Usuario` INT NOT NULL,
  `Tienda_id_tienda` INT NOT NULL,
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `fk_Producto_Usuario1`
    FOREIGN KEY (`Usuario_id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Tienda1`
    FOREIGN KEY (`Tienda_id_tienda`)
    REFERENCES `Tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Producto_Usuario1_idx` ON `Producto` (`Usuario_id_Usuario` ASC) VISIBLE;
CREATE INDEX `fk_Producto_Tienda1_idx` ON `Producto` (`Tienda_id_tienda` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `total` DECIMAL(10,2) NOT NULL,
  `Comprador_id_Usuario` INT NOT NULL,
  PRIMARY KEY (`id_venta`),
  CONSTRAINT `fk_Venta_Usuario1`
    FOREIGN KEY (`Comprador_id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Venta_Usuario1_idx` ON `Venta` (`Comprador_id_Usuario` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mercado_libre`.`DetalleVenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DetalleVenta` (
  `id_detalle_venta` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `Producto_id_producto` INT NOT NULL,
  `Venta_id_venta` INT NOT NULL,
  PRIMARY KEY (`id_detalle_venta`, `Producto_id_producto`, `Venta_id_venta`),
  CONSTRAINT `fk_DetalleVenta_Producto1`
    FOREIGN KEY (`Producto_id_producto`)
    REFERENCES `Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleVenta_Venta1`
    FOREIGN KEY (`Venta_id_venta`)
    REFERENCES `Venta` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DetalleVenta_Producto1_idx` ON `DetalleVenta` (`Producto_id_producto` ASC) VISIBLE;
CREATE INDEX `fk_DetalleVenta_Venta1_idx` ON `DetalleVenta` (`Venta_id_venta` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Factura` (
  `id_factura` INT NOT NULL AUTO_INCREMENT,
  `fecha_emision` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `detalles_factura` TEXT NULL,
  `DetalleVenta_id_detalle_venta` INT NOT NULL,
  `DetalleVenta_Producto_id_producto` INT NOT NULL,
  `DetalleVenta_Venta_id_venta` INT NOT NULL,
  PRIMARY KEY (`id_factura`, `DetalleVenta_id_detalle_venta`, `DetalleVenta_Producto_id_producto`, `DetalleVenta_Venta_id_venta`),
  CONSTRAINT `fk_Factura_DetalleVenta1`
    FOREIGN KEY (`DetalleVenta_id_detalle_venta`, `DetalleVenta_Producto_id_producto`, `DetalleVenta_Venta_id_venta`)
    REFERENCES `DetalleVenta` (`id_detalle_venta`, `Producto_id_producto`, `Venta_id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Factura_DetalleVenta1_idx` ON `Factura` (`DetalleVenta_id_detalle_venta` ASC, `DetalleVenta_Producto_id_producto` ASC, `DetalleVenta_Venta_id_venta` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pago` (
  `id_pago` INT NOT NULL AUTO_INCREMENT,
  `metodo_pago` ENUM('pendiente', 'completado') NULL DEFAULT 'pendiente',
  `fecha_pago` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `DetalleVenta_id_detalle_venta` INT NOT NULL,
  `DetalleVenta_Producto_id_producto` INT NOT NULL,
  `DetalleVenta_Venta_id_venta` INT NOT NULL,
  PRIMARY KEY (`id_pago`, `DetalleVenta_id_detalle_venta`, `DetalleVenta_Producto_id_producto`, `DetalleVenta_Venta_id_venta`),
  CONSTRAINT `fk_Pago_DetalleVenta1`
    FOREIGN KEY (`DetalleVenta_id_detalle_venta`, `DetalleVenta_Producto_id_producto`, `DetalleVenta_Venta_id_venta`)
    REFERENCES `DetalleVenta` (`id_detalle_venta`, `Producto_id_producto`, `Venta_id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pago_DetalleVenta1_idx` ON `Pago` (`DetalleVenta_id_detalle_venta` ASC, `DetalleVenta_Producto_id_producto` ASC, `DetalleVenta_Venta_id_venta` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reporte` (
  `id_reporte` INT NOT NULL AUTO_INCREMENT,
  `tipo_reporte` VARCHAR(100) NOT NULL,
  `fecha_generacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `datos_reporte` JSON NULL,
  `Tienda_id_tienda` INT NOT NULL,
  PRIMARY KEY (`id_reporte`, `Tienda_id_tienda`),
  CONSTRAINT `fk_Reporte_Tienda1`
    FOREIGN KEY (`Tienda_id_tienda`)
    REFERENCES `Tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Reporte_Tienda1_idx` ON `Reporte` (`Tienda_id_tienda` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Historial_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Historial_Compra` (
  `id_Historial` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `id_Producto` INT NOT NULL,
  `fecha_compra` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_Historial`),
  INDEX `fk_Historial_Compra_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  INDEX `fk_Historial_Compra_Producto_idx` (`id_Producto` ASC) VISIBLE,
  CONSTRAINT `fk_Historial_Compra_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Historial_Compra_Producto`
    FOREIGN KEY (`id_Producto`)
    REFERENCES `Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categoria` (
  `id_Categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_Categoria`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Producto_Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Producto_Categoria` (
  `id_Producto` INT NOT NULL,
  `id_Categoria` INT NOT NULL,
  PRIMARY KEY (`id_Producto`, `id_Categoria`),
  INDEX `fk_Producto_Categoria_Producto_idx` (`id_Producto` ASC) VISIBLE,
  INDEX `fk_Producto_Categoria_Categoria_idx` (`id_Categoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Categoria_Producto`
    FOREIGN KEY (`id_Producto`)
    REFERENCES `Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Categoria_Categoria`
    FOREIGN KEY (`id_Categoria`)
    REFERENCES `Categoria` (`id_Categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comentario` (
  `id_Comentario` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `id_Producto` INT NOT NULL,
  `comentario` TEXT NOT NULL,
  `fecha_comentario` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Comentario`),
  INDEX `fk_Comentario_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  INDEX `fk_Comentario_Producto_idx` (`id_Producto` ASC) VISIBLE,
  CONSTRAINT `fk_Comentario_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Producto`
    FOREIGN KEY (`id_Producto`)
    REFERENCES `Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Calificacion` (
  `id_Calificacion` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `id_Producto` INT NOT NULL,
  `calificacion` INT NOT NULL,
  `fecha_calificacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Calificacion`),
  INDEX `fk_Calificacion_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  INDEX `fk_Calificacion_Producto_idx` (`id_Producto` ASC) VISIBLE,
  CONSTRAINT `fk_Calificacion_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Calificacion_Producto`
    FOREIGN KEY (`id_Producto`)
    REFERENCES `Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Direccion_Envio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Direccion_Envio` (
  `id_Direccion` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `ciudad` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(100) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `pais` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_Direccion`),
  INDEX `fk_Direccion_Envio_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Direccion_Envio_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Metodo_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Metodo_Pago` (
  `id_Metodo_Pago` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  `detalles` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_Metodo_Pago`),
  INDEX `fk_Metodo_Pago_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Metodo_Pago_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carrito` (
  `id_Carrito` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Carrito`),
  INDEX `fk_Carrito_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Carrito_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mercado_libre`.`Carrito_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carrito_Producto` (
  `id_Carrito` INT NOT NULL,
  `id_Producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_Carrito`, `id_Producto`),
  INDEX `fk_Carrito_Producto_Carrito_idx` (`id_Carrito` ASC) VISIBLE,
  INDEX `fk_Carrito_Producto_Producto_idx` (`id_Producto` ASC) VISIBLE,
  CONSTRAINT `fk_Carrito_Producto_Carrito`
    FOREIGN KEY (`id_Carrito`)
    REFERENCES `Carrito` (`id_Carrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carrito_Producto_Producto`
    FOREIGN KEY (`id_Producto`)
    REFERENCES `Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;