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
