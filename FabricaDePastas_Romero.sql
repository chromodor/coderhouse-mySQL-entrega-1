DROP DATABASE IF EXISTS FabricaDePastas;

CREATE DATABASE FabricaDePastas;
USE FabricaDePastas;

CREATE TABLE FabricaDePastas.Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(255),
    tipo_producto VARCHAR(255),
    precio DECIMAL(10, 2)
);

CREATE TABLE FabricaDePastas.Ingredientes (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_ingrediente VARCHAR(255),
    cantidad_disponible DECIMAL(10, 2),
    unidad_medida VARCHAR(50),
    id_proveedor INT -- Añadimos esta columna para la clave foránea
);

CREATE TABLE FabricaDePastas.Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(50)
);

CREATE TABLE FabricaDePastas.Pedidos_Proveedores (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    fecha_pedido DATE,
    fecha_entrega DATE
);

CREATE TABLE FabricaDePastas.Detalles_Pedidos_Proveedores (
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_ingrediente INT,
    cantidad DECIMAL(10, 2)
);

CREATE TABLE FabricaDePastas.Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empleado VARCHAR(255),
    posicion VARCHAR(255),
    salario DECIMAL(10, 2),
    fecha_contratacion DATE
);

CREATE TABLE FabricaDePastas.Produccion (
    id_produccion INT AUTO_INCREMENT PRIMARY KEY,
    fecha_produccion DATE,
    id_producto INT,
    id_empleado INT,
    cantidad_producida DECIMAL(10, 2)
);

CREATE TABLE FabricaDePastas.Ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATE,
    id_cliente INT,
    id_empleado INT,
    total_venta DECIMAL(10, 2)
);

CREATE TABLE FabricaDePastas.Detalles_Ventas (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad DECIMAL(10, 2),
    precio_unitario DECIMAL(10, 2)
);

CREATE TABLE FabricaDePastas.Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(50)
);

CREATE TABLE FabricaDePastas.Productos_Ingredientes (
	id_productos_ingredientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    id_ingrediente INT
);

CREATE TABLE FabricaDePastas.Proveedores_Ingredientes (
	id_proveedores_ingredientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    id_ingrediente INT
);

-- Agregar claves foráneas con constraints
ALTER TABLE FabricaDePastas.Ingredientes 
	ADD CONSTRAINT fk_proveedor_ingrediente 
	FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor);

ALTER TABLE FabricaDePastas.Pedidos_Proveedores 
	ADD CONSTRAINT fk_pedido_proveedor 
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor);

ALTER TABLE FabricaDePastas.Detalles_Pedidos_Proveedores 
	ADD CONSTRAINT fk_detalle_pedido 
	FOREIGN KEY (id_pedido) REFERENCES Pedidos_Proveedores(id_pedido),
	ADD CONSTRAINT fk_detalle_ingrediente 
	FOREIGN KEY (id_ingrediente) REFERENCES Ingredientes(id_ingrediente);

ALTER TABLE FabricaDePastas.Produccion 
	ADD CONSTRAINT fk_produccion_producto 
	FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
	ADD CONSTRAINT fk_produccion_empleado 
	FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado);

ALTER TABLE FabricaDePastas.Ventas 
	ADD CONSTRAINT fk_venta_cliente 
	FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
	ADD CONSTRAINT fk_venta_empleado 
	FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado);

ALTER TABLE FabricaDePastas.Detalles_Ventas 
	ADD CONSTRAINT fk_detalle_venta 
	FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
	ADD CONSTRAINT fk_detalle_producto 
	FOREIGN KEY (id_producto) REFERENCES Productos(id_producto);

ALTER TABLE FabricaDePastas.Productos_Ingredientes 
	ADD CONSTRAINT fk_producto_ingrediente_producto 
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
	ADD CONSTRAINT fk_producto_ingrediente_ingrediente 
    FOREIGN KEY (id_ingrediente) REFERENCES Ingredientes(id_ingrediente);

ALTER TABLE FabricaDePastas.Proveedores_Ingredientes 
	ADD CONSTRAINT fk_proveedor_ingrediente_proveedor 
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),
	ADD CONSTRAINT fk_proveedor_ingrediente_ingrediente 
    FOREIGN KEY (id_ingrediente) REFERENCES Ingredientes(id_ingrediente);
