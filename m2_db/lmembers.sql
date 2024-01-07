select * from custdemo;
select * from compet;
select * from channel;
select * from member;
select * from prodcls;
select * from purprod;

select count(*) from purprod; 


SELECT 고객번호, SUM(구매금액)
FROM purprod
GROUP BY 고객번호
ORDER BY SUM(구매금액) DESC;

select custdemo."연령대"
    ,channel."제휴사"
    ,count(*)
from channel inner join custdemo
    on channel.고객번호 = custdemo.고객번호
where substr(channel."제휴사",1,1) = 'A'
group by custdemo."연령대", channel."제휴사"
order by custdemo."연령대";

SELECT 고객번호, ROUND(AVG(구매금액))평균금액 FROM PURPROD GROUP BY 고객번호;

--고객번호별
SELECT 고객번호, 제휴사, 대분류코드, SUM(구매금액) 구매액
FROM PURPROD
GROUP BY 고객번호, 제휴사, 대분류코드
ORDER BY 고객번호;

--이용횟수가 제일 많은 제휴사에서의 고객 연령분포
SELECT SP.연령대, COUNT(*) COUNT
FROM
(
    SELECT 고객번호,
    (SELECT 연령대 FROM CUSTDEMO WHERE 고객번호=C.고객번호) 연령대
    FROM CHANNEL C
    WHERE 제휴사 = (
        SELECT 제휴사 FROM (SELECT 제휴사, COUNT(*) CNT FROM CHANNEL GROUP BY 제휴사)
        WHERE CNT = (SELECT MAX(CNT) FROM (SELECT 제휴사, COUNT(*) AS CNT FROM CHANNEL GROUP BY 제휴사))
    )
) SP
GROUP BY SP.연령대
ORDER BY SP.연령대;

--다둥이 멤버가 제일 많이 구매한 소분류 아이템 건수 순
SELECT PP.소분류코드, PC.소분류명, count(*) 구매건수
From purprod PP
LEFT OUTER JOIN prodcls PC on PP.소분류코드 = PC.소분류코드
WHERE 고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '다둥이')
GROUP BY PP.소분류코드, PC.소분류명
ORDER BY 구매건수 DESC;

--고객의 구매횟수에 따라 내림차순으로 정렬
select "고객번호", count(*) AS "구매횟수"
from purprod
group by "고객번호"
order by count(*) desc;

--다둥이 멤버가 구매한 금액 순 소분류 아이템
SELECT PP.소분류코드, PC.소분류명, sum(구매금액) 소분류별구매금액
From purprod PP
LEFT OUTER JOIN prodcls PC on PP.소분류코드 = PC.소분류코드
WHERE 고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '다둥이')
GROUP BY PP.소분류코드, PC.소분류명
ORDER BY 소분류별구매금액 DESC;

--테이블 결합
SELECT c.고객번호, c.성별, c.연령대, c.거주지역, p.제휴사, p.구매일자, p.구매금액, p.YEAR 
FROM CUSTDEMO c, PURPROD p
WHERE c.고객번호 = p.고객번호;

CREATE VIEW vw_cp
AS SELECT c.*, p.구매일자, p.구매금액
FROM custdemo c, purprod p
WHERE c.고객번호=p.고객번호;

SELECT * FROM vw_cp;
SELECT 성별, ROUND(SUM(구매금액)/1000000) 구매합계, ROUND(AVG(구매금액)) 구매평균
FROM vw_cp
GROUP BY 성별;

SELECT 거주지역, ROUND(SUM(구매금액)/1000000) 구매합계, ROUND(AVG(구매금액)) 구매평균
FROM vw_cp
GROUP BY 거주지역
ORDER BY 구매평균 DESC;

SELECT DISTINCT 연령대 FROM vw_cp;
SELECT 연령대, 성별, ROUND(SUM(구매금액)/1000000) 구매합계, ROUND(AVG(구매금액)) 구매평균
FROM vw_cp
GROUP BY 연령대, 성별
ORDER BY 구매합계 DESC;

--종합과제 : LMEMBERS 데이터셋를 탐색하여 가장 큰 이슈(근거 설명)를 찾아서 그 대책을 제안하세요.
--예시 : 구매감소 고객 증가(14년 상반기 대비 15년 하반기) 및 대응 방안
--분석 결과 리포트를 PPT로 작성 발표