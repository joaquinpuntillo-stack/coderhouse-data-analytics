# RetailPro - Proyecto de Data Analytics
 
Proyecto integrador del curso **Data Analytics** de Coderhouse (comisión 91030). Recorre el flujo completo de un análisis de datos: base de datos en SQL Server, consultas de negocio, ETL en Power Query y modelo con medidas DAX en Power BI.
 
> **Sobre los nombres:** RetailPro es el nombre del proyecto integrador del curso. La base de datos se llama `Ventas_Tech_DB` y es de una tienda de tecnología. No hay ninguna base llamada RetailPro.
 
## Estructura del repositorio
 
| Ruta | Módulo | Contenido |
|---|---|---|
| `modulo-3/ventas_tech_db.sql` | 3 | Crea la base `Ventas_Tech_DB`, las 4 tablas y carga los datos |
| `modulo-4/m4_consultas_negocio.sql` | 4 | Ventas por mes, top 5 de productos, clientes con más de un pedido y mes contra promedio (CTE) |
| `modulo-5/m5_consultas_joins.sql` | 5 | Vista base con INNER JOIN de las 4 tablas, clientes sin compras y productos sin ventas (LEFT JOIN) y consolidado por quincena (UNION ALL) |
| `Pipeline_ETL_Puntillo_Joaquin.pbix` | 6 | ETL en Power Query: `Dim_Clientes`, `Dim_Productos`, `Dim_Categorias` y `Fact_Ventas` |
| `Puntillo_Joaquin_Checkpoint2 (1).pbix` | 8 | Modelo de datos: relaciones 1:N, tabla calendario `Dim_Fechas` y tabla `_Medidas` con 5 medidas DAX |
 
## Modelo de datos (SQL)
 
`categorias` 1:N `productos` 1:N `ventas` N:1 `clientes`
 
| Tabla | Filas | Clave |
|---|---|---|
| `categorias` | 4 | `id_categoria` |
| `clientes` | 6 | `id_cliente` |
| `productos` | 7 | `id_producto`, con FK a `categorias` |
| `ventas` | 10 | `id_venta`, con FK a `clientes` y a `productos` |
 
## Herramientas
 
- **SQL Server 2016 o superior** y **SSMS** para los scripts
- **Power BI Desktop** (Power Query y DAX)
- **GitHub**
 
## Cómo ejecutar los scripts SQL
 
1. Bajá el repositorio con **Code → Download ZIP**, o clonalo:
   ```bash
   git clone https://github.com/joaquinpuntillo-stack/coderhouse-data-analytics.git
   ```
2. Abrí SSMS y conectate a tu instancia de SQL Server.
3. Abrí `modulo-3/ventas_tech_db.sql` y ejecutalo completo con **F5**. No hace falta crear la base antes: el script la crea si no existe, borra las tablas y las vuelve a cargar. Se puede correr todas las veces que haga falta.
4. Revisá los cuatro `SELECT` del final. Tienen que dar **4 categorías, 6 clientes, 7 productos y 10 ventas**.
5. Ejecutá `modulo-4/m4_consultas_negocio.sql` y después `modulo-5/m5_consultas_joins.sql`. Los dos empiezan con `USE Ventas_Tech_DB`, no hay que elegir la base a mano.
 
El orden importa: los módulos 4 y 5 leen las tablas que crea el módulo 3. El módulo 5 necesita la versión actual de ese script, que es la que tiene la columna `region`, un cliente sin compras y un producto sin ventas.
 
Los scripts están escritos para SQL Server (`TOP`, `BIT`, `GO`, `DROP TABLE IF EXISTS`). No corren tal cual en MySQL ni en PostgreSQL.
 
## Archivos de Power BI
 
Los `.pbix` **no se conectan a la base SQL**. Leen el Excel del curso `Pipeline_ETL_Dataset.xlsx` (hojas clientes, productos, ventas y categorias), que es otro juego de datos: 50 ventas entre enero de 2023 y julio de 2024.
 
- Se pueden abrir y mirar sin nada más: los datos ya están cargados dentro del archivo.
- Para actualizarlos hace falta ese Excel, que no está en este repositorio, y cambiar la ruta del origen, que hoy apunta a una carpeta de mi máquina (**Transformar datos → Configuración de origen de datos**).
- Los totales de Power BI (47.578) no coinciden con los de SQL (6.444) porque son datos distintos. No hay que compararlos.
 
## Qué muestran los datos
 
**SQL** (10 ventas, del 5 al 15 de marzo de 2024)
 
- Facturación total: 6.444. Ticket promedio: 644,40.
- Computación concentra el 76,8% de la facturación (Laptop Pro 15: 55,9%; Monitor 4K 27: 20,9%).
- El Mouse Inalámbrico es el producto con más unidades (13 de 29), pero factura el 5,6%.
- Hay un producto sin ventas (Play Station, 45 unidades en stock) y un cliente registrado que nunca compró.
 
**Power BI** (50 ventas)
 
- 2023 facturó 28.764 y 2024 lleva 18.814, pero 2024 solo tiene datos hasta julio. El -34,6% anual compara un año completo contra siete meses: no es una caída del negocio.
 
**Limitación:** con 10 ventas en un solo mes no se pueden sacar tendencias. Estos datos sirven para describir, no para proyectar.
 
## Pendientes
 
- La consulta 4 del módulo 4 marca "Por debajo" cuando hay un solo mes, porque el total es igual al promedio. Hay que revisarla cuando se carguen más meses.
- La base SQL y los archivos de Power BI usan datos distintos. Para unificarlos habría que conectar Power BI a `Ventas_Tech_DB`.
 
## Autor
 
Joaquin Puntillo
