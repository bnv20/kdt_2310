select * from custdemo;
select * from compet;
select * from channel;
select * from member;
select * from prodcls;
select * from purprod;

select count(*) from purprod; 


SELECT ����ȣ, SUM(���űݾ�)
FROM purprod
GROUP BY ����ȣ
ORDER BY SUM(���űݾ�) DESC;

select custdemo."���ɴ�"
    ,channel."���޻�"
    ,count(*)
from channel inner join custdemo
    on channel.����ȣ = custdemo.����ȣ
where substr(channel."���޻�",1,1) = 'A'
group by custdemo."���ɴ�", channel."���޻�"
order by custdemo."���ɴ�";

SELECT ����ȣ, ROUND(AVG(���űݾ�))��ձݾ� FROM PURPROD GROUP BY ����ȣ;

--����ȣ��
SELECT ����ȣ, ���޻�, ��з��ڵ�, SUM(���űݾ�) ���ž�
FROM PURPROD
GROUP BY ����ȣ, ���޻�, ��з��ڵ�
ORDER BY ����ȣ;

--�̿�Ƚ���� ���� ���� ���޻翡���� �� ���ɺ���
SELECT SP.���ɴ�, COUNT(*) COUNT
FROM
(
    SELECT ����ȣ,
    (SELECT ���ɴ� FROM CUSTDEMO WHERE ����ȣ=C.����ȣ) ���ɴ�
    FROM CHANNEL C
    WHERE ���޻� = (
        SELECT ���޻� FROM (SELECT ���޻�, COUNT(*) CNT FROM CHANNEL GROUP BY ���޻�)
        WHERE CNT = (SELECT MAX(CNT) FROM (SELECT ���޻�, COUNT(*) AS CNT FROM CHANNEL GROUP BY ���޻�))
    )
) SP
GROUP BY SP.���ɴ�
ORDER BY SP.���ɴ�;

--�ٵ��� ����� ���� ���� ������ �Һз� ������ �Ǽ� ��
SELECT PP.�Һз��ڵ�, PC.�Һз���, count(*) ���ŰǼ�
From purprod PP
LEFT OUTER JOIN prodcls PC on PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE ����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ٵ���')
GROUP BY PP.�Һз��ڵ�, PC.�Һз���
ORDER BY ���ŰǼ� DESC;

--���� ����Ƚ���� ���� ������������ ����
select "����ȣ", count(*) AS "����Ƚ��"
from purprod
group by "����ȣ"
order by count(*) desc;

--�ٵ��� ����� ������ �ݾ� �� �Һз� ������
SELECT PP.�Һз��ڵ�, PC.�Һз���, sum(���űݾ�) �Һз������űݾ�
From purprod PP
LEFT OUTER JOIN prodcls PC on PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE ����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ٵ���')
GROUP BY PP.�Һз��ڵ�, PC.�Һз���
ORDER BY �Һз������űݾ� DESC;

--���̺� ����
SELECT c.����ȣ, c.����, c.���ɴ�, c.��������, p.���޻�, p.��������, p.���űݾ�, p.YEAR 
FROM CUSTDEMO c, PURPROD p
WHERE c.����ȣ = p.����ȣ;

CREATE VIEW vw_cp
AS SELECT c.*, p.��������, p.���űݾ�
FROM custdemo c, purprod p
WHERE c.����ȣ=p.����ȣ;

SELECT * FROM vw_cp;
SELECT ����, ROUND(SUM(���űݾ�)/1000000) �����հ�, ROUND(AVG(���űݾ�)) �������
FROM vw_cp
GROUP BY ����;

SELECT ��������, ROUND(SUM(���űݾ�)/1000000) �����հ�, ROUND(AVG(���űݾ�)) �������
FROM vw_cp
GROUP BY ��������
ORDER BY ������� DESC;

SELECT DISTINCT ���ɴ� FROM vw_cp;
SELECT ���ɴ�, ����, ROUND(SUM(���űݾ�)/1000000) �����հ�, ROUND(AVG(���űݾ�)) �������
FROM vw_cp
GROUP BY ���ɴ�, ����
ORDER BY �����հ� DESC;

--���հ��� : LMEMBERS �����ͼ¸� Ž���Ͽ� ���� ū �̽�(�ٰ� ����)�� ã�Ƽ� �� ��å�� �����ϼ���.
--���� : ���Ű��� �� ����(14�� ��ݱ� ��� 15�� �Ϲݱ�) �� ���� ���
--�м� ��� ����Ʈ�� PPT�� �ۼ� ��ǥ