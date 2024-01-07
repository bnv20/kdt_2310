--ESCAPE 
--WHERE �÷��� ���� �� 
--LIKE ����
--ESCAPE ����
--_�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����ϰ� ���� �� escape �ɼ��� ����Ѵ�.
select * from employees where job_id like '%_A%';
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
select * from employees order by salary asc, last_name asc;

--[�ֿ� �Լ�]

--DUAL ���̺�
--select �� ������ �ݵ�� from ���� ����ؾ� �Ѵ�.
--������ ��� select �� ��ü������ ������ �����ϱ� ������ from �� �ڿ� �� ���̺��� �ʿ����.
--�̷� ��� ����� �� �ִ� Dummy ���̺��� DUAL ���̺��̴�.

--    mod()					������ �Լ�
select * from employees where mod( employee_id, 2 )= 1;

select mod( 10, 3 ) from dual;

--round()				�ݿø� �Լ�
select round( 355.95555 ) from dual;		356	�Ҽ��� ���� �ݿø�
select round( 355.95555, 2 ) from dual;	355.96	�Ҽ��� ���� ��°�ڸ� �ݿø�
select round( 355.95555, 0 ) from dual;	356
select round( 355.95555, -1 ) from dual;	360	�Ҽ��� ���� ���ڸ� �ݿø�

--trunc()					���� �Լ�. ������ �ڸ��� ���ϸ� ���� ����� ����
select trunc( 45.5555, 1 ) from dual;		45.5	�Ҽ��� ���� ���ڸ������� ǥ��
select ceil( 45.3333 ) from dual;
select last_name, trunc( salary/12, 2 ) from employees;

--��¥ ���� �Լ�
sysdate
�ý��ۿ� ����� ���� ��¥�� ��ȯ
select sysdate from dual;

select sysdate + 1 from dual;
select sysdate - 1 from dual;

select last_name, round(sysdate-hire_date) from employees;			�ٹ��� ��¥
sysdate�� �����Ͻú��ʰ� �������µ� �Ի����ڴ� 0�� 0�� 00�ʷ� ����Ǿ� �ִ�.

add_months()    		Ư�� ���� ���� ���� ��¥�� ���Ѵ�.
select last_name, add_months( hire_date, 6 ) from employees;

last_day()			�ش� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
select last_day( sysdate ) - sysdate from dual;
select hire_date, last_day( hire_date ) from employees;
select last_name, hire_date, last_day( add_months( hire_date, 1 ) ) from employees;

next_day()			�ش� ��¥�� �������� ��õ� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ
�� ~ ��, 1 ~ 7 �� ǥ�������ϴ�.
select hire_date, next_day( hire_date, '��' ) from employees;
select  TO_CHAR(SYSDATE'DY MONTH DD,YYYY','NLS_DATE_LANGUAGE=ENGLISH') from DUAL;


months_between()		��¥�� ��¥ ������ �������� ���Ѵ�.
select last_name, round(months_between( sysdate, hire_date ), 2) ������ from employees;

--�� ��ȯ �Լ�
	
    <-TO_NUMBER                   <-TO_CHAR
Number                character	               	 date
     TO_CHAR ->                   TO_DATE ->

to_date()			���ڿ��� ��¥��
to_date( ����¥�� ) 	
select sysdate from dual;

����: '2023-01-01'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�ϼ���.
SELECT TO_DATE('2023-01-01', 'YYYY-MM-DD') FROM dual;

����: ���� ��¥(SYSDATE)�� 'YYYY/MM/DD' ������ ���ڿ��� ��ȯ�ϼ���.
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM dual;

����: '01-01-2023'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�ϼ���
SELECT TO_DATE('01-01-2023', 'DD-MM-YYYY') FROM dual;
;

����: ���� ��¥�� �ð�(SYSDATE)�� 'YYYY-MM-DD HH24:MI:SS' ������ ���ڿ��� ��ȯ�ϼ���
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;

����: '2023-01-01 15:30:00'�̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���.
SELECT TO_DATE('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS') FROM dual;


select employee_id ���, last_name �̸�, hire_date �Ի���,
trunc( ( to_date( '13/01/01' ) - hire_date ) / 365 ) �ټӿ���
from employees order by �ټӿ��� desc;

SELECT TO_DATE('20210101') , 
TO_CHAR(TO_DATE('20210101'),'MonthDD YYYY','NLS_DATE_LANGUAGE=ENGLISH') FORMAT1 
, TO_CHAR(TO_DATE('20210101'),'MonthDD, YYYY','NLS_DATE_LANGUAGE=ENGLISH') FORMAT1_1 
, TO_CHAR(TO_DATE('20210101'),'Month','NLS_DATE_LANGUAGE=ENGLISH') FORMAT2 
, TO_CHAR(TO_DATE('20210101'),'MonthfmDD, YYYY','NLS_DATE_LANGUAGE=ENGLISH') FORMAT3
, TO_CHAR(TO_DATE('20210101'),'MonthDD, YYYY, Day','NLS_DATE_LANGUAGE=ENGLISH') FORMAT4 FROM DUAL;

to_char( ��¥ )		��¥�� ���ڷ� ��ȯ
select to_char( sysdate, 'yy/mm/dd hh24:mi:ss' ) from dual;
select to_char( sysdate, 'yy/mm/dd' ) from dual;
select to_char( sysdate, 'YYYY-MM-DD' ) from dual;
select to_char( sysdate, 'hh24:mi:ss' ) from dual;
select to_char( sysdate, 'DAY' ) from dual;

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
--
--AM �Ǵ� PM	���� ����
--HH �Ǵ� HH12	12�ð�
--HH24		24�ð�
--MI		��
--SS		��

--to_char( ���� )	���ڸ� ���ڷ� ��ȯ

--9		�� �ڸ��� ���� ǥ��		( 1111, ��99999�� )		1111	
--0		�� �κ��� 0���� ǥ��		( 1111, ��099999�� )		001111
--$		�޷� ��ȣ�� �տ� ǥ��		( 1111, ��$99999�� )		$1111
--.		�Ҽ����� ǥ��			( 1111, ��99999.99�� )		1111.00
--,		Ư�� ��ġ�� , ǥ��		( 1111, ��99,999�� )		1,111
--MI		�����ʿ� ? ��ȣ ǥ��		( 1111, ��99999MI�� )		1111-
--PR		�������� <>�� ǥ��		( -1111, ��99999PR�� )		<1111>
--EEEE		������ ǥ��			( 1111, ��9.999EEEE�� )		1.11E+03
--V		10�� n�� ���Ѱ����� ǥ��	( 1111, ��999V99�� )		111100
--B		������ 0���� ǥ��		( 1111, ��B9999.99�� )		1111.00
--L		������ȭ			( 1111, ��L9999�� )
'99999'�� ���� ������ ��Ÿ����, 'MI'�� ������ �ƴ� ��� �ڿ� ������, ������ ��쿡�� ���̳ʽ� ��ȣ�� �߰�
select salary, to_char( salary, '0999999' ) from employees;
select to_char( -salary, '999999PR' ) from employees;
select to_char( 11111, '9.99EEEE' ) from dual;	
select to_char( 1111, 'B9999.99' ) from dual;	
select to_char( 1111, 'L99999' ) from dual;
select to_char( 1111, '99999' ) from dual;
select to_char( 1111, '9.99EEEE' ) from dual;
SELECT TO_CHAR(-1111111, '9999999MI') FROM dual;

( 1111, ��99999MI�� )
--width_bucket()				������, �ּҰ�, �ִ밪, bucket����
select width_bucket( 92, 0, 100, 10 ) from dual;
select width_bucket( 100, 0, 100, 10 ) from dual;
select width_bucket( 21, 0, 21, 21 ) from dual;
select department_id, last_name, salary, width_bucket( salary, 0, 20000, 5 ) from employees where department_id=50;
select max(salary) from employees;
select min(salary) from employees;
select salary, width_bucket(salary,2100, 24000, 5) ��� from employees; 
--Q. employees ���̺��� salary�� 5�� ������� ǥ���ϼ���
select max(salary) max, min(salary) min from employees;
SELECT salary, WIDTH_BUCKET(salary, 2100, 24001, 5) AS grade
FROM employees;

--���� �Լ� Character Function 
--upper()			�빮�ڷ� ����
select upper( 'Hello World' ) from dual;

--lower()			�ҹ��ڷ� ����
select lower( 'Hello World' ) from dual;

select last_name, salary from employees where last_name='seo';
select last_name, salary from employees where lower( last_name )='seo';

--initcap()			ù���ڸ� �빮��
select initcap( job_id ) from employees;

--length()			���ڿ��� ����
select job_id, length( job_id ) from employees;

--instr()			���ڿ�, ã�� ����, ã�� ��ġ, ã�� ���� �� �� �� °
select instr( 'Hello World', 'o', 3, 2 ) from dual;

--substr()			���ڿ�, ������ġ, ����
select substr( 'Hello World', 3, 3 ) from dual;
select substr( 'Hello World', -3, 3 ) from dual;		�ڿ��� 3��° ���� 3����

--lpad()			������ ���� �� ���ʿ� ���ڸ� ä���.
select lpad( 'Hello World', 20, '#' ) from dual;

--rpad()			���� ���� �� ���ʿ� ���ڸ� ä���.
select rpad( 'Hello World', 20, '#' ) from dual;

--ltrim()
select ltrim( 'aaaHello Worldaaa', 'a' ) from dual;	Hello Worldaaa	���� Ư�� ���� ����
select ltrim( '   Hello World   ' ) from dual;		Hello World	���ڿ� �յ� ���� ����

--rtrim()
select rtrim( 'aaaHello Worldaaa', 'a' ) from dual;	aaaHello World	���� Ư�� ���� ����
select rtrim( '   Hello World   ' ) from dual;		Hello World	���ڿ� �յ� ���� ����

--trim()

select trim( '   Hello World   ' ) from dual;
select last_name, trim( 'A' from last_name ) from employees;		�յ��� Ư�� ���� ����

--��Ÿ �Լ�
nvl()		null�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
select salary, salary*12*nvl(commission_pct, 0 ) from employees;
select last_name, manager_id, 
nvl( to_char( manager_id ), 'CEO' ) from employees;

// deparment_id �� ���� ��� '����' ���

--decode() 	if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
--DECODE �Լ��� �ܼ��� ���ǿ� ����Ͽ� ���� ��ȯ�մϴ�. ������ DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--���⼭ expression�� �˻��� ���� ��Ÿ����, search�� result�� ���� ���ǰ� �ش� ������ ���� �� ��ȯ�� ��
--default�� ��� search ������ ������ �� ��ȯ�� �⺻ �� ���
select last_name, department_id, 
decode( department_id, 
    90, '�濵������', 
    60, '���α׷���', 
    100, '�λ��', '��Ÿ' ) �μ� from employees;

����: employees ���̺��� commission_pct�� null�� �ƴ� ���, 'A' �ƴ� ��� 'N'�� ǥ���ϴ� ������ �ۼ�
SELECT commission_pct, DECODE(commission_pct, NULL, 'N', 'A') AS commission_status
FROM employees;

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

SELECT employee_id, last_name, 
       CASE 
           WHEN salary > 10000 THEN 'High'
           WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_level
FROM employees;

����: employees ���̺��� salary�� 20000 �̻��̸� 'a', 10000�� 20000 ���̸� 'b', �� ���ϸ� 'c'�� ǥ���ϴ� ������ �ۼ��Ͻÿ�.
SELECT salary, 
       CASE 
           WHEN salary >= 20000 THEN 'a'
           WHEN salary BETWEEN 10000 AND 19999 THEN 'b'
           ELSE 'c'
       END AS salary_size
FROM employees;



--* INSERT
--
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);
--
--�ش� Į���� ������ ������ CHAR�� VARCHAR2 �� ���� ������ ��� ������ (SINGLE QUOTATION)�� �Է��� ���� �Է��Ѵ�. 
--������ ��� ��'��(SINGLE QUOTATION)�� ������ �ʾƵ� �ȴ�.
--[a ����]
--[����] INSERT INTO PLAYER (PLAYER_ID, PLAYER_NAME, TEAM_ID, POSITION, HEIGHT, WEIGHT, BACK_NO) 
--            VALUES (��2002007��, ����������, ��K07��, ��MF��, 178, 73, 7); 
--a ������ ���̺��� Į���� ������ �� �ִµ�, �̶� Į���� ������ ���̺��� Į�� ������ ��ġ�� �ʿ�� ������, �������� ���� Į���� 
--Default�� NULL  ���� �Էµȴ�.  ��, Primary Key�� Not NULL �� ������ Į���� NULL�� ������ �ʴ´�.
--
--[b ����]
--[����] INSERT INTO PLAYER VALUES ('2002010','��û��','K07','','BlueDragon','2002','MF','17��, NULL,NULL,'1',180,69);
--b ������ ��� Į���� �����͸� �Է��ϴ� ���� ���� COLUMN_LIST�� ������� �ʾƵ� ������, Į���� ������� �������� 
--�����Ͱ� �ԷµǾ�� �Ѵ�. �����͸� �Է��ϴ� ��� ���ǵ��� ���� ������ ���� E PLAYER NAME �� �ΰ��� ��''��SINGLE QUOTATION
--�� �ٿ��� ǥ���ϰų�, NATION�̳� BIRTH_DATE�� ���ó�� NULL�̶�� ��������� ǥ���� �� �ִ�.
--
--* UPDATE
--UPDATE ������ �����Ǿ�� �� Į���� �����ϴ� ���̺���� �Է��ϰ�, SET  ������ �����Ǿ�� �� Į����� �ش� Į�� ���� ������ ������ �̷������.
--UPDATE ���̺�� SET �����Ǿ�� �� Į���� = �����Ǳ⸦ ���ϴ� ���ο� ��;
--[����] UPDATE PLAYER SET POSITION = 'MF��;
--�Ϲ������δ�5������ ��� WHERE ���� ����Ͽ� UPDATE ��� ���� �����Ѵ�. WHERE ���� ������� �ʴ´ٸ� ���̺��� ��ü �����Ͱ� �����ȴ�.
--
--* DELETE
--DELETE FROM ������ ������ ���ϴ� �ڷᰡ ����Ǿ� �ִ� ���̺���� �Է��ϰ� �����Ѵ�. �̶� FROM ������ ������ ������ Ű�����̴�. 
--DELETE [FROM] ������ ���ϴ� ������ �ִ� ���̺��;
--[����] DELETE FROM PLAYER; 
--
--* SELECT
--��ȸ�ϱ⸦ ���ϴ� Į������ SELECT ������ �޸� ������(,)�� �����Ͽ� �����ϰ�, FROM ������ �ش� Į���� �����ϴ� ���̺���� �Է��Ͽ� �����Ų��.
--SELECT [ALL/DISTINCT] ������� Į����,. . . FROM �ش� Į������ �ִ� ���̺��;
---  ALL : �ߺ��� �����Ͱ� �־ ��� ����Ѵ�. Default �ɼ��̹Ƿ� ������ ǥ������ �ʾƵ� �ȴ�.
---  DISTINCT : �ߺ��� �����Ͱ� �ִ� ��� 1������ ó���ؼ� ����Ѵ�.
--[����] SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID, POSITION, HEIGHT, WEIGHT, BACK_NO FROM PLAYER;
--[����] SELECT ALL POSITION FROM PLAYER;
--[����] SELECT DISTINCT POSITION FROM PLAYER;
--
--�ش� ���̺��� ��� Į�� ������ ���� ���� ��쿡�� ���ϵ�ī��� �ֽ��͸���ũ(*)�� ����Ͽ� ��ȸ�� �� �ִ�.
--SELECT * FROM ���̺��;
--���� ��� ȭ���� ���� Į�� ���̺�(LABLE)�� �� ���� ��������, ���̺� �ؿ� ������ ��������. �������� �ڷ�� ���� �ٺ��� ���۵ȴ�.
--���̺��� �⺻������ �빮�ڷ� ��������, ù ���ο� �������� ���̺��� ������ ������ ����.
--- ���� ���� : ���� �� ��¥ ������
--- ���� ���� : ���� ������
--[����] SELECT * FROM PLAYER;
--
--SELECT - ALIAS
--��ȸ�� ����� ������ ����(ALIAS, ALIASES)�� �ο��ؼ� Į�� ���̺��� ������ �� �ִ�. 
--- Į���� �ٷ� �ڿ� �´�.
--- Į����� ALIAS ���̿� AS, as Ű���带 ����� ���� �ִ�. (option)
--[����] SELECT PLAYER NAME AS ������, POSITION AS ��ġ, HEIGHT AS Ű, WEIGHT AS ������ FROM PLAYER;
--Į�� ������ AS�� �� ������� �ʾƵ� �ǹǷ�, �Ʒ� SQL�� �� SQL�� ���� ����� ����Ѵ�.
--[����] SELECT PLAYER_NAME ������, POSITION ��ġ, HEIGHT Ű, WEIGHT ������ FROM PLAYER;
--
--SELECT - ALIAS
--ALIAS ���� ���� �ο��ȣ(Double Quotation)�� ALIAS�� ����, Ư�����ڸ� ������ ���� ��ҹ��� ������ �ʿ��� ��� ���ȴ�.
--SELECT PLAYER_NAME "���� �̸�", POSITION "�׶��� ������",
--[����] HEIGHT "Ű", WEIGHT "Weight�� FROM PLAYER;
--
--
--���̺� ����

CREATE TABLE MEMBER(
    ID                  VARCHAR2(50),
    PWD             NVARCHAR2(50),
    NAME          NVARCHAR2(50),
    GENDER      NCHAR(2),  
    AGE              NUMBER(3),
    BIRTHDAY  CHAR(10),    
    PHONE        CHAR(13),      
    REGDATE   DATE
);


CREATE TABLE NOTICE(
    ID                        NUMBER,
    TITLE                  NVARCHAR2(100),
    WRITER_ID       NVARCHAR2(50),    
    CONTENT         CLOB,
    REGDATE         TIMESTAMP,    
    HIT                     NUMBER,      
    FILES                  NVARCHAR2(1000)
);

CREATE TABLE "COMMENT"(
    ID                        NUMBER,
    CONTENT         NVARCHAR2(2000),
    REGDATE         TIMESTAMP,
    WRITER_ID       NVARCHAR2(50),         
    NOTICE_ID       NUMBER
);
-- ����� COMMENT�� ""�� ó���ϸ� ���� �ذ�
--select last_name, salary*12 as ���� ���� from employees;
--�����̳� $ _ # �� Ư�����ڸ� ���� ��� �� ����ǥ�� ���

CREATE TABLE ROLE(
    ID                        VARCHAR2(50),
    DISCRIPTION    NVARCHAR2(500)
);

CREATE TABLE MEMBER_ROLE(
   MEMBER_ID     NVARCHAR2(50),
   ROLE_ID            VARCHAR2(50)
);

-- Concatenation
    select last_name, 'is a ', job_id from employees;
    select last_name ||  ' is a'  || job_id from employees;
--    �޸� ��ſ� ����ϸ� ���ڿ��� ����Ǿ� ��µȴ�.

--  Distinct
    select job_id from employees;
    select distinct job_id from employees;
--    �ߺ��Ǵ� �÷��� �� ������ �����ش�.

--UPDATE/DELETE
SELECT * FROM MEMBER;
SELECT id "USER_ID", NAME, PWD FROM MEMBER;

UPDATE MEMBER SET PWD='222';
-- PWD�� ���� �ٲ�, ������ �߰��Ͽ� Ư�� �����͸� ������ �� ����
UPDATE MEMBER SET PWD='111' WHERE ID='DRAGON';
UPDATE MEMBER SET PWD='333', NAME='KING' WHERE ID='DRAGON'; 

INSERT INTO MEMBER(ID, PWD, NAME) VALUES('TES1','112','JAMES');
DELETE MEMBER WHERE ID='TEST';

UPDATE MEMBER SET PWD='111' WHERE NAME='KING';
--���ǿ��� UPDATE �� COMMIT���� ������ LOCK�� �ɷ� �ٸ����ǿ��� �ش� DATA�� ���� UDATE�� ������� ����
COMMIT;

update member set name = replace(����з�, null, '��ǰ') where �Һз��ڵ� like 'C06%';
update member set name = replace(name, 'JAMES', '��ǰ') where pwd =112;


--UNION
--UNION( ������ ) INTERSECT( ������ ) MINUS( ������ ) UNION ALL( ��ġ�� �ͱ��� ���� )
--�� ���� �������� ����ؾ� �Ѵ�. ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�.

select first_name �̸�, salary �޿� from employees 
where salary < 5000
union
select first_name �̸�, salary �޿� from employees 
where hire_date < '99/01/01';			92��

select first_name �̸�, salary �޿� from employees 
where salary < 5000
union all
select first_name �̸�, salary �޿� from employees 
where hire_date < '99/01/01';			127��

select first_name �̸�, salary �޿� from employees 
where salary < 5000
minus
select first_name �̸�, salary �޿� from employees 
where hire_date < '99/01/01';			14��

select first_name �̸�, salary �޿� from employees 
where salary < 5000
intersect
select first_name �̸�, salary �޿� from employees 
where hire_date < '99/01/01';			35��

-- JOIN ���

CREATE TABLE test1(
ID VARCHAR2(10),
NAME VARCHAR2(10),
ENG NUMBER
);

INSERT INTO test1 VALUES('111','KEVIN',90);
INSERT INTO test1 VALUES('112','JAMES',70);
INSERT INTO test1 VALUES('113','SUSAN',80);
INSERT INTO test1 VALUES('114','TOM',85);
INSERT INTO test1 VALUES('115','DRAGON',75);

CREATE TABLE test2(
ID VARCHAR2(10),
MATH NUMBER,
AGE NUMBER);
INSERT INTO test2 VALUES('111',80,90);
INSERT INTO test2 VALUES('112',80,90);
INSERT INTO test2 VALUES('113',80,90);
INSERT INTO test2 VALUES('116',80,90);
INSERT INTO test2 VALUES('117',80,90);

--inner join
SELECT t1.id, t1.name, t1.eng, t2.math, t2.age
FROM test1 t1
JOIN test2 t2 ON t1.id = t2.id;

--left outer join
SELECT t1.id, t1.name, t1.eng, t2.math, t2.age
FROM test1 t1
JOIN test2 t2 ON t1.id = t2.id(+);

--right outer join
SELECT t1.id, t1.name, t1.eng, t2.math, t2.age
FROM test1 t1
JOIN test2 t2 ON t1.id(+) = t2.id;

--full outer join
SELECT t1.id, t1.name, t1.eng, t2.math, t2.age
FROM test1 t1
FULL OUTER JOIN test2 t2 ON t1.id= t2.id;

SELECT ID  FROM test1
WHERE ENG > 80
UNION
SELECT ID FROM test2
WHERE MATH > 70;

SELECT ID  FROM test1
WHERE ENG > 80
UNION ALL
SELECT ID FROM test2
WHERE MATH > 70;

SELECT ID  FROM test1
WHERE ENG > 80
INTERSECT
SELECT ID FROM test2
WHERE MATH > 70;

SELECT ID  FROM test1
WHERE ENG > 80
MINUS
SELECT ID FROM test2
WHERE MATH > 70;

SELECT employee_id, department_name 
FROM employees E 
join departments D on E.department_id=D.department_id 
WHERE employee_id=110;

--Q.����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
--join~on, where �� �����ϴ� �� ���� ��� ���.
SELECT E.employee_id, E.last_name, E.job_id, J.job_title
FROM employees E, jobs J
WHERE E.job_id = J.job_id AND E.employee_id = 120;

SELECT employee_id, last_name, E.job_id, job_title
FROM employees E JOIN jobs J ON E.job_id=J.job_id 
WHERE employee_id=120;

SELECT E.employee_id ���ID
 , E.LAST_NAME
 , J.job_id ����
 , J.job_title ������
FROM employees E, jobs J
WHERE J.job_id IN (SELECT E.job_id FROM employees WHERE J.job_id=E.job_id AND E.employee_id = 120);
--WHERE employee_ID LIKE 120 AND E.job_id = J.job_id;

--������ ���̺� ����
SELECT employee_id, job_title, department_name 
FROM employees E, jobs J, departments D
WHERE E.job_id = J.job_id
AND E.department_id = D.department_id;

SELECT R.region_name ��� , C.country_id ����, L.street_address �ּ�
From COUNTRIES C , regions R , LOCations L
where C.country_id = L.country_id 
AND R.region_id = C.region_id;

SELECT E.last_name, L.city, L.street_address 
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.department_id = D.department_id AND L.location_id = D.location_id;

select * from employees;

SELECT employee_id, job_title, last_name, hire_date, salary, city, country_id
FROM employees E, jobs J, departments D, locations L
WHERE E.job_id = J.job_id 
AND E.department_id = D.department_id 
AND D.location_id = L.location_id 
AND job_title = 'President';

--self join �ϳ��� ���̺��� �� ���� ���̺��� ��ó�� ����
SELECT E.employee_id ���, E.last_name �̸�, M.last_name, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.manager_id;

--outer join : ���� ���ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ���� �� ���
SELECT E.employee_id ���, E.last_name �̸�, M.last_name ���, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.manager_id(+);


-----------------------------------------------------------------------------
	DDL
-----------------------------------------------------------------------------

�� DDL Data Definition Language
�� ���̺� ����
    create table ���̺��( �÷��� �ڷ��� );

    create table test1 (
	eno number( 4 ),
	ename varchar2( 20 ),
	esal number( 7, 2 )
    );

�� ���̺� ����
    create table test2 as select * from test1;
    �ٸ� ���̺��� ���� �Ӿƴ϶� �����ͱ��� �����ؼ� ���ο� ���̺� ����
    ���� ���̺��� �÷��� �����ؼ� ������ ���� �ִ�.

�� ���̺� ���� ����
    create table test3 as select * from test1 where 1=0;
    where �������� ���� ������ �����ϸ� �ش� �ο츦 �߰����� ���ϱ� ������ 
    �ο찡 ���� �� ���̺��� �����Ѵ�.
		
�� �÷� �߰��ϱ�
    alter table test1 add( email varchar2( 10 ) );
	
�� �÷� �����ϱ�	
    alter table test1 modify( email varchar2( 40 ) );
	
    �����Ͱ� ������ ��� ������ Ÿ���� ������ �� ����. 
    �� char�� varchar2 �� �����ϴ�.
    ũ��� ���� �����ͺ��� ���ų� ũ�� ���游 �����ϴ�.

�� �÷� �����ϱ�
    alter table test1 drop column email;
	
�� �÷� ��Ȱ��ȭ
    alter table test1 set unused( email );
    �÷��� ������ ��� ������� ���� �ֱ� ������ 
    �ϴ� �������� ������ �� ���󵵰� ���� �ð��� ���� ���� �۾��� �Ѵ�.
    delete�� ���� �ٽ� ����� �� ����.

    select * from user_unused_col_tabs;
    �÷� ���� Ȯ��	

    alter table test1 drop unused columns;
    unused column ��� ����

�� ���̺��� ��� �ο� ����
    truncate table test1;
	
�� ���̺� ����
    drop table test1;


--[���̺� ���� ��Ģ]

--���̺���� ��ü�� �ǹ��� �� �ִ� ������ �̸��� ����Ѵ�. ������ �ܼ����� �ǰ��Ѵ�.--
--���̺���� �ٸ� ���̺��� �̸��� �ߺ����� �ʾƾ� �Ѵ�.--
--�� ���̺� �������� Į������ �ߺ��ǰ� ������ �� ����. --
--���̺� �̸��� �����ϰ� �� Į������ ��ȣ "( )" �� ���� �����Ѵ�.--
--�� Į������ �޸�" ", �� ���еǰ�, �׻� ���� �����ݷ� ";"���� ������.--
--Į���� ���ؼ��� �ٸ� ���̺���� ����Ͽ� �����ͺ��̽� �������� �ϰ��� �ְ� ����ϴ� ���� ����. (������ ǥ��ȭ ����)--
--Į�� �ڿ� ������ ������ �� �����Ǿ�� �Ѵ�.--
--���̺��� Į������ �ݵ�� ���ڷ� �����ؾ� �ϰ�, �������� ���̿� ���� �Ѱ谡 �ִ�.--
--�������� ������ ������ �����(Reserved word)�� �� �� ����.--
--A-Z, a-z, 0-9, _, $, # ���ڸ� ���ȴ�.


SELECT * FROM TABS;
--MEMBER TABLE ����
DROP TABLE MEMBER;
CREATE TABLE MEMBER
(
    ID                  VARCHAR2(50),
    PWD             VARCHAR2(50),
    NAME          VARCHAR2(50),
    GENDER      VARCHAR2(50),
    AGE              NUMBER,
    BIRTHDAY  VARCHAR2(50),
    PHONE        VARCHAR2(50),
    REGDATE   DATE
);

--National Language ����Ʈ��
select length('ab') from dual;
select length('�ѱ�') from dual;

select lengthb('ab') from dual;
select lengthb('�ѱ�') from dual;

SELECT * FROM NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET	                        AL32UTF8
--NLS_NCHAR_CHARACTERSET     	AL16UTF16

-- ���̺� ����
DROP TABLE MEMBER;

--������ ���� ����
CREATE TABLE MEMBER(
    ID                  VARCHAR2(50),
    PWD             VARCHAR2(50),
    NAME          VARCHAR2(50),
--    GENDER      CHAR(2),    --����, ����, UTF
--    GENDER      CHAR(2 CHAR),   --2�� ���ڶ�� �ǹ�
    GENDER      NCHAR(2),  --2�� ����, UTF16�� ��� ���ڴ� 2bytes�� ó��, ���� ����
    AGE              NUMBER,
    BIRTHDAY  CHAR(10),     --2000-01-02
    PHONE        CHAR(13),      --010-1234-2345
    REGDATE   DATE
);

--Nchar , Nvarchar2		ũ���� ������ Byte�� �ƴ϶� ���ڼ��� ��Ÿ��

INSERT INTO MEMBER (GENDER) VALUES('����');
SELECT LENGTH (GENDER) FROM MEMBER;
SELECT LENGTHB (GENDER) FROM MEMBER;

DESC MEMBER;

-- ��뷮 ���� ����
LONG : �ִ� 2Gbyte, ���̺��� �ѹ��� ���, �� ������� ������ CLOB�� �ַ� ���
CLOB : ��뷮 �ؽ�Ʈ ������ Ÿ��(�ִ� 4Gbyte)
NCLOB : ��뷮 �ؽ�Ʈ �����ڵ� ������ Ÿ��(�ִ� 4Gbyte)

ALTER TABLE MEMBER ADD TEXT NCLOB;
INSERT INTO MEMBER (ID,PWD, TEXT) VALUES('200903','234','��ġ�� ������ ���� �����Ѵ�');
SELECT * FROM MEMBER;

--NUMBER [ (p [, s]) ] : NUMBER value�� 1 to 22 bytes, p�� 1 to 38, s�� -84 to 127
--    number (���� �� �Ǽ� ��� ����)
--    number(5) 		-> -99999 ~ 99999
--    number(3) 		-> -999 ~ 999
--    number(5,2) 	-> -999.99 ~ 999.99
--    number(6,3) 	-> -999.999 ~ 999.999

SELECT * FROM TABS;
DESC MEMBER;
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    ID                  VARCHAR2(50),
    PWD             NVARCHAR2(50),
    NAME          NVARCHAR2(50),
    GENDER      NCHAR(2),  
    AGE              NUMBER(3),
    BIRTHDAY  CHAR(10),    
    PHONE        CHAR(13),      
    REGDATE   DATE
);

--DATE(��¥)                         4712 BC~9999 AD (EX:01-JAN-99)
--TIMESTAMP(�ú���)        NLS_TIMESTAMP_FORMAT �Ķ���Ϳ� ��õ� ���� ����  

--CREATE
--���̺� ����
CREATE TABLE MEMBER
(
   ID                          VARCHAR2(50) NOT NULL,
   PWD                     VARCHAR2(50),
   NAME                  VARCHAR2(50),
   GENDER              NCHAR(2),  --���ڼ�
   AGE                      NUMBER,
   BIRTHDAY          CHAR(10),  --2000-01-02 
   PHONE                CHAR(13), --010-1234-2345
   REGDATE           DATE
);
INSERT INTO MEMBER (ID, PWD, NAME) VALUES('200901','111','kevin');

--SELECT ������ ���� ���̺� ����
CREATE TABLE MEMBER1 AS SELECT * FROM MEMBER;
SELECT * FROM MEMBER1;
DESC MEMBER1;
SELECT * FROM TABS;
--������ ����
INSERT INTO MEMBER1 (ID, PWD, NAME, GENDER) 
VALUES('200902','123','dragon','����');
SELECT LENGTHB (GENDER) FROM MEMBER;
SELECT * FROM MEMBER1;

--ALTER
--���� : MODIFY
--Nchar , Nvarchar2	ũ���� ������ Byte�� �ƴ϶� ���ڼ��� ��Ÿ��
ALTER TABLE MEMBER1 MODIFY( ID NVARCHAR2(50), NAME NVARCHAR2(50));
ALTER TABLE MEMBER1 MODIFY(PWD CONSTRAINT MEMBER1_NN NOT NULL);

--����: RENAME
ALTER TABLE MEMBER1 RENAME COLUMN BIRTHDAY TO BD;
--����: DROP
ALTER TABLE MEMBER1 DROP COLUMN AGE;
--�߰�: ADD
ALTER TABLE MEMBER1 ADD TEXT NCLOB;
INSERT INTO MEMBER1 (ID,PWD, TEXT) 
VALUES('200903','234','��ġ�� ������ ���� �����Ѵ�');
SELECT * FROM MEMBER1;
-- �������� �߰�: ADD CONTRAINT
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER_PK PRIMARY KEY (ID);
DESC MEMBER1;
--�������� Ȯ��: USER_CONSTRAINTS
--CONTRAINT_TYPE�� C�̸� NOT_NULL �Ǵ� CHECK���� �ǹ�
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;
--�������� ����: DROP CONTRAINT
ALTER TABLE MEMBER1 DROP CONSTRAINT MEMBER_PK;
--���̺� ����ִ� ��� �� ����
TRUNCATE TABLE MEMBER1;
SELECT * FROM MEMBER1;

-----------------------------------------------------------------------------
	Ʈ�����
-----------------------------------------------------------------------------

--Ʈ����� ����	
--Ʈ����� ������ ó���� �� ������ �ǹ��Ѵ�.
--�ϳ��� Ʈ������� All-Or-Nothing ������� ó���ȴ�.
--���� ���� ����� ��� ���������� ó���Ǹ� ���� ���� �ϰ�
--�ϳ��� ������������ ó���Ǹ� ��θ� ����Ѵ�.
--
--    commit		������� ���� ��� �����ͺ��̽��� �����ϰ� ������ Ʈ������� �����Ѵ�.
--			Ʈ����� ó�������� ��� �ݿ��Ǹ� �ϳ��� Ʈ����� ������ ������.
--    savepoint �̸�;	��������� Ʈ������� Ư�� �̸����� �����ϴ� ���
--    rollback [to �̸�]	������� ���� �����͸� ��� ����ϰ� Ʈ������� �����Ѵ�.
--			savepoint �� ������ ��ġ�� ���ư���.
--	
--    create alter drop ���� �ڵ� Ŀ���� �߻��Ѵ�.
  
SELECT * FROM member;

INSERT INTO MEMBER (ID, PWD, NAME) VALUES('200901','111','kevin');
SAVEPOINT SV1;
INSERT INTO member (ID, PWD, NAME, AGE) VALUES('200902','112','james',25);
UPDATE MEMBER SET PWD='121' WHERE NAME='kevin';
UPDATE MEMBER SET PWD='122', AGE='25' WHERE ID='200902'; 
SAVEPOINT SV2;
--ROLLBACK TO SV1;
INSERT INTO member (ID, PWD, NAME, AGE) VALUES('200902','112','james',35);
UPDATE member SET ID='200903', NAME='susan' WHERE AGE=35;
ROLLBACK TO SV1;
ROLLBACK TO SV2;
DELETE member WHERE ID='200901';
DELETE member WHERE ID='200902';
DELETE member WHERE ID='200903';
COMMIT;
-----------------------------------------------------------------------------
	���� ���� Constraints
-----------------------------------------------------------------------------

���Ἲ ���� ����
���̺� �������� �ڷᰡ �ԷµǴ� ���� �����ϱ� ���� ���̺��� ������ �� �÷��� �����ϴ� ��Ģ

not null	�ش� �÷� ������ NULL�� ������� �ʴ´�.
unique	�ش� �÷� ���� �׻� ���Ϲ����� ���� ������.
primary key	�ش� �÷� ���� �ݵ�� �����ؾ� �ϰ� �����ؾ� �Ѵ�.
    not null�� unique�� ������ ����
foreign key	�ش� �÷� ���� Ÿ �÷��� ���� �����ؾ� �Ѵ�.
    �����Ǵ� �÷��� ���� ���� �Է� �Ұ�
check	�ش� �÷��� ���� ������ ������ ���� ������ ����� ������ ����

���� ���� Ȯ���ϱ�
select * from user_constraints;

P 		primary key
R 		foreign key
C 		check, not null

�������� �̸��� ���̺��_�÷���_���� ���� ���� ������ ���Ѵ�.
pk		primary key
fk		    foreign key
nn		not null
uk    	unique
ck		check

�������� �̸� ����
alter table table_name RENAME CONSTRAINTS 
old_constraint_name TO new_constraint_name;

���� ���� �����ϱ�	
alter table test drop constraint test1_name_pk;

create table test1 (
id number( 3 ) primary key, 
name varchar2( 10 ) not null,
tel varchar2( 10 ),
address varchar2( 50 )
);

SELECT * FROM test1;
DESC test1;
ALTER TABLE test1 MODIFY name constraint SYS_C0010273 null;
ALTER TABLE test1 DROP  constraint SYS_C0010274;

--not null ���� ����
--name varchar2(10) constraint test1_name_nn not null,
    
create table test2 (
id number( 3 ) constraint test2_id_pk primary key,
name varchar2(10) constraint test2_name_nn not null,
tel varchar2( 10 ),
address varchar2( 50 )
);
	
DESC test2
ALTER TABLE test2 DROP  constraint test2_name_nn;
ALTER TABLE test2 DROP  constraint test2_id_pk;
    
���� ���̺��� �÷��� not null �� ������ ���� 
alter table ~ add constraint ~�� ����� �� ����.
not null ������ �߰��ϴ� ���� �ƴ϶� null �� ���¸� not null �� �ٲٴ� ���̴�.

alter table test1 modify name constraint test1_name_nn not null;
     

--�⺻Ű ���� ����
--�⺻ Ű �÷����� NULL ���� �� �� ������ �ߺ� �� �� ����.   

id varchar2(10) constraint test1_id_pk primary key,	

alter table test1 add constraint test1_id_pk primary key(id);
alter table test1 drop constraint test1_id_pk;

--����Ű ��������
--UNIQUE ���� ������ �����ϸ� �ߺ� ���� ������� �ʴ´�. 
--�ϳ��� ���̺� ���� ���� ������ �� �ִ�.
--�� NULL�� ���� �ƴϱ� ������ ���� ���� �����ϴ�.

name varchar2(10) constraint test2_name_uk unique,

alter table test1 add constraint test1_email_uk unique(email);
alter table test1 drop constraint test1_email_uk;

--check ���� ����
--�����͸� �˻��Ͽ� Ư�� ���ǿ� �´� �����͸� �Է��ϵ��� ���� �Ѵ�.

age number constraint test1_age_ck check( age between 0 and 150 ),

alter table test1 add constraint test1_sal_ck check( sal between 0 and 20000 );
alter table test1 drop constraint test1_sal_ck;

�������Ἲ
create table depart (
deno number primary key,
dename varchar2( 30 ) unique
);

�μ� ���̺� �μ���ȣ�� 10 20 30 40�� �����Ѵٸ�
��� ���̺� �����ϴ� �μ���ȣ�� �ݵ�� �μ� ���̺��� �μ� ��ȣ ���� ��ȣ�� ������ �Ѵ�.
�̷� ��� ��� ���̺��� �μ� ���̺��� �����ϴ� ���Ӱ��谡 �����ȴ�.
��� ���̺��� �ڽ� ���̺��� �ǰ� �μ� ���̺��� �θ� ���̺��� �ȴ�.

��� ���̺��� �μ���ȣ �÷��� �ܷ�Ű�� �ϰ� �μ� ���̺��� �μ���ȣ �÷��� �θ�Ű�� �ȴ�.
�μ���ȣ �÷��� �θ�Ű�� �Ƿ��� UNIQUE ���� �������� �����Ǿ�� �Ѵ�.

���� �ԷµǴ� ��������� �μ���ȣ�� �θ�Ű�� �������� �ʴ� ��ȣ��� 
���Ἲ ���� ���ǿ� ����ȴٴ� ������ �߻��Ѵ�.

create table test2(
...
deno varchar2(10) references depart( deno ),
...
);
test1 ���̺��� deno �÷��� �����ϴ� �ܷ�Ű�� �����Ѵ�.
���� ���Ǹ��� ������ ���� ��� ����Ŭ ���� �������Ǹ��� ���δ�.

deno varchar2(10) constraint test2_deno_fk references depart( deno ),
���� ���Ǹ��� ���� �ٿ��ش�.

alter table test2 add constraint test2_deno_fk foreign key(deno) references depart( deno );

cascade
���� ���Ἲ �������� ſ�� �⺻Ű�� ���� ���̺��� �������� �ʴ� ���� 
�� �ڿ� cascade �ɼ��� �����Ѵ�.

drop table depart cascade constraint;

select * from user_constraints where table_name = 'DBTEST';
�θ�Ű�� ���� ���̺��� �����Ǹ� �������ǵ� �����ȴ�.
    

-----------------------------------------------------------------------------
	Merge
-----------------------------------------------------------------------------

INSERT or UPDATE ������ �� ���� �ȿ� �ִ� MERGE ����
���̺��� ��ȸ�ؼ� ���� �����Ͱ� ���� ��쿡�� INSERT
���� �����Ͱ� ���� ��쿡�� UPDATE

MERGE INTO ���̺��  ��Ī
USING ������̺�/��  
ON ��������
WHEN MATCHED THEN
UPDATE SET
        �÷�1=��1
            �÷�2=��2
WHEN NOT MATCHED THEN
INSERT (�÷�1,�÷�2,...) VALUES (��1,��2,...);    

merge into employees
using dual
on ( salary < 10000 )
when matched then 
update set commission_pct = commission_pct + 0.1;

80�� �μ� ������ �����ϴ� commission ���̺��� ������Ʈ �ϴ� ���
employees ���̺��� ��� �����͸� ������� ���� �� �����Ѵ�.
������ 8000 ������ ���� 10000���� �����Ѵ�.
�̻��� ���� �״�� �Է��Ѵ�.

create table commission as select employee_id, salary from employees where department_id=80;

merge into commission c
using ( select * from employees ) e
on ( e.employee_id = c.employee_id )
when matched then
update set c.salary = 9999 where e.salary < 8000
when not matched then
insert ( c.employee_id, c.salary ) 
values ( e.employee_id, e.salary ) 

commission ���̺� �����ϴ� 80�� �μ� �� 
8000 �̸��� 10000���� ����ǰ�
8000 �̻��� ������� �ʴ´�.
employee ���̺��� �����ϴ� �ٸ� �������� 
commission ���̺�� �Էµȴ�. 

select * from departments;
select * from employees;

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

--����: orders ���̺��� orderdate�� '2020-07-05' ������ �ֹ����� �����ϴ� �� recent_orders�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
SELECT * FROM orders;
CREATE VIEW recent_orders AS
SELECT *
FROM orders
WHERE orderdate > '2020-07-05';
SELECT * FROM recent_orders;

create view special_employee as
select * 
from employees
where salary >= 10000;
select * from special_employee;

CREATE VIEW long_term_employees AS
SELECT *
FROM employees
WHERE SYSDATE - hire_date >= 3650;

select * from long_term_employees;

CREATE VIEW department_employee_count AS
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
select * from department_employee_count;


--* GRANT : �����ͺ��̽� ����ڿ��� ��� ������ �ο��ϴ� ��ɾ� �̴�.
--�ɼ� GRANT & REVOKE ����
--CONNECT : �����ͺ��̽��� ������ �� �ִ� �⺻���� ���� �Ѵ�.
--RESOURCE : �⺻���� ��ü(���̺�, �ε���, ��, Ŭ����Ʈ ��) ����, ����, �����Ҽ� �ִ� ���� ���� �Ѵ�.
--
--����ڿ��� ���̺��� SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ������ �ο�
--GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON (���̺��) TO �����;
--����ڿ���?���̺��� �������� �ο�
--GRANT ALL PRIVILEGES ON (table ��)  TO ����ڸ�;
--
--* REVOKE?: ����ڿ� ���� ������ ȸ���Ѵ�.
--REVOKE �����̸�?ON �����ڸ�.���̺�� ?FROM �����;
--EX) ?REVOKE CONNECT, RESOURCE FROM USER01
--
--* CREATE USER : ����� ����(������ ����ڴ� �ƹ��� ������ ����.)
--CREATE USER �����ID
--IDENTIFIED BY ��й�ȣ

select * from user_sys_privs where username='C##KITA';

CREATE USER C##USER1
IDENTIFIED BY USERPASS;

-- USER1 ����

DROP USER C##USER1;
CREATE USER C##USER1 IDENTIFIED BY pw123;

-- USER1���� �⺻���� ���� ���Ѱ� ��ü ���� ���� �ο�
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO C##USER1;

-- USER1�κ��� CREATE VIEW ���� ȸ��
REVOKE CREATE VIEW FROM C##USER1;

-- USER1 ����
DROP USER C##USER1 CASCADE;

--* GRANT : �ý��� ����
--GRANT �����̸�|��|PUBLIC
--[WITH ADMIN OPTION]WITH GRANT OPTION]

--���� ���� Ȯ��
SELECT * FROM system privilege_map;
select * from user_sys_privs where username='C##KITA';
--USER01����ڿ��� �����ͺ��̽��� ������ �� �ִ� ���Ѱ� ���̺��� ������ �� �ִ� ������ �ο�
GRANT CREATE SESSION,CREATE TABLE TO C##USER01;

SELECT * FROM all_users;

REVOKE CREATE SESSION,CREATE TABLE FROM C##USER01;

DROP USER C##USER01;

--* Ʈ�����

--Ʈ������� �����ͺ��̽��� ���� ��������̴�. 
--Ʈ�����(TRANSACTION)�̶� ������ ���õǾ� �и��� �� ���� �� �� �̻� �� �����ͺ��̽� ������ ����Ų��. 
--�ϳ��� Ʈ����ǿ��� �ϳ� �̻��� SQL ������ ���Եȴ�.
--Ʈ������� �ǹ������� ������ �� ���� �ּ��� �����̴�.  �׷��� ������ ���� �����ϰų� ���� ����Ѵ�. 
--��, TRANSACTION �� ALL OR NOTHING ALL OR NOTHING�� ������ ���̴�.
--[���] ������ü��� �۾������� �ΰ��� ������ ��� ���������� �Ϸ�Ǿ��� �� ����ȴ�. 
-- �� �� �ϳ��� ������ ��� ������ü�� ������ �ݾ��� �����ϰ� �־�߸� �Ѵ�.
--- STEP1. 100�� ������ �ܾ׿��� 10,000���� ����. 
--STEP2. 200�� ������ �ܾ׿� 10,000���� ���Ѵ�

--TCL (Transaction Control Language)
--COMMIT: ���� Ʈ����� ������ ����� ��� ����(INSERT, UPDATE, DELETE ��)�� �����ͺ��̽��� ���������� ����.
--COMMIT ����� �����ϸ�, Ʈ������� �Ϸ�Ǹ�, �� ���Ŀ��� ���� ������ �ǵ��� �� ����.
--ROLLBACK: ���� Ʈ����� ������ ����� ������� ����ϰ�, �����ͺ��̽��� Ʈ������� �����ϱ� ���� ���·� �ǵ�����. 
--������ �߻��߰ų� �ٸ� ������ Ʈ������� ����ؾ� �� ��쿡 ���ȴ�.
--SAVEPOINT: Ʈ����� ������ �߰� üũ����Ʈ�� �����մϴ�. ������ �߻��� ���, ROLLBACK�� ����Ͽ� �ֱ��� SAVEPOINT���� �ǵ��� �� �ִ�.
--Ʈ������� ��Ʈ���ϴ� TCL(TRANSACTION CONTROL LANGUAGE)

--�������� ���� : ������ü
 
User
members��� ���̺��� �����ϰ� ������ �Ӽ� 5���� �����Ͽ� �����͸� �Է��ϰ� ���� 3���� �����͸� ��������.
������ �����͸� ����ϱ� ���Ͽ� �ѹ��� �������.
2���� �����͸� �߰��� �Է��ϴµ� Ŀ���ϱ����� ������ �Է��� �����ʹ� ����ϰ� Ŀ������.
���� ������ �ڵ�� �ۼ�����

-- members ���̺� ����
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    join_date DATE,
    status VARCHAR2(20)
);

-- ������ �Է�
INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');
select * from members;
commit;
-- ������ ����
UPDATE members SET status = 'Inactive' WHERE member_id = 1;
UPDATE members SET status = 'Inactive' WHERE member_id = 2;
UPDATE members SET status = 'Active' WHERE member_id = 3;

-- �ѹ��� ����Ͽ� ���� ���
ROLLBACK;

-- 2���� ������ �߰�
INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');


-- �� �������� SAVEPOINT ����
SAVEPOINT sp1;

-- �� ��° ������ �߰�
INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

-- ������ �Է¸� �ѹ� (SAVEPOINT sp1�� �ǵ��ư�)
ROLLBACK TO sp1;

-- ù ��° �߰� �����Ϳ� ���� ��������� Ŀ��
COMMIT;

����:

orders��� ���̺��� �����ϰ�, order_id, customer_id, order_date, amount, status��� �Ӽ��� �����ϼ���.
�����͸� 5�� �Է��ϼ���.
�Է��� ������ �� 2���� �����ϼ���.
������ �����͸� ����ϱ� ���� �ѹ��� ����ϼ���.
3���� ���ο� �����͸� �Է��ϰ�, �� �� ������ ������ �Է¸� ����� �� �������� Ŀ���ϼ���.





-Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A.
SELECT FIRST_NAME, SALARY, SALARY*1.1 UPSALARY FROM EMPLOYEES;
    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '05/01/01' AND '05/06/30';  

--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
SELECT * FROM EMPLOYEES WHERE JOB_ID IN('SA_MAN','IT_PROG','ST_MAN');
   
--Q4. manager_id �� 101���� 103�� ����� ���
--A.   	
select * from employees where manager_id between 101 and 103;

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
select last_name, hire_date, next_day( add_months( hire_date, 6 ), '��' ) "TARGET" from employees;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A.
select employee_id, last_name, salary, hire_date, 
trunc((months_between(sysdate, hire_date))) 
w_month from employees order by w_month desc;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
select employee_id, last_name, salary, hire_date,  
trunc( ( sysdate - hire_date ) / 365 ) w_year 
from employees order by w_year desc; 

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
select employee_id, last_name from employees where mod( employee_id, 2 )= 1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
select employee_id, last_name, round( salary/12, 2 ) m_salary from employees;  

--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������  �ټӳ���� ���� 30 ������� ������  ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.
select employee_id, last_name, salary, hire_date,
trunc( ( ( to_date('20/12/31') - hire_date ) / 365)) �ټӿ���,
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30)) wb,
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30))  * 1000 bonus
from employees
order by bonus desc;  

--20�� ���ʽ� ��� �����
select employee_id, last_name, salary, hire_date, trunc( ( sysdate - hire_date ) / 365) �ټӿ���,
trunc(( sysdate - hire_date ) / 365) ���,(width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20)) wb,
(width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20))  * 1000 bonus_wb,
trunc(( sysdate - hire_date ) / 365) * 1000 bonus_���
from employees order by bonus_wb desc;



--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
SELECT count(*) FROM employees
WHERE commission_pct is null;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A.
select last_name, department_id, nvl(to_char(department_id),'����') position
from employees where department_id is null;


--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A.
select e.employee_id, e.last_name, j.job_id, j.job_title from employees e
join jobs j on e.job_id=j.job_id where employee_id=120;

select  e.employee_id, e.last_name, j.job_id, j. job_title from employees e, jobs j
where e.job_id=j.job_id and employee_id = 120;

--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
SELECT FIRST_NAME || ' ' || LAST_NAME NAME FROM EMPLOYEES;

--Q15. lmembers purprod ���̺�� ���� �ѱ��ž�, 2014 ���ž�, 2015 ���ž��� �ѹ��� ����ϼ���.
select (select sum(p1.���űݾ�) from purprod p1)  as amt,
(select sum(p2.���űݾ�) from purprod p2 where p2.�������� <20150101) as amt_2014,
(select sum(p3.���űݾ�) from purprod p3 where p3.�������� >20141231) as amt_2015
from dual;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A.
-- _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����ϰ� ���� �� escape �ɼ��� ����Ѵ�. \������ ��('_')�� Ư�����ڷ� ���͸�
select * from employees where job_id like '%\_A%' escape '\';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
select SALARY, LAST_NAME from employees order by salary asc, last_name asc;

   
--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.
select department_name from departments 
where department_id=(select department_id from employees where last_name='Seo');     

--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUSTDEMO ���̺�� 
--����ȣ�� �������� �����Ͽ� ����ϼ���.
CREATE TABLE CUSPUR
AS SELECT ����ȣ, SUM(���űݾ�) ���űݾ�
FROM PURPROD
GROUP BY ����ȣ
ORDER BY ����ȣ;
SELECT * FROM CUSPUR;


--CUST�� CUSPUR ����ȣ ���� ����
SELECT C.*, CP.���űݾ�
FROM CUSTDEMO C, CUSPUR CP
WHERE C.����ȣ = CP.����ȣ;

--Q20.PURPROD ���̺�� ���� �Ʒ� ������ �����ϼ���.
-- 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ���� (��³��� : ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ�)
--AMT14�� AMT15 2�� ���̺��� ����ȣ�� ���޻縦 �������� FULL OUTER JOIN �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ���(��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)

SELECT * FROM PURPROD
WHERE YEAR <2015;
DESC PURPROD;

CREATE TABLE AMT14
AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ� 
FROM PURPROD
WHERE �������� < 20150101
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

select * from amt14;

CREATE TABLE AMT15
AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ� 
FROM PURPROD
WHERE �������� > 20141231
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

select * from amt15;

--FULL OUTER JOIN ���̺� ����
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.����ȣ, A4.���޻�, A4.���űݾ� ����14, A5.���űݾ� ����15
FROM AMT14 A4 FULL OUTER JOIN AMT15 A5
ON (A4.����ȣ=A5.����ȣ AND A4.���޻�=A5.���޻�);

--FULL OUTER JOIN ����� ���� ���
SELECT ����ȣ,���޻�, NVL(����14,0) ����14, NVL(����15,0) ����15,
(NVL(����15,0)-NVL(����14,0)) ����
FROM AMT_YEAR_FOJ A;

DROP TABLE amt14;
DROP TABLE amt15;
DROP TABLE AMT_YEAR_FOJ;

--Q(BONUS). HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.
�μ��� ��� SALARY ����
SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;



