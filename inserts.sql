
 /* Inserciones en la tabla autores */
INSERT INTO autores (id, nombre, direccion, url) VALUES 
(1, 'Carlos Alberto Gómez', 'Carrera 15 #25-30, Bogotá', 'http://www.carlosalbertogomez.com'),
(2, 'Luisa Fernanda Pérez', 'Calle 5 #15-45, Medellín', 'http://www.luisafernandaperez.com'),
(3, 'María José Ramírez', 'Avenida 3 #8-12, Cali', 'http://www.mariajoseramirez.com'),
(4, 'Pedro Rodríguez López', 'Carrera 7 #30-50, Barranquilla', 'http://www.pedrorodriguez.com'),
(5, 'Laura Martínez Gutiérrez', 'Calle 12 #20-10, Cartagena', 'http://www.lauramartinez.com');

/* Inserciones en la tabla almacenes */
INSERT INTO almacenes (id, direccion) VALUES
(1, 'Carrera 45 #123-56, Bogotá'),
(2, 'Calle 78 #34-12, Medellín'),
(3, 'Avenida 23 #45-67, Cali'),
(4, 'Carrera 12 #34-56, Barranquilla'),
(5, 'Calle 34 #56-78, Cartagena');

/* Inserciones en la tabla prioridad */
INSERT INTO prioridad (id, tipo) VALUES
(1, 'Negocios'),
(2, 'Personal'),
(3, 'Trabajo'),
(4, 'Casa'),
(5, 'Otros');

/* Inserciones en la tabla prefijosTelefonicos */
INSERT INTO prefijosTelefonicos (id, prefijo) VALUES
(1, '+57'),
(2, '+58'),
(3, '+60'),
(4, '+1'),
(5, '+3');

/* Inserciones en la tabla telefonosAlmacenes */
INSERT INTO telefonosAlmacenes (almacenes_id, telefono, prefijosTelefonicos_id) VALUES
(1, 3124567890, 1),
(2, 3505678901, 1),
(3, 3186789012, 1),
(4, 3137890123, 1),
(5, 3608901234, 1),
(1, 3001234567, 1);


/* Inserciones en la tabla editores */
INSERT INTO editores (id, nombre, url, direccion) VALUES 
(1, 'Editorial Minerva', 'http://www.editorialabc.com', 'Avenida Principal #10-20, Bogotá'),
(2, 'Ediciones xd', 'http://www.edicionesxyz.com', 'Calle Secundaria #5-15, Medellín'),
(3, 'Libros carita al piso', 'http://www.librosdelsur.com', 'Carrera Norte #8-12, Cali'),
(4, 'Ediciones del Este', 'http://www.edicionesdeleste.com', 'Calle Este #30-50, Barranquilla'),
(5, 'Editorial La puñalada de tinta', 'http://www.editorialoccidente.com', 'Avenida Oeste #12-10, Cartagena');

/* Inserciones en la tabla telefonosEditores */
INSERT INTO telefonosEditores (editores_id, telefono, prioridad_id, prefijosTelefonicos_id) VALUES
(1, 318456789, 1, 1),
(2, 318567890, 2, 1),
(3, 313678901, 3, 1),
(4, 350789012, 1, 1),
(5, 370890123, 2, 1);


/* Inserciones en la tabla libros */
INSERT INTO libros (id, titulo, isbn, año, precio, editores_id) VALUES 
(1, 'La Vida en Colores', '9781234567890', 2020, 25.99, 1),
(2, 'El Secreto del Bosque', '9782345678901', 2021, 19.99, 2),
(3, 'Historias de Amor y Desamor', '9783456789012', 2019, 22.50, 3),
(4, 'Aventuras en el Espacio', '9784567890123', 2022, 30.00, 4),
(5, 'El Tesoro Perdido', '9785678901234', 2021, 18.75, 5);

/* Inserciones en la tabla autores_has_libros */
INSERT INTO autores_has_libros (autores_id, libros_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

/* Inserciones en la tabla stock */
INSERT INTO stock (almacenes_id, libros_id, cantidad) VALUES
(1, 3, 20),  
(1, 4, 12),   
(1, 5, 18),   
(2, 1, 15),   
(2, 3, 10),   
(2, 4, 8),    
(3, 1, 18), 
(3, 2, 12),   
(3, 4, 14),   
(4, 2, 10),  
(4, 3, 15),   
(4, 5, 20),   
(5, 1, 7),    
(5, 2, 5),   
(5, 5, 10);  


/* Inserciones en la tabla clientes */
INSERT INTO clientes (id, nombre, direccion, correo) VALUES 
(1, 'Juan Pérez', 'Carrera 20 #30-40, Bogotá', 'juan.perez@example.com'),
(2, 'María Gómez', 'Calle 10 #15-25, Medellín', 'maria.gomez@example.com'),
(3, 'Pedro Ramírez', 'Avenida 5 #8-10, Cali', 'pedro.ramirez@example.com'),
(4, 'Luisa Rodríguez', 'Carrera 3 #10-20, Barranquilla', 'luisa.rodriguez@example.com'),
(5, 'Ana Martínez', 'Calle 8 #18-28, Cartagena', 'ana.martinez@example.com'),
(6, 'David Santos', 'Calle 789 #90-12, Medellín', 'david.santos@example.com')
(7, 'Brayan Stick', 'Carrera 123 #45-67, Bogotá', 'brayan.stick@example.com');



/* Inserciones en la tabla tarjetasCredito */
INSERT INTO tarjetasCredito (clientes_id, numeroTarjeta, ccv, fechaExpiracion) VALUES
(1, 1234567890123456, 123, '12/25'),
(1, 7890123456789012, 789, '05/24'),
(2, 2355678901234567, 234, '11/24'),
(3, 3456189012345678, 345, '09/23'),
(4, 4567890124456789, 456, '08/22'),
(4, 2345678901234567, 234, '11/28'),
(5, 5678901234567890, 567, '07/21'),
(5, 3456789012345678, 345, '10/29'),
(5, 4567890123456789, 456, '09/30'),
(5, 5678901244567890, 567, '08/31');

/* Inserciones en la tabla telefonosClientes */
INSERT INTO telefonosClientes (clientes_id, telefono, prefijosTelefonicos_id) VALUES
(1, 3112345678, 1),  
(1, 3223456789, 1),  
(2, 3334567890, 1),  
(2, 3445678901, 1),   
(3, 3556789012, 1),   
(3, 3667890123, 1),   
(4, 3778901234, 1),   
(4, 3889012345, 1),  
(5, 3990123456, 1),   
(5, 3001234567, 1);   


/* Inserciones en la tabla carrito */
INSERT INTO carrito (id, clientes_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5)
(6, 7),
(7, 7),
(8, 7);

/* Inserciones en la tabla detalleCarrito */
INSERT INTO detalleCarrito (carrito_id, libros_id, cantidadCopias) VALUES
(1, 1, 20),
(2, 2, 1),
(3, 3, 5),
(4, 4, 2),
(5, 5, 1);


/* Inserciones en la tabla tipoPago */
INSERT INTO tipoPago (id, tipo) VALUES
(1, 'Tarjeta'),
(2, 'Transferencia bancaria'),
(3, 'Efectivo');

/* Inserciones en la tabla estadoEnvio */
INSERT INTO estadoEnvio (id, tipo) VALUES
(1, 'En Proceso'),
(2, 'Realizado'),
(3, 'Cancelado'),
(4, 'En Camino'),
(5, 'Entregado'),
(6, 'Devuelto');

/* Inserciones en la tabla tipoEnvio */
INSERT INTO tipoEnvio (id, tipo) VALUES
(1, 'Express'),
(2, 'Estándar'),
(3, 'Recoger en tienda');

/* Inserciones en la tabla pedido */
INSERT INTO pedido (id, direccionFactura, direccionEnvio, tipoPago_id, estadoEnvio_id, carrito_id, tipoEnvio_id, total, fecha) VALUES
(1, 'Calle 1 #2-3, Bogotá', 'Carrera 4 #5-6, Bogotá', 1, 1, 1, 1, 50.00, '2023-11-06'),
(2, 'Carrera 10 #20-30, Medellín', 'Calle 10 #20-30, Medellín', 2, 2, 2, 2, 60.00, '2023-11-07'),
(3, 'Avenida 7 #8-9, Cali', 'Carrera 12 #13-14, Cali', 1, 1, 3, 3, 70.00, '2023-11-08'),
(4, 'Calle 20 #30-40, Barranquilla', 'Carrera 20 #30-40, Barranquilla', 2, 2, 4, 1, 80.00, '2023-11-09'),
(5, 'Carrera 3 #4-5, Cartagena', 'Calle 6 #7-8, Cartagena', 3, 3, 5, 2, 90.00, '2023-11-10');

/* Inserciones en la tabla notificacion */
INSERT INTO notificacion (id, mensaje, pedido_id) VALUES
(1, 'Su pedido ha sido procesado exitosamente.', 1),
(2, 'Su pedido está en camino.', 2),
(3, 'Su pedido ha sido entregado. ¡Gracias por su compra!', 3),
(4, 'Su pedido ha sido devuelto.', 4),
(5, 'Su pedido ha sido cancelado.', 5);