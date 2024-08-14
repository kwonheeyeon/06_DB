-- 한 줄 주석

/* 범위 주석 */ 

-- SQL 한 줄 실행 : ctrl + Enter

/* SYS 관리자 계정으로 수행하는 SQL */
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER KH_KHY IDENTIFIED BY KH1234;

GRANT RESOURCE, CONNECT TO KH_KHY;

ALTER USER KH_KHY DEFAULT TABLESPACE USERS QUOTA 20M ON USERS;