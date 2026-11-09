drop database if exists andesbike;
create database andesbike;
use andesbike;

create table tiendas (
	id_tienda int auto_increment primary key,
    nombre varchar (60) not null,
    comuna varchar (50) not null
    );
    
create table vendedores (
		id_vendedor int auto_increment primary key,
        nombre varchar(90) not null,
        id_tienda int null, 
        fecha_ingreso date not null,
        foreign key (id_tienda) references tiendas(id_tienda)
        );
        
create table bicicletas (
			id_bicicleta int auto_increment primary key,
            modelo varchar (60) not null,
            categoria enum("Eléctrica", "Infantil", "Montaña", "Ruta", "Urbana") not null,
            precio decimal(10,2) not null
            );
create table ventas (
	id_venta int auto_increment primary key,
    id_vendedor int not null,
    id_bicicleta int not null,
    fecha date not null,
    unidades int not null,
    foreign key (id_vendedor) references vendedores(id_vendedor),
    foreign key (id_bicicleta) references bicicletas(id_bicicleta)
    );

insert into tiendas (nombre, comuna) values
('Andes Providencia', 'Providencia'),
('Andes Maipú', 'Maipú'),
('Andes Concepción', 'Concepción'),
('Andes La Serena', 'La Serena');

insert into vendedores (nombre, id_tienda, fecha_ingreso) values
('Camila Ortiz', 1, '2024-06-20'),
('Diego Fuentes', 1, '2024-01-15'),
('Javiera Soto', 2, '2023-07-24'),
('Matías Herrera', 2, '2024-01-15'),
('Paula Riquelme', 3, '2022-11-02'),
('Ignacio Vera', 3, '2024-08-19'),
('Fernanda Lillo', 1, '2025-02-03'),
('Rubén Castro', null, '2025-06-10');

insert into bicicletas (modelo, categoria, precio) values
('Cordillera 29', 'Montaña', 549990.00),
('Ruta Austral', 'Ruta', 899990.00),
('Urbana Pro', 'Urbana', 329990.00),
('Pequeño Andes', 'Infantil', 149990.00),
('Volt City', 'Eléctrica', 1249990.00),
('Trail Master', 'Montaña', 749990.00),
('Urbana Lite', 'Urbana', 229990.00),
('Sprint R7', 'Ruta', 1099990.00);

insert into ventas (id_vendedor, id_bicicleta, fecha, unidades) values
(1, 1, '2025-03-04', 2),
(1, 3, '2025-03-18', 1),
(1, 5, '2025-04-02', 1),
(2, 2, '2025-03-04', 1),
(2, 1, '2025-04-11', 3),
(2, 7, '2025-05-06', 2),
(3, 4, '2025-03-21', 4),
(3, 3, '2025-04-15', 2),
(3, 6, '2025-05-20', 1),
(4, 1, '2025-03-27', 1),
(4, 5, '2025-05-09', 2),
(5, 2, '2025-04-08', 1),
(5, 6, '2025-04-23', 2),
(5, 4, '2025-06-02', 5),
(6, 3, '2025-05-13', 3),
(6, 7, '2025-06-17', 1),
(6, 1, '2025-06-24', 2),
(1, 6, '2025-06-30', 1);

#verificación monto total ventas, de 18 ventas de 35 unidades como indica el enunciado
select
	sum(v.unidades) as total_unidades,
    sum(v.unidades * b.precio) as monto_total_ventas
    from ventas v
    join bicicletas b on v.id_bicicleta = b.id_bicicleta;
    
#Consultas
    
#consulta 1
select
	v.nombre as vendedor, count(ven.id_venta) as cantidad_ventas
    from vendedores v
    left join ventas ven on v.id_vendedor = ven.id_vendedor
    group by v.id_vendedor, v.nombre
    order by cantidad_ventas desc, v.nombre asc;
    
#consulta 2
select
	t.nombre as nombre_tienda, count(ven.id_venta) as cantidad_ventas, sum(ven.unidades) as total_unidades
    from tiendas t
    left join vendedores v on t.id_tienda = v.id_tienda
    left join ventas ven on v.id_vendedor = ven.id_vendedor
    group by t.id_tienda, t.nombre
    order by total_unidades desc;

#consulta 3 
select
	t.nombre as nombre_tienda, v.nombre as nombre_vendedor
    from tiendas t
    left join vendedores v on t.id_tienda = v.id_tienda
    where v.id_vendedor is null; 
    
#consulta 4 
select
		b.modelo, b.categoria, ven.unidades
        from bicicletas b
        left join ventas ven on b.id_bicicleta = ven.id_bicicleta and ven.fecha between "2025-06-01" and "2025-06-30"
        where ven.id_venta is null
        order by b.modelo desc;
        
#consulta 5
select
		vend.nombre as nombre_vendedor, t.nombre as nombre_tienda, vent.unidades as unidades_vendidas
        from vendedores vend
        left join ventas vent on vend.id_vendedor = vent.id_vendedor
        left join tiendas t on vend.id_tienda = t.id_tienda
        where vent.id_venta is null
        order by vend.nombre asc;
