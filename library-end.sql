

DROP DATABASE IF EXISTS library20230327;

CREATE DATABASE library20230327 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE library20230327;

DROP TABLE IF EXISTS orders;

-- 1)書籍books
DROP TABLE IF EXISTS books;
CREATE TABLE books(
  書籍id int(5) NOT NULL UNIQUE,
  書籍標題 VARCHAR(100),
  作者id int(5),
  譯者id int(5),
  發行商id int(5),
  類別id INT(5),
  isbn VARCHAR(20),
  PRIMARY KEY (書籍id)
);

INSERT INTO books VALUES (00001,'原子習慣',00001,00001,00001,00001,'9789863988472');
INSERT INTO books VALUES (00002,'晶片戰爭',00002,00002,00002,00001,'9789863988473');
INSERT INTO books VALUES (00003,'平板電腦',00003,00003,00003,00001,'9789863988474');
INSERT INTO books VALUES (00005,'海洋知識大闖關',00005,00005,00005,00002,'97898639884123');
INSERT INTO books VALUES (00006,'視覺圖解 腦的結構與原理',00006,00006,00006,00002,'97898639884156');
INSERT INTO books VALUES (00007,'遇到選擇時，你會怎麼做',00007,00007,00007,00003,'978986384123');
INSERT INTO books VALUES (00008,'人性的弱點：卡內基經典成功學',00008,00008,00008,00003,'97898678884123');
INSERT INTO books VALUES (00009,'為什麼不能等一下',00009,00009,00009,00004,'97788639884123');
INSERT INTO books VALUES (00010,'廚房用具大作戰',00004,00004,00004,00004,'97898639884123');
INSERT INTO books VALUES (00011,'廚房用具大作戰',00004,00004,00004,00004,'97898639884123');
INSERT INTO books VALUES (00012,'廚房用具大作戰',00004,00004,00004,00004,'97898639884123');


-- 2）書籍類別book_category
CREATE TABLE book_category (
  類別id INT(5) NOT NULL,
  書籍id INT(5) NOT NULL,
  類別名 VARCHAR(30) NOT NULL,
  PRIMARY KEY (類別id, 書籍id),
  FOREIGN KEY (書籍id) REFERENCES books(書籍id)
);

INSERT INTO book_category VALUES (00001, 00001, '恐怖');
INSERT INTO book_category VALUES (00002, 00002, '推理');
INSERT INTO book_category VALUES (00003, 00003, '流行');
INSERT INTO book_category VALUES (0004, 00010, '兒童');
INSERT INTO book_category VALUES (0004, 00011, '兒童');
INSERT INTO book_category VALUES (0004, 00012, '兒童');

-- 3）作者資料authors
CREATE TABLE authors (
  作者id INT(5) PRIMARY KEY,
  作者名 VARCHAR(30),
  國家代碼 VARCHAR(3)
);

INSERT INTO authors VALUES (00001, '李先生', 'TWN');
INSERT INTO authors VALUES (00002, '山東分公司', 'JPN');
INSERT INTO authors VALUES (00003, 'Emily', 'GBR');
INSERT INTO authors VALUES (00004, 'Cayy', 'TWN');
INSERT INTO authors VALUES (00005, '張海風', 'TWN');
INSERT INTO authors VALUES (00006, '王規範', 'CHN');
INSERT INTO authors VALUES (00007, '林辦法', 'TWN');
INSERT INTO authors VALUES (00008, '陳挺好', 'TWN');
INSERT INTO authors VALUES (00009, '黃風格姐', 'HKG');


-- 4）譯者資料translators
CREATE TABLE translators (
  譯者id INT(5) PRIMARY KEY,
  譯者名 VARCHAR(30),
  國籍碼 VARCHAR(3)
);

INSERT INTO translators VALUES (00001,'李翻譯','TWN');
INSERT INTO translators VALUES (00002,'田中yo','JPN');
INSERT INTO translators VALUES (00003,'Emily','USA');
INSERT INTO translators VALUES (00004,' 蘇懿禎','TWN');


-- 5）發行商 publisher
CREATE TABLE publisher (
  發行商id INT(5) PRIMARY KEY,
  發行商名稱 VARCHAR(30),
  發行日期 DATE,
  發行商地址 VARCHAR(100)
);

INSERT INTO publisher VALUES (00001,'商務印書','2022-01-01','台中市南區興大路145號');
INSERT INTO publisher VALUES (00002,'商周出版','2022-02-01','台中市南區興大路156號');
INSERT INTO publisher VALUES (00003,'天下文化出版','2022-01-03','台中市南區興大路200號');
 
-- ALTER TABLE books ADD CONSTRAINT fk_books_publisher FOREIGN KEY (發行商id) REFERENCES publisher(發行商id);


-- 6）借閲人borrowers 
CREATE TABLE borrowers (
  借閲人id INT(5) PRIMARY KEY,
  借閲人姓名 VARCHAR(30),
  借閲人email VARCHAR(30),
  借閲人電話 VARCHAR(10),
  借閲人住址 VARCHAR(100)
);

INSERT INTO borrowers VALUES (00001, '張三', 'zhang3@gmail.com', '0987878787', '台北市信義區忠孝東路');
INSERT INTO borrowers VALUES (00002, '李四', 'lee@gmail.com', '0912345678', '台北市信義區忠孝東路');
INSERT INTO borrowers VALUES (00003, '張三他弟', 'wang@gmail.com', '0912345678', '桃園市桃園區仁愛路');

-- 7）借閲記錄 borrowing_records
CREATE TABLE borrowing_records (
借閲id INT(5) PRIMARY KEY,
借閲人id INT(5),
書籍id INT(5),
借書日期 DATE,
應還日期 DATE,
實還日期 DATE,
狀態 VARCHAR(10),
FOREIGN KEY (借閲人id) REFERENCES borrowers(借閲人id),
FOREIGN KEY (書籍id) REFERENCES books(書籍id)
);

INSERT INTO borrowing_records VALUES (00001,00001,00001,'2022-01-01','2022-01-08','2022-01-08','已還書');
INSERT INTO borrowing_records VALUES (00002,00002,00002,'2022-02-01','2022-02-08',NULL,'已出借');
INSERT INTO borrowing_records VALUES (00003,00003,00003,'2022-03-01','2022-03-08',NULL,'可出借');

-- 8）閲讀歷史記錄reading_history
DROP TABLE IF EXISTS reading_history;
CREATE TABLE reading_history (
閲讀id INT(5) PRIMARY KEY,
書籍id INT(5),
借閲人id INT(5),
閲讀評分 varchar(5),
閲讀評價 varchar(100),
FOREIGN KEY (書籍id) REFERENCES books(書籍id),
FOREIGN KEY (借閲人id) REFERENCES borrowers(借閲人id)
);


INSERT INTO reading_history VALUES (00001,00001,00001,'5','值得一看');
INSERT INTO reading_history VALUES (00002,00002,00002,'4','太少了');
INSERT INTO reading_history VALUES (00003,00003,00003,'3','good');




-- 9）預約記錄
CREATE TABLE reservation (
預約id INT(5) PRIMARY KEY,
借閲人id INT(5),
書籍id INT(5),
預約日期 DATE,
預約到期日期 DATE,
預約狀態 VARCHAR(10),
FOREIGN KEY (借閲人id) REFERENCES borrowers(借閲人id),
FOREIGN KEY (書籍id) REFERENCES books(書籍id)
);

INSERT INTO reservation VALUES (00001, 00001, 00001, '2023-03-24', '2023-03-26', '已預約');
INSERT INTO reservation VALUES (00002,00002, 00002, '2023-03-23', '2023-03-25', '已預約');
INSERT INTO reservation VALUES (00003, 00003,00003, '2023-03-22', '2023-03-24', '已預約');

-- 10）續借記錄renew
CREATE TABLE renew (
續借id INT(5) PRIMARY KEY,
借閲id INT(5),
續借日期 DATE,
新應還日期 DATE,
續借次數 INT(2),
FOREIGN KEY (借閲id) REFERENCES borrowing_records(借閲id)
);

INSERT INTO renew VALUES (00001, 00001, '2022-01-01', '2022-03-01', 1);
INSERT INTO renew VALUES (00002, 00002, '2022-01-02', '2022-04-01', 2);
INSERT INTO renew VALUES (00003, 00003, '2022-01-03', '2022-05-01', 3);

-- 11）罰款記錄fine_record
CREATE TABLE fine_record (
罰款id INT(5) PRIMARY KEY,
借閲id INT(5),
借閲人id INT(5),
書籍id INT(5),
罰款金額 DECIMAL(8),
繳費日期 DATE,
罰款狀態 VARCHAR(10),
FOREIGN KEY (借閲id) REFERENCES borrowing_records(借閲id),
FOREIGN KEY (借閲人id) REFERENCES borrowers(借閲人id),
FOREIGN KEY (書籍id) REFERENCES books(書籍id)
);

INSERT INTO fine_record VALUES (00001, 00001, 00001, 00001, 100, '2022-01-01', '已繳清');
INSERT INTO fine_record VALUES (00002, 00002, 00002, 00002, 50, '2022-02-01', '已繳清');
INSERT INTO fine_record VALUES (00003, 00003, 00003, 00003, 80, '2022-03-01', '已繳清');

-- 12）員工資料staff
CREATE TABLE staff (
員工id INT(5) PRIMARY KEY,
員工姓名 varchar(30),
員工職稱 varchar(30),
員工住址 varchar(50),
員工電話 varchar(20),
員工電郵 varchar(50)
);

INSERT INTO staff VALUES (1,'aa','經理','中壢','555-1234','111@gmail.com');
INSERT INTO staff VALUES (2,'bb','圖書館員','臺北','555-5678','j222@gmail.com');
INSERT INTO staff VALUES (3,'cc','圖書館員','臺中','555-9012','333@gmail.com');


-- 13）圖書分區資料book_section
CREATE TABLE book_section (
分區id INT(5) PRIMARY KEY,
分區名稱 VARCHAR(20),
類別id INT(5),
員工id INT(5),
分區位置 VARCHAR(10),
FOREIGN KEY (類別id) REFERENCES book_category(類別id),
FOREIGN KEY (員工id) REFERENCES staff(員工id)
);

INSERT INTO book_section VALUES (00001, '中文區', 00001, 00001, '1F row10');
INSERT INTO book_section VALUES (00002, '英文區',00002, 00001, '1F row12');
INSERT INTO book_section VALUES (00003, '推理區', 00003, 00002, '2F row12');

INSERT INTO book_section VALUES (00004, '兒童區', 00004, 00003, '3F row12');


-- 14）購書記錄purchase_history
CREATE TABLE purchase_history (
購書id INT(5) PRIMARY KEY,
書籍id INT(5),
購買日期 DATE,
單價 VARCHAR(3),
購買途徑 VARCHAR(20),
員工id INT(5),
FOREIGN KEY (書籍id) REFERENCES books(書籍id),
FOREIGN KEY (員工id) REFERENCES staff(員工id)
);

INSERT INTO purchase_history VALUES (00001, 00001, '2022-01-01', '150', '網路購買', 00001);
INSERT INTO purchase_history VALUES (00002, 00003, '2022-02-05', '100', '網路購買', 00002);
INSERT INTO purchase_history VALUES (00003, 00002, '2022-03-10', '200', '網路購買', 00003);


-- 15）捐贈單位donation_units

DROP TABLE IF EXISTS donation_units;
CREATE TABLE donation_units (
  捐贈單位id INT(5) PRIMARY KEY,
  捐贈單位名稱 VARCHAR(30),
  捐贈單位地址 VARCHAR(50),
  捐贈單位電話 VARCHAR(20),
  捐贈單位電郵 VARCHAR(30)
);

INSERT INTO donation_units VALUES (1, '捐贈單位A', '台北市', '02-123450', 'donation_a@gmail.com');
INSERT INTO donation_units VALUES (2, '捐贈單位B', '新北市', '02-234560', 'donation_b@gmail.com');
INSERT INTO donation_units VALUES (3, '捐贈單位C', '台中市', '04-3456780', 'donation_c@gmail.com');


-- 16）捐贈記錄donation_records
DROP TABLE IF EXISTS donation_records;
CREATE TABLE donation_records (
捐贈id INT(5) ZEROFILL PRIMARY KEY,
書籍id INT(5),
捐贈日期 DATE,
捐贈單位id INT(5),
員工id INT(5),
FOREIGN KEY (書籍id) REFERENCES books(書籍id),
FOREIGN KEY (捐贈單位id) REFERENCES donation_units(捐贈單位id),
FOREIGN KEY (員工id) REFERENCES staff(員工id)
);

INSERT INTO donation_records VALUES (00001, 1, '2022-01-01', 1, 1);
INSERT INTO donation_records VALUES (00002, 2, '2022-02-02', 2, 2);
INSERT INTO donation_records VALUES (00003, 3, '2022-01-03', 3, 3);





-- 17）館藏損壞記錄damage_records
DROP TABLE IF EXISTS damage_records;
CREATE TABLE damage_records (
  損壞id INT(5) PRIMARY KEY,
  書籍id INT(5),
  損壞日期 DATE,
  員工id INT(5),
  損壞狀態 VARCHAR(20),
  FOREIGN KEY (書籍id) REFERENCES books(書籍id),
  FOREIGN KEY (員工id) REFERENCES staff(員工id)
);

INSERT INTO damage_records VALUES (1,  1, '2022-01-01', 1, '損壞');
INSERT INTO damage_records VALUES (2,  2, '2022-03-15', 2, '損壞');
INSERT INTO damage_records VALUES (3,  3, '2022-05-20', 3, '已修復');

-- 18）修復記錄repair_records 
DROP TABLE IF EXISTS repair_records;
CREATE TABLE repair_records (
    修復id INT(5) PRIMARY KEY,
    損壞id INT(5),
    書籍id INT(5),
    翻新日期 DATE,
    翻新狀態 VARCHAR(20),
    FOREIGN KEY (損壞id) REFERENCES damage_records(損壞id),
    FOREIGN KEY (書籍id) REFERENCES books(書籍id)
);

INSERT INTO repair_records VALUES (1, 1, 1, '2022-03-15', '已修復');
INSERT INTO repair_records VALUES (2, 2, 2, '2022-03-16', '修復中');
INSERT INTO repair_records VALUES (3, 3, 3, '2022-03-17', '不可修復');



-- 19）棄置記錄abandon_records
DROP TABLE IF EXISTS abandon_records;
CREATE TABLE abandon_records (
  棄置id INT(5) PRIMARY KEY,
  書籍id INT(5),
  棄置日期 DATE,
  棄置原因 VARCHAR(50),
  員工id INT(5),
  FOREIGN KEY (書籍id) REFERENCES books(書籍id),
  FOREIGN KEY (員工id) REFERENCES staff(員工id)
);

INSERT INTO abandon_records VALUES(1, 1, '2022-03-01', '破損', 1);
INSERT INTO abandon_records VALUES(2, 2, '2022-03-02', '過時', 2);
INSERT INTO abandon_records VALUES(3, 3, '2022-03-03', '過時', 3);



-- 20）回饋意見表feedback 
CREATE TABLE feedback (
  回饋id int(5) PRIMARY KEY,
  書籍id int(5) REFERENCES books(書籍id),
  借閲人id int(5) REFERENCES borrowers(借閲人id),
  回饋日期 date,
  回饋 varchar(100)
);

INSERT INTO feedback  VALUES(1, 1001, 2001, '2022-12-01', '好看');
INSERT INTO feedback  VALUES(2, 1002, 2003, '2023-01-15', 'fun');
INSERT INTO feedback  VALUES(3, 1005, 2002, '2023-02-28', 'good');

-------------------------------------------------------------------------------

-- 創建顯示會員借閲記錄
CREATE VIEW member_borrowing_records AS
SELECT br.借閲id, br.借閲人id, b.書籍標題, br.借書日期, br.應還日期, br.實還日期, br.狀態
FROM borrowing_records AS br
JOIN books AS b ON br.書籍id = b.書籍id;

-- 顯示會員id0002的借閲記錄
CREATE VIEW view_borrowing_records AS
SELECT br.借閲id, br.借閲人id, b.借閲人姓名, br.書籍id, bk.書籍標題, br.借書日期, br.應還日期, br.實還日期, br.狀態
FROM borrowing_records br
JOIN borrowers b ON br.借閲人id = b.借閲人id
JOIN books bk ON br.書籍id = bk.書籍id;

SELECT * FROM view_borrowing_records WHERE 借閲人id = 00002;



-- 找出名爲晶片戰爭的書

CREATE VIEW book_details AS
SELECT b.書籍id, b.書籍標題, a.作者名, t.譯者名, p.發行商名稱, b.isbn
FROM books AS b
JOIN authors AS a ON b.作者id = a.作者id
JOIN translators AS t ON b.譯者id = t.譯者id
JOIN publisher AS p ON b.發行商id = p.發行商id
WHERE b.書籍標題 = '晶片戰爭';
SELECT *
FROM book_details;


-- 調出所有作者國際twn的書
SELECT b.書籍id, b.書籍標題, a.作者名, a.國家代碼
FROM books b
JOIN authors a ON b.作者id = a.作者id
WHERE a.國家代碼 = 'TWN';

-- 查詢《廚房用具大作戰》的分區位置

SELECT bs.分區位置, b.書籍id, b.書籍標題, a.作者名, a.國家代碼
FROM books AS b
JOIN book_section AS bs ON b.類別id = bs.類別id
JOIN authors a ON b.作者id = a.作者id
WHERE b.書籍標題 = '廚房用具大作戰';



-- 查詢棄置記錄
CREATE VIEW disposal_view AS
SELECT  d.棄置id,  b.書籍id,  b.書籍標題,  a.作者名,  d.棄置日期
FROM  abandon_records d  INNER JOIN books b ON d.書籍id = b.書籍id INNER JOIN authors a ON b.作者id = a.作者id;
SELECT * FROM disposal_view;

-- 以圖書分區資料分類出員工的基本資料
CREATE VIEW view_book_section_staff AS
SELECT bs.分區id, bs.分區名稱, bs.分區位置, s.員工id, s.員工姓名, s.員工職稱, s.員工住址, s.員工電話, s.員工電郵
FROM book_section bs
JOIN staff s ON bs.員工id = s.員工id;
SELECT *
FROM view_book_section_staff;

-- 備份數據庫

-- SELECT * INTO OUTFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' FROM library20230327.books;
-- SELECT * INTO OUTFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' FROM library20230327.book_category;
-- SELECT * INTO OUTFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' FROM library20230327.authors;
-- SELECT * INTO OUTFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' FROM library20230327.translators;
-- SELECT * INTO OUTFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' FROM library20230327.publisher;

-- LOAD DATA INFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' INTO TABLE library20230327.books;
-- LOAD DATA INFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' INTO TABLE library20230327.book_category;
-- LOAD DATA INFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' INTO TABLE library20230327.authors;
-- LOAD DATA INFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' INTO TABLE library20230327.translators;
-- LOAD DATA INFILE 'C:ProgramData/MySQL Server 8.0/Uploads/members.txt' INTO TABLE library20230327.publisher;


