CREATE DATABASE VINABOOK
USE VINABOOK


CREATE TABLE AUTHOR(
    AUTHOR_ID DECIMAL(16,0) NOT NULL PRIMARY KEY,
    AUTHOR_NAME NVARCHAR(50) NOT NULL
)


CREATE TABLE PUBLISHER(
    PUBLISHER_ID DECIMAL(16,0) NOT NULL PRIMARY KEY,
    PUBLISHER_NAME NVARCHAR(50) NOT NULL
)


CREATE TABLE CATEGORY(
    CATEGORY_ID DECIMAL(16,0) NOT NULL PRIMARY KEY,
    CATEGORY_NAME NVARCHAR(50) NOT NULL    
)


CREATE TABLE PRODUCT(
    PRODUCT_ID DECIMAL(16,0) NOT NULL PRIMARY KEY,
    PRODUCT_NAME NVARCHAR(100) NOT NULL,
    PRICE MONEY CHECK(PRICE>0),
    PAGES SMALLINT CHECK(PAGES>0),
    SIZE VARCHAR(20) NOT NULL,
    WEIGHT FLOAT CHECK(WEIGHT>0),
    DESCRIPTION NVARCHAR(MAX) NOT NULL,
    LANGUAGE NVARCHAR(50) NOT NULL,
    BOOK_FORMAT NVARCHAR(50) NOT NULL,
    AUTHOR_ID DECIMAL(16,0) NOT NULL,
    PUBLISHER_ID DECIMAL(16,0) NOT NULL,
    CATEGORY_ID DECIMAL(16,0) NOT NULL,
    PUBLIC_DAY DATE NOT NULL,
    AMOUNT INT DEFAULT 0 ,
	[Image] varchar(MAX),
    FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID),
    FOREIGN KEY (PUBLISHER_ID) REFERENCES PUBLISHER(PUBLISHER_ID),
    FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
)
   
CREATE TABLE CUSTOMER(
    CUSTOMER_ID DECIMAL(16,0) NOT NULL PRIMARY KEY,
    CUSTOMER_NAME NVARCHAR(50) NOT NULL,
    PHONE VARCHAR(12),
    ADDRESS NVARCHAR(100),
    BIRTHDAY DATE,
    EMAIL VARCHAR(100),
    SEX VARCHAR(10),
	[Password] VARCHAR(100),
	[Role] int,
	cart varchar(MAX) default '',
	fav varchar(MAX) default '',
)


CREATE TABLE ORDERS(
    ORDER_ID DECIMAL(16,0) NOT NULL PRIMARY KEY IDENTITY(1,1),
    CUSTOMER_ID DECIMAL(16,0) NOT NULL,
    ORDER_DATE DATE,
    TOTAL_PRICE MONEY,
	PAYING bit default 0,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)  
)


CREATE TABLE ORDER_DETAIL(
    ORDER_ID DECIMAL(16,0) NOT NULL,
    PRODUCT_ID DECIMAL(16,0) NOT NULL,
    PRICE MONEY,
    AMOUNT INT CHECK(AMOUNT>0),
    PRIMARY KEY (ORDER_ID,PRODUCT_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
	EVALUATED bit default 0,
)


CREATE TABLE EVALUATION(
    CUSTOMER_ID DECIMAL(16,0),
    PRODUCT_ID DECIMAL(16,0),
    EVA_CONTENT NVARCHAR(500),
    EVA_SCORE FLOAT,
    EVA_TIME DATETIME,
    PRIMARY KEY (CUSTOMER_ID,PRODUCT_ID,EVA_TIME),
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
)


INSERT INTO AUTHOR VALUES(1001,N'Bryan Syverson')
INSERT INTO AUTHOR VALUES(1002,N'Marc Beckman')
INSERT INTO AUTHOR VALUES(1003,N'Marta Matus')
INSERT INTO AUTHOR VALUES(1004,N'Nikolai A. Ostrovsky')
INSERT INTO AUTHOR VALUES(1005,N'George R. R. Martin')
INSERT INTO AUTHOR VALUES(1006,N'Tô Hoài')
INSERT INTO AUTHOR VALUES(1007,N'Victor Hugo')
INSERT INTO AUTHOR VALUES(1008,N'Forbes Vietnam')
INSERT INTO AUTHOR VALUES(1009,N'Nguyễn Nhật Ánh')
INSERT INTO AUTHOR VALUES(1010,N'Nguyễn Xuân Lạc')
INSERT INTO AUTHOR VALUES(1011,N'Rick Riordan')
INSERT INTO AUTHOR VALUES(1012,N'Philip Kotler')
INSERT INTO AUTHOR VALUES(1013,N'Robert T. Kiyosaki')
INSERT INTO AUTHOR VALUES(1014,N'Brian Tracy')
INSERT INTO AUTHOR VALUES(1015,N'FAHASA')
INSERT INTO AUTHOR VALUES(1016,N'Aoyama Gosho')
INSERT INTO AUTHOR VALUES(1017,N'Nhóm Sư Phạm VHP')
INSERT INTO AUTHOR VALUES(1018,N'Lê Văn Thông')


INSERT INTO PUBLISHER VALUES(201,N'NXB Khoa học và kỹ thuật')
INSERT INTO PUBLISHER VALUES(202,N'NXB Thanh Niên')
INSERT INTO PUBLISHER VALUES(203,N'Văn Lang')
INSERT INTO PUBLISHER VALUES(204,N'NXB Mỹ thuật')
INSERT INTO PUBLISHER VALUES(205,N'HarperCollins Publishers Ltd')
INSERT INTO PUBLISHER VALUES(206,N'NXB Kim Đồng')
INSERT INTO PUBLISHER VALUES(207,N'NXB văn học')
INSERT INTO PUBLISHER VALUES(208,N'Forbes Vietnam')
INSERT INTO PUBLISHER VALUES(209,N'NXB Trẻ')
INSERT INTO PUBLISHER VALUES(210,N'Nxb Hội Nhà Văn')
INSERT INTO PUBLISHER VALUES(211,N'Oxford University Press')
INSERT INTO PUBLISHER VALUES(212,N'Pearson Education')
INSERT INTO PUBLISHER VALUES(213,N'Heinle Cengage Learning ')
INSERT INTO PUBLISHER VALUES(214,N'Thăng Long')
INSERT INTO PUBLISHER VALUES(215,N'NXBTH TPHCM')
INSERT INTO PUBLISHER VALUES(216,N'Fahasa')


INSERT INTO CATEGORY VALUES(30001,N'Sách Tin học - Ngoại ngữ')
INSERT INTO CATEGORY VALUES(30002,N'Sách Công Nghệ')
INSERT INTO CATEGORY VALUES(30003,N'Sách Thiếu Nhi')
INSERT INTO CATEGORY VALUES(30004,N'Sách Văn học Nước Ngoài')
INSERT INTO CATEGORY VALUES(30005,N'Sách Văn học Trong Nước')
INSERT INTO CATEGORY VALUES(30006,N'Sách Kinh Tế')
INSERT INTO CATEGORY VALUES(30009,N'Sách Thưởng Thức-Đời Sống')
INSERT INTO CATEGORY VALUES(30010,N'Sách Giáo Khoa-Giáo Trình')
INSERT INTO CATEGORY VALUES(30011,N'Sách Phát Triển Bản Thân')
INSERT INTO CATEGORY VALUES(30012,N'Sách Chuyên Ngành')





INSERT INTO PRODUCT VALUES(1,N'SQL Server 2008 - Hướng Dẫn Học Qua Ví Dụ',161000,520,'19 X 27',902,N'Cuốn sách SQL Server 2008 - Hướng dẫn học qua ví dụ đã được Trường Đại học FPT chọn','Vietnamese',N'Bìa mềm',1001,201,30001,'20100111',123,'image/1.jpg')
INSERT INTO PRODUCT VALUES(2,N'Cách Mạng Công Nghệ 4.0',2900,88,'21 X 29',374,N'Cơ sở dữ liệu giữ một vai trò quan trọng trong hệ thống thông tin của các tổ chức, doanh nghiệp.','Vietnamese',N'Bìa mềm',1001,201,30001,'20200111',234,'image/2.jpg')
INSERT INTO PRODUCT VALUES(3,N'Sổ tay bác sĩ nhí – Hiểu đúng bệnh, chữa nhẹ tênh',153000,80,'21 X 29',500,N'Sổ tay bác sĩ nhí cung cấp những thông tin về các bệnh thường gặp, giúp độc giả nhí tự trang bị kiến thức để từ đó hiểu về cơ thể.','Vietnamese',N'Bìa cứng',1003,203,30003,'20150221',10,'image/3.jpg')
INSERT INTO PRODUCT VALUES(4,N'Thép Đã Tôi Thế Đấy',70000,144,'17 X 23',440,N'Sổ tay bác sĩ nhí cung cấp những thông tin về các bệnh thường gặp, giúp độc giả nhí tự trang bị kiến thức để từ đó hiểu về cơ thể.','Vietnamese',N'Bìa mềm',1004,204,30004,'20190130',2,'image/4.jpg')
INSERT INTO PRODUCT VALUES(5,N'A Song of Ice and Fire, 7 Vol',2280000,5232,'16 X 19',3856,N'HBOs hit series A GAME OF THRONES is based on George R R Martins internationally bestselling series A SONG OF ICE AND FIRE.','English',N'Bìa cứng',1006,206,30006,'20180101',1000,'image/5.jpg')
INSERT INTO PRODUCT VALUES(6,N'Dế Mèn Phiêu Lưu Ký (Tái Bản 2018)',120000,144,'18 X 25',528,N'Dế Mèn phiêu lưu ký là một trong những sáng tác tâm đắc nhất của nhà văn Tô Hoà.i','Vietnamese',N'Bìa cứng',1006,206,30006,'20160713',1,'image/6.jpg')
INSERT INTO PRODUCT VALUES(7,N'Những Người Khốn Khổ (Bộ 3 Tập)',420000,2048,'14 X 20',2552,N'Những Người Khốn Khổ là một cuốn tiểu thuyết xã hội hiện đại, một thiên hùng ca bằng văn xuôi.','Vietnamese',N'Bìa cứng',1007,207,30005,'20200821',15,'image/7.jpg')
INSERT INTO PRODUCT VALUES(8,N'Tạp chí Forbes - Số 115',95000,112,'20 X 27',400,N'Để trả lời cho câu hỏi sau đại dịch COVID-19 chân dung của người tiêu dùng đã thay đổi như thế nào, NielsenIQ đã tiến hành nhiều khảo sát.','Vietnamese',N'Bìa mềm',1008,208,30004,'20190615',6,'image/8.jpg')
INSERT INTO PRODUCT VALUES(9,N'Con Chó Nhỏ Mang Giỏ Hoa Hồng',63000,256,'13 X 20',242,N'Con chó nhỏ mang giỏ hoa hồng” là tác phẩm mới nhất của nhà văn chuyên viết cho thanh thiếu niên Nguyễn Nhật Ánh.','Vietnamese',N'Bìa mềm',1009,209,30005,'20180321',2,'image/9.jpg')
INSERT INTO PRODUCT VALUES(10,N'Lạc Giữa Thanh Xuân',55000,172,'12 X 20', 198,N'Cuốn sách là tự truyện, được biến tấu thành Truyện. Kể về cuộc đời nhiều biến cố của một cô hotgirl xứ Nghệ, sau nhiều vấp ngã, trả giá cho một tuổi trẻ nông nổi, dại khờ để xây mộng vươn tới một ngôi sao.','Vietnamese',N'Bìa mềm',1010,210,30005,'20200221',13,'image/10.jpg')
INSERT INTO PRODUCT VALUES(11,N'Vẽ 50 tòa nhà và công trình kiến trúc',15000,520,'19 X 27',902,N'Quyển sách hướng dẫn các bạn yêu thích hội họa từng bước từ đơn giản đến phức tạp để có thể vẽ được dễ dàng những công trình kiến trúc nổi tiếng trên thế giới như đền Taj Mahal ở Ấn Độ, tháp nghiêng Pisa ở Ý, tòa nhà Empire State ở thành phố New York, Mỹ. Ngoài ra bạn còn có thể vẽ được nhiều kiểu kiến trúc bản địa độc đáo của các quốc gia trên thế giới như kiểu nhà tranh Ireland, kiểu nhà Adobe ở Pueblo, kiểu nhà trên núi ở Thụy Sĩ...','Vietnamese',N'Bìa mềm',1015,216,30012,'20200901',7,'image/11.jpg')
INSERT INTO PRODUCT VALUES(12,N'Cây Chuối Non Đi Giày Xanh (Bìa Mềm)',29000,188,'21 X 29',324,N'Cơ sở dữ liệu giữ một vai trò quan trọng trong hệ thống thông tin của các tổ chức, doanh nghiệp.','Vietnamese',N'Bìa mềm',1017,216,30011,'20160121',5,'image/12.jpg')
INSERT INTO PRODUCT VALUES(13,N'Rượu Độc Lóng Lánh',153000,180,'21 X 29',530,N'Sổ tay bác sĩ nhí cung cấp những thông tin về các bệnh thường gặp, giúp độc giả nhí tự trang bị kiến thức để từ đó hiểu về cơ thể.','Vietnamese',N'Bìa cứng',1016,213,30011,'20180121',2,'image/13.jpg')
INSERT INTO PRODUCT VALUES(14,N'Sapiens - Lược Sử Loài Người Bằng Tranh - Tập 2: Những Trụ Cột Của Nền Văn Minh',700000,104,'17 X 23',340,N'Sổ tay bác sĩ nhí cung cấp những thông tin về các bệnh thường gặp, giúp độc giả nhí tự trang bị kiến thức để từ đó hiểu về cơ thể.','Vietnamese',N'Bìa mềm',1018,204,30009,'20180331',19,'image/14.jpg')
INSERT INTO PRODUCT VALUES(15,N'Bách Khoa Toàn Thư Content: Đại Biểu Mẫu',2180000,5232,'16 X 19',3856,N'HBOs hit series A GAME OF THRONES is based on George R R Martins internationally bestselling series A SONG OF ICE AND FIRE.','English',N'Bìa cứng',1016,206,30006,'20190806',22,'image/15.jpg')
INSERT INTO PRODUCT VALUES(16,N'Harry Potter and the Philosopher''s Stone', 150000, 223, '15 X 22', 300, N'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive.', 'English', N'Bìa mềm', 1011, 211, 30004, '19970626', 500,'image/16.jpg')
INSERT INTO PRODUCT VALUES(17,N'Marketing Management', 450000, 816, '20 X 25', 1500, N'This is the 14th edition of ''Marketing Management'' which preserves the strengths of previous editions while introducing new material and structure to further enhance learning.', 'English', N'Bìa cứng', 1012, 212, 30006, '20120218', 60,'image/17.jpg')
INSERT INTO PRODUCT VALUES(18,N'Rich Dad Poor Dad', 200000, 336, '15 X 22', 400, N'Personal finance author and lecturer Robert T. Kiyosaki developed his unique economic perspective from two very different influences - his two fathers.', 'English', N'Bìa mềm', 1013, 213, 30011, '20000411', 120,'image/18.jpg')
INSERT INTO PRODUCT VALUES(19,N'No Excuses!: The Power of Self-Discipline',175000,304,'15 X 22',350,N'You don''t need to have been born under a lucky star, or with incredible wealth, or with terrific contacts and connections, or even special skills...but what you do need to succeed in any of your life goals is self-discipline.','English',N'Bìa mềm',1014,214,30011,'20110301',75,'image/19.jpg')
INSERT INTO PRODUCT VALUES(20,N'Cây cam ngọt của tôi',73000,244,'14 X 20',500,N'	Vị chua chát của cái nghèo hòa trộn với vị ngọt ngào khi khám phá ra những điều khiến cuộc đời này đáng số một tác phẩm kinh điển của Brazil.','Vietnamese',N'Bìa mềm',1005,214,30010,'20200101',15,'image/20.jpg')
INSERT INTO PRODUCT VALUES(21,N'Lời giải bài tập Python cơ bản',161000,520,'19 X 27',902,N'Python là ngôn ngữ lập trình bậc cao khá dễ học, rất phù hợp để  học và dạy trong nhà trường phổ thông, vì thế Python sẽ đóng vai trò rất lớn trong môn Tin học, thời gian tới Python dự kiến sẽ được đưa vào Chương trình tin học lớp 10 trong Chương trình môn Tin học mới.','Vietnamese',N'Bìa mềm',1001,201,30002,'20210114',123,'image/21.jpg')




INSERT INTO CUSTOMER ([CUSTOMER_ID]
           ,[CUSTOMER_NAME]
           ,[PHONE]
           ,[ADDRESS]
           ,[BIRTHDAY]
           ,[EMAIL]
           ,[SEX]
           ,[Password]
           ,[Role]
           ,[cart]) VALUES
(101001,N'Chu Thanh Hồng','0993189175',N'Xã Minh Đức, Huyện Mỹ Hào, Hưng Yên','20000519','chuthanhhong632@gmail.com', 'F','1','1','')
,(101002,N'Diệp Tùy Anh','0899062708',N'Phước Hoà, Phước Sơn, Quảng Nam, Việt Nam','19980402','tuyanh@gmail.com', 'F','1','1','')
,(101003,N'Lê Hoàng','0564105737',N'Trung An, Củ Chi, Thành phố Hồ Chí Minh, Việt Nam','20000519','hoangle09@gmail.com', 'M','1','1','')
,(101004,N'Đào Phương Quỳnh','0995047627',N'Phước Mỹ Trung, Mỏ Cày Bắc, Bến Tre, Việt Nam','20050723','pquynhdao@gmail.com', 'F','1','1','')
,(101005,N'Phạm Quang Hiệp','0899328285',N'Lý Văn Lâm, Tp. Cà Mau, Cà Mau, Việt Nam','19900629','hiepquangpham@gmail.com', 'M','1','2','')
,(101006,N'Lê Văn Dương','0367890817',N'Lệ Chi, Gia Lâm, Hà Nội, Việt Nam','20010212','duongvanle@gmail.com', 'M','1','2','')
,(101007,N'Hồ Thị Cẩm Ly','0584873334',N'Tô Hiến Thành, Quận 10, TP.HCM','19991218','camlyy@gmail.com', 'F','1','2','')
,(101008,N'Đặng Minh Duy','0586408728',N'Nguyễn Văn Lương, Quận 12, TP.HCM','20040622','duyminh06@gmail.com', 'M','1','2','')
,(101009,N'Huỳnh Thanh Nga','0898190241',N'Cửa Dương, Tp. Phú Quốc, Kiên Giang, Việt Nam','20030519','thnga@gmail.com', 'F','1','2','')
,(101010,N'Phạm Thanh Bình','0898123241',N'Hàm Nghi, Thanh Khê, Đà Nẵng','20030519','phamthbinh@gmail.com', 'M','1','2','')
,(101011,N'Nguyễn Hải Chung','0993135175',N'Vị Bình, Vị Thuỷ, Hậu Giang, Việt Nam','20000519','haichug@gmail.com', 'M','1','2','')
,(101012,N'Nguyễn Hữu Tâm','0899092708',N'Phước Hoà, Phước Sơn, Quảng Nam, Việt Nam','19980402','huutam@gmail.com', 'F','1','2','')
,(101013,N'Lê Hồ Mai','0564102737',N'Trung An, Củ Chi, Thành phố Hồ Chí Minh, Việt Nam','20000519','lehomai@gmail.com', 'F','1','2','')
,(101014,N'Vũ Thị Hạnh','0994447627',N'Tôn Đức Thắng, Quận 1, TP HCM','20050723','vuthihanh@gmail.com', 'F','1','2','')
,(101015,N'Châu Ngọc Anh','0899338285',N'Hoàng Quốc Việt, Biên Hoà, Đồng Nai','19900629','chaungocanh@gmail.com', 'F','1','2','')
,(101016,N'Lê Thị Dương','0367123817',N'Quang Trung, Hai Bà Trưng, Hà Nội, Việt Nam','20010212','lethiduong@gmail.com', 'F','1','2','')
,(101017,N'Đỗ Minh Huy','0584888334',N'Tân Thịnh, Yên Bái, Việt Nam','19991218','minhuydo@gmail.com', 'M','1','2','')
,(101018,N'Nguyễn Minh Tuấn','0586308728',N'Lộc Ninh, Quảng Bình, Việt Nam','20040622','ngminhtuan@gmail.com', 'M','1','2','')
,(101019,N'Bùi Thanh Thuận','0972876331',N'Lê Thánh Tông, Hạ Long, Quảng Ninh, Việt Nam','20010301','thanhthuan@gmail.com', 'M','1','2','')
,(101020,N'Trần Thanh Hiếu','0984311009',N'Phạm Văn Đồng, TP Huế, Việt Nam','20000311','trthanhhieu@gmail.com', 'M','1','2','')


INSERT INTO ORDERS 
		   ([CUSTOMER_ID]
           ,[ORDER_DATE]
           ,[TOTAL_PRICE])
VALUES(101011,'20230630',133000),
(101015,'20221130',1400000),
(101016,'20220130',202900),
(101011,'20230430',161000),
(101011,'20211030',573000),
(101005,'20220630',29000),
(101007,'20230330',2595000),
(101017,'20220228',22114000),
(101017,'20220330',700000),
(101007,'20230228',90000),
(101008,'20230930',390000),
(101012,'20211230',452900),
(101010,'20220930',95000),
(101017,'20220130',210000),
(101018,'20230430',2490000),
(101007,'20230228',338000),
(101010,'20230630',795000),
(101013,'20230630',23661000),
(101014,'20230130',2509000),
(101001,'20230430',489000),
(101014,'20230630',296000),
(101017,'20230130',449000),
(101014,'20220930',830000),
(101007,'20221230',263000),
(101013,'20221030',2955000),
(101010,'20220930',6606000),
(101017,'20230530',1273000),
(101010,'20220830',63000),
(101005,'20230930',299100),
(101012,'20230830',95000),
(101016,'20230630',4475000),
(101012,'20220330',21800000),
(101008,'20230330',2297900),
(101020,'20230730',980300),
(101004,'20230930',2297900),
(101007,'20211230',6715000),
(101006,'20221130',450000),
(101008,'20230530',581000),
(101008,'20211030',23500000),
(101016,'20230730',1400000),
(101020,'20230228',2747000),
(101001,'20230330',619700),
(101015,'20230130',328000),
(101006,'20220830',150000),
(101018,'20221130',161000),
(101004,'20230130',17400),
(101006,'20230730',311000),
(101001,'20230130',2280000),
(101020,'20230830',150000),
(101017,'20211230',2341000)


INSERT INTO ORDER_DETAIL
			([ORDER_ID]
           ,[PRODUCT_ID]
           ,[PRICE]
           ,[AMOUNT])
VALUES(1,9,63000,1),
(1,4,70000,1),
(2,14,700000,2),
(3,18,200000,1),
(3,2,2900,1),
(4,1,161000,1),
(5,7,420000,1),
(5,3,153000,1),
(6,12,29000,1),
(7,9,63000,5),
(7,5,2280000,1),
(8,1,161000,1),
(8,15,2180000,10),
(8,13,153000,1),
(9,19,175000,4),
(10,11,15000,6),
(11,18,200000,1),
(11,12,29000,1),
(11,1,161000,1),
(12,2,2900,1),
(12,17,450000,1),
(13,8,95000,1),
(14,4,70000,3),
(15,5,2280000,1),
(15,4,70000,3),
(16,12,29000,7),
(16,11,15000,9),
(17,8,95000,1),
(17,14,700000,1),
(18,5,2280000,10),
(18,14,700000,1),
(18,1,161000,1),
(19,12,29000,1),
(19,18,200000,1),
(19,5,2280000,1),
(20,19,175000,1),
(20,1,161000,1),
(20,3,153000,1),
(21,6,120000,1),
(21,11,15000,1),
(21,1,161000,1),
(22,12,29000,1),
(22,7,420000,1),
(23,18,200000,1),
(23,4,70000,9),
(24,9,63000,1),
(24,18,200000,1),
(25,18,200000,1),
(25,10,55000,1),
(25,17,450000,6),
(26,14,700000,9),
(26,3,153000,1),
(26,13,153000,1),
(27,13,153000,1),
(27,7,420000,1),
(27,14,700000,1),
(28,9,63000,1),
(29,3,153000,1),
(29,2,2900,9),
(29,6,120000,1),
(30,8,95000,1),
(31,5,2280000,1),
(31,15,2180000,1),
(31,11,15000,1),
(32,15,2180000,10),
(33,5,2280000,1),
(33,11,15000,1),
(33,2,2900,1),
(34,2,2900,7),
(34,18,200000,2),
(34,4,70000,8),
(35,2,2900,1),
(35,11,15000,1),
(35,5,2280000,1),
(36,15,2180000,3),
(36,19,175000,1),
(37,17,450000,1),
(38,7,420000,1),
(38,1,161000,1),
(39,5,2280000,10),
(39,14,700000,1),
(40,14,700000,2),
(41,15,2180000,1),
(41,9,63000,9),
(42,1,161000,1),
(42,17,450000,1),
(42,2,2900,3),
(43,13,153000,1),
(43,19,175000,1),
(44,16,150000,1),
(45,1,161000,1),
(46,2,2900,6),
(47,1,161000,1),
(47,8,95000,1),
(47,10,55000,1),
(48,5,2280000,1),
(49,16,150000,1),
(50,15,2180000,1),
(50,1,161000,1)


INSERT INTO EVALUATION VALUES(101011,9,N'Trang sách rách hết, làm ăn gì kì vậy',2.0,'20230630')
INSERT INTO EVALUATION VALUES(101015,14,N'Sản phẩm như vậy mà cũng bán à',1.0,'20221130')
INSERT INTO EVALUATION VALUES(101016,18,N'Sách thì mắc mà đọc thì chán, chả hiểu luôn',1.0,'20220130')
INSERT INTO EVALUATION VALUES(101016,2,N'Sách tạm ổn, nội dung không hay lắm',3.0,'20220130')
INSERT INTO EVALUATION VALUES(101011,1,N'Sách thì mắc mà đọc thì chán, chả hiểu luôn',1.0,'20230430')
INSERT INTO EVALUATION VALUES(101011,7,N'Này là sách lậu à mn?',1.0,'20211030')
INSERT INTO EVALUATION VALUES(101011,3,N'Mn check link này nhận xu nhé',5.0,'20211030')
INSERT INTO EVALUATION VALUES(101005,12,N'Shop giao hàng lẹ quá, siêu ghê',4.0,'20220630')
INSERT INTO EVALUATION VALUES(101007,9,N'Cảm ơn shop nhiều nhé',5.0,'20230330')
INSERT INTO EVALUATION VALUES(101007,5,N'Trang sách rách hết, làm ăn gì kì vậy',1.0,'20230330')
INSERT INTO EVALUATION VALUES(101017,1,N'Sách thì mắc mà đọc thì chán, chả hiểu luôn',2.0,'20220228')
INSERT INTO EVALUATION VALUES(101017,15,N'Giao hàng chậm, lúc nhận sách thì thấy ổn',3.0,'20220228')
INSERT INTO EVALUATION VALUES(101017,13,N'Bìa sách khá đẹp và mới',5.0,'20220228')
INSERT INTO EVALUATION VALUES(101007,11,N'Sách dùng rất oke',4.0,'20230228')
INSERT INTO EVALUATION VALUES(101008,18,N'Mình bị ép phải review mọi người ơi',4.0,'20230930')
INSERT INTO EVALUATION VALUES(101008,12,N'Sách cũng tạm được, có nhiều lỗi nội dung',3.0,'20230930')
INSERT INTO EVALUATION VALUES(101008,1,N'Đề nghị lần sau shop gói hàng kĩ hơn!',3.0,'20230930')
INSERT INTO EVALUATION VALUES(101012,17,N'Sách quá dày đọc không hết',2.0,'20211230')
INSERT INTO EVALUATION VALUES(101010,8,N'Giao hàng nhanh, gọn lẹ',4.0,'20220930')
INSERT INTO EVALUATION VALUES(101017,4,N'Sách rất tốt và đẹp',5.0,'20220130')
INSERT INTO EVALUATION VALUES(101018,5,N'Sách rất tốt và đẹp',4.0,'20230430')
INSERT INTO EVALUATION VALUES(101018,4,N'Sách rất tốt và đẹp',5.0,'20230430')
INSERT INTO EVALUATION VALUES(101007,12,N'Nên mua nha mọi người, nhìn oke lắm',5.0,'20230228')
INSERT INTO EVALUATION VALUES(101007,11,N'Bìa sách khá đẹp và mới',5.0,'20230226')
INSERT INTO EVALUATION VALUES(101010,14,N'Giao hàng chậm, lúc nhận sách thì thấy ổn',3.0,'20230630')
INSERT INTO EVALUATION VALUES(101013,1,N'Giao hàng lề mề, sách thì xấu',1.0,'20230630')
INSERT INTO EVALUATION VALUES(101014,12,N'Sản phẩm như vậy mà cũng bán à',2.0,'20230130')
INSERT INTO EVALUATION VALUES(101014,18,N'Này là sách lậu à mn?',2.0,'20230130')
INSERT INTO EVALUATION VALUES(101014,5,N'Giao hàng quá nhanh, sách rất ổn',5.0,'20230130')
INSERT INTO EVALUATION VALUES(101001,19,N'Giao hàng quá nhanh, sách rất ổn',4.0,'20230430')
INSERT INTO EVALUATION VALUES(101001,1,N'Sản phẩm như vậy mà cũng bán à',1.0,'20230430')
INSERT INTO EVALUATION VALUES(101001,3,N'Giao hàng quá nhanh, sách rất ổn',5.0,'20230430')
INSERT INTO EVALUATION VALUES(101014,6,N'Sách rất tốt và đẹp',5.0,'20230630')
INSERT INTO EVALUATION VALUES(101014,11,N'Sản phẩm như vậy mà cũng bán à',2.0,'20230630')
INSERT INTO EVALUATION VALUES(101014,1,N'Giao hàng nhanh, gọn lẹ',4.0,'20230630')
INSERT INTO EVALUATION VALUES(101017,12,N'Bìa sách mỏng hơn nhiều so với miêu tả',3.0,'20230130')
INSERT INTO EVALUATION VALUES(101017,7,N'Sách đẹp lắm, cảm ơn shop!',4.0,'20230130')
INSERT INTO EVALUATION VALUES(101014,4,N'Cảm ơn shop nhiều nhé',5.0,'20220930')
INSERT INTO EVALUATION VALUES(101007,9,N'Mình bị ép phải review mọi người ơi',5.0,'20221230')
INSERT INTO EVALUATION VALUES(101013,18,N'Sách gì mà lỗi lắm thế',1.0,'20221030')
INSERT INTO EVALUATION VALUES(101013,10,N'Sản phẩm như vậy mà cũng bán à',1.0,'20221030')
INSERT INTO EVALUATION VALUES(101013,17,N'Sách đẹp nhưng nội dung có nhiều chỗ sai',3.0,'20221030')
INSERT INTO EVALUATION VALUES(101010,14,N'Giao hàng lề mề, sách thì xấu',1.0,'20220930')
INSERT INTO EVALUATION VALUES(101010,3,N'Đề nghị lần sau shop gói hàng kĩ hơn!',3.0,'20220930')
INSERT INTO EVALUATION VALUES(101010,13,N'Sách đẹp lắm, cảm ơn shop!',5.0,'20220930')
INSERT INTO EVALUATION VALUES(101017,13,N'Shop giao hàng lẹ quá, siêu ghê',5.0,'20230530')
INSERT INTO EVALUATION VALUES(101017,14,N'Sách đẹp nhưng nội dung có nhiều chỗ sai',3.0,'20230530')
INSERT INTO EVALUATION VALUES(101010,9,N'Giao hàng lề mề, sách thì xấu',1.0,'20220830')
INSERT INTO EVALUATION VALUES(101005,3,N'Sách đẹp nhưng nội dung có nhiều chỗ sai',3.0,'20230930')
INSERT INTO EVALUATION VALUES(101005,2,N'Giao hàng nhanh, gọn lẹ',5.0,'20230930')
INSERT INTO EVALUATION VALUES(101012,8,N'Đề nghị lần sau shop gói hàng kĩ hơn!',3.0,'20230830')
INSERT INTO EVALUATION VALUES(101016,5,N'Sách quá ổn luôn!',5.0,'20230630')
INSERT INTO EVALUATION VALUES(101016,15,N'Trang sách rách hết, làm ăn gì kì vậy',2.0,'20230630')
INSERT INTO EVALUATION VALUES(101016,11,N'Sản phẩm như vậy mà cũng bán à',1.0,'20230630')
INSERT INTO EVALUATION VALUES(101012,15,N'Sản phẩm như vậy mà cũng bán à',2.0,'20220330')
INSERT INTO EVALUATION VALUES(101008,5,N'Giao hàng lề mề, sách thì xấu',2.0,'20230330')
INSERT INTO EVALUATION VALUES(101008,11,N'Cảm ơn shop nhiều nhé',4.0,'20230330')
INSERT INTO EVALUATION VALUES(101008,2,N'Cảm ơn shop nhiều nhé',5.0,'20230330')
INSERT INTO EVALUATION VALUES(101020,2,N'Trang sách rách hết, làm ăn gì kì vậy',2.0,'20230730')
INSERT INTO EVALUATION VALUES(101020,18,N'Sách gì mà lỗi lắm thế',1.0,'20230730')
INSERT INTO EVALUATION VALUES(101020,4,N'Nội dung cực kì chất lượng',4.0,'20230730')
INSERT INTO EVALUATION VALUES(101004,11,N'Sách thì mắc mà đọc thì chán, chả hiểu luôn',1.0,'20230930')
INSERT INTO EVALUATION VALUES(101007,15,N'Sản phẩm như vậy mà cũng bán à',2.0,'20211230')
INSERT INTO EVALUATION VALUES(101006,17,N'Nên mua nha mọi người, nhìn oke lắm',5.0,'20221130')
INSERT INTO EVALUATION VALUES(101008,7,N'Bìa sách khá đẹp và mới',4.0,'20230530')
INSERT INTO EVALUATION VALUES(101008,1,N'Sách cũng tạm được, có nhiều lỗi nội dung',3.0,'20230530')
INSERT INTO EVALUATION VALUES(101008,5,N'Sách đẹp nhưng nội dung có nhiều chỗ sai',3.0,'20211030')
INSERT INTO EVALUATION VALUES(101008,14,N'Mn check link này nhận xu nhé',4.0,'20211030')
INSERT INTO EVALUATION VALUES(101020,9,N'Sách quá ổn luôn!',4.0,'20230228')
INSERT INTO EVALUATION VALUES(101001,1,N'Này là sách lậu à mn?',1.0,'20230330')
INSERT INTO EVALUATION VALUES(101001,17,N'Giao hàng nhanh, gọn lẹ',5.0,'20230330')
INSERT INTO EVALUATION VALUES(101015,19,N'Sách sai tè le mà cũng bán',1.0,'20230130')
INSERT INTO EVALUATION VALUES(101018,1,N'Đề nghị lần sau shop gói hàng kĩ hơn!',3.0,'20221130')
INSERT INTO EVALUATION VALUES(101004,2,N'Sách dùng rất oke',5.0,'20230130')
INSERT INTO EVALUATION VALUES(101006,1,N'Nội dung tạm được',3.0,'20230730')
INSERT INTO EVALUATION VALUES(101006,10,N'Sách gì mà lỗi lắm thế',1.0,'20230730')
INSERT INTO EVALUATION VALUES(101001,5,N'Nên mua nha mọi người, nhìn oke lắm',4.0,'20230130')
INSERT INTO EVALUATION VALUES(101020,16,N'Bìa sách khá đẹp và mới',4,'20230830')
INSERT INTO EVALUATION VALUES(101017,15,N'Bìa sách khá ổn, nhưng có nhiều trang bị lỗi',3.0,'20211230')
INSERT INTO EVALUATION VALUES(101017,1,N'Sách đẹp lắm, cảm ơn shop!',5,'20211230')


select * from AUTHOR
select * from CATEGORY
select * from CUSTOMER
select * from EVALUATION
select * from ORDER_DETAIL
select * from ORDERS
select * from PRODUCT
select * from PUBLISHER


