SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = ''
ORDER BY JOB_CODE ASC;

-- TB_USER 테이블 생성
CREATE TABLE TB_USER(
	USER_NO NUMBER CONSTRAINT TB_USER_PK PRIMARY KEY,
	USER_ID VARCHAR2(30) NOT NULL,
	USER_PW VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30)	NOT NULL,
	ENROLL_DATE DATE DEFAULT CURRENT_DATE
);


COMMENT ON COLUMN TB_USER.USER_NO IS '사용자 번호';
COMMENT ON COLUMN TB_USER.USER_ID IS '사용자 아이디';
COMMENT ON COLUMN TB_USER.USER_PW IS '사용자 비밀번호';
COMMENT ON COLUMN TB_USER.USER_NAME IS '사용자 이름';
COMMENT ON COLUMN TB_USER.ENROLL_DATE IS '사용자 가입일';

-- USER_NO 컬럼에 삽입될 시퀀스 생성
CREATE SEQUENCE SEQ_USER_NO NOCACHE;

-- 샘플 데이터 INSERT
INSERT INTO TB_USER VALUES (SEQ_USER_NO.NEXTVAL, 'user01', 'pass01', '유저일', DEFAULT);
INSERT INTO TB_USER VALUES (SEQ_USER_NO.NEXTVAL, 'user05', 'pass05', '이순신', DEFAULT);

SELECT * FROM TB_USER;

COMMIT;

-- 아이디, 비밀번호를 입력 받아
-- 아이디, 비밀번호가 일치하는 사용자(TB_USER)의 이름을
-- 이름을 수정(UPDATE)
UPDATE TB_USER
SET USER_NAME = '' 
WHERE USER_ID = '' AND USER_PW = '';
-- 아이디, 비밀번호 일치 -> 수정 성공(1)
-- 아이디 또는 비밀번호 불일치 -> 수정 실패(0)

ROLLBACK;

-------------------------------------------------------------------

/* USER 관리 프로그램 - JAVA */

-- User 전체 조회(SELECT)
SELECT
	USER_NO,
	USER_ID,
	USER_PW,
	USER_NAME,
	TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일"') ENROLL_DATE
FROM TB_USER
ORDER BY USER_NO ASC;

------------------------------------------------------------------

-- 이름에 검색어가 포함된 User 조회(SELECT)
SELECT
	USER_NO,
	USER_ID,
	USER_PW,
	USER_NAME,
	TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일"') ENROLL_DATE
FROM TB_USER
WHERE USER_NAME LIKE '%' || ? || '%'
ORDER BY USER_NO ASC;

-----------------------------------------------------------------

-- USER_NO를 입력 받아 일치하는 User 삭제(DELETE)
DELETE
FROM TB_USER
WHERE USER_NO = ?;

-----------------------------------------------------------------

-- 입력 받은 ID, PW가 일치하는 User가 있는지 조회(SELECT)
SELECT USER_NO
FROM TB_USER
WHERE USER_ID = ? AND USER_PW = ?;

-----------------------------------------------------------------

-- USER_NO(PK)가 일치하는 User의 이름을 수정(UPDATE)
UPDATE TB_USER
SET USER_NAME = ?
WHERE USER_NO = (SELECT USER_NO
								 FROM TB_USER
								 WHERE USER_ID = ? AND USER_PW = ?);

-----------------------------------------------------------------

-- 중복되는 ID가 있는지 조회
-- 중복이면 1, 아니면 0
SELECT COUNT(*)
FROM TB_USER
WHERE USER_ID = ?;
