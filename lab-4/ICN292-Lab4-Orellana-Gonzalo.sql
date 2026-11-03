DROP database if exists austral;
create database austral;
use austral;

create table autores (
id_autor INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(80) NOT NULL,
pais VARCHAR(60) NULL,
genero ENUM("Cómic", "Ensayo", "Infantil", "Novela", "Poesía") NOT NULL
);

create table colecciones (
id_coleccion int AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(120) NOT NULL,
fecha_publicacion date NOT NULL
);

create table libros (
id_libro INT auto_increment PRIMARY KEY, 
id_autor int NOT NULL,
id_coleccion INT NULL,
titulo VARCHAR(120) NOT NULL,
paginas int NOT NULL,
ejemplares_vendidos int NOT NULL,
anio int NOT NULL,
FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
FOREIGN KEY (id_coleccion) REFERENCES colecciones(id_coleccion)
);

create table pagos (
id_pago int auto_increment primary key,
id_autor int not null,
fecha_pago date not null,
monto decimal(10,2) not null,
foreign key (id_autor) references autores(id_autor)
);

select*from autores;
select*from colecciones;
select*from libros;
select*from pagos;

insert into autores (nombre, pais, genero) values
("Elena Pizarro", "Chile", "Novela"),
("Harold Finch", "Inglaterra", "Ensayo"),
("Rodrigo Bahamonde", "Chile", "Poesía"),
("Valentina Correa", "Argentina", "Infantil"),
("Nora Keller", "Estados Unidos", "Novela"),
("Kenji Arakawa", NULL, "Cómic");

insert into colecciones (titulo, fecha_publicacion) values
("Colección Clásicos Contemporáneos", "2023-01-15"),
("Coleccion Novedades Austral", "2024-03-01");

insert into libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) values
(1, 1, "Cielo de Enero", 210, 1500, 2024), 
(1, 1, "Marea Baja", 185, 800, 2023),
(1, 1, "El Norte", 200, 2200, 2024),
(2, 1, "Estrellas que Caen", 240, 3000, 2022),
(2, 2, "Máquinas", 215, 450, 2024),
(3, 2, "Luz Artificial", 300, 1200, 2024),
(3, 2, "Ruido Blanco", 280, 600, 2023),
(4, 2, "El Barrio de Lila", 190, 5000, 2024),
(4, 2, "Antes del Amanecer", 205, 2700, 2024),
(4, 1, "La Calle 8", 175, 900, 2023),
(5, 1, "Flor de Hierro", 195, 4100, 2024),
(5, 2, "Hora Dorada", 220, 1800, 2022);

insert into pagos (id_autor, fecha_pago, monto) values
(1, "2024-05-10", 150000.50),
(1, "2024-08-15", 200000.00),
(3, "2024-06-20", 95000.75);

#consulta 1 
select nombre, genero
from autores
where pais <> "Chile" or pais is null
order by nombre asc;

#consulta 2
select titulo, paginas
from libros
where paginas between 190 and 220
order by paginas asc;

#consulta 3 
select
count(*) as total_libros,
sum(ejemplares_vendidos) as suma_ejemplos_vendidos,
avg(paginas) as promedio_paginas,
min(anio) as anio_mas_antiguo,
max(ejemplares_vendidos) as max_ejemplares_vendidos
from libros;

#consulta 4
select distinct genero
from autores
order by genero asc;

#consulta 5
 select a.nombre, count(*) as total_libros_2024
 from autores a
 join libros l on a.id_autor = l.id_autor
 where l.anio = 2024
 group by a.id_autor, a.nombre
 having count(*) > 1
 order by a.nombre asc;

#consulta 6
select titulo, ejemplares_vendidos
from libros
where anio = 2024 and ejemplares_vendidos > 2000
order by ejemplares_vendidos desc
Limit 3;

#consulta 7
insert into libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) 
values (3, 2, "Papel Mojado", 260, 50, 2024);
select * from libros where titulo = "Papel Mojado";
set SQL_SAFE_UPDATES = 0;
delete from libros where titulo = "Papel Mojado";
SET SQL_SAFE_UPDATES = 1;
select * from libros where titulo = "Papel Mojado";

#consulta 8
select titulo, ejemplares_vendidos
from libros
where titulo = "Cielo de Enero";

set SQL_SAFE_UPDATES = 0;
update libros
set ejemplares_vendidos = ejemplares_vendidos +100
where titulo = "Cielo de Enero";
set SQL_SAFE_UPDATES = 1;

select titulo, ejemplares_vendidos
from libros
where titulo = "Cielo de Enero";

#consulta 9
select l.titulo as libro, c.titulo as coleccion, c.fecha_publicacion 
from libros l
join colecciones c on l.id_coleccion = c.id_coleccion
order by c.titulo asc, l.titulo asc;

#consulta 10
select a.nombre as autor, p.fecha_pago, p.monto 
from pagos p
join autores a on a.id_autor = p.id_autor
order by p.fecha_pago asc;

select a.nombre as autor, sum(p.monto) as total_pagado
from pagos p
join autores a on a.id_autor = p.id_autor
group by a.id_autor, a.nombre
order by total_pagado desc;
