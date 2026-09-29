-- ============================================================
-- M4 - Consultas de negocio sobre Ventas_Tech_DB
-- Joaquin Puntillo - 29/09/2026
-- ============================================================
USE Ventas_Tech_DB;
GO

select month(fecha_venta) as mes,
       count(cantidad) total_pedidos,
       sum(precio_unitario * cantidad) as total_facturado,
       avg(precio_unitario * cantidad) as ticket_promedio
from ventas
group by month(fecha_venta);

select top 5 id_producto as producto,
       sum(cantidad) as unidades, 
       sum(precio_unitario * cantidad) as total_facturado
from ventas
group by id_producto
order by total_facturado desc;

select id_cliente as cliente,
       COUNT(*) as cantidad_pedidos,
       sum(precio_unitario * cantidad) as total_gastado
from ventas
group by id_cliente
having count(*) > 1
order by total_gastado desc;

with ventas_por_mes as(
select month(fecha_venta) as mes,
       sum(precio_unitario * cantidad) as total_facturado
from ventas
group by month(fecha_venta))
SELECT mes,
       total_facturado,
       CASE WHEN total_facturado > (SELECT AVG(total_facturado) FROM ventas_por_mes)
            THEN 'Por encima'
            ELSE 'Por debajo'
       END AS comparacion
FROM   ventas_por_mes
ORDER BY mes;

---Solo hay ventas de Marzo---
---El id_proudcto 1 fue el mas vendido---
---todos los clientes fueron igual de recurrentes en el periodo de analisis---
