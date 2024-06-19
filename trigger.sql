
USE VINABOOK
GO


--Tìm sách theo cụm từ có trong tên sách, tác giả hoặc danh mục
CREATE FUNCTION Find_Book(@Ten NVARCHAR(100))
RETURNS @tb TABLE(
    ProName NVARCHAR(100),
    Author NVARCHAR(50),
    Category NVARCHAR(50)
)
AS
    BEGIN
        insert @tb
            select p.PRODUCT_NAME,a.AUTHOR_NAME,c.CATEGORY_NAME
            from PRODUCT p join AUTHOR a on p.AUTHOR_ID=a.AUTHOR_ID
            join CATEGORY c on p.CATEGORY_ID=c.CATEGORY_ID
            where p.PRODUCT_NAME like concat(CONCAT('%',@Ten),'%')
            or a.AUTHOR_NAME like concat(CONCAT('%',@Ten),'%')
            or c.CATEGORY_NAME like concat(CONCAT('%',@Ten),'%')
        return
    END
GO


--Ví dụ:
select * from dbo.Find_Book(N'Vẽ')
GO
---------------------------------------------------------------------


--Liệt kê đánh giá theo sản phẩm (tên khách, điểm, ngày đánh giá, nội dung)
CREATE FUNCTION LIST_EVALUATION(@PRODUCT_ID DECIMAL(16,0))
RETURNS TABLE
AS
    RETURN
    SELECT E.CUSTOMER_ID,C.CUSTOMER_NAME,E.EVA_SCORE,E.EVA_TIME,E.EVA_CONTENT
    FROM EVALUATION E JOIN CUSTOMER C ON E.CUSTOMER_ID=C.CUSTOMER_ID AND PRODUCT_ID=@PRODUCT_ID
GO




--Ví dụ:
SELECT * FROM LIST_EVALUATION(1);
GO
---------------------------------------------------------------------


--Tính Điểm đánh giá Trung Bình của 1 sản phẩm
CREATE FUNCTION AVG_EVALUATION(@PRODUCT_ID DECIMAL(16,0))
RETURNS FLOAT
AS BEGIN
    DECLARE @TB FLOAT
    SET @TB = (SELECT AVG(E.EVA_SCORE) FROM EVALUATION E JOIN CUSTOMER C ON E.CUSTOMER_ID=C.CUSTOMER_ID AND PRODUCT_ID=@PRODUCT_ID);
    RETURN @TB
END
GO


--Ví dụ:
DECLARE @TB FLOAT
SET @TB = DBO.AVG_EVALUATION(1);
PRINT N'Điểm đánh giá trung bình: ' + convert(nvarchar(10), @TB);
GO
---------------------------------------------------------------------

--Liệt kê top 3 sách bán chạy
create function BestSeller()
returns @tb table(
	PRODUCT_ID DECIMAL(16,0),
    PRODUCT_NAME NVARCHAR(100),
    AUTHOR_NAME NVARCHAR(50),
    PRICE MONEY,
    SELLING_AMOUNT INT
)
AS
    BEGIN
        INSERT @tb
        SELECT TOP 3 P.PRODUCT_ID,P.PRODUCT_NAME,A.AUTHOR_NAME,P.PRICE,O.TOTAL FROM PRODUCT P JOIN AUTHOR A ON P.AUTHOR_ID=A.AUTHOR_ID
        JOIN (SELECT PRODUCT_ID,SUM(AMOUNT) 'TOTAL' FROM ORDER_DETAIL GROUP BY PRODUCT_ID) O ON P.PRODUCT_ID=O.PRODUCT_ID
        ORDER BY O.TOTAL DESC
        RETURN ;
    END
GO


--Ví dụ
SELECT * FROM DBO.BestSeller()
GO
---------------------------------------------------------------------

--Liệt kê top 5 sách mới phát hành
create function NewBook()
returns @tb table(
    PRODUCT_NAME NVARCHAR(100),
    AUTHOR_NAME NVARCHAR(50),
    PRICE MONEY,
    PUBLIC_DAY DATE
)
AS
    BEGIN
        INSERT @tb
        SELECT TOP 5 P.PRODUCT_NAME,A.AUTHOR_NAME,P.PRICE,P.PUBLIC_DAY FROM PRODUCT P JOIN AUTHOR A ON P.AUTHOR_ID=A.AUTHOR_ID
        ORDER BY P.PUBLIC_DAY DESC
        RETURN ;
    END
GO


--Ví dụ
SELECT * FROM DBO.NewBook()
GO
---------------------------------------------------------------------

--Xoá đánh giá theo sản phẩm và khách hàng
--Yêu cầu kiểm tra khách hàng, sản phẩm, đánh giá có tồn tại
CREATE PROCEDURE DeleteEvaluation(@CustomerID DECIMAL(16,0), @ProductID DECIMAL(16,0),@Time DATETIME)
AS BEGIN
    IF NOT EXISTS (SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = @CustomerID)
        BEGIN
            PRINT N'không tìm thấy ID tài khoản này'
            RETURN
        END
    IF NOT EXISTS (SELECT * FROM PRODUCT WHERE PRODUCT_ID = @ProductID)
        BEGIN
            PRINT N'không tìm thấy ID sản phẩm này'
            RETURN
        END
    DELETE FROM EVALUATION WHERE CUSTOMER_ID = @CustomerID AND PRODUCT_ID = @ProductID AND EVA_TIME=@Time;
   
    IF @@ROWCOUNT>0
        PRINT N'Xoá đánh giá thành công'
    ELSE    
        PRINT N'Tài khoản chưa đánh giá sản phẩm'
END;


--Ví dụ
---------------------------------------------------------------------
GO

GO
---------------------------------------------------------------------

--Liệt kê chi tiết hoá đơn theo ID
CREATE FUNCTION FIND_ORDER(@ORDERID DECIMAL)
RETURNS TABLE
AS
    RETURN
    SELECT O.ORDER_ID,P.PRODUCT_ID,P.PRODUCT_NAME,O.PRICE,O.AMOUNT,O.PRICE*O.AMOUNT AS N'Tổng giá'
    FROM ORDER_DETAIL O JOIN PRODUCT P ON O.PRODUCT_ID=P.PRODUCT_ID
    WHERE ORDER_ID=@ORDERID
GO


--Ví dụ
SELECT * FROM DBO.FIND_ORDER(3)
GO
---------------------------------------------------------------------


--Liệt kê lịch sử mua hàng trong thời gian gần đây, 'd' là ngày, 'm' là tháng
--VD: 30d là 30 ngày
CREATE PROCEDURE ShowOrderHistory(@CustomerID DECIMAL(16,0), @Range VARCHAR(10))
AS BEGIN
    DECLARE @RECENT DATE
    DECLARE @VALUE INT
    SET @VALUE = CAST(LEFT(@Range, LEN(@Range)-1) AS INT)


    IF @Range LIKE '%d'
        SET @RECENT = DATEADD(DAY, -@VALUE, GETDATE())
    ELSE IF @Range LIKE '%m'
        SET @RECENT = DATEADD(month, -@VALUE, GETDATE())
    ELSE
        BEGIN
            PRINT N'Lỗi định dạng thời gian'
            RETURN
        END
   
    SELECT * FROM ORDERS WHERE CUSTOMER_ID = @CustomerID AND ORDER_DATE >= @RECENT ORDER BY ORDER_DATE DESC
END
GO


--Ví dụ
EXECUTE ShowOrderHistory 101018, '2m'
EXECUTE ShowOrderHistory 101015, '150d'
EXECUTE ShowOrderHistory 101016, '150'
---------------------------------------------------------------------
GO
--Tính doanh thu trong ngày của tất cả sản phẩm
CREATE PROCEDURE TotalRevenueInDay(@Date DATE)
AS
    BEGIN
        declare @t money = 0;
        set @t = (select sum(TOTAL_PRICE) from ORDERS where ORDER_DATE=@Date);
        if @t is null
            set @t = 0
        print N'Tổng doanh thu của ngày ('+ Cast(@Date as nvarchar(20))+N') là: '+Cast(@t as nvarchar(20));
    END
GO


--Ví dụ
DECLARE @TODAY DATE
SET @TODAY = GETDATE()
EXECUTE TotalRevenueInDay @TODAY
---------------------------------------------------------------------
GO
--Tính doanh thu trong tháng của tất cả sản phẩm
CREATE PROCEDURE TotalRevenueInMonth(@Month int, @Year int)
AS
    BEGIN
        declare @t money
        select @t=sum(TOTAL_PRICE) from ORDERS where Month(ORDER_DATE)=@Month and YEAR(ORDER_DATE)=@Year
        if @t is null
            set @t = 0
        print N'Tổng doanh thu của tháng ('+Cast(@Month as nvarchar(2))+'/'+Cast(@Year as nvarchar(4))+N') là: '+Cast(@t as nvarchar(20))
    END
GO


--Ví dụ
EXECUTE TotalRevenueInMonth 9, 2023
---------------------------------------------------------------------
GO
--Top đại gia mua sách
CREATE PROCEDURE TopBuyer
AS
    BEGIN
        select top 10 o.CUSTOMER_ID,c.CUSTOMER_NAME, sum(o.TOTAL_PRICE) AS 'TOTAL'
        from ORDERS o join CUSTOMER c on c.CUSTOMER_ID=o.CUSTOMER_ID
		where o.PAYING=1
        group by o.CUSTOMER_ID,c.CUSTOMER_NAME
        order by sum(o.TOTAL_PRICE) desc
    END
GO


--Ví dụ
EXECUTE TopBuyer
GO
---------------------------------------------------------------------


--Xem sản phẩm đã hết hàng
CREATE PROCEDURE OutOfStock
AS
    BEGIN
        select PRODUCT_ID,PRODUCT_NAME,AMOUNT from PRODUCT where AMOUNT=0
    END
GO


--Ví dụ
EXECUTE OutOfStock
GO
---------------------------------------------------------------------

--Ví dụ
---------------------------------------------------------------------


--Liệt kê doanh thu theo quý, năm
CREATE FUNCTION  RevenueInQuarter()
returns table
AS  
	return
    SELECT CAST(DATEPART(QUARTER, ORDERS.ORDER_DATE) AS VARCHAR(1))+'/'+CAST(DATEPART(YEAR, ORDERS.ORDER_DATE) AS VARCHAR(4)) AS N'Quarter',
    SUM(TOTAL_PRICE) AS N'Total' FROM ORDERS GROUP BY DATEPART(QUARTER, ORDERS.ORDER_DATE), DATEPART(YEAR, ORDERS.ORDER_DATE) 


GO
select * from RevenueInQuarter()
--Ví dụ
---------------------------------------------------------------------
GO
--Chỉ cho phép Insert nếu giới tính là ‘F’ hoặc ‘M’
CREATE TRIGGER TR_INSERT_SEX
ON CUSTOMER
FOR INSERT
AS
    BEGIN
    DECLARE @GioiTinh CHAR(2)
    SET @GioiTinh = (SELECT INS.SEX FROM inserted INS)
    IF (@GioiTinh != 'F' AND @GioiTinh != 'M')
        BEGIN
            RAISERROR(N'Giới tính không hợp lệ',16,1)
            ROLLBACK
        END
    END
GO


--Ví dụ
INSERT INTO CUSTOMER VALUES(101000,N'Phúc Đại Gia','08999999',N'Việt Nam','20000519','abc@gmail.com', '?','1','1','','')
---------------------------------------------------------------------
GO
--Chỉ cho phép Insert nếu Customer từ 12 tuổi trở lên
CREATE TRIGGER TR_INSERT_AGE
ON CUSTOMER
FOR INSERT
AS
    BEGIN
    DECLARE @TUOI INT
    SET @TUOI = YEAR(GETDATE())-(select Year(inserted.BIRTHDAY) FROM inserted)
    IF (@TUOI < 12)
        BEGIN
        RAISERROR (N'NGƯỜI DÙNG PHẢI TRÊN 12 TUỔI', 16,1)
        ROLLBACK TRANSACTION
        END
    END
GO


--Ví dụ
INSERT INTO CUSTOMER VALUES(101000,N'Phúc Đại Gia','08999999',N'Việt Nam','20220519','abc@gmail.com', 'M','1','1','','')
---------------------------------------------------------------------
GO
--Tự động cập nhật tổng tiền khi chi tiết đơn hàng được tạo hoặc cập nhật
CREATE TRIGGER TR_TongTien
ON ORDER_DETAIL
FOR INSERT, UPDATE
AS
    BEGIN
    UPDATE ORDER_DETAIL SET PRICE = PRODUCT.PRICE
    FROM ORDER_DETAIL, PRODUCT, inserted
    WHERE PRODUCT.PRODUCT_ID = ORDER_DETAIL.PRODUCT_ID
    AND ORDER_DETAIL.PRODUCT_ID = inserted.PRODUCT_ID
    AND ORDER_DETAIL.ORDER_ID = inserted. ORDER_ID
    UPDATE ORDERS SET TOTAL_PRICE = (
        SELECT SUM(ORDER_DETAIL.PRICE*inserted.AMOUNT) FROM ORDER_DETAIL, inserted
        WHERE ORDER_DETAIL.ORDER_ID = inserted.ORDER_ID
        GROUP BY ORDER_DETAIL.ORDER_ID)
    FROM ORDERS, inserted
    WHERE ORDERS.ORDER_ID = inserted. ORDER_ID
    END
GO
---------------------------------------------------------------------

--Cập nhật hàng tồn khi có khách mua hàng
CREATE TRIGGER TR_InsertOrderAmount
ON ORDER_DETAIL
FOR INSERT
AS
    BEGIN
    UPDATE PRODUCT
    SET PRODUCT.AMOUNT = PRODUCT.AMOUNT - (
        SELECT AMOUNT
        FROM inserted
        WHERE inserted.PRODUCT_ID=PRODUCT.PRODUCT_ID)
    FROM PRODUCT,inserted
    WHERE PRODUCT.PRODUCT_ID=inserted.PRODUCT_ID
    END
GO
---------------------------------------------------------------------


--Cập nhật hàng tồn khi thêm, bớt chi tiết hoá đơn
CREATE TRIGGER TR_UpdateOrderAmount
ON ORDER_DETAIL
FOR UPDATE
AS
    BEGIN
    UPDATE PRODUCT SET PRODUCT.AMOUNT=PRODUCT.AMOUNT-
        (SELECT AMOUNT FROM inserted WHERE inserted.PRODUCT_ID = PRODUCT.PRODUCT_ID)+
        (SELECT AMOUNT FROM deleted WHERE deleted.PRODUCT_ID = PRODUCT.PRODUCT_ID)
    FROM PRODUCT
    JOIN deleted ON PRODUCT.PRODUCT_ID= deleted.PRODUCT_ID
    END
GO
---------------------------------------------------------------------


--Cập nhật hàng tồn khi huỷ hoá đơn
CREATE TRIGGER TR_CancelOrder_Amount
ON ORDER_DETAIL
FOR DELETE
AS
    BEGIN
    UPDATE PRODUCT
    SET AMOUNT=PRODUCT.AMOUNT +
    (SELECT AMOUNT FROM deleted WHERE deleted.PRODUCT_ID = PRODUCT.PRODUCT_ID)
    FROM PRODUCT
    JOIN deleted ON PRODUCT.PRODUCT_ID = deleted.PRODUCT_ID
    UPDATE ORDERS
    SET TOTAL_PRICE= TOTAL_PRICE-
    (SELECT PRICE*AMOUNT FROM deleted WHERE deleted.ORDER_ID = ORDERS.ORDER_ID)
    FROM ORDERS
   
 JOIN deleted ON ORDERS.ORDER_ID = deleted.ORDER_ID
    END
GO---------------------------------------------------------------------


--Không cho xoá bảng Publisher và Author
CREATE TRIGGER TR_NOT_ALLOWED_P
ON PUBLISHER
AFTER DELETE
AS
BEGIN
    RAISERROR ('KHÔNG ĐƯỢC XÓA CÁC CỘT TRONG BẢNG NÀY', 16, 1)
    ROLLBACK TRANSACTION
END
go


CREATE TRIGGER TR_NOT_ALLOWED_A
ON Author
AFTER DELETE
AS
BEGIN
    RAISERROR ('KHÔNG ĐƯỢC XÓA CÁC CỘT TRONG BẢNG NÀY', 16, 1)
    ROLLBACK TRANSACTION
END
---------------------------------------------------------------------

--KIỂM TRA SỐ LƯỢNG TỒN KHO VÀ SỐ LƯỢNG ORDER
--NẾU SỐ LƯỢNG ORDER > SỐ LƯỢNG TỒN KHO -> HỦY
go
CREATE TRIGGER TR_CHECK_AMOUNT
ON ORDER_DETAIL
FOR INSERT, update
AS
BEGIN
    DECLARE @ORDER_AMOUNT INT, @PRO_ID INT, @STOCK INT;
    SELECT @ORDER_AMOUNT = AMOUNT, @PRO_ID = PRODUCT_ID FROM inserted;
    SELECT @STOCK = AMOUNT + @ORDER_AMOUNT FROM PRODUCT WHERE PRODUCT_ID = @PRO_ID;


    IF (@ORDER_AMOUNT <= @STOCK)
    BEGIN
        UPDATE PRODUCT
        SET AMOUNT = @STOCK - @ORDER_AMOUNT
        WHERE PRODUCT_ID = @PRO_ID;
    END
    ELSE
    BEGIN
        RAISERROR (N'SỐ LƯỢNG ORDER LỚN HƠN STOCK', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
   
END
GO
create procedure deleteOrder(@id decimal(16,0))
as 
begin
	delete from ORDER_DETAIL where ORDER_ID=@id
	delete from ORDERS where ORDER_ID=@id and PAYING=0
end
go

execute deleteOrder 53;

select * from PRODUCT
Insert ORDER_DETAIL values (15,3,120000.00,9,0)
update ORDER_DETAIL set AMOUNT=22 where PRODUCT_ID=15 and ORDER_ID=3
delete ORDER_DETAIL where PRODUCT_ID=3 and ORDER_ID=15






