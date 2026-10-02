-- ============================================================
-- M3 - Creacion de la base Ventas_Tech_DB (DDL + DML)
-- Joaquin Puntillo - actualizado 02/10/2026
-- Ampliado para el M5: columna region en clientes, un cliente
-- sin compras y un producto sin ventas.
-- ============================================================

if db_id('Ventas_Tech_DB') is null
	create database Ventas_Tech_DB;
	go
	use Ventas_Tech_DB
	go

---------- Sección 1 — DROP TABLES ----------
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
GO

---------- Sección 2 — CREATE TABLES ----------
	create table categorias (
	id_categoria int,
	nombre_categoria varchar(50) not null,
	descripcion varchar(200),
	constraint pk_categoria primary key (id_categoria)
	);

	create table clientes (
	id_cliente int,
	nombre varchar(100) not null,
	email varchar(100) unique,
	ciudad varchar (50),
	region varchar (50),
	fecha_registro date not null,
	constraint pk_cliente primary key (id_cliente)
	);

	create table productos (
	id_producto int,
	nombre_producto varchar (100) not null,
	id_categoria int not null,
	precio decimal (10,2) not null,
	stock int not null default 0,
	activo bit not null default 1,
	constraint pk_producto primary key (id_producto),
	constraint fk_categoria_producto foreign key (id_categoria) references categorias (id_categoria)
	);

	create table ventas (
	id_venta int,
	id_cliente int not null,
	id_producto int not null,
	cantidad int not null,
	precio_unitario decimal (10,2) not null,
	fecha_venta date not null,
	constraint pk_venta primary key (id_venta),
	constraint fk_ventas_clientes foreign key (id_cliente) references clientes (id_cliente),
	constraint fk_ventas_producto foreign key (id_producto) references productos (id_producto)

	);
	GO

	---------- Seccion 3 - INSERT DATA ----------

	INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
  (1, 'Computación',    'Laptops, PCs y monitores'),
  (2, 'Accesorios',     'Periféricos y complementos'),
  (3, 'Audio',          'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');

  INSERT INTO clientes (id_cliente, nombre, email, ciudad, region, fecha_registro) VALUES
  (1, 'María López',  'maria@mail.com',  'Buenos Aires', 'AMBA', '2024-01-05'),
  (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba', 'Centro' , '2024-01-10'),
  (3, 'Ana Gómez',    'ana@mail.com',    'Rosario', 'Litoral' , '2024-02-01'),
  (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',  'Cuyo' , '2024-02-15'),
  (5, 'Laura Torres', 'laura@mail.com',  'Tucumán','NOA' , '2024-03-01'),
  (6, 'Joaquin Puntillo', 'joaquin@mail.com' ,'Buenos Aires', 'AMBA', '2024-02-01');

  INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES
  (1, 'Laptop Pro 15',      1, 1200.00, 15, 1),
  (2, 'Mouse Inalámbrico',  2,   28.00, 80, 1),
  (3, 'Monitor 4K 27',      1,  450.00, 12, 1),
  (4, 'Auriculares BT Pro', 3,  120.00, 35, 1),
  (5, 'SSD Externo 1TB',    4,  130.00, 18, 1),
  (6, 'Teclado Mecánico',   2,   95.00, 40, 1),
  (7, 'Play Station', 1, 2000.00, 45, 1);

  INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
  ( 1, 1, 1, 2, 1200.00, '2024-03-05'),
  ( 2, 2, 2, 5,   28.00, '2024-03-06'),
  ( 3, 3, 3, 1,  450.00, '2024-03-07'),
  ( 4, 1, 4, 2,  120.00, '2024-03-08'),
  ( 5, 4, 5, 3,  130.00, '2024-03-10'),
  ( 6, 2, 6, 4,   95.00, '2024-03-11'),
  ( 7, 5, 1, 1, 1200.00, '2024-03-12'),
  ( 8, 3, 2, 8,   28.00, '2024-03-13'),
  ( 9, 4, 4, 1,  120.00, '2024-03-14'),
  (10, 5, 3, 2,  450.00, '2024-03-15');

  	---------- Seccion 4 - VALIDACION ----------

  SELECT * FROM categorias;
  select * from clientes;
  select * from productos;
  select * from ventas;
