select * from employees;

--Q.����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
SELECT E.employee_id ���, E.first_name �̸�, E.last_name ��, E.job_id ����, J.job_title ������
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
WHERE E.employee_id = 120;

SELECT 
EMPLOYEE_ID ���, 
FIRST_NAME || ' ' || LAST_NAME AS �̸�,
J.JOB_ID ����,
J.JOB_TITLE ������
FROM EMPLOYEES E, JOBS J
WHERE E.EMPLOYEE_ID=120
AND e.job_id = j.job_id;

--����2_1116. HR EMPLOYEES ���̺��� �̸�, �޿�, 10% �λ�� �޿��� ����ϼ���.
SELECT last_name �̸� , salary �޿�, salary*1.1 �λ�ȱ޿�
FROM employees;

--����3_1116. 2005�� ��ݱ⿡ �Ի��� ����鸸 ���
SELECT first_name||' '||last_name "�̸�", hire_date "�Ի���"
FROM employees
WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

--����4_1116. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

--����5_1116. manager_id �� 101���� 103�� ����� ���
SELECT manager_id
FROM employees
WHERE manager_id between 101 and 103;

--_�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����ϰ� ���� �� escape �ɼ��� ���
select * from employees where job_id like '%\_A%';
select * from employees where job_id like '%\_A%' escape '\';
select * from employees where job_id like '%#_A%' escape '#';

--IN : OR ��� ���
select * from employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id in ( 101, 102, 103 );

--IS NULL / IS NOT NULL
--null �������� Ȯ���� ��� = �� �����ڸ� ������� �ʰ� is null�� ����Ѵ�.
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--ORDER BY
--ORDER BY �÷��� [ASC | DESC]
select * from employees order by salary asc;
select * from employees order by salary desc;
select * from employees order by salary asc, last_name desc;

--DUAL ���̺�
select * from employees where mod( employee_id, 2 )= 1;
select mod( 10, 3 ) from dual;

--round()
select round( 355.95555 ) from dual;
select round( 355.95555, 2 ) from dual;
select round( 355.95555, -2 ) from dual;

--trunc()	���� �Լ�. ������ �ڸ��� ���ϸ� ���� ��� ����
select trunc( 45.5555, 1 ) from dual;
--ceil() ������ �ø�, �ڸ� ���� ����	
select ceil( 45.111 ) from dual;

--����6_1116. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
SELECT employee_id �����ȣ, last_name �̸� 
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees WHERE mod(employee_id, 2) = 1);

--����7_1116. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
SELECT COUNT(*) FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;

--����8_1116. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.(position ���� �߰�)
select employee_id, first_name, last_name, '����' as position 
from employees
where department_id is null;

select last_name, department_id, nvl(to_char(department_id),'����') position
from employees where department_id is null;

--����9_1116. employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME
FROM employees;

--����10_1116. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
SELECT * FROM employees ORDER BY salary,last_name;

--��¥ ���� �Լ�
select sysdate from dual;
select sysdate + 1 from dual;
select sysdate - 1 from dual;

select * from employees;
--�ٹ��� ��¥ ���
select last_name, round(sysdate-hire_date) �ٹ��Ⱓ from employees;

--add_months()    		Ư�� ���� ���� ���� ��¥�� ���Ѵ�.
select last_name, hire_date, add_months( hire_date, 6 ) from employees;

--last_day()			�ش� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
select last_name, hire_date, last_day( hire_date ) from employees;
select last_name,hire_date, last_day(add_months(hire_date,1)) from employees;

--next_day()			�ش� ��¥�� �������� ��õ� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ
--�� ~ ��, 1 ~ 7 �� ǥ������
select hire_date, next_day( hire_date, '��' ) from employees;

--months_between()		��¥�� ��¥ ������ �������� ���Ѵ�.
SELECT hire_date, round(months_between(sysdate, hire_date),1) from employees;

--�� ��ȯ �Լ� : to_date()			���ڿ��� ��¥��
--'2023-01-01'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ
SELECT TO_DATE('2023-01-01', 'YYYY-MM-DD') FROM dual;

--to_char( ��¥ )		��¥�� ���ڷ� ��ȯ
select to_char( sysdate, 'yy/mm/dd' ) from dual;

--����
--YYYY 		�� �ڸ� ����
--YY		�� �ڸ� ����
--YEAR		���� ���� ǥ��
--MM		���� ���ڷ�
--MON		���� ���ĺ�����
--DD		���� ���ڷ�
--DAY		���� ǥ��
--DY		���� ��� ǥ��
--D		���� ���� ǥ��
--AM �Ǵ� PM	���� ����
--HH �Ǵ� HH12	12�ð�
--HH24		24�ð�
--MI		��
--SS		��
select sysdate from dual;

����1_1117. ���� ��¥(SYSDATE)�� 'YYYY/MM/DD' ������ ���ڿ��� ��ȯ�ϼ���.
select to_char(sysdate, 'YYYY/MM/DD') "��¥" from dual;

����2_1117. '01-01-2023'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�ϼ���
SELECT TO_DATE('02-01-2023', 'mm-dd-YYYY') FROM DUAL;

����3_1117. ���� ��¥�� �ð�(SYSDATE)�� 'YYYY-MM-DD HH24:MI:SS' ������ ���ڿ��� ��ȯ�ϼ���
SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;

����4_1117. '2023-01-01 15:30:00'�̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���.
select to_date('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS') from dual;

--to_char( ���� )	���ڸ� ���ڷ� ��ȯ
--9		�� �ڸ��� ���� ǥ��		( 1111, ��99999�� )		1111	
--0		�� �κ��� 0���� ǥ��		( 1111, ��099999�� )		001111
--$		�޷� ��ȣ�� �տ� ǥ��		( 1111, ��$99999�� )		$1111
--.		�Ҽ����� ǥ��			( 1111, ��99999.99�� )		1111.00
--,		Ư�� ��ġ�� , ǥ��		( 1111, ��99,999�� )		1,111
--MI		�����ʿ� - ��ȣ ǥ��		( 1111, ��99999MI�� )		1111-
--PR		�������� <>�� ǥ��		( -1111, ��99999PR�� )		<1111>
--EEEE		������ ǥ��			( 1111, ��99.99EEEE�� )		1.11E+03
--V		10�� n�� ���Ѱ����� ǥ��	( 1111, ��999V99�� )		111100
--B		������ 0���� ǥ��		( 1111, ��B9999.99�� )		1111.00
--L		������ȭ			( 1111, ��L9999�� )

select salary, to_char( salary, '0999999' ) from employees;
select to_char( -salary, '999999PR' ) from employees;
--1111 -> 1.11E+03
select to_char( 11111, '9.999EEEE' ) from dual; 
SELECT TO_CHAR(-1111111, '9999999MI') FROM dual;

--width_bucket()				������, �ּҰ�, �ִ밪, bucket����
select width_bucket( 92, 0, 100, 10 ) from dual;
select width_bucket( 100, 0, 100, 10 ) from dual;

select last_name from employees;
--Q. employees ���̺��� salary�� 5�� ������� ǥ���ϼ���
select max(salary) max, min(salary) min from employees;
SELECT salary, WIDTH_BUCKET(salary, 2100, 24001, 5) AS grade
FROM employees;

--���� �Լ� Character Function
--upper()			�빮�ڷ� ����
select upper( 'Hello World' ) from dual;
--lower()			�ҹ��ڷ� ����
select lower( 'Hello World' ) from dual;

--Q. last_name�� Seo�� ������ last_name �� salary�� ���ϼ���.(Seo, SEO, seo ��� ����)
SELECT LAST_NAME, SALARY FROM EMPLOYEES WHERE lower(LAST_NAME) = 'seo';

--initcap()			ù���ڸ� �빮��
select job_id, initcap( job_id ) from employees;

--length()			���ڿ��� ����
select job_id, length( job_id ) from employees;

--instr()			���ڿ�, ã�� ����, ã�� ��ġ, ã�� ���� �� �� �� °
select instr( 'Hello World', 'o', 3, 2 ) from dual;

--substr()			���ڿ�, ������ġ, ����
select substr( 'Hello World', 3, 3 ) from dual;
SELECT substr('Hello World', 9, 3) FROM dual;
SELECT substr('Hello World', -3, 3) FROM dual;

--lpad()			������ ���� �� ���ʿ� ���ڸ� ä���.
select lpad( 'Hello World', 20, '#' ) from dual;

--rpad()			���� ���� �� �����ʿ� ���ڸ� ä���.
select rpad( 'Hello World', 20, '#' ) from dual;

--ltrim()
select ltrim( 'aaaHello Worldaaa', 'a' ) from dual;
select ltrim( '   Hello World   ' ) from dual;

--rtrim()
select rtrim( 'aaaHello Worldaaa', 'a' ) from dual;
select rtrim( '   Hello World   ' ) from dual;

select last_name from employees;
select last_name as �̸�, ltrim(last_name, 'A') as ��ȯ
from employees;

--
--trim
select trim( '   Hello World   ' ) from dual;
--�յ��� Ư�� ���� ����
select last_name, trim( 'A' from last_name ) from employees;

--nvl()		null�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
select last_name, manager_id, 
nvl( to_char( manager_id ), 'CEO' ) from employees;

--decode() 	if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
--DECODE �Լ��� �ܼ��� ���ǿ� ����Ͽ� ���� ��ȯ�մϴ�. ������ DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--���⼭ expression�� �˻��� ���� ��Ÿ����, search�� result�� ���� ���ǰ� �ش� ������ ���� �� ��ȯ�� ��
--default�� ��� search ������ ������ �� ��ȯ�� �⺻ �� ���
select last_name, department_id, 
decode(department_id,
    90, '�濵������', 
    60, '���α׷���', 
    100, '�λ��','��Ÿ') �μ�
from employees;

����5_1117. employees ���̺��� commission_pct�� null�� �ƴ� ���, 'A' null�� ��� 'N'�� ǥ���ϴ� ������ �ۼ�
select commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') as ��ȯ
from employees
order by ��ȯ desc;

--case()
--decode() �Լ��� �����ϳ� decode() �Լ��� ������ ������ ��츸 ����������
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ������ �� �ִ�.
--CASE ���� ���ǿ� ���� �ٸ� ���� ��ȯ�ϴ� �� ���Ǹ�, DECODE���� ������ ������ ǥ���� �� �ִ�. 
--������ CASE WHEN condition THEN result ... ELSE default END�̴�. 
select last_name, department_id, 
case when department_id=90 then '�濵������' 
when department_id=60 then '���α׷���' 
when department_id=100 then '�λ��' 
else '��Ÿ'
end as �Ҽ�
from employees;

����6_1117. employees ���̺��� salary�� 20000 �̻��̸� 'a', 10000�� 20000 �̸� ���̸� 'b', �� ���ϸ� 'c'�� ǥ���ϴ� ������ 
--�ۼ��Ͻÿ�.(case)
select last_name,salary,
case
when salary>=20000 then ' a'
when salary>10000 and salary<20000 then ' b'
else ' c'
end as ���
from employees;

--INSERT
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);

-- Concatenation :  �޸� ��ſ� ����ϸ� ���ڿ��� ����Ǿ� ��µȴ�.
select last_name, 'is a ', job_id from employees;
select last_name ||  ' is a'  || job_id from employees;

--UNION
--UNION( ������ ) INTERSECT( ������ ) MINUS( ������ ) UNION ALL( ��ġ�� �ͱ��� ���� )
--�� ���� �������� ����ؾ� �Ѵ�. ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�.
select first_name �̸�, salary �޿� from employees 
where salary < 5000
union
select first_name �̸�, salary �޿� from employees 
where hire_date < '99/01/01';

select first_name �̸�, salary �޿� from employees 
where salary < 5000
minus
select first_name �̸�, salary �޿� from employees 
where hire_date < '99/01/01';

select first_name �̸�, salary �޿� from employees 
where salary < 5000
intersect
select first_name �̸�, salary �޿� from employees 
where hire_date < '99/01/01';

--CREATE VIEW ��ɾ�� ����Ŭ SQL���� ���̺��� Ư�� �κ��̳� ���ε� ����� ������ ��(view)�� ���� �� ���
--��� �����͸� ����ϰų� ������ ������ �ܼ�ȭ�ϸ�, ����ڿ��� �ʿ��� �����͸��� �����ִ� �� ����
--��� ���� ���̺� �����͸� �������� �ʰ�, ��� ���� ����� ����
--���� �ֿ� Ư¡
--���� �ܼ�ȭ: ������ ������ ��� ���������ν� ����ڴ� ������ �������� �ݺ��ؼ� �ۼ��� �ʿ� ���� �����ϰ� �並 ������ �� �ִ�.
--������ �߻�ȭ: ��� �⺻ ���̺��� ������ ����� ����ڿ��� �ʿ��� �����͸��� ������ �� �־�, ������ �߻�ȭ�� ����.
--���� ��ȭ: �並 ����ϸ� Ư�� �����Ϳ� ���� ������ ������ �� ������, ����ڰ� �� �� �ִ� �������� ������ ������ �� �ִ�.
--������ ���Ἲ ����: �並 ����Ͽ� �����͸� �����ϴ���, �� ��������� �⺻ ���̺��� ������ ���Ἲ ��Ģ�� �������� �ʵ��� ������ �� �ִ�.

CREATE VIEW employee_details AS
SELECT employee_id, last_name, department_id
FROM employees;

SELECT * FROM employee_details;

����7_1117. employees ���̺��� salary�� 10000�� �̻��� �������� �����ϴ� �� special_employee�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
CREATE VIEW special_employee AS
SELECT *
FROM employees
WHERE salary >= 10000;
select * from special_employee;

����8_1117. employees ���̺��� �� �μ��� ���� ���� �����ϴ� �並 �����ϼ���
CREATE VIEW department_employee_count AS
SELECT department_id, COUNT(*) AS �μ���_������
FROM employees
GROUP BY department_id
ORDER BY �μ���_������;

select * from department_employee_count;

����9_1117. employees ���̺��� �ټӱⰣ�� 10�� �̻��� ������ �����ϴ� �並 �����ϼ���.
CREATE VIEW goinmul AS
SELECT last_name, round(sysdate-hire_date) AS �ټӱⰣ
FROM employees
WHERE round(sysdate-hire_date) > 365 * 10;

SELECT * from goinmul;

--TCL (Transaction Control Language)
--COMMIT: ���� Ʈ����� ������ ����� ��� ����(INSERT, UPDATE, DELETE ��)�� �����ͺ��̽��� ���������� ����.
--COMMIT ����� �����ϸ�, Ʈ������� �Ϸ�Ǹ�, �� ���Ŀ��� ���� ������ �ǵ��� �� ����.
--ROLLBACK: ���� Ʈ����� ������ ����� ������� ����ϰ�, �����ͺ��̽��� Ʈ������� �����ϱ� ���� ���·� �ǵ�����. 
--������ �߻��߰ų� �ٸ� ������ Ʈ������� ����ؾ� �� ��쿡 ���ȴ�.
--SAVEPOINT: Ʈ����� ������ �߰� üũ����Ʈ�� �����մϴ�. ������ �߻��� ���, ROLLBACK�� ����Ͽ� �ֱ��� SAVEPOINT���� �ǵ��� �� �ִ�.
--Ʈ������� ��Ʈ���ϴ� TCL(TRANSACTION CONTROL LANGUAGE)

-- members ���̺� ����
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    join_date DATE,
    status VARCHAR2(20)
);

INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');

select * from members;

INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

SAVEPOINT sp1;
INSERT INTO members (member_id, name, email, join_date, status) VALUES (7, 'Bob Kim', 'bob@example.com', SYSDATE, 'Inactive');

rollback to sp1;
commit;

--����10_1117.
--orders��� ���̺��� �����ϰ�, order_id, customer_id, order_date, amount, status��� �Ӽ��� �����ϼ���.
--�����͸� 5�� �Է��ϼ���.
--�Է��� ������ �� 2���� �����ϼ���.
--������ �����͸� ����ϱ� ���� �ѹ��� ����ϼ���.
--3���� ���ο� �����͸� �Է��ϰ�, �� �� ������ ������ �Է¸� ����� �� �������� Ŀ���ϼ���.

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount NUMBER check (amount > 0),
    status VARCHAR2(30));

INSERT INTO orders VALUES(1,1, '2023-11-01',32000, '��޿Ϸ�');
INSERT INTO orders VALUES(2,2, '2023-11-02',20000, '��޿Ϸ�');
INSERT INTO orders VALUES(3,2, '2023-11-09',20000, '��޿Ϸ�');
INSERT INTO orders VALUES(4,3, '2023-11-10',18000, '�ֹ�ó����');
INSERT INTO orders VALUES(5,4, '2023-11-14',45000, '�ֹ�Ȯ����');
SAVEPOINT sp;

SELECT * FROM orders;

UPDATE orders
SET status = '�ֹ����'
WHERE order_id = 4;

UPDATE orders
SET status = '�ֹ����'
WHERE order_id = 5;

ROLLBACK to sp;

INSERT INTO orders VALUES(6,5, '2023-11-15',30000, '�ֹ�ó����');
INSERT INTO orders VALUES(7,6, '2023-11-15',48000, '�ֹ�ó����');
SAVEPOINT spa;
INSERT INTO orders VALUES(8,5, '2023-11-16',25000, '�ֹ�Ȯ����');
ROLLBACK to spa;
COMMIT;

--����11_1117. �����ִ� db ���̺��� �����ϰ� �����ϴ� �ó������� �ۼ��Ͽ� ������ �Է�, ����, ���� ������ ������ �� ���� ������ 
--10���� ����ϼ���.(ROLLBACK 2ȸ, SAVEPOINT 2���� �ּ��� ���)
create table employee_evaluation(
    employee_id char(10) primary key -- 1���� 10����
    , name varchar2(50) not null
    , department char(50) not null -- ��ȹ��, ������, ����1��, ����2��
    , position char(10) not null
    , hire_date date
    , goal int not null
    , performance int
);

select *
from employee_evaluation;

alter table employee_evaluation drop column name;
alter table employee_evaluation add (first_name varchar2(50));
alter table employee_evaluation add (last_name varchar2(50));
alter table employee_evaluation add (salary number check(salary > 3000));
alter table employee_evaluation add (achieve char(10) not null);

select *
from employee_evaluation;

savepoint sp_1;

alter table employee_evaluation drop column achieve;
alter table employee_evaluation add (achieve char(10));

rollback sp_1;

insert into employee_evaluation values (1, '��ȹ��', '����', '2020-01-01', 100, 110, '����', '��', 10000, '');
insert into employee_evaluation values (2, '��ȹ��', '����', '2020-05-01', 70, 70, '�쿵', '��', 7500, '');
insert into employee_evaluation values (3, '��ȹ��', '�븮', '2021-01-25', 30, 25, '�Լ�', '��', 5500, '');
insert into employee_evaluation values (4, '����1��', '����', '2020-01-01', 100, 120, '����', 'Ȳ', 9000, '');
insert into employee_evaluation values (5, '����1��', '����', '2020-05-01', 70, 90, '����', '��', 7300, '');
insert into employee_evaluation values (6, '����1��', '�븮', '2021-01-25', 30, 45, '���', '��', 5300, '');
insert into employee_evaluation values (7, '����2��', '����', '2020-05-01', 70, 80, '���', '��', 7300, '');
insert into employee_evaluation values (8, '����2��', '����', '2020-05-01', 50, 120, '����', '��', 5800, '');
insert into employee_evaluation values (9, '����2��', '���', '2023-06-01', 15, 20, '����', '��', 4500, '');
insert into employee_evaluation values (10, '������', '�븮', '2022-05-14', 30, 45, '�缺', '��', 5600, '');

savepoint sp_2;

select *
from employee_evaluation;

alter table employee_evaluation modify (employee_id char(10));
alter table employee_evaluation modify (department varchar2(50));

rollback to sp_2;

commit;

alter table employee_evaluation modify (position char(15));

update employee_evaluation
set position = '����(����)'
where position = '����';

commit;

update employee_evaluation
set performance = 90
where first_name = '����';

update employee_evaluation
set performance = 50
where first_name = '����';

commit;

-- ����
create view KPI as
    select last_name||''||first_name as �̸�
        , employee_id as ���
        , position as ����
        , goal as "��ǥ KPI"
        , performance as "�޼� KPI"
        , (performance - goal) as "KPI �ʰ���"
        , case when (performance - goal) >= 0
            then 'Y'
            else 'N'
            end as "ACHIEVE"
    from employee_evaluation
    order by achieve desc, "KPI �ʰ���" desc;
    
select *
from KPI
where "KPI �ʰ���" >= 0;


--����12_1117. HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
select * from job_history;

--�μ��� �޿� ��Ȳ
--���̺����, �μ��� �޿��� �� �޿��� Ȯ�� �� �� ����.
--(�޿��� �� ��� �ּڰ� �ִ�, �� ������, �޿���ü����, ������ձ޿�, �μ���ձ޿�)
--table ����� �μ��� �޿��� �뷫������ ����
--����� ���̺� Ȯ��
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--�μ� ��� Ȯ��
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- �μ� ��� department_id : 10,20,30,40,50,60,70,80,90,100,110 �� �� ������(120~200��..)�� ���� null ���� ����.
--department_id �� null �� ����� ��� job_id �� �´� department_id �� �ο����ַ�����(������ ���Ἲ)
--1. department_id �� null ���� ��� ã��
select *
from employees
where department_id IS NULL;
--�Ѹ� �ۿ� ����. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id �� SA_REP �� department_id ã�� (������ �´� �μ� ã��)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP �� department_id �� 80

--3. ���� �� savepoint ����
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. ��������primary key �� employee_id �� ã�Ƽ� derpartment_id �� 80���� ����
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint�� ����
--commit;
--������


--�μ��� �޿� Ȯ��..
SELECT department_id,SALARY
FROM employees
WHERE department_id = ANY(10,20,30,40,50,60,70,80,90,100,110)
order by department_id;


--�μ� �̸� Ȯ��
select department_id, department_name from departments;


--department_id �μ��� ������ Ȯ�� (employees ���̺���)
select department_id, count(department_id)
from employees
group by department_id
order by department_id;

select *
from employees
order by department_id desc;

--�μ��� �� �޿� �ջ�ݾ�, ���, �ּ�, �ִ�.. --��հ��� �Ҽ��� ��°�ڸ�����...
SELECT sum(SALARY), round(avg(salary),2), min(salary), max(salary)
FROM employees
WHERE department_id = 80; --10,20,30,40,50,60,70,80,90,100,110

--------------------------------------------
--���̺� ���� : �μ��� �޿��� �뷫������ ����..
CREATE TABLE OVERVIEW_departments_salary(
    department_id NUMBER(4) NOT NULL
    , department_name VARCHAR2(40) NOT NULL
    , department_num_of_employees NUMBER(3) NOT NULL
    , SUM_salary NUMBER(10) default 0
    , AVG_salary NUMBER(10) default 0
    , MIN_salary NUMBER(10) default 0
    , MAX_salary NUMBER(10) default 0
    , PRIMARY KEY (department_id)
);
DESC overview_departments_salary;

--�÷����̳ʹ� �� ����
ALTER TABLE OVERVIEW_departments_salary
RENAME COLUMN department_num_of_employees TO num_employees; 

--���̺� ���� �� INSERT �ϱ��� SAVEPOINT
SAVEPOINT before_insert;
---------------------------SAVEPOINT--------------------------------------

--������ �Է�. 
INSERT INTO OVERVIEW_departments_salary VALUES(10, 'Administration', 1, 4400, 4400, 4400, 4400);
INSERT INTO OVERVIEW_departments_salary VALUES(20, 'Marketing', 2, 19000, 9500, 6000, 13000);
INSERT INTO OVERVIEW_departments_salary VALUES(30, 'Purchasing', 6, 24900, 4150, 2500, 11000);
INSERT INTO OVERVIEW_departments_salary VALUES(40, 'Human Resources', 1, 6500, 6500, 6500, 6500);
INSERT INTO OVERVIEW_departments_salary VALUES(50, 'Shipping', 45, 156400, 3475.56, 2100, 8200);
INSERT INTO OVERVIEW_departments_salary VALUES(60, 'IT', 5, 28800, 5760, 4200, 9000);
INSERT INTO OVERVIEW_departments_salary VALUES(70, 'Public Relations', 1, 10000, 10000, 10000, 10000);
INSERT INTO OVERVIEW_departments_salary VALUES(80, 'Sales', 34, 311500, 8900, 6100, 14000);
INSERT INTO OVERVIEW_departments_salary VALUES(90, 'Executive', 3, 58000, 19333.33, 17000, 24000);
INSERT INTO OVERVIEW_departments_salary VALUES(100, 'Finance', 6, 51608, 8601.33, 6900, 12008);
INSERT INTO OVERVIEW_departments_salary VALUES(110, 'Accounting', 2, 20308, 10154, 8300, 12008);
--�μ���ȣ, �μ���, �����, �޿��� ��-���-�ּڰ�-�ִ�
select * from overview_departments_salary;

--�޿����ռ�
select department_id, department_name, num_employees, sum_salary from overview_departments_salary order by sum_salary desc; 
--��ձ޿���
select department_id, department_name, num_employees, avg_salary from overview_departments_salary order by avg_salary desc; 
--�ּұ޿���(��������)
select department_id, department_name, num_employees, min_salary from overview_departments_salary order by min_salary asc; 
--�ִ�޿���
select department_id, department_name, num_employees, max_salary from overview_departments_salary order by max_salary desc; 

--�� ������, �޿���ü����, ������ձ޿�, �μ���ձ޿� Ȯ��
select 
    sum(num_employees) AS "�� ������"
    , SUM(sum_salary) AS "�޿���ü����"
    , round(SUM(sum_salary) / sum(num_employees),2) AS "������ձ޿�"
    , AVG(sum_salary) AS "�μ���ձ޿�"
from overview_departments_salary;

-- savepoint�� ����
--rollback before_insert;
--commit; --���̺� Ŀ��.

--������ �� ������ ������
--�� �μ����� ������ ����̰� � �����ǵ��� �ְ� ������ ��� �Ǵ���
SELECT E.department_id, D.department_name, nvl(E.job_id,'Total') job_id , count(*) ������
FROM employees E
LEFT OUTER JOIN departments D on E.department_id = D.department_id
GROUP BY ROLLUP((E.department_id, D.department_name), E.job_id)
ORDER BY E.department_id;

--JOB ID �� �� ����� �ִ���
SELECT E.job_ID, J.job_title, count(E.employee_id)
FROM employees E
LEFT OUTER JOIN jobs J on E.job_id = J.job_id
WHERE E.job_id = J.job_id
GROUP BY E.job_id, J.job_title;

--JOB ID �� ������� �� �޴��� �� �������� ������ ���
SELECT job_id, ����, round(avg(salary)) ��ձ޿�
from (select job_id, floor(months_between(sysdate, hire_date)/12) as ����, salary from employees)
GROUP BY job_id, ����
ORDER BY job_id, ����;

