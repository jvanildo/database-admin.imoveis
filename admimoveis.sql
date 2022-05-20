create database admimoveis;
use admimoveis;

create table if not exists propietario(
id_prop int not null auto_increment,
nome_prop varchar(30),
cpf_prop varchar(17) not null unique,
telefone_prop int(15),
nascimento_prop date,
primary key (id_prop)
);
insert into propietario values
(default,'thiao','12433224256','96184226','2005-09-02'),
(default,'thiago','115.478.564-78','87987364','2002-08-10'),
(default,'paulo','113.928.874-89','98784698','2001-05-11'),
(default,'joao','118.889.124-98','98589409','2004-04-19'),
(default,'renato','109.788.994-84','98749820','2007-04-18'),
(default,'junior','126.787.974-87','98875902','2008-03-12'),
(default,'lima','017.748.774-71','89874989','2006-06-08'),
(default,'matheus','738.928.854-72','98093898','2002-09-07'),
(default,'leonardo','198.727.894-88','99895898','2002-07-15');

SELECT id_prop,nome_prop,cpf_prop,telefone_prop, DATE_FORMAT(nascimento_prop,'%d/%m/%Y') AS nascimento_prop FROM propietario;

create table if not exists apartamento(
id_apt int not null auto_increment,
cep_apt varchar(17) not null unique,
rua_apt varchar(30),
numero_apt int(6),
primary key (id_apt)
);
insert into apartamento values
(default,'14015-040','rua sao miguel','123'),
(default,'14015-542','rua luiz franco','23'),
(default,'14015-041','rua junio danta','321'),
(default,'14015-213','rua carlos de nobrega','412'),
(default,'14015-421','rua tz da coro','765'),
(default,'14015-987','av sebastiao salazar','823')
;
desc apartamento;
select*from apartamento;
/* add uma chave esstrangeira pra se relacionar com o id _apt*/

create table if not exists casa (
id_casa int not null auto_increment,
cep_casa varchar(17) not null unique,
rua_casa varchar(30),
numero_casa int(6),
primary key (id_casa)
);
insert into casa values
(default,'14015-040','rua sao miguel','123'),
(default,'14015-542','rua luiz franco','23'),
(default,'14015-041','rua junio danta','321'),
(default,'14015-213','rua carlos de nobrega','412'),
(default,'14015-421','rua tz da coro','765'),
(default,'14015-987','av sebastiao salazar','823')
;
select* from casa;

/* add uma chave esstrangeira pra se relacionar com o id _apt*/

create table if not exists vender_apt(
id_vender_apt int not null auto_increment,
valor_vender_apt double(10,2),
primary key (id_vender_apt)
);
insert into vender_apt values
(default,'350.50','4'),
(default,'1200.45','3'),
(default,'2000.00','5'),
(default,'1500.45','2'),
(default,'200.45','6'),
(default,'1250.00','1');
alter table vender_apt
add id_relacao int;
/* add uma foreign key*/
alter table vender_apt
add foreign key (id_relacao)
references apartamento(id_apt);

select apartamento.rua_apt,vender_apt.valor_vender_apt
from apartamento left outer join vender_apt 
on vender_apt.id_relacao=apartamento.id_apt;

select* from vender_apt;

/*apartamento int not null auto_increment, futura foreinght key*/ 

create table if not exists alugar_apt(
id_alugar_apt int not null auto_increment,
valor_alugar_apt double(10,2),
primary key(id_alugar_apt)
);
insert into alugar_apt values
(default,'1250.00','5'),
(default,'2000.00','4'),
(default,'200.45','2'),
(default,'350.50','6'),
(default,'1200.45','3'),
(default,'1500.45','1');
alter table alugar_apt
add id_relacao int;
/*modifiquei o nome*/
alter table alugar_apt
change id_relacao_casa id_relacao_apt int;

alter table alugar_apt 
add foreign key(id_relacao_apt)
references casa(id_apt);

select apartamento.rua_apt,alugar_apt.valor_alugar_apt
from apartamento left outer join alugar_apt 
on alugar_apt.id_relacao_apt=apartamento.id_apt;

select*from alugar_apt;


create table if not exists vender_casa(
id_vender_casa int not null auto_increment,
valor_vender_casa double(10,2),
primary key (id_vender_casa)
);
insert into vender_casa values
(default,'1500.45','2'),
(default,'200.45','6'),
(default,'2000.00','5'),
(default,'350.50','4'),
(default,'1200.45','3'),
(default,'1250.00','1');

alter table vender_casa
add id_relacao_casa int;

alter table vender_casa
add foreign key(id_relacao_casa)
references casa(id_casa);


select casa.rua_casa,vender_casa.valor_vender_casa
from casa left outer join vender_casa 
on vender_casa.id_relacao_casa=casa.id_casa;

select*from vender_casa;



create table if not exists alugar_casa(
id_alugar_casa int not null auto_increment,
valor_alugar_casa double(10,2),
primary key (id_alugar_casa)
); 
alter table alugar_casa
add id_relacao_alugar_casa int;

alter table alugar_casa
add foreign key (id_relacao_alugar_casa)
references casa(id_casa);

insert into alugar_casa values
(default,'1500.45','2'),
(default,'200.45','6'),
(default,'2000.00','5'),
(default,'350.50','4'),
(default,'1200.45','3'),
(default,'1250.00','1');

/*procurar pela rua o valor da casa*/
select casa.rua_casa,alugar_casa.valor_alugar_casa
from casa left outer join alugar_casa 
on alugar_casa.id_relacao_alugar_casa=casa.id_casa;


select *from alugar_casa;

create table if not exists cliente(
id_cliente int not null auto_increment,
nome_cliente varchar(30) not null,
cpf_cliente varchar(30) not null unique,
nascimento_cliente date not null,
genero_cliente enum('M','F'),
telefone int (15) not null,
primary key(id_cliente)
);

insert into cliente values(default,'jose','123.342.543-65','2003-08-26','M','996184226'),
(default,'leo','123.342.843-65','2010-10-20','M','999673196'),
(default,'douglas','123.342.343-65','2009-01-22','M','985161182'),
(default,'pedro','123.342.143-65','2003-04-13','M','983644892'),
(default,'joao','123.342.243-64','2003-05-21','M','996805130'),
(default,'matheus','123.342.743-65','2003-12-20','M','995235860'),
(default,'euclides','123.342.443-65','2003-11-30','M','985144285');

select * from cliente;
SELECT id_cliente,nome_cliente,cpf_cliente,DATE_FORMAT(nascimento_cliente,'%d/%m/%Y') AS nascimento_cliente,genero_cliente, telefone FROM cliente;
/*-------------------------------------------------------------------------------------------------------------------*/

