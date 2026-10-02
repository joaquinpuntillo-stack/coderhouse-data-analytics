-- ============================================================
-- M5 - Consultas con JOINs sobre Ventas_Tech_DB
-- Joaquin Puntillo - 02/10/2026
-- ============================================================
USE Ventas_Tech_DB;
GO

-------------- Consulta 1 - Vista base del proyecto (INNER JOIN) --------------
-- Cruza las cuatro tablas para obtener la vista enriquecida del negocio.
-- Hallazgo: devuelve las 10 ventas con cliente, region, producto y categoria en una sola fila.

SELECT v.fecha_venta as fecha,
c.nombre as cliente,
c.region as region,
p.nombre_producto as producto,
ca.nombre_categoria as categoria,
v.cantidad as cantidad,
v.precio_unitario as precio_unitario,
v.cantidad * v.precio_unitario AS total_venta
FROM   ventas   v
JOIN   clientes c ON c.id_cliente = v.id_cliente
JOIN productos p on p.id_producto = v.id_producto
JOIN categorias ca on ca.id_categoria = p.id_categoria;


---------------- Consulta 2 - Clientes que nunca compraron (LEFT JOIN) ------------------
-- Identifica clientes registrados sin ninguna compra.
-- Hallazgo: hay un cliente registrado que nunca compro, 1 de 6.

select c.nombre, c.email, c.fecha_registro
from clientes c
left join ventas v on v.id_cliente = c.id_cliente
where v.id_venta is null;


---------------- Consulta 3 - Productos sin ventas (LEFT JOIN) -------------------------
-- Identifica productos del catalogo sin ninguna venta registrada.
-- Hallazgo: hay un producto del catalogo sin ventas, 1 de 7, con 45 unidades en stock.

select p.nombre_producto, ca.nombre_categoria, p.precio
FROM      productos  p
JOIN      categorias ca ON ca.id_categoria = p.id_categoria
LEFT JOIN ventas     v  ON v.id_producto   = p.id_producto
WHERE     v.id_venta IS NULL;


------------------ Consulta 4 - Consolidado por canal (UNION ALL) -----------------------------
-- Separa las ventas de marzo en dos quincenas y totaliza por cada una.
-- Hallazgo: la primera quincena facturo 3.620 y la segunda 2.824, una caida del 22% con 5 ventas en cada una.

WITH ventas_por_canal AS (
SELECT v.cantidad * v.precio_unitario AS total, 'Primera quincena' AS canal
FROM   ventas v
WHERE  v.fecha_venta < '2024-03-11'
union all 
SELECT v.cantidad * v.precio_unitario AS total, 'Segunda quincena' AS canal
FROM   ventas v
WHERE  v.fecha_venta >= '2024-03-11')
SELECT   canal,
         COUNT(*)   AS cantidad_ventas,
         SUM(total) AS total_facturado
FROM     ventas_por_canal
GROUP BY canal;
