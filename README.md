

# BASE DE DATOS BIBLIOTECA

![Imagen Biblioteca](./images/16576.jpg)

## Modelo Conceptual 

Identifique las posibles tablas y campos asociados del escenario proporcionado. Book.com es una tienda virtual en línea en Internet donde los clientes pueden examinar el catálogo y seleccionar los productos que deseen. 

- Cada libro tiene un título, ISBN, año y precio. La tienda también conserva la información del autor y del editor de cualquier libro. 

- Para los autores, la base de datos conserva el nombre, la dirección y la URL de su página inicial. 

- Para los editores, la base de datos conserva el nombre, la dirección, el número de teléfono y la URL de su sitio web. 

- La tienda tiene varios almacenes, cada uno de los cuales tiene un código, una dirección y un número de teléfono. 

- El almacén tiene en stock muchos libros. Un libro puede estar en stock en varios almacenes. 

- La base de datos registra el número de copias de un libro almacenadas en stock en varios almacenes. 

- La librería conserva el nombre, la dirección, el ID de correo electrónico y el número de teléfono de sus clientes. 

- Un cliente es propietario de varios carritos de la compra. El carrito de la compra se identifica mediante un Shopping_Cart_ID y contiene varios libros. 

- Algunos carritos de la compra pueden contener más de una copia del mismo libro. La base de datos registra el número de copias de cada libro que hay en cualquier carrito de la compra. 

- En ese momento, se necesitará más información para completar la transacción. Normalmente, se le pedirá al cliente que rellene o seleccione una dirección de facturación, una dirección de envío, una opción de envío e información de pago como el número de tarjeta de crédito. Se enviará una notificación por correo electrónico al cliente en cuanto se realice el pedido

## Modelo Físico


![Modelo Fisico](./images/libreria.png)

## Descripcion tablas

### Tabla autores
Esta tabla almacena información sobre los autores de los libros, incluyendo su nombre, dirección y una URL opcional.

### Tabla almacenes
Aquí se guardan registros de los almacenes donde se almacenan los libros, identificados por su dirección.

### Tabla prioridad
Contiene diferentes tipos de prioridades que pueden asignarse a los teléfonos.

### Tabla prefijosTelefonicos
Registra códigos numéricos utilizados para identificar regiones geográficas en sistemas telefónicos.

### Tabla telefonosAlmacenes
Asocia números de teléfono con almacenes específicos.

### Tabla editores
Almacena información sobre las editoriales de libros, incluyendo su nombre, dirección y una URL opcional.

### Tabla telefonosEditores
Similar a telefonosAlmacenes, asocia números de teléfono con editores específicos.

### Tabla libros
Contiene información detallada sobre los libros, incluyendo su título, ISBN, año de publicación, precio y el editor asociado.

### Tabla autores_has_libros
Establece relaciones entre autores y libros, indicando qué autores han contribuido a cada libro.

### Tabla stock
Mantiene un registro del stock de libros en cada almacén, indicando la cantidad disponible de cada título.

### Tabla clientes
Guarda información sobre los clientes, incluyendo su nombre, dirección y correo electrónico.

### Tabla tarjetasCredito
Registra la información de las tarjetas de crédito asociadas a los clientes.

### Tabla telefonosClientes
Asocia números de teléfono con clientes específicos.

### Tabla carrito
Contiene información sobre los carritos de compra de los clientes.

### Tabla detalleCarrito
Registra los detalles de los productos en el carrito de un cliente.

### Tabla tipoPago
Guarda los diferentes tipos de métodos de pago que pueden ser utilizados.

### Tabla estadoEnvio
Contiene los diferentes estados de envío que pueden ser asignados a un pedido.

### Tabla tipoEnvio
Registra los diferentes tipos de métodos de envío disponibles.

### Tabla pedido
Guarda información detallada sobre los pedidos realizados por los clientes.

### Tabla notificacion
Registra notificaciones asociadas a un pedido específico.


## Consultas para la base de datos

### Tabla de Autores

- Se requiere saber todos los autores con la letra "a" en su nombre

```sql
SELECT * FROM autores WHERE nombre LIKE '%a%';
```

- Se desea saber los autores con residencia en Bogotá

```sql
SELECT * FROM autores WHERE direccion LIKE '%Bogotá%';
```

### Tabla de Almacenes

- Obtener todos los almacenes que estén ubicados en calles

```sql
SELECT * FROM almacenes WHERE direccion LIKE '%Calle%';
```

- Se necesita saber la cantidad de almacenes en una ciudad específica

```sql
CREATE PROCEDURE obtener_mensaje(IN ciudad VARCHAR(100))
BEGIN
    SELECT CONCAT('Solo tenemos ', COUNT(*), ' almacenes en la ciudad de ', ciudad, '.') as mensaje
    FROM almacenes 
    WHERE direccion LIKE CONCAT('%', ciudad, '%');
END //
DELIMITER ;
CALL obtener_mensaje('Barranquilla');
```

### Tabla de Autores y Libros

- Se necesita saber los autores, el URL de su página y sus libros publicados

```sql
SELECT autores.nombre, autores.url, libros.titulo 
FROM autores
INNER JOIN autores_has_libros ON autores.id = autores_has_libros.autores_id
INNER JOIN libros ON autores_has_libros.libros_id = libros.id;
```

- Obtener autores que no tienen libros publicados

```sql
SELECT autores.nombre, autores.url
FROM autores
LEFT JOIN autores_has_libros ON autores.id = autores_has_libros.autores_id
WHERE autores_has_libros.autores_id IS NULL;
```

### Tabla de Carritos

- Obtener el ID del carrito, el nombre del libro en el carrito, la cantidad de copias y el nombre del cliente asociado a ese carrito

```sql
SELECT carrito.id as carrito_id, libros.titulo as nombre_libro, detalleCarrito.cantidadCopias, clientes.nombre as nombre_cliente
FROM carrito
INNER JOIN detalleCarrito ON carrito.id = detalleCarrito.carrito_id
INNER JOIN clientes ON carrito.clientes_id = clientes.id
INNER JOIN libros ON detalleCarrito.libros_id = libros.id;
```

- Obtener el nombre de cada cliente y el total de carritos que tienen, incluyendo aquellos clientes que no tienen ningún carrito

```sql
SELECT clientes.nombre as nombre_cliente, COUNT(carrito.id) as total_carritos
FROM clientes
LEFT JOIN carrito ON clientes.id = carrito.clientes_id
GROUP BY clientes.nombre;
```

- Obtener el nombre de cada cliente y el total de carritos que tienen, incluyendo aquellos clientes que no tienen ningún carrito

```sql
SELECT clientes.nombre as nombre_cliente, COUNT(carrito.id) as total_carritos
FROM clientes
LEFT JOIN carrito ON clientes.id = carrito.clientes_id
GROUP BY clientes.nombre;
```

### Tabla de Clientes

- Obtener el nombre de los clientes junto con sus números de teléfono registrados. En caso de que un cliente no tenga ningún teléfono registrado, se mostrará el mensaje "Sin teléfonos registrados".

```sql
SELECT c.nombre, 
       IFNULL(GROUP_CONCAT(DISTINCT CONCAT(pt.prefijo, '', tc.telefono) SEPARATOR ','), 'Sin teléfonos registrados') AS numeros_telefono
FROM clientes c
LEFT JOIN telefonosClientes tc ON c.id = tc.clientes_id
LEFT JOIN prefijosTelefonicos pt ON tc.prefijosTelefonicos_id = pt.id
GROUP BY c.nombre;
```

- Obtener el cantidad de tarjetas de crédito registradas para cada cliente, mostrando el ID del cliente, su nombre y la cantidad de tarjetas de crédito asociadas a él. En caso de que un cliente no tenga tarjetas de crédito registradas, se mostrará '0' como la cantidad de tarjetas

```sql
SELECT c.id AS id_cliente, c.nombre AS nombre_cliente, COUNT(tc.clientes_id) AS cantidad_tarjetas 
FROM clientes c LEFT JOIN tarjetasCredito tc ON c.id = tc.clientes_id 
GROUP BY c.id, c.nombre;
```

### Tabla detalle Carrito

- Calcular el total de libros vendidos en todos los detalles de carrito

```sql
SELECT SUM(dc.cantidadCopias) AS total_libros_vendidos_en_todos_los_detalles
FROM detalleCarrito dc;
```

- Mostrar el ID del libro y la cantidad total de copias vendidas para cada uno.

```sql
SELECT libros_id, SUM(cantidadCopias) AS total_libros_vendidos
FROM detalleCarrito
GROUP BY libros_id;
```

### Tabla Editores

- Mostrar los editores que se encuentran ubicados en Cartagena

```sql
SELECT * FROM editores WHERE direccion LIKE '%Cartagena%';
```

-  Mostrar los editores que tienen una URL especificada.

```sql
SELECT nombre, direccion,url
FROM editores
WHERE url IS NOT NULL;
```

### Tabla estados envio 

- Mostrar todos los estados de envío.

```sql
SELECT *
FROM estadoenvio order by id asc;
```

- Mostrar el total de pedidos asociados a cada estado de envío.

```sql
SELECT ee.tipo, COUNT(p.id) AS total_pedidos
FROM estadoenvio ee
LEFT JOIN pedido p ON ee.id = p.estadoEnvio_id
GROUP BY ee.tipo;
```

### Tabla libros

- Mostrar los títulos de los libros publicados en el año 2021.

```sql
SELECT titulo
FROM libros
WHERE año = 2021;
```

- Mostrar los títulos y precios de los libros publicados por una editorial específica, ingresando el nombre de la editorial.

```sql
SELECT l.titulo, l.precio
FROM libros l
WHERE l.editores_id = (
    SELECT id
    FROM editores
    WHERE nombre = 'Ediciones xd'
);
```

### Tabla notificación

- Mostrar todos los mensajes de notificación.

```sql
SELECT mensaje
FROM notificacion;
```

-  Mostrar los mensajes de notificación asociados a un pedido específico.

```sql
SELECT n.mensaje
FROM notificacion n
JOIN pedido p ON n.pedido_id = p.id
WHERE p.id = 1;
```

### Tabla pedido 

-  Mostrar la información de los pedidos realizados en una fecha determinada.

```sql
SELECT p.id, p.direccionFactura, p.direccionEnvio, tp.tipo AS tipo_pago, ee.tipo AS estado_envio, te.tipo AS tipo_envio, p.total, p.fecha
FROM pedido p
JOIN tipoPago tp ON p.tipoPago_id = tp.id
JOIN estadoEnvio ee ON p.estadoEnvio_id = ee.id
JOIN tipoEnvio te ON p.tipoEnvio_id = te.id
WHERE p.fecha = '2023-11-07';
```

- Mostrar la cantidad de pedidos por cliente 

```sql
SELECT c.id AS clientes_id,c.nombre, COUNT(p.id) AS total_pedidos
FROM clientes c
INNER JOIN carrito cc ON c.id = cc.clientes_id
INNER JOIN pedido p ON cc.id = p.carrito_id
GROUP BY c.id;
```

### Tabla prefijos telefónicos

- Obtener todos los prefijos telefónicos

```sql
SELECT prefijo
FROM prefijostelefonicos;
```

- Obtener la cantidad de teléfonos con el mismo prefijo definido

```sql
SELECT pt.prefijo, COUNT(tc.clientes_id) AS total_telefonos
FROM prefijosTelefonicos pt
JOIN telefonosClientes tc ON pt.id = tc.prefijosTelefonicos_id
GROUP BY pt.prefijo;
```



### Tabla prioridades

- Mostrar todas las prioridades

```sql
SELECT tipo
FROM prioridad;
```

- Mostrar los teléfonos de cada editor asociados a cada tipo de prioridad.

```sql
SELECT  edit.nombre,te.telefono,pr.tipo
FROM prioridad pr
JOIN telefonosEditores te ON pr.id = te.prioridad_id
JOIN editores edit ON edit.id = te.editores_id
;
```

### Tabla stock 

- Mostrar la cantidad total de libros en stock en cada almacen

```sql
SELECT a.direccion, SUM(s.cantidad) AS total_libros_en_stock
FROM stock s 
JOIN almacenes a ON s.almacenes_id = a.id
GROUP BY s.almacenes_id;
```

- Mostrar las cantidad de copias en cada sucursal de un libro determinado 

```sql
SELECT l.titulo, s.cantidad, a.direccion
FROM stock s
JOIN libros l ON s.libros_id = l.id
JOIN almacenes a ON s.almacenes_id = a.id
WHERE s.cantidad >=0 and l.titulo = 'El Secreto del Bosque';
```

### Tabla Tarjeta de credito 

- Mostrar las tarjetas que expiraron o están prontas a expirar dependiendo el año que determinamos 

```sql
SELECT c.nombre, tc.numeroTarjeta, tc.fechaExpiracion
FROM tarjetasCredito tc
JOIN clientes c ON c.id = tc.clientes_id 
WHERE SUBSTRING(tc.fechaExpiracion, 4, 2) < '24';
```

- Saber el total de tarjetas que tenemos almacenadas en nuestra base de datos 

```sql
SELECT COUNT(clientes_id) as total_tarjetas_guardadas
FROM tarjetasCredito;
```

### Tabla Telefonos almacenes

- Saber todos los telefonos de determinado almacen

```sql
SELECT ta.almacenes_id,a.direccion, ta.telefono
FROM telefonosalmacenes ta
JOIN almacenes a ON ta.almacenes_id = a.id
WHERE a.direccion LIKE '%Cartagena%';
```

- Mostrar los telefonos de todos los almacenes

```sql
SELECT ta.almacenes_id,a.direccion, ta.telefono
FROM telefonosalmacenes ta
JOIN almacenes a ON ta.almacenes_id = a.id;
```

### Tabla Telefonos Clientes

- Conocer los números telefonicos de todos los clientes junto con sus prefijos ya que podemos tener clientes extranjeros

```sql
SELECT c.nombre, pt.prefijo, tc.telefono
FROM telefonosClientes tc
JOIN clientes c ON tc.clientes_id = c.id
JOIN prefijosTelefonicos pt ON pt.id = tc.prefijosTelefonicos_id;
```

- Mostrar los clientes que tienen mas de un teléfono,y mostrar los teléfonos concatenados en una sola casilla separados por un / 

```sql
SELECT c.nombre, pt.prefijo, GROUP_CONCAT(tc.telefono SEPARATOR ' / ') AS numeros_telefono
FROM telefonosClientes tc
JOIN clientes c ON tc.clientes_id = c.id
JOIN prefijosTelefonicos pt ON pt.id = tc.prefijosTelefonicos_id
WHERE tc.clientes_id IN (
    SELECT clientes_id
    FROM telefonosClientes
    GROUP BY clientes_id
    HAVING COUNT(*) > 1
)
GROUP BY c.nombre, pt.prefijo;
```

### Tabla Telefonos editores

- Mostrar todos los telefonos de los editores, en este orden nombre, prefijo, telefono y prioridad

```sql
SELECT e.nombre, pt.prefijo, te.telefono, p.tipo 
FROM telefonosEditores te
JOIN editores e ON e.id = te.editores_id
JOIN prefijosTelefonicos pt ON pt.id = te.prefijosTelefonicos_id  
JOIN  prioridad p ON p.id = te.prioridad_id;
```

- Mostrar solo los teléfonos que tienen como tipo de prioridad Negocios 

```sql
SELECT e.nombre, pt.prefijo, te.telefono, p.tipo 
FROM telefonosEditores te
JOIN editores e ON e.id = te.editores_id
JOIN prefijosTelefonicos pt ON pt.id = te.prefijosTelefonicos_id  
JOIN  prioridad p ON p.id = te.prioridad_id
WHERE p.tipo = 'Negocios';
```

### Tabla tipos de envios

- Mostrar todos los tipos de envios disponibles

```sql 
SELECT *
FROM tipoenvio;
```

- Mostrar el total de pedidos realizados por cada tipo de envío.

```sql
SELECT te.tipo, COUNT(p.id) AS total_pedidos
FROM tipoenvio te
JOIN pedido p ON te.id = p.tipoEnvio_id
GROUP BY te.tipo;
```

### Tabla tipos de pagos

- Mostrar todos los tipos de pagos

```sql
SELECT *
FROM tipoPago;
```

-  Mostrar el total de pedidos realizados por cada tipo de pago

```
SELECT tp.tipo, COUNT(p.id) AS total_pedidos
FROM tipopago tp
JOIN pedido p ON tp.id = p.tipoPago_id
GROUP BY tp.tipo;
```

## INSTRUCCIONES DE USO

## 1. Conectar al Servidor de Base de Datos

Abre un cliente de línea de comandos o una interfaz gráfica que te permita conectarte a tu servidor de bases de datos MySQL o MariaDB.

`mysql -u tu_usuario -p`

Reemplaza tu_usuario con el nombre de usuario de tu base de datos.

## 2. Crear la Base de Datos

`CREATE DATABASE nombre_de_tu_base_de_datos;`

Reemplaza nombre_de_tu_base_de_datos con el nombre que desees para tu base de datos.

## 3. Seleccionar la Base de Datos

`USE nombre_de_tu_base_de_datos;`

Esto te permitirá ejecutar comandos dentro de esa base de datos.

## Ejecutar el Script SQL

Puedes copiar el script contenido dentro `bd_biblioteca.sql` y pegarlo en tu consola para generar la ejecucion.


## Construido con 🛠️

* [Notion](https://notion.so/es-es/product) - Para el diseño del modelo conceptual utilizamos notion 
* [Mysql Workbench](https://www.mysql.com/products/workbench/) - Para el diseño fisico
* [Readme.so](https://readme.so/editor) - Herramienta de construccion de Readme
