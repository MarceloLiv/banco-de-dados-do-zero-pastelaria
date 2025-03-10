-- criação do banco de dados para uma pastelaria
create database if not exists pastelaria;
use pastelaria;

-- criar tabela cliente
	create table clients(
		idclient int auto_increment primary key,
		Fname varchar(10),
		phone char(11),
		Address varchar(30)
	);

insert into clients (Fname, phone, Address)
	values 
	('Marcelo', '16996054641', 'Rua Poços, 192'),
	('Marina', '16996034303', 'Av. Caldas, 291'),
	('Liv', '00000000000', 'Rua 7 de Setembro, 37');

-- criar tabela produto
	create table products(
		idProduct int auto_increment primary key,
		Pname varchar(20),
        price float(5),
		category enum('Salgado', 'Doce')
	);
    
insert into products (Pname, price, category)
	values 
	('Pastel_Carne', "10.00", 'Salgado'),
	('Pastel_Queijo', "12.00", 'Salgado'),
	('Pastel_Chocolate', "13.00", 'Doce');

-- criar tabela funcionarios
	create table employees(
		idEmployee int auto_increment primary key,
		Ename varchar(100) not null,
		jobfunction enum('Atendente', 'Balconista', 'Faxineira', 'Cozinheira'),
		contact char(11) not null
	);
    
insert into employees (Ename, jobfunction, contact)
	values 
	('Olivia Liv', 'Atendente', '35888887777'),
	('Renata', 'Cozinheira', '35777776666');

-- criar tabela pedido
	create table orders(
		idOrder int auto_increment primary key,
		idClient int,
        idEmployee int,
		orderStatus enum('Em Espera', 'Preparando', 'Pronto') default 'Em Espera',
		foreign key (idEmployee) references employees(idEmployee),
        foreign key (idClient) references clients(idclient)
	);

insert into orders (idClient, idEmployee, orderStatus)
	values 
	(1, 1, 'Em Espera'),
	(2, 2, 'Preparando'),
	(1, 1, 'Pronto');    

-- criar table produto pedido			
	create table productOrder(
		idOrder int,
		idProduct int,
		Quantity int default 1,
		price float(5),
		primary key (idOrder, idProduct),
		foreign key (idOrder) references orders(idOrder),
		foreign key (idProduct) references products(idProduct)
	);
 
insert into productOrder (idOrder, idProduct, Quantity, price)
	values 
	(4, 1, 2, 10.00),
	(5, 2, 3, 12.00),
	(6, 3, 1, 13.00);
 
-- Quais clientes fizeram pedidos e qual o total gasto em cada pedido?
SELECT 
    c.Fname AS cliente,
    o.idOrder AS pedido,
    SUM(po.Quantity * po.price) AS total_gasto
FROM clients c
JOIN orders o ON c.idclient = o.idClient
JOIN productOrder po ON o.idOrder = po.idOrder
GROUP BY c.idClient, o.idOrder
HAVING total_gasto > 10
ORDER BY total_gasto DESC;

-- Quais produtos têm um preço superior a 10 e em que categoria estão?
SELECT 
    Pname AS produto,
    price AS preco,
    category AS categoria
FROM products
WHERE price > 10
ORDER BY price ASC;

-- Quais são os funcionários que têm mais de 1 função e qual função exercem?
SELECT e.Ename AS funcionario
FROM employees e
Where e.jobfunction = "Atendente"
ORDER BY funcionario;