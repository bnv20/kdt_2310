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

SELECT * FROM customer; 

--Q.Customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� �����ѹα� �λꡯ���� �����Ͻÿ�.

--������ ����
UPDATE customer
SET address= '���ѹα� �λ�'
WHERE custid = 5;

--����12_1115. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.

--������ ����
INSERT INTO customer VALUES(11,'�迬��','����','000-1111-0001');

--������ ����
DELETE customer
WHERE custid = 11;

--����13_1115. 10���� �Ӽ����� ���� ���̺� ���� �� 5�� �����͸� ������ �� ������ ���Ͽ� ���� �� 2���� �����ϰ� ���� 3���� ����ϼ���.

SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875, 1)
FROM dual;
 
--����14_1115. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.

--Q.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT bookid, REPLACE(bookname, '��','�߱�') bookname, publisher, price
FROM book;

--Q.���½����������� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����, length(bookname) ���ڼ�, lengthb(bookname) ����Ʈ��
FROM book
WHERE publisher = '�½�����';

SELECT * FROM customer;
INSERT INTO Customer VALUES (5, '�ڼ���', '���ѹα� ����', NULL);
--����15_1115. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.

--����16_1115. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.

--Q.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '2020-07-07';
desc orders;

SELECT SYSDATE FROM DUAL;
--����17_1115. DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.

--Q.�̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� ǥ���Ͻÿ�.
--NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�. �Լ�  :  NVL("��", "������") 
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

--�μ��� ������� ���ϰ� ó������ NULL�� �ƴ� ù ��° ���� ���� ���� ��ȯ�մϴ�. 
--���� ��� SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value');�� �� ��° ���� Null�� �ƴ� ù ���̱� ������ 
--�� ��° ���� ��ȯ

select * from customer;

--����18_1115. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.

SELECT * FROM orders;
--����19_1115. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.

--����20_1115. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.

