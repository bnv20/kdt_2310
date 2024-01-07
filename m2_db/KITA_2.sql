--madang user 생성
--4개의 테이블 생성 : 

SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM imported_book;
SELECT * FROM orders;

SELECT bookname, price FROM book;
SELECT publisher FROM book;
--중복 없이 출력
SELECT DISTINCT publisher FROM book;

--Q. 가격이 10,000원 이상인 도서를 검색하시오.
SELECT * 
FROM book
WHERE price > 10000;

--과제1_1114: 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.(2가지 방법)
SELECT * 
FROM book
WHERE price >= 10000 AND price <= 20000;

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

--과제2_1114: 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.(3가지 방법)
SELECT *
FROM book
WHERE (publisher='굿스포츠') OR (publisher='대한미디어');

SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

SELECT *
FROM book
WHERE  publisher = '굿스포츠'
UNION
SELECT *
FROM book
WHERE  publisher = '대한미디어';

--출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 가 아닌 도서를 검색
SELECT	*
FROM	Book
WHERE	publisher NOT IN ('굿스포츠', '대한미디어');

SELECT bookname, publisher
FROM book
WHERE bookname LIKE '축구의 역사';

-- 과제3_1114: 도서이름에 ‘축구’ 가 포함된 출판사를 검색하시오.
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '%축구%';

-- 과제4_1114: 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '_구%';

-- 과제5_1114: 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT *
FROM book
WHERE bookname LIKE '%축구%' and price >= 20000;

SELECT *
FROM book
ORDER BY bookname;

SELECT *
FROM book
ORDER BY bookname DESC;

-- 과제6_1114: 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
SELECT	*
FROM	Book
ORDER BY	price, bookname;

SELECT * FROM orders;
SELECT * FROM customer;

-- 과제7_1114: 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
select customer.name, orders.custid, sum(orders.saleprice)
from orders
inner join customer on orders.custid = customer.custid
where orders.custid = 2
group by customer.name, orders.custid;

SELECT SUM(saleprice) AS "총 판매액"
FROM orders
WHERE custid = 2;

--GROUP BY 절은 SQL에서 매우 중요한 개념으로, 데이터를 특정 기준에 따라 그룹화하는 데 사용
--이를 통해 집계 함수(예: SUM, AVG, MAX, MIN, COUNT 등)를 사용하여 각 그룹에 대한 집계 데이터를 계산
SELECT SUM(saleprice) AS total,
       AVG(saleprice) AS average,
       MIN(saleprice) AS minimum,
       MAX(saleprice) AS maximum
FROM orders;

SELECT * FROM orders;

SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;

--HAVING 절은 SQL에서 GROUP BY 절과 함께 사용되어 그룹화된 결과에 조건을 적용하는 데 사용
--WHERE 절로는 처리할 수 없는 경우에 사용
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE bookid > 5
GROUP BY custid
HAVING COUNT(*) > 2;

-- 과제8_1114: 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.(GRPUP BY, COUNT)

SELECT custid, COUNT(*) AS 도서수량
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

--과제1_1115. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오
SELECT *
FROM customer , orders
WHERE customer.custid = orders.custid 
ORDER BY customer.custid;

--과제2_1115. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--과제3_1115. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, SUM(saleprice) "총 판매액"
FROM orders
GROUP BY custid
ORDER BY custid;

SELECT name, SUM (saleprice) AS "총 판매액"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

--과제4_1115. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.

SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid=O.custid AND O.bookid = B.bookid;

SELECT customer.name, book.bookname
FROM orders
INNER JOIN customer ON orders.custid = customer.custid
INNER JOIN book ON orders.bookid = book.bookid;

--과제5_1115. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid=B.bookid AND B.price = 20000; 

SELECT 
(SELECT NAME FROM customer where custid = x.custid) "고객명",
(SELECT BOOKNAME FROM book where bookid = x.bookid) "책이름",
(SELECT PRICE FROM book where bookid = x.bookid) "책판매가",
x.saleprice "구입가격",
x.orderdate "구입날짜"
FROM orders x
WHERE bookid IN (SELECT BOOKID FROM BOOK WHERE price = 20000)
ORDER BY custid;

--JOIN은 두 개 이상의 테이블을 연결하여 관련된 데이터를 결합할 때 사용
--내부 조인 (Inner Join)
SELECT customer.name,orders.saleprice
FROM customer 
INNER JOIN orders ON customer.custid=orders.custid;

--왼쪽 외부 조인 (Left Outer Join) : . 두 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name,orders.saleprice
FROM customer 
LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--오른쪽 외부 조인 (Right Outer Join) : 첫 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name,orders.saleprice
FROM customer 
RIGHT OUTER JOIN orders ON customer.custid=orders.custid;

--FULL OUTER JOIN : 일치하는 데이터가 없는 경우 해당 테이블에서는 NULL 값이 사용
SELECT customer.name,orders.saleprice
FROM customer 
FULL OUTER JOIN orders ON customer.custid=orders.custid;

--CROSS JOIN : 두 테이블 간의 모든 가능한 조합을 생성
SELECT customer.name,orders.saleprice
FROM customer 
CROSS JOIN orders;

--과제6_1115. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.(2가지 방법, WHERE, JOIN)

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

SELECT customer.name,orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--부속 질의
SELECT * FROM book;
SELECT * FROM orders;
--Q. 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

과제7_1115. ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher = '대한미디어'));

과제8_1115. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2 
WHERE b2.publisher = b1.publisher);

과제9_1115. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

과제10_1115. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT name AS 고객의이름, address AS 고객의주소
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--데이터 타입
--숫자형 (Numeric Types)
--NUMBER: 가장 범용적인 숫자 데이터 타입. 정수, 실수, 고정 소수점, 부동 소수점 수를 저장
--문자형 (Character Types)
--VARCHAR2(size): 가변 길이 문자열을 저장. size는 최대 문자 길이를 바이트로 지정
--NVARCHAR2(size)의 사이즈를 지정할 때는 바이트 단위 대신 항상 문자 단위로 크기가 지정
--CHAR(size): 고정 길이 문자열을 저장. 지정된 길이보다 짧은 문자열이 입력되면 나머지는 공백으로 채워짐
--날짜 및 시간형 (Date and Time Types)
--DATE: 날짜와 시간을 저장. 데이터 타입은 년, 월, 일, 시, 분, 초를 포함
--TIMESTAMP: 날짜와 시간을 더 상세히 나노초 단위까지 저장
--이진 데이터형 (Binary Data Types)
--BLOB: 대량의 이진 데이터를 저장. 이미지, 오디오 파일 등을 저장하는 데 적합
--대규모 객체형 (Large Object Types)
--CLOB: 대량의 문자 데이터를 저장
--NCLOB: 대량의 국가별 문자 집합 데이터를 저장

--제약조건 : 
--PRIMARY KEY : 각 행을 고유하게 식별하는 열(또는 열들의 조합). 중복되거나 NULL 값을 허용하지 않는다.
--FOREIGN KEY : 다른 테이블의 기본 키를 참조하는 열. 참조 무결성을 유지
--UNIQUE : 열에 중복된 값이 없어야 함을 지정. NULL값이 허용
--NOT NULL : 열에 NULL 값을 허용하지 않는다.
--CHECK : 열 값이 특정 조건을 만족해야 함을 지정 (예: age > 18)
--DEFAULT : 열에 명시적인 값이 제공되지 않을 경우 사용될 기본값을 지정

--AUTHOR 테이블 생성
CREATE TABLE authors (
  id NUMBER PRIMARY KEY,
  first_name VARCHAR2(50) NOT NULL,
  last_name VARCHAR2(50) NOT NULL,
  nationality VARCHAR2(50)
);
DROP TABLE authors;

--Q. NEWBOOK이라는 테이블을 생성하세요.
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
--테이블 제약조건 수정, 추가, 속성 추가, 삭제, 수정
ALTER TABLE newbook MODIFY (isbn VARCHAR2(10));
ALTER TABLE newbook ADD author_id NUMBER;
ALTER TABLE newbook DROP COLUMN author_id;

--ON DELETE CASCADE 옵션이 설정되어 있어, newcustomer 테이블에서 어떤 고객의 레코드가 삭제되면, 해당 고객의 모든 주문이 
--neworders 테이블에서도 자동으로 삭제
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

--과제11_1115. 10개의 속성으로 구성되는 테이블 2개를 작성하세요. 단 FOREIGN KEY를 적용하여 한쪽 테이블의 데이터를 삭제 시 다른 테이블의
--관련되는 데이터도 모두 삭제되도록 하세요. (모든 제약조건을 사용)

SELECT * FROM customer; 

--Q.Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.

--데이터 수정
UPDATE customer
SET address= '대한민국 부산'
WHERE custid = 5;

--과제12_1115. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.

--데이터 삽입
INSERT INTO customer VALUES(11,'김연경','수원','000-1111-0001');

--데이터 삭제
DELETE customer
WHERE custid = 11;

--과제13_1115. 10개의 속성값을 가진 테이블 생성 후 5개 데이터를 삽입한 후 각각에 대하여 수정 후 2개를 삭제하고 남은 3개를 출력하세요.

SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875, 1)
FROM dual;
 
--과제14_1115. 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.

--Q.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
SELECT bookid, REPLACE(bookname, '농구','야구') bookname, publisher, price
FROM book;

--Q.‘굿스포츠’에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT bookname 제목, length(bookname) 글자수, lengthb(bookname) 바이트수
FROM book
WHERE publisher = '굿스포츠';

SELECT * FROM customer;
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);
--과제15_1115. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.

--과제16_1115. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.

--Q.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT orderid 주문번호, TO_CHAR(orderdate, 'YYYY-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = '2020-07-07';
desc orders;

SELECT SYSDATE FROM DUAL;
--과제17_1115. DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.

--Q.이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시하시오.
--NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다. 함수  :  NVL("값", "지정값") 
SELECT name 이름, NVL(phone, '연락처없음') 전화번호
FROM customer;

--인수를 순서대로 평가하고 처음으로 NULL이 아닌 첫 번째 식의 현재 값을 반환합니다. 
--예를 들어 SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value');는 세 번째 값이 Null이 아닌 첫 값이기 때문에 
--세 번째 값을 반환

select * from customer;

--과제18_1115. 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.

SELECT * FROM orders;
--과제19_1115. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.

--과제20_1115. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.

