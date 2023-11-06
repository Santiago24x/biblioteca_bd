
/* tabla autores */
CREATE TABLE IF NOT EXISTS autores (
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    url TEXT NULL
);

/* constraint autores */
ALTER TABLE autores
    ADD CONSTRAINT PK_autores PRIMARY KEY (id);


/* tabla almacenes */
CREATE TABLE IF NOT EXISTS almacenes (
    id INT NOT NULL,
    direccion VARCHAR(100) NOT NULL  
);

/* constraint almacenes */
ALTER TABLE almacenes
    ADD CONSTRAINT PK_almacenes PRIMARY KEY (id);


/* tabla prioridad telefonos autores */
CREATE TABLE IF NOT EXISTS prioridad (
    id INT NOT NULL,
    tipo VARCHAR(12) NOT NULL
);

/* constraint prioridad */
ALTER TABLE prioridad
    ADD CONSTRAINT PK_prioridad PRIMARY KEY (id);

/* tabla prefijos telefonicos */
CREATE TABLE IF NOT EXISTS prefijosTelefonicos (
    id INT NOT NULL,
    prefijo VARCHAR(4) NOT NULL
);

/* constraint prefijosTelefonicos */
ALTER TABLE prefijosTelefonicos
    ADD CONSTRAINT PK_prefijosTelefonicos PRIMARY KEY (id);

/* tabla telefonosAlmacenes */
CREATE TABLE IF NOT EXISTS telefonosAlmacenes (
    almacenes_id INT NOT NULL,
    telefono BIGINT NOT NULL,
    prefijosTelefonicos_id INT NOT NULL
);

/* constraint telefonosAlmacenes */
ALTER TABLE telefonosAlmacenes
    ADD CONSTRAINT FK_telefonosAlmacenes_almacenes FOREIGN KEY (almacenes_id) REFERENCES almacenes(id),
    ADD CONSTRAINT FK_telefonosAlmacenes_prefijosTelefonicos FOREIGN KEY (prefijosTelefonicos_id) REFERENCES prefijosTelefonicos(id),
    ADD CONSTRAINT UQ_telefono UNIQUE (telefono);



/* tabla editores */
CREATE TABLE editores (
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    url TEXT NULL,
    direccion VARCHAR(100) NOT NULL
);

/* constraint editores */
ALTER TABLE editores
    ADD CONSTRAINT PK_editores PRIMARY KEY (id);


/* tabla telefonosEditores */
CREATE TABLE IF NOT EXISTS telefonosEditores (
    editores_id INT NOT NULL,
    telefono BIGINT NOT NULL,
    prioridad_id INT NOT NULL,
    prefijosTelefonicos_id INT NOT NULL
);

/* constraint telefonosEditores */
ALTER TABLE telefonosEditores
    ADD CONSTRAINT FK_telefonosEditores_editores FOREIGN KEY (editores_id) REFERENCES editores(id),
    ADD CONSTRAINT FK_telefonosEditores_prioridad FOREIGN KEY (prioridad_id) REFERENCES prioridad(id),
    ADD CONSTRAINT FK_telefonosEditores_prefijosTelefonicos FOREIGN KEY (prefijosTelefonicos_id) REFERENCES prefijosTelefonicos(id),
    ADD CONSTRAINT UQ_telefono UNIQUE (telefono);


/* tabla libros */
CREATE TABLE IF NOT EXISTS libros (
    id INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    año YEAR NOT NULL,
    precio FLOAT NOT NULL,
    editores_id INT NOT NULL    
);

/* constraint libros */
ALTER TABLE libros
    ADD CONSTRAINT PK_libros PRIMARY KEY (id),
    ADD CONSTRAINT UQ_libros UNIQUE (isbn),
    ADD CONSTRAINT FK_libros_editores FOREIGN KEY (editores_id) REFERENCES editores(id);



/* tabla autores_has_libros */
CREATE TABLE IF NOT EXISTS autores_has_libros (
    autores_id INT NOT NULL,
    libros_id INT NOT NULL
);

/* constraint autores_has_libros */
ALTER TABLE autores_has_libros
    ADD CONSTRAINT FK_autores_has_libros_autores FOREIGN KEY (autores_id) REFERENCES autores(id),
    ADD CONSTRAINT FK_autores_has_libros_libros FOREIGN KEY (libros_id) REFERENCES libros(id);

/* tabla stock */
CREATE TABLE IF NOT EXISTS stock (
    almacenes_id INT NOT NULL,
    libros_id INT NOT NULL,
    cantidad INT NOT NULL
);

/* constraint stock */
ALTER TABLE stock
    ADD CONSTRAINT FK_stock_almacenes FOREIGN KEY (almacenes_id) REFERENCES almacenes(id),
    ADD CONSTRAINT FK_stock_libros FOREIGN KEY (libros_id) REFERENCES libros(id);


/* tabla clientes */
CREATE TABLE IF NOT EXISTS clientes (
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NULL
);

/* constraint clientes */
ALTER TABLE clientes
    ADD CONSTRAINT PK_clientes PRIMARY KEY (id),
    ADD CONSTRAINT UQ_correo UNIQUE (correo);

/* tabla tarjetasCredito */
CREATE TABLE IF NOT EXISTS tarjetasCredito (
    clientes_id INT NOT NULL,
    numeroTarjeta BIGINT NOT NULL,
    ccv INT NOT NULL,
    fechaExpiracion VARCHAR(7) NOT NULL
);



/* constraint tarjetasCredito */
ALTER TABLE tarjetasCredito
    ADD CONSTRAINT FK_tarjetasCredito_clientes FOREIGN KEY (clientes_id) REFERENCES clientes(id),
    ADD CONSTRAINT UQ_tarjetasCredito UNIQUE (numeroTarjeta);

/* tabla telefonosClientes */
CREATE TABLE IF NOT EXISTS telefonosClientes (
    clientes_id INT NOT NULL,
    telefono BIGINT NOT NULL,
    prefijosTelefonicos_id INT NOT NULL
); 

/* constraint telefonosClientes */
ALTER TABLE telefonosClientes
    ADD CONSTRAINT FK_telefonosClientes_clientes FOREIGN KEY (clientes_id) REFERENCES clientes(id),
    ADD CONSTRAINT FK_telefonosClientes_prefijosTelefonicos FOREIGN KEY (prefijosTelefonicos_id) REFERENCES prefijosTelefonicos(id),
    ADD CONSTRAINT UQ_telefono UNIQUE (telefono);


/* tabla carrito */
CREATE TABLE IF NOT EXISTS carrito (
    id INT NOT NULL,
    clientes_id INT NOT NULL
);

/* constraint carrito */
ALTER TABLE carrito
    ADD CONSTRAINT PK_carrito PRIMARY KEY (id),
    ADD CONSTRAINT FK_carrito_clientes FOREIGN KEY (clientes_id) REFERENCES clientes(id);

/* tabla detalleCarrito */
CREATE TABLE IF NOT EXISTS detalleCarrito (
    carrito_id INT NOT NULL,
    libros_id INT NOT NULL,
    cantidadCopias INT NOT NULL
);

/* constraint detalleCarrito */
ALTER TABLE detalleCarrito
    ADD CONSTRAINT FK_detalleCarrito_carrito FOREIGN KEY (carrito_id) REFERENCES carrito(id),
    ADD CONSTRAINT FK_detalleCarrito_libros FOREIGN KEY (libros_id) REFERENCES libros(id);

/* tabla tipoPago  */
CREATE TABLE IF NOT EXISTS tipoPago (
    id INT NOT NULL,
    tipo VARCHAR(25) NOT NULL
);

/* constraint tipoPago */
ALTER TABLE tipoPago
    ADD CONSTRAINT PK_tipoPago PRIMARY KEY (id),
    ADD CONSTRAINT UQ_tipoDePago UNIQUE (tipo);

/* tabla estadoEnvio  */
CREATE TABLE IF NOT EXISTS estadoEnvio (
    id INT NOT NULL,
    tipo VARCHAR(12) NOT NULL
);

/* constraint estadoEnvio */
ALTER TABLE estadoEnvio
    ADD CONSTRAINT PK_estadoEnvio PRIMARY KEY (id),
    ADD CONSTRAINT UQ_tipoDeEstadoEnvio UNIQUE (tipo);

/* tabla tipoEnvio */
CREATE TABLE IF NOT EXISTS tipoEnvio (
    id INT NOT NULL,
    tipo VARCHAR(25) NOT NULL
);

/* constraint tipoEnvio */
ALTER TABLE tipoEnvio
    ADD CONSTRAINT PK_leiEnvio PRIMARY KEY (id),
    ADD CONSTRAINT UQ_tipoDeEnvio UNIQUE (tipo);

/* tabla pedido  */
CREATE TABLE IF NOT EXISTS pedido (
    id INT NOT NULL,
    direccionFactura VARCHAR(100) NOT NULL,
    direccionEnvio VARCHAR(100) NOT NULL,
    tipoPago_id INT NOT NULL,
    estadoEnvio_id INT NOT NULL,
    carrito_id INT NOT NULL,
    tipoEnvio_id INT NOT NULL,
    total FLOAT NOT NULL,
    fecha DATE NOT NULL
);

/* constraint pedido */
ALTER TABLE pedido
    ADD CONSTRAINT PK_pedido PRIMARY KEY (id),
    ADD CONSTRAINT FK_pedido_carrito FOREIGN KEY (carrito_id) REFERENCES carrito(id),
    ADD CONSTRAINT FK_pedio_tipoPago FOREIGN KEY (tipoPago_id) REFERENCES tipoPago(id),
    ADD CONSTRAINT FK_pedido_estadoEnvio FOREIGN KEY (tipoEnvio_id) REFERENCES estadoEnvio(id),
    ADD CONSTRAINT FK_pedido_tipoEnvio FOREIGN KEY (tipoEnvio_id) REFERENCES tipoEnvio(id);

/* tabla notificacion  */
CREATE TABLE IF NOT EXISTS notificacion (
    id INT NOT NULL,
    mensaje TEXT NOT NULL,
    pedido_id INT NOT NULL
);

/* constraint notificacion */
ALTER TABLE notificacion
    ADD CONSTRAINT PK_notificacion PRIMARY KEY (id),
    ADD CONSTRAINT FK_notificacion_pedido FOREIGN KEY (pedido_id) REFERENCES pedido(id);

