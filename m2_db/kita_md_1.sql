--DML(Data Manipulation Language)
--�����ͺ��̽����� �����͸� �����ϴ� �� ���Ǵ� SQL�� �Ϻ�. 
--�ַ� INSERT, UPDATE, DELETE ���� ����Ͽ� �����͸� ����, ����, ����

--INSERT - ������ ����
--���ο� �����͸� ���̺� �߰��� �� ���
--UPDATE - ������ ����
--���̺��� ���� �����͸� ������ �� ���
--DELETE - ������ ����
--���̺��� �����͸� ������ �� ���
--UPDATE�� DELETE ����� �����ϹǷ� ���� ���ǰ� �ʿ�
--Ư�� WHERE ���� �����ϸ� ���̺��� ��� ���� ������ ���� �� �ִ�.
--���̺��� �����͸� �����ϴ� �۾��� �ǵ��� �� �����Ƿ�, Ư�� �߿��� �����͸� �ٷ� ���� �����ϰ� �۾�.
--�����ͺ��̽��� ���Ἲ�� �����ϱ� ���� ������ ���������� �����Ǿ� �ִ��� Ȯ��

--madang user ����
--4���� ���̺� ���� : 

SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM imported_book;
SELECT * FROM orders;

SELECT bookname, price FROM book;
SELECT publisher FROM book;

--�ߺ� ���� ���
SELECT DISTINCT publisher FROM book;

--Q. ������ 10,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT * 
FROM book
WHERE price > 10000;

--����1_1114: ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.(2���� ���)
SELECT * 
FROM book
WHERE price >= 10000 AND price <= 20000;

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

--����2_1114: ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.(3���� ���)
SELECT *
FROM book
WHERE (publisher='�½�����') OR (publisher='���ѹ̵��');

SELECT *
FROM book
WHERE publisher IN ('�½�����', '���ѹ̵��');

SELECT *
FROM book
WHERE  publisher = '�½�����'
UNION
SELECT *
FROM book
WHERE  publisher = '���ѹ̵��';

--���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� �ƴ� ������ �˻�
SELECT	*
FROM	Book
WHERE	publisher NOT IN ('�½�����', '���ѹ̵��');

SELECT bookname, publisher
FROM book
WHERE bookname LIKE '�౸�� ����';

-- ����3_1114: �����̸��� ���౸�� �� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '%�౸%';

-- ����4_1114: �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '_��%';

-- ����5_1114: �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT *
FROM book
WHERE bookname LIKE '%�౸%' and price >= 20000;

SELECT *
FROM book
ORDER BY bookname;

SELECT *
FROM book
ORDER BY bookname DESC;

-- ����6_1114: ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�
SELECT	*
FROM	Book
ORDER BY	price, bookname;

SELECT * FROM orders;
SELECT * FROM customer;

-- ����7_1114: 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select customer.name, orders.custid, sum(orders.saleprice)
from orders
inner join customer on orders.custid = customer.custid
where orders.custid = 2
group by customer.name, orders.custid;

SELECT SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE custid = 2;

--GROUP BY ���� SQL���� �ſ� �߿��� ��������, �����͸� Ư�� ���ؿ� ���� �׷�ȭ�ϴ� �� ���
--�̸� ���� ���� �Լ�(��: SUM, AVG, MAX, MIN, COUNT ��)�� ����Ͽ� �� �׷쿡 ���� ���� �����͸� ���
SELECT SUM(saleprice) AS total,
       AVG(saleprice) AS average,
       MIN(saleprice) AS minimum,
       MAX(saleprice) AS maximum
FROM orders;

SELECT * FROM orders;

SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;

--HAVING ���� SQL���� GROUP BY ���� �Բ� ���Ǿ� �׷�ȭ�� ����� ������ �����ϴ� �� ���
--WHERE ���δ� ó���� �� ���� ��쿡 ���
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE bookid > 5
GROUP BY custid
HAVING COUNT(*) > 2;

-- ����8_1114: ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.(GRPUP BY, COUNT)

SELECT custid, COUNT(*) AS ��������
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2;

SELECT 
( 
    SELECT NAME FROM CUSTOMER WHERE CUSTID=A.CUSTID
) NAME, 
COUNT(*) AS Count
FROM
ORDERS  A
WHERE
BOOKID IN (
    SELECT BOOKID FROM BOOK WHERE PRICE >= 8000
)
GROUP BY CUSTID;

SELECT * FROM orders;
SELECT * FROM customer;

--����1_1115. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�
SELECT *
FROM customer , orders
WHERE customer.custid = orders.custid 
ORDER BY customer.custid;

--����2_1115. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--����3_1115. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, SUM(saleprice) "�� �Ǹž�"
FROM orders
GROUP BY custid
ORDER BY custid;

SELECT name, SUM (saleprice) AS "�� �Ǹž�"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

--����4_1115. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.

SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid=O.custid AND O.bookid = B.bookid;

SELECT customer.name, book.bookname
FROM orders
INNER JOIN customer ON orders.custid = customer.custid
INNER JOIN book ON orders.bookid = book.bookid;

--����5_1115. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid=B.bookid AND B.price = 20000; 

SELECT 
(SELECT NAME FROM customer where custid = x.custid) "����",
(SELECT BOOKNAME FROM book where bookid = x.bookid) "å�̸�",
(SELECT PRICE FROM book where bookid = x.bookid) "å�ǸŰ�",
x.saleprice "���԰���",
x.orderdate "���Գ�¥"
FROM orders x
WHERE bookid IN (SELECT BOOKID FROM BOOK WHERE price = 20000)
ORDER BY custid;

--JOIN�� �� �� �̻��� ���̺��� �����Ͽ� ���õ� �����͸� ������ �� ���
--���� ���� (Inner Join)
SELECT customer.name,orders.saleprice
FROM customer 
INNER JOIN orders ON customer.custid=orders.custid;

--���� �ܺ� ���� (Left Outer Join) : . �� ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name,orders.saleprice
FROM customer 
LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--������ �ܺ� ���� (Right Outer Join) : ù ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name,orders.saleprice
FROM customer 
RIGHT OUTER JOIN orders ON customer.custid=orders.custid;

--FULL OUTER JOIN : ��ġ�ϴ� �����Ͱ� ���� ��� �ش� ���̺����� NULL ���� ���
SELECT customer.name,orders.saleprice
FROM customer 
FULL OUTER JOIN orders ON customer.custid=orders.custid;

--CROSS JOIN : �� ���̺� ���� ��� ������ ������ ����
SELECT customer.name,orders.saleprice
FROM customer 
CROSS JOIN orders;

--����6_1115. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.(2���� ���, WHERE, JOIN)

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

SELECT customer.name,orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--�μ� ����
SELECT * FROM book;
SELECT * FROM orders;
--Q. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

����7_1115. �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher = '���ѹ̵��'));

����8_1115. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2 
WHERE b2.publisher = b1.publisher);

����9_1115. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

����10_1115. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT name AS �����̸�, address AS �����ּ�
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--������ Ÿ��
--������ (Numeric Types)
--NUMBER: ���� �������� ���� ������ Ÿ��. ����, �Ǽ�, ���� �Ҽ���, �ε� �Ҽ��� ���� ����
--������ (Character Types)
--VARCHAR2(size): ���� ���� ���ڿ��� ����. size�� �ִ� ���� ���̸� ����Ʈ�� ����
--NVARCHAR2(size)�� ����� ������ ���� ����Ʈ ���� ��� �׻� ���� ������ ũ�Ⱑ ����
--CHAR(size): ���� ���� ���ڿ��� ����. ������ ���̺��� ª�� ���ڿ��� �ԷµǸ� �������� �������� ä����
--��¥ �� �ð��� (Date and Time Types)
--DATE: ��¥�� �ð��� ����. ������ Ÿ���� ��, ��, ��, ��, ��, �ʸ� ����
--TIMESTAMP: ��¥�� �ð��� �� ���� ������ �������� ����
--���� �������� (Binary Data Types)
--BLOB: �뷮�� ���� �����͸� ����. �̹���, ����� ���� ���� �����ϴ� �� ����
--��Ը� ��ü�� (Large Object Types)
--CLOB: �뷮�� ���� �����͸� ����
--NCLOB: �뷮�� ������ ���� ���� �����͸� ����

--�������� : 
--PRIMARY KEY : �� ���� �����ϰ� �ĺ��ϴ� ��(�Ǵ� ������ ����). �ߺ��ǰų� NULL ���� ������� �ʴ´�.
--FOREIGN KEY : �ٸ� ���̺��� �⺻ Ű�� �����ϴ� ��. ���� ���Ἲ�� ����
--UNIQUE : ���� �ߺ��� ���� ����� ���� ����. NULL���� ���
--NOT NULL : ���� NULL ���� ������� �ʴ´�.
--CHECK : �� ���� Ư�� ������ �����ؾ� ���� ���� (��: age > 18)
--DEFAULT : ���� ������� ���� �������� ���� ��� ���� �⺻���� ����

--AUTHOR ���̺� ����
CREATE TABLE authors (
  id NUMBER PRIMARY KEY,
  first_name VARCHAR2(50) NOT NULL,
  last_name VARCHAR2(50) NOT NULL,
  nationality VARCHAR2(50)
);
DROP TABLE authors;

--Q. NEWBOOK�̶�� ���̺��� �����ϼ���.
CREATE TABLE newbook (
    bookid NUMBER,
    isbn NUMBER(13),
    bookname VARCHAR2(50) NOT NULL,
    author VARCHAR2(50) NOT NULL,
    publisher VARCHAR2(30) NOT NULL,
    price NUMBER DEFAULT 10000 CHECK(price>1000),
    published_date DATE,
    PRIMARY KEY(bookid)
); 

DESC NEWBOOK;
--���̺� �������� ����, �߰�, �Ӽ� �߰�, ����, ����
ALTER TABLE newbook MODIFY (isbn VARCHAR2(10));
ALTER TABLE newbook ADD author_id NUMBER;
ALTER TABLE newbook DROP COLUMN author_id;

--ON DELETE CASCADE �ɼ��� �����Ǿ� �־�, newcustomer ���̺��� � ���� ���ڵ尡 �����Ǹ�, �ش� ���� ��� �ֹ��� 
--neworders ���̺����� �ڵ����� ����
CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

CREATE TABLE neworders(
orderid NUMBER,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER,
orderdate DATE,
PRIMARY KEY(orderid),
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE);
DESC  NEWORDERS;

--����11_1115. 10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. �� FOREIGN KEY�� �����Ͽ� ���� ���̺��� �����͸� ���� �� �ٸ� ���̺���
--���õǴ� �����͵� ��� �����ǵ��� �ϼ���. (��� ���������� ���)
--��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù��° �����͸� �����ϰ� �ִ� �Ӽ��� �����Ͽ� ������ ���� 

create table mart(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- �湮 ��
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- ��������
    , family number -- ���� ������ ��
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(20));
alter table mart modify (phone varchar2(100));

insert into mart values(1, '��浿', 32, '��', '010-1234-1234', '���� ����', 5, 1500000, 'N', 3);
insert into mart values(2, '�����', 31, '��', '010-7777-1234', '���� ��õ', 5, 200000000, 'Y', 4);
insert into mart values(3, '�̼���', 57, '��', '010-1592-1234', '�泲 �뿵', 5, 270000, 'N', 1);
insert into mart values(4, '������', 30, '��', '010-0516-1234', '���� ����', 5, 750000000, 'Y', 4);

select * from mart;


create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- ���� ã�� ����
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- �߷���ŷ ���� ��뿩��
    , rounge varchar2(20) -- vip ����� ��뿩��
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '�����', 31, '��', '010-7777-1234', '���� ��õ', 'LV', 900000000,'','');
insert into department values(2, '������', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');

DELETE department
WHERE custid = 1;

--table school, student
CREATE TABLE school(
schoolid NUMBER PRIMARY KEY,
schoolname VARCHAR2(20) NOT NULL,
schooltype VARCHAR2(10) NOT NULL,
schooladdress VARCHAR2(50) NOT NULL,
schoolsize NUMBER,
headmaster_name VARCHAR2(10),
class_total NUMBER DEFAULT 1,
teachers_total NUMBER,
students_total NUMBER CHECK(students_total>5),
established_date DATE);

DESC school;

CREATE TABLE student(
schoolid NUMBER,
schoolname VARCHAR2(20) NOT NULL,
schooltype VARCHAR2(10) NOT NULL,
gradenumber NUMBER NOT NULL,
classnumber NUMBER NOT NULL,
studentnumber NUMBER,
studentname VARCHAR2(10) NOT NULL,
address VARCHAR2(50),
email VARCHAR2(30) UNIQUE,
phone CHAR(13) DEFAULT '000-0000-0000',
PRIMARY KEY(studentnumber),
FOREIGN KEY(schoolid) REFERENCES school(schoolid) ON DELETE CASCADE);

DESC student;

ALTER TABLE school MODIFY(schooltype VARCHAR2(20));
INSERT INTO school VALUES(1,'��ȭ','�ʵ��б�','�λ����� ���ݵ�', 1000,'�ƹ���',36,50,1080,'1955-01-01');
INSERT INTO school VALUES(2,'����','�ʵ��б�','�λ����� �簨��',1200,'�贩��',48,60,1920,'1996-01-01');
INSERT INTO school VALUES(3,'����','�ʵ��б�','�λ곲�� ��ȣ��',1100,'�̴���',36,50,1080,'2001-01-01');
INSERT INTO school VALUES(4,'����','���б�','�λ곲�� ��ȣ��',1000,'�ڴ���',30,40,800,'2002-01-01');
INSERT INTO school VALUES(5,'����','����б�','�λ곲�� ��ȣ��',1000,'������',20,30,600,'2002-01-01');
SELECT * FROM school;

ALTER TABLE student MODIFY(schooltype VARCHAR2(20));
INSERT INTO student VALUES(1,'��ȭ','�ʵ��б�',1,3,20,'������','�λ����� ���ݵ�','jsldk@naver.com','');
INSERT INTO student VALUES(1,'��ȭ','�ʵ��б�',2,3,24,'�Ѵ���','�λ����� �簨��','lkjq@gmail.com',DEFAULT);
INSERT INTO student VALUES(2,'����','�ʵ��б�',6,1,10,'������','�λ����� �簨��','poir@naver.com','010-1234-1234');
INSERT INTO student VALUES(3,'����','�ʵ��б�',4,3,21,'Ȳ����','�λ����� ��ȣ��','',DEFAULT);
INSERT INTO student VALUES(4,'����','���б�',3,2,1,'�δ���','�λ����� ��ȣ��','','010-987-6543');
SELECT * FROM student;

DELETE school
WHERE schoolid = 1;

DELETE student
WHERE schoolid = 2;

SELECT * FROM school;
SELECT * FROM student;

--����1_1116. ParentTable, ChildTable 2���� �ۼ��ϰ� �� ���̺��� �Ӽ��� 4��(������ Ÿ���� ��� �ٸ�)�� ���������� 5�� �̻� �����Ѵ�.
--ParentTable�� �⺻Ű�� ���Ͽ� ChildTable�� �Ӽ��� �ϳ��� ������ �ϴ� �ܷ�Ű�� �����ϰ� Ư�� �����͸� �����ϸ� ��� ������ �ǵ��� �Ѵ�.
--�����ʹ� ���� 10�� �̻� �Է��ϰ� ������ �����Ѵ�.
--������ ��ü ��ȸ, ����, ���� ���� ���Ͽ� ���ϴ� �׷��� ���� �ݾ��� �����Ѵ�.
--VARCHAR2, CHAR, NUMBER, DATE, (DECIMAL, FLOAT, INTEGER, TIMESTAMP) 

--naver ���� ������ ����
CREATE TABLE na_restaurant(
      tid                    NUMBER PRIMARY KEY, 
    name                VARCHAR2(40) NOT NULL,
    address             VARCHAR2(40) NOT NULL,
    registration_number     VARCHAR2(40) UNIQUE NOT NULL,
    phone_number             VARCHAR2(40),
    hompage_url             VARCHAR2(40),
    running_time             VARCHAR2(40),
    real_estate_price    NUMBER DEFAULT 50000 CHECK(real_estate_price > 10000),
    registration_date   DATE,
    open_date            DATE,
    pet_yn                CHAR(1) DEFAULT 'N'
);
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(1, 'ȣŸ��', '4���ⱸ ����', 'R001');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(2, '��귣�����', '7���ⱸ ����', 'R002');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(3, '����«��', '4���ⱸ ����', 'R003');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(4, '����Ĵ�', '�п� ����', 'R004');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(5, '���ʽĴ�', '4���ⱸ ����', 'R005');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(11, '������', '4���ⱸ ����', 'R011');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(12, '��һ����뱹', '4���ⱸ ����', 'R012');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(13, '��������â��', '4���ⱸ ����', 'R013');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(14, '�������', '4���ⱸ ����', 'R014');
INSERT INTO na_restaurant(TID,NAME,ADDRESS,registration_number) VALUES(15, '���ʹ�', '4���ⱸ ����', 'R015');
SELECT * FROM na_restaurant;

CREATE TABLE na_food(
    tid                          NUMBER PRIMARY KEY,
    na_restaurant_tid      NUMBER NOT NULL,
    name                      VARCHAR2(40) NOT NULL,
    price                       NUMBER NOT NULL,
    selling_count           NUMBER DEFAULT 0,
    registration_date     DATE DEFAULT SYSDATE,
    pepper_yn           CHAR(1) DEFAULT 'N',
    salt_yn                CHAR(1) DEFAULT 'N',
    sugar_yn             CHAR(1) DEFAULT 'N',
    detail_info           CLOB,
    FOREIGN KEY(na_restaurant_tid) REFERENCES na_restaurant(tid) ON DELETE CASCADE
);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(1,1,'���������',10000);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(2,2,'�ñ״�ó����',4400);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(3,3,'¥���',7000);  
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(4,4,'���',9000);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(5,5,'���',8000);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(11,11,'�������',11000);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(12,12,'�����뱹',9500);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(13,13,'���',7000);  
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(14,14,'���',7500);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(15,15,'�����ʹ�',18000);

-- 1,2,3 ������ ��հ� �׽�Ʈ�� ������
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(6,1,'�������',9500);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(7,1,'Ÿ�ھ߳�',11000);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(8,2,'¥��ġ��Ʈ',6500);
INSERT INTO na_food(TID,na_restaurant_tid,name,price) VALUES(9,3,'«��',8500);  

-- ������ Ȯ��
SELECT * FROM na_restaurant;
SELECT * FROM na_food;

-- ĳ��ĳ�̵� ���� �׽�Ʈ
DELETE na_restaurant WHERE TID IN (4,5);

-- ���Ժ� �޴� ��ձݾ� �׽�Ʈ
SELECT R.NAME R_NAME, ROUND(AVG(F.PRICE)/10)*10 F_AVG_PRICE 
FROM na_restaurant R, na_food F
WHERE R.TID = F.na_restaurant_tid
GROUP BY R.NAME;

--���� ��곻�� Ȯ��
create table parents(
    family_name varchar2(100) primary key
    , age number not null
    , stock number
    , cash number
    , car_num char(10) default '0000' -- �ڵ��� ��ȣ
    , repay_date date -- ���� ��ȯ����
);

insert into parents values('Kim', 50, 1000000, 20000000, '4458', '2021-11-30');
insert into parents values('Lee', 57, 2000000, 10000000, '4521', '2023-12-31');
insert into parents values('Park', 60, 4000000, 5000000, '5893', '2024-02-20');
insert into parents values('Sim', 55, 8000000, 2500000, '9820', '2024-01-07');
insert into parents values('Seo', 58, 16000000, 1250000, '2786', '2023-11-01');
insert into parents values('Choi', 49, 120000000, 5000000, '1157', '2023-11-11');
insert into parents values('Kang', 59, 3200000, 100000000, '2984', '2023-12-01');
insert into parents values('Joo', 53, 258000000, 12000000, '4233', '2024-01-06');
insert into parents values('Chae', 52, 38000000, 37500000, '2520', '2022-05-05');
insert into parents values('Sung', 60, 58700000, 50000000, '1003', '2025-01-01');

select * from parents;

create table child(
    family_name varchar2(100) primary key
    , age number not null check (age > 25)
    , stock number
    , cash number
    , car_num char(10) default '0000'
    , graduation_date date not null
    , foreign key(family_name) references parents(family_name) on delete cascade
);

insert into child values('Kim', 26, 25000000, 2000000, '5555', '2023-07-31');
insert into child values('Lee', 27, 12500000, 4000000, '4521', '2021-12-28');
insert into child values('Park', 30, 5000000, 8000000, '6666', '2019-02-28');
insert into child values('Sim', 30, 100000000, 100000000, '9820', '2019-02-28');
insert into child values('Seo', 27,50000000, 50000000, '2786', '2022-07-31');
insert into child values('Choi', 26, 15000000, 5000000, '5252', '2023-07-31');
insert into child values('Kang', 26, 18000000, 12000000, '3488', '2021-12-28');
insert into child values('Joo', 31, 20000000, 7000000, '8966', '2019-02-28');
insert into child values('Chae', 33, 35000000, 2500000, '9722', '2019-02-28');
insert into child values('Sung', 28, 5000000, 3500000, '1152', '2022-07-31');

select * from child;

select parents.family_name as "�θ�"
    , to_char(parents.cash, '999,999,999') as "�θ� ���ݺ�����(��)"
    , child.family_name as "�ڽ�"
    , to_char(child.cash, '999,999,999') as "�ڽ� ���ݺ�����(��)"
from parents inner join child
    on parents.family_name = child.family_name
order by parents.cash desc;


select repay_date as "��ȯ����"
    ,(case when stock > cash
    then to_char((stock - cash),'999,999,999')
    else '�ڵ����㺸����'
    end) as "�ֽĴ㺸���� ����(��)"
    ,(case when repay_date < sysdate
    then '��ü'
    else '�̿�ü'
    end) as "��ü����"
from parents
order by family_name;




SELECT * FROM customer; 


--����12_1115. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE customer
SET address = (
    SELECT address
    FROM customer
    WHERE name = '�迬��'
)
WHERE name = '�ڼ���';

--Ȯ��
select address, name
from customer;

--�ٽ� �λ����� ����
update customer
set address = '���ѹα� �λ�'
where name ='�ڼ���';
--������ ����
INSERT INTO customer VALUES(11,'�迬��','����','000-1111-0001');

--������ ����
DELETE customer
WHERE custid = 11;


SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875, 1)
FROM dual;
 
--Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
SELECT * FROM orders;
SELECT custid AS ����ȣ, ROUND(AVG(saleprice), -2) AS ����ֹ��ݾ�
FROM orders
GROUP BY custid;

--Q.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM book;

--Q.���½����������� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����, length(bookname) ���ڼ�, lengthb(bookname) ����Ʈ��
FROM book
WHERE publisher = '�½�����';

SELECT * FROM customer;
INSERT INTO Customer VALUES (5, '�ڼ���', '���ѹα� ����', NULL);

--Q. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
select substr(name,1,1) ��, count(*) �ο�
from customer
group by substr(name,1,1);

--Q. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT orderid, orderdate AS �ֹ���, orderdate + 10 AS Ȯ������
FROM orders;

--Q.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
--SELECT orderid �ֹ���ȣ, orderdate �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '2020-07-07';
desc orders;

SELECT SYSDATE FROM DUAL;

--Q. DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') SYSDATE1
FROM DUAL;

--Q.�̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� ǥ���Ͻÿ�.
--NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�. �Լ�  :  NVL("��", "������") 
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

select * from customer;

--Q. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
--ROWNUM : ����Ŭ���� �ڵ����� �����ϴ� ���� ���� ������ ����Ǵ� ���� �� �࿡ �Ϸù�ȣ�� �ڵ����� �Ҵ�.
SELECT rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ 
FROM customer
WHERE rownum < 3;

SELECT * FROM orders;
Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice
from orders
where saleprice < (select avg(saleprice) from orders);

--Q. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) AS ���Ǹž�
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');
