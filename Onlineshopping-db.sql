use Shopping;
create table CUSTOMER(
cust_ID int  primary key,
cust_name varchar(50),
cust_email varchar(50) unique,
cust_phno bigint not null unique,
cust_address varchar(50)
);

select * from CUSTOMER;

insert into CUSTOMER values(101,'anvith','anvith@gmail.com',9876543210,'karnataka');
insert into CUSTOMER values(102,'ankush','ankush@gmail.com',9988776655,'Hydrabad');
insert into CUSTOMER values(103,'arjun','arjun@gmail.com',9887766554,'Telangana');
insert into CUSTOMER values(104,'anjali','anjali@gmail.com',9731014167,'assam');
insert into CUSTOMER values(105,'sajan','sajan@gmail.com',7765432189,'Kerala');
insert into CUSTOMER values(106,'sanjana','sanjana@gmail.com',7645281904,'kashmeer');
insert into CUSTOMER values(107,'deeksha','deeksha@gmail.com',9876543245,'karnataka');
insert into CUSTOMER values(108,'dhanya','dhanya@gmail.com',9876523789,'Kerala');
insert into CUSTOMER values(109,'nidhi','nidhi@gmail.com',8965123890,'Hydrabad');
insert into CUSTOMER values(110,'anjan','anjan@gmail.com',6734891203,'Telangana');

create table product_deatils(
prod_ID int primary key,
prod_name varchar(10),
prod_price int
);

insert into product_deatils values(201,'saree',1000);
insert into product_deatils values(202,'jeans',1500);
insert into product_deatils values(203,'saree',800);
insert into product_deatils values(204,'tops',2500);
insert into product_deatils values(205,'kurtha',500);
insert into product_deatils values(206,'legin',200);
insert into product_deatils values(207,'tops',400);
insert into product_deatils values(208,'jeans',1000);
insert into product_deatils values(209,'kurtha',5000);
insert into product_deatils values(210,'saree',1000);

create table ADDRESS(
state varchar(80),
place varchar(80),
pin int
);

insert into ADDRESS values('Telangana','Vizag',578215);
insert into ADDRESS values('Hydrabad','Nellur',579215);
insert into ADDRESS values('karnataka','Davanagere',577215);
insert into ADDRESS values('karnataka','Shimoga',577216);
insert into ADDRESS values('kerala','viyanad',576215);
insert into ADDRESS values('kerala','kasaragudu',576215);
insert into ADDRESS values('assam','ranchi',575215);
insert into ADDRESS values('Telangana','chitur',578215);
insert into ADDRESS values('karnataka','Mysore',577217);
insert into ADDRESS values('karnatak','Bangalore',577218);

create table Distributors(
dist_ID int primary key,
prod_ID int ,
dist_name varchar(50),
location varchar(80),
constraint prod_ID FOREIGN KEY (prod_ID) references product_deatils(prod_ID)
);

insert into Distributors values(301,205,'RK','Telangana');
insert into Distributors values(302,203,'SK','karnataka');
insert into Distributors values(303,201,'NK','Kerala');
insert into Distributors values(304,207,'RK','assam');
insert into Distributors values(305,206,'SK','Hydrabad');
insert into Distributors values(306,210,'RK','assam');
insert into Distributors values(307,208,'NK','kerala');
insert into Distributors values(308,202,'NK','Hydrabad');
insert into Distributors values(309,209,'SK','karnataka');
insert into Distributors values(310,204,'RK','Telangana');

create table ORDER_details(
order_ID int primary key,
prod_ID int ,
cust_ID int ,
order_date date,
delivery_charge int,
FOREIGN KEY(prod_ID) references product_deatils(prod_ID),
FOREIGN KEY(cust_ID ) references CUSTOMER(cust_ID )
);

Select * from ORDER_details;

insert into ORDER_details values(001,203,109,SYSDATETIME(),300);
insert into ORDER_details values(002,204,103,SYSDATETIME(),400);
insert into ORDER_details values(003,205,102,SYSDATETIME(),100);
insert into ORDER_details values(004,207,105,SYSDATETIME(),50);
insert into ORDER_details values(005,209,101,SYSDATETIME(),300);
insert into ORDER_details values(006,206,107,SYSDATETIME(),600);
/*insert into ORDER_details values(007,202,106,DATE_FORMAT(@dt, '%01:%20:%55 - %12 %06 %2021'),900);
insert into ORDER_details values(009,202,106,DATEADD('2021-09-12', INTERVAL 1 YEAR),900); */


