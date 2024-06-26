--Batch 1: Create the tables that have no dependencies on other tables.
--Create the asset_type table.
--Since it does not have any foreign keys, it does not depend on any other table.
--The asset_desc table (to be created later) depends on the asset_type table.

drop table asset_type;--Use as needed.

create table asset_type (
    asset_type_id number(10),
    asset_type_desc varchar2(50) not null,
    constraint asset_type_pk primary key(asset_type_id),
    constraint a_typ_desc_unq unique (asset_type_desc)
);

drop sequence asset_type_id_seq;--Use as needed.

create sequence asset_type_id_seq
start with 8;--You can start with anything 8 or higher

--Create the ci_status table.
--Since it does not have any foreign keys, it does not depend on any other table.
--The ci_inventory table (to be created later) depends on the ci_status table.

drop table ci_status;--Use as needed.

create table ci_status
(
    ci_status_code char(8),
    ci_status_description varchar2(50),
    constraint ci_status__pk primary key(ci_status_code),
    constraint ci_st_desc_unq unique(ci_status_description)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the di_status_data.csv file provided into your asset_type table. This 
procedure is demonstrated in class. */



--Create the rel_type table.
--Since it does not have any foreign keys, it does not depend on any other table.
--The related_assets table (to be created later) depends on the rel_type table.

drop table rel_type;--Use as needed.

create table rel_type (
    rel_type_code char(4),
    rel_type_desc varchar(50),
    constraint rel_type_pk primary key(rel_type_code),
    constraint rel_type_desc_unq unique(rel_type_desc)
    );

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the rel_type_data.csv file provided into your asset_type table. This 
procedure is demonstrated in class. */



--Create the department table.
--Since it does not have any foreign keys, it does not depend on any other table.
--The employee table (to be created later) depends on the department table.

drop table department;
--All drop commands are coded for your convenience, to run as needed.

create table department (
    dept_code char(10),
    dept_name varchar2(50),
    constraint dept_pk primary key (dept_code),
    constraint dept_nm_unq unique (dept_name)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the department_data.csv file provided into your asset_type table. This 
procedure is demonstrated in class. */



--Batch 2: Create the tables that have a dependency on one of the tables created 
--in Batch 1.

--Create the asset_desc table.
--The asset_desc table has a foreign key to the asset_type table. This is 
--a dependency.

drop table  asset_desc;--Use as needed.

create table asset_desc (
  asset_desc_id number(10),
  asset_type_id number(10) not null,
  asset_make varchar2(50) not null,
  asset_model varchar2(50) not null,
  asset_ext varchar2(50) not null,
  constraint asset_desc_pk primary key(asset_desc_id),
  constraint  asset_desc_asset_type_fk foreign key (asset_type_id)
  references asset_type(asset_type_id)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the asset_desc_data.csv file provided into your asset_type table. This 
procedure is demonstrated in class. */

--The attribute asset_desc_id is a surrogate key for the asset description entity.
--In Oracle database, a separate object called a sequence can be created to generate
--sequential integer values for a surrogate key field.

drop sequence asset_desc_id_seq;--Use as needed.

create sequence asset_desc_id_seq
start with 23;--You can start with any number higher then the largest value used



--Create the employee table. 
--It has a foreign key to the department table, a table that exists now. The
--employee table also has a foreign key to emp_id, one of its own fields.

drop table employee;--Use as needed.

create table employee (
	emp_id number(10),
	first_name varchar2(100) not null,
    last_name varchar2(100) not null,
    lastfour_ssn char(4) not null,
    co_mobile varchar2(12),
    co_email varchar2(100) not null,
    action varchar2(20) not null,
    action_date date not null,
    dept_code char(10) not null,
    job_title varchar2(200),
    supervisor_id number(10),
    constraint employee_pk primary key(emp_id),
    constraint co_mobile_unq unique(co_mobile),
    constraint co_email_unq unique(co_email),
    constraint emp_dept_fk foreign key (dept_code) 
    references department(dept_code),
    constraint supervisor_fk foreign key (supervisor_id)
    references employee(emp_id)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the employee_data.csv file provided into your asset_type table. This 
procedure is demonstrated in class. */

--The attribute emp_id is a surrogate key for the employee entity.
--In Oracle database, a separate object called a sequence can be created to generate
--sequential integer values for a surrogate key field.

drop sequence emp_id_seq;-- Use as needed.

create sequence emp_id_seq
start with 25;--You can start with any value larger than the largest value used.



--Batch 3: Create the tables that have a dependency on the tables created in 
--Batch 2.

--Create the application table.
--The application table has a foreign key to the asset_desc table. This is a
--dependency.

drop table application;--Use as needed.

create table application (
	asset_desc_id number(10),
    appl_inst_version varchar2(10),
	appl_details varchar2(100), 
    constraint appl_pk primary key(asset_desc_id),
    constraint appl_asset_desc_fk foreign key(asset_desc_id)
    references asset_desc(asset_desc_id)
 );

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the application_data.csv file provided into your asset_type table. This 
procedure is demonstrated in class. */



--Create the computer table.
--The computer table has a foreign key to the asset_desc table. This is a
--dependency.

drop table computer;--Use as needed.

create table computer (
    asset_desc_id number(10),
    cpu_details varchar2(100),
    graphics varchar2(50),
    vol_memory varchar2(25),
    storage_type varchar2(50),
    storage_capacity varchar2(10),
    display varchar2(10),--built-in or external
    bi_display_details varchar2(50),
    constraint computer_pk primary key(asset_desc_id),
    constraint computer_asset_desc_fk foreign key(asset_desc_id)
    references asset_desc(asset_desc_id)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the computer.csv file provided into your asset_type table. This 
procedure is demonstrated in class. */



--Create the it_service table.
--The it_service table has a foreign key to the asset_desc table. This is a
--dependency.

drop table it_service;--Use as needed.

create table it_service (
    asset_desc_id number(10),
    service_details varchar2(200),
    constraint service_pk primary key(asset_desc_id),
    constraint service_asset_desc_fk foreign key(asset_desc_id)
    references asset_desc(asset_desc_id)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */



--Create the peripheral table.
--The peripheral table has a foreign key to the asset_desc table. This is a
--dependency.

drop table peripheral;--Use if needed.

create table peripheral (
    asset_desc_id number(10),
    peripheral_details varchar2(200),
    constraint peripheral_pk primary key(asset_desc_id),
    constraint peripheral_asset_desc_fk foreign key(asset_desc_id)
    references asset_desc(asset_desc_id)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */



--Create the server table.
--The server table has a foreign key to the asset_desc table. This is a
--dependency.

drop table server;--Use if needed.

create table server (
	asset_desc_id number(10),
    cpu_details varchar2(100),
    vol_memory varchar2(25),
    storage_type varchar2(50),
    storage_capacity varchar2(10),
    constraint server_pk primary key(asset_desc_id),
    constraint server_asset_desc_fk foreign key(asset_desc_id)
    references asset_desc(asset_desc_id)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */



--Create the other table.
--The other table has a foreign key to the asset_desc table. This is a
--dependency.

drop table other;--Use as needed.

create table other (
	asset_desc_id number(10),
    other_desc varchar2(100),
	other_details varchar2(100), 
    constraint other_pk primary key(asset_desc_id),
    constraint other_asset_desc_fk foreign key(asset_desc_id)
    references asset_desc(asset_desc_id)
 );

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */



--Create the it_asset_inv_summary table.
--The it_asset_inv_summary table has a foreign key to the asset_desc table. 
--This is a dependency.

drop table it_asset_inv_summary;--Use as needed.

create table it_asset_inv_summary (
    it_asset_inv_summary_id number(10),
    asset_desc_id number(10) not null,
    inv_summary_date date not null,
    num_available number(8),
    num_assgnd_use number(8),
    num_assgnd_support number(8),
    constraint it_inv_summary_pk primary key (it_asset_inv_summary_id),
    constraint inv_summary_asset_desc_fk foreign key (asset_desc_id) references
    asset_desc(asset_desc_id)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */

--The attribute it_asset_inv_summary_id is a surrogate key for the 
--it_asset_inv_summary entity.
--In Oracle database, a separate object called a sequence can be created to generate
--sequential integer values for a surrogate key field.

drop sequence it_asset_inv_summary_id_seq;--Use as needed.

create sequence it_asset_inv_summary_id_seq
start with 131;--Start with any value larger than the largest value used in the data.


 
 --Create the related_assets table.
--The related_assets table has a foreign key to the rel_type table and it has two
--foreign keys to the asset_desc table. These are dependencies.

drop table related_assets;--Use as needed.

create table related_assets (
    rel_asset_desc_id_1 number(10),
    rel_type_code char(4),
    rel_asset_desc_id_2 number(10),
    constraint rel_assets_pk primary key(rel_asset_desc_id_1,rel_asset_desc_id_2,rel_type_code),
    constraint rel_asset_1_fk foreign key(rel_asset_desc_id_1)
    references asset_desc(asset_desc_id),
    constraint rel_asset_2_fk foreign key(rel_asset_desc_id_2)
    references asset_desc(asset_desc_id),
    constraint rel_asset_rel_type foreign key (rel_type_code)
    references rel_type(rel_type_code)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */



--Batch 4: Create the tables that have one or more dependencies on the tables 
--created in Batch 1 though Batch 3.

--Create the ci_inventory table.
--The ci_inventory table has a foreign key to the ci_status table and it has a 
--foreign key to the asset_desc table . These are dependencies.

drop table ci_inventory;--Use as needed.

create table ci_inventory (
	ci_inv_id number(10),
    asset_desc_id number(10) not null,
    purchase_or_rental char(8),
    unique_id varchar2(50),--such as a serial number or license key
    ci_acquired_date date not null,
    ci_status_code char(8) not null,
    ci_status_date date not null,
    constraint ci_inv_pk primary key(ci_inv_id),
    constraint ci_inv_asset_fk foreign key(asset_desc_id)
    references asset_desc(asset_desc_id),
    constraint ci_inv_ci_status_fk foreign key (ci_status_code)
    references ci_status(ci_status_code)
);

/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */

--The attribute ci_inv_id is a surrogate key for the ci_inventory entity.
--In Oracle database, a separate object called a sequence can be created to generate
--sequential integer values for a surrogate key field.

drop sequence ci_inv_id_seq;--Use as needed.

create sequence ci_inv_id_seq
start with 84;--Start with any value larger than the largest value used in the data



--Batch 5: Create the tables that have one or more dependencies on the tables 
--created in Batch 1 though Batch 4.

--Create the employee_ci table.
--The employee_ci table has a foreign key to the employee table and it has a 
--foreign key to the ci_inventory table . These are dependencies.

drop table employee_ci;--Use as needed.

create table employee_ci (
	ci_inv_id number(10),
    emp_id number(10) not null,
    use_or_support char(8) not null,
    date_assigned date not null,
	date_unassigned date NULL,
    constraint employee_ci_pk primary key(ci_inv_id,emp_id,date_assigned),
    constraint ci_inv_emp_asset_fk foreign key (ci_inv_id)
    references ci_inventory (ci_inv_id),
    constraint emp_asset_emp_fk foreign key(emp_id)
    references employee(emp_id)
);
alter session set nls_date_format = 'DD-MON-YYYY HH:MI:SS AM';
select * from employee_ci
/* Use Oracle sqlldr tool or Oracle SQL Developer tool to import data from 
the it_service table belonging to the ITAM user on the class server. The 
procedure for using Oracle SQL Developer tool to download the data and save 
it in a .csv file is demonstrated in class. */



/* The tables of the schema are now created and data has been inserted. Note
that the process is successful because dependencies were accommodated. The 
dependencies required for creation of the tables also affect the order in 
which data can be inserted into the tables.

Here is the order in which the the tables were created. The order of creation 
within each "batch" is not important.

Batch 1: asset_type, ci_status, rel_type, department
Batch 2: asset_desc, employee
Batch 3: application, computer, it_service, other, peripheral, server, 
it_asset_inv_summary, related_assets
Batch 4: ci_inventory
Batch 5: employee_ci   */


select * from jaherna42.department
order by dept_name, dept_code;

select * from jaherna42.employee
order by emp_id;
select * from jaherna42.CI_Inventory

select * from department
insert into employee
values (25,'Laura','Scott',5698,'346-447-6363','lmscott@abcco.com','HIRE',
to_date('23-AUG-22','DD-MON-RR'),'HR','Human Resources',2);

insert into employee
values (12,'Mikey','Wong',8514,'346-825-7863','mswong@abcco.com','HIRE',
to_date('06-JUL-22','DD-MON-RR'),'ITHELP','Systems Analyst',1);

insert into employee
values (14,'Lamar','Littles',6515,'832-688-8743','lllittles@abcco.com','HIRE',
to_date('21-MAR-22','DD-MON-RR'),'ITHELP','IT Help Desk Manager',null);

commit;
select * from jaherna42.employee;

select * from jaherna42.asset_type

insert into asset_desc
values (35,2,'Dell','XPS 15 Laptop','11th Gen Intel� Core� i7-11800H'); 

insert into asset_desc
values (36,1,'Microsoft','Windows OS','Windows 11 Home'); 

select * from asset_desc
order by asset_desc_id;

insert into other
values (35,'11th Gen Intel� Core� i7-11800H (24 MB cache, 8 cores, 16 threads, up to 4.60 GHz Turbo)',
'15.6", 3.5K 3456x2160, 60Hz, OLED, Touch, Anti-Reflect, 400 nit, InfinityEdge');

insert into other
values (36,'11','factory installed on laptop');
commit;

select * from jaherna42.CI_inventory
where ci_inv_id = 68;

insert into CI_inventory
values (68,35,'PURCHASE','Serial No. CN-0 68MCF -74261-55N-07AL',to_date('30-AUG-22','DD-MON-SS'),'WORKING',
to_date('01-SEP-22','DD-MON-SS'));

insert into it_asset_inv_summary
values (89,35,to_date('01-SEP-22','DD-MON-RR'),0+1,0,0);

insert into CI_inventory
values (69,35,'PURCHASE','Serial No. CN-0 69KCF -52761-54N-07OP',to_date('30-AUG-22','DD-MON-SS'),'WORKING',
to_date('01-SEP-22','DD-MON-SS'));

insert into it_asset_inv_summary
values (95,35,to_date('01-SEP-22','DD-MON-RR'),1+1,0,0);

insert into CI_inventory
values (70,35,'PURCHASE','Serial No. CN-0 45MCF -52333-54N-89PO',to_date('30-AUG-22','DD-MON-SS'),'WORKING',
to_date('01-SEP-22','DD-MON-SS'));

insert into it_asset_inv_summary
values (96,35,to_date('01-SEP-22','DD-MON-RR'),2+1,0,0);

commit;

select * from ci_inventory where asset_desc_id = 35;
select * from jaherna42.employee where last_name like '%W%';

select * from employee_ci
select * from employee

insert into employee_ci
values (68,25,'USE',to_date('01-SEP-22','DD-MON-RR'),null);

commit;

select * from jaherna42.employee_ci where emp_id = 13 and ci_inv_id = 68;

insert into it_asset_inv_summary
values (it_asset_inv_summary_id_seq.nextval,35,to_date('08-SEP-22','DD-MON-RR'),3-1,0+1,0);

commit;

select * from employee_ci
where it_asset_inv_summary_id = 
select * from ci_inventory

insert into employee_ci
values (68,12,'Support',to_date('01-SEP-22','DD-MON-RR'),null);

insert into it_asset_inv_summary
values (it_asset_inv_summary_id_seq.nextval,35,to_date('08-SEP-22','DD-MON-RR'),3-1,0+1,0+1);

insert into employee_ci
values (69,12,'Support',to_date('01-SEP-22','DD-MON-RR'),null);

insert into it_asset_inv_summary
values (it_asset_inv_summary_id_seq.nextval,35,to_date('08-SEP-22','DD-MON-RR'),1,1,1);
select * from jaherna42.employee_ci

update ci_inventory
SET
ci_status_code = 'DISPOSED'
where ci_inv_id = 69;

select * from jaherna42.ci_inventory

insert into related_assets values (35,'RO',36);
commit;

--Task 2 Command 1
--Jordan Allen
select emp_id,first_name,last_name,co_email,action,action_date,dept_code,
job_title from jaherna42.employee where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 2
--Jordan Allen
select asset_desc_id,asset_type_id,asset_make,asset_model,asset_ext
from jaherna42.asset_desc where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 3
-- Jordan Allen
select * from jaherna42.computer
--the ITAM documents explain what tables represent sub-entities
--the sub-entity table you select from correspondes to the asset type of the
--asset description you inserted
where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 4
-- Jordan Allen
select ci_inv_id,asset_desc_id,purchase_or_rental,unique_id,ci_acquired_date,
ci_status_code,ci_status_date from jaherna42.ci_inventory 
where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 5
--Jordan Allen
select ci_inv_id,emp_id,use_or_support,date_assigned,date_unassigned
from jaherna42.employee_ci where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 6
--Jordan Allen
select * from jaherna42.it_asset_inv_summary 
where changed_by_user = 'JMALLE25'
order by asset_desc_id,it_asset_inv_summary_id;
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 7
--Jordan Allen
select * from jaherna42.Computer
where changed_by_user = 'JMALLE25' ;
--replace YOURUSERNAME in the command with your user name on the class se

select * from itam.department
--Jordan Allen
--cloudJA10
--Ex 6 Task 5 Command 1
insert into itam.department(Dept_code, Dept_name) Values ('ACCT', 'Accounting');
commit;

--Jordan Allen
--Connected as cloudTB12
--Ex 6 Task 5 Command 2
select * from itam.department where Dept_code='ACCT';


--Jordan Allen
--Connected as cloudTB12
--Ex 6 Task 5 Command 3
Update ITAM.DEPARTMENT
set DEPT_CODE ='MGMT', DEPT_NAME ='Management'
where DEPT_CODE ='ACCT';
commit;

--Jordan Allen
--Connected as cloudTB12
--Ex 6 Task 5 Command 4
select * from itam.department where Dept_code='MGMT';


--Jordan Allen
--Connected as cloudTB12
--Ex 6 Task 5 Command 5
DELETE FROM ITAM.DEPARTMENT WHERE DEPT_CODE='MGMT';
COMMIT;


--Jordan Allen
--Connected as cloudTB12
--Ex 6 Task 5 Command 6
select * from itam.department where dept_code='MGMT';

--Jordan Allen
--Connected as cloudTB12
--Ex 6 Task 11
create view vw_itam_employees_info
as
select first_name, last_name, co_mobile, co_email, dept_code, Job_title
from itam.employee;

--Jordan Allen
----Connected as cloudTB12
--Ex 6 Task 12
select * from vw_itam_employees_info;

commit;
