CREATE DATABASE TH5
GO
USE TH5
GO
CREATE TABLE KHACHHANG
(
	MAKH CHAR(10) PRIMARY KEY,
	TENKH NVARCHAR(20)
);
INSERT INTO dbo.KHACHHANG
(
    MAKH,
    TENKH
)
VALUES
('KH01',N'Nguyễn An'),
('KH02',N'Lê Bình'),
('KH03',N'Đào Tú');
GO
CREATE TABLE NHANVIEN
(
	MANV CHAR(10) PRIMARY KEY,
	TENNV NVARCHAR(20),
	HESOTT FLOAT
);
INSERT INTO dbo.NHANVIEN
(
    MANV,
    TENNV,
    HESOTT
)
VALUES
('NV01',N'Lý Thuý',0.25),
('NV02',N'Minh Hoa',0.35);
GO
CREATE TABLE HOADON
(
	MAHD CHAR(10) PRIMARY KEY,
	NGAY DATE,
	MAKH CHAR(10) FOREIGN KEY REFERENCES dbo.KHACHHANG(MAKH),
	MANV CHAR(10) FOREIGN KEY REFERENCES dbo.NHANVIEN(MANV),
	TONGTIEN INT,
	TRANGTHAI NVARCHAR(20)
);

INSERT INTO dbo.HOADON
(
    MAHD,
    NGAY,
    MAKH,
    MANV,
    TONGTIEN,
    TRANGTHAI
)
VALUES
('HD01','2022/9/26','KH01','NV01',10000,N'Đã giao'),
('HD02','2022/9/20','KH02','NV01',5000,N'Chưa giao'),
('HD03','2022/9/15','KH03','NV01',4000,N'Đã giao'),
('HD04','2022/9/10','KH01','NV02',15000,N'Chưa giao'),
('HD05','2022/9/5','KH02','NV02',2000,N'Đã giao');

--1. Đặt biến để lưu các thông tin khách hàng như sau.
--1.1. Biến @makh để lưu Mã khách hàng của khách hàng tên là Nguyễn An.
DECLARE  @makh CHAR(10);
SELECT @makh=MAKH
FROM dbo.KHACHHANG
WHERE TENKH=N'Nguyễn An'
PRINT N'câu 1.1: '
PRINT @makh
-----------------------------------------------------------
--viết thủ tục
alter proc sp_makhachhang @ten nvarchar(10), @makh char(10) out
as
	if exists (SELECT * FROM KHACHHANG WHERE TENKH=@ten)
	begin
		SELECT @makh=MAKH
		FROM KHACHHANG
		WHERE TENKH=@ten
		return 1
	end	
	else
		return 2
-----------------------------------------------------------
--thực thi thủ tục
DECLARE  @makh CHAR(10), @tenkh nvarchar(10), @kq int
set @tenkh =N'Nguyễn An'
exec @kq = sp_makhachhang @tenkh, @makh out
if @kq = 1
	print N'Khách hàng có tên là: '+@tenkh+', có mã khách hàng là: '+@makh
else
	print N'Không có khách hàng tên là: '+@tenkh 
-----------------------------------------------------------
--1.2. Biến @hd11 để lưu thông tin mã hóa đơn của khách hàng có mã là @makh mua hàng ngày 26/9 /2022 
DECLARE  @hd11 CHAR(10), @makh char(10);
SELECT @hd11=MAHD
FROM dbo.HOADON
WHERE MAKH=@makh AND NGAY='2022/9/26'
PRINT N'câu 1.2: '
PRINT @hd11
---------------------------------------------------------------
--viết thủ tục
create proc sp_mahd @makh char(10), @ngay date, @hd11 char(10) out
as
	if exists (SELECT * FROM HOADON WHERE MAKH=@makh and NGAY=@ngay)
	begin
		SELECT @hd11=MAHD
		FROM HOADON
		WHERE MAKH=@makh and NGAY=@ngay
		return 1
	end	
	else
		return 2
---------------------------------------------------------------
--thực thi thủ tục
DECLARE  @makh CHAR(10), @ngay date, @hd11 char(10), @kq int;
set @ngay='2022/9/26'
set @makh='KH01'
exec @kq = sp_mahd @makh,@ngay, @hd11 out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+', có mã hd là: '+@hd11 + 'Mua vao ngay: '+Cast(@ngay as nvarchar(15))
else
	print N'Không có khách hàng : '+@makh 
---------------------------------------------------------------
--1.3. Biến @tt11 để lưu thông tin tổng tiền của khách hàng có mã là @makh mua hàng ngày 26/9 /2022 
DECLARE  @tt11 INT;
SELECT @tt11=TONGTIEN
FROM dbo.HOADON
WHERE MAKH=@makh AND NGAY='2022/9/26'
PRINT N'câu 1.3: '
PRINT @tt11

----viet thu tuc
create proc sp_tongtien @makh char(10), @ngay date, @tt11 int out
as
	if exists (SELECT * FROM HOADON WHERE MAKH=@makh and NGAY=@ngay)
	begin
		SELECT @tt11=TONGTIEN
		FROM HOADON
		WHERE MAKH=@makh and NGAY=@ngay
		return 1
	end	
	else
		return 2

---thuc thi thu tuc
DECLARE  @makh CHAR(10), @ngay date, @tt11 int, @kq int;
set @ngay='2022/9/26'
set @makh='KH01'
exec @kq = sp_tongtien @makh, @ngay, @tt11 out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+ 'Mua vao ngay: '+Cast(@ngay as nvarchar(15)) + N' Co tong tien la: '+cast(@tt11 as nvarchar(20))
else
	print N'Không có khách hàng : '+@makh 
--1.4. Biến @hd12 để lưu thông tin mã hóa đơn của khách hàng có mã là @makh mua hàng ngày 10/9 /2022 
DECLARE  @hd12 CHAR(10);
SELECT @hd12=MAHD
FROM dbo.HOADON
WHERE MAKH=@makh AND NGAY='2022/9/10'
PRINT N'câu 1.4: '
PRINT @hd12

----viet thu tuc
alter proc sp_mahd2 @makh char(10), @ngay date, @hd12 char(10) out
as
	if exists (SELECT * FROM HOADON WHERE MAKH=@makh and NGAY=@ngay)
	begin
		SELECT @hd12=MAHD
		FROM HOADON
		WHERE MAKH=@makh and NGAY=@ngay
		return 1
	end	
	else
		return 2

---thuc thi thu tuc
DECLARE  @makh CHAR(10), @ngay date, @hd12 char(10), @kq int;
set @ngay='2022/9/10'
set @makh='KH01'
exec @kq = sp_mahd2 @makh, @ngay, @hd12 out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+ 'Mua vao ngay: '+Cast(@ngay as nvarchar(15)) + N' Co ma hoa don la: '+@hd12
else
	print N'Không có khách hàng : '+@makh 
--1.5. Biến @tt12 để lưu thông tin tổng tiền của khách hàng có mã là @makh mua hàng ngày 10/9 /2022 
DECLARE  @tt12 INT;
SELECT @tt12=TONGTIEN
FROM dbo.HOADON
WHERE MAKH=@makh AND NGAY='2022/9/10'
PRINT N'câu 1.5: '
PRINT @tt12

----viet thu tuc
create proc sp_tongtien2 @makh char(10), @ngay date, @tt12 int out
as
	if exists (SELECT * FROM HOADON WHERE MAKH=@makh and NGAY=@ngay)
	begin
		SELECT @tt12=TONGTIEN
		FROM HOADON
		WHERE MAKH=@makh and NGAY=@ngay
		return 1
	end	
	else
		return 2

---thuc thi thu tuc
DECLARE  @makh CHAR(10), @ngay date, @tt12 int, @kq int;
set @ngay='2022/9/10'
set @makh='KH01'
exec @kq = sp_tongtien2 @makh, @ngay, @tt12 out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+ 'Mua vao ngay: '+Cast(@ngay as nvarchar(15)) + N' Co tong tien la: '+cast(@tt12 as nvarchar(20))
else
	print N'Không có khách hàng : '+@makh 
--1.6. Tính tổng số tiền của hàng của khách hàng có mã khách hàng là @makh và lưu vào biến @tongtienMH.
DECLARE  @tongtienMH INT;
SELECT @tongtienMH=SUM(TONGTIEN)
FROM dbo.HOADON
WHERE MAKH=@makh
PRINT N'câu 1.6: '
PRINT @tongtienMH

----viet thu tuc
create proc sp_tongtienMH @makh char(10), @tongtinMH int out
as
	if exists (SELECT * FROM HOADON WHERE MAKH=@makh)
	begin
		SELECT @tongtinMH=Sum(TONGTIEN)
		FROM HOADON 
		WHERE MAKH=@makh 
		return 1
	end	
	else
		return 2

---thuc thi thu tuc
DECLARE  @makh CHAR(10), @tongtienMH int, @kq int;
set @makh='KH01'
exec @kq = sp_tongtienMH @makh, @tongtienMH out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+  N' Co tong tien mat hang la: '+cast(@tongtienMH as nvarchar(20))
else
	print N'Không có khách hàng : '+@makh 
--1.7. Nếu tổng tiền mua hàng của khách hàng @makh trên 8000 thì lưu trạng thái khách hàng là ‘VIP’ vào biến @lk ngược lại thì nhận giá trị ‘BT’ .
DECLARE  @lk CHAR(10);
IF @tongtienMH >8000
	SET @lk='VIP'
ELSE
	SET @lk='BT'
PRINT N'câu 1.7: '
PRINT @lk

---viet thu tuc

create proc sp_trangthai @makh char(10), @tongtienMH int,@lk nvarchar(3) out
as
	if exists (SELECT * FROM HOADON WHERE MAKH=@makh)
	begin
		
		SELECT @lk=TRANGTHAI, @tongtienMH=TONGTIEN
		FROM HOADON 
		WHERE MAKH=@makh
		if @tongtienMH>8000
			SET @lk='VIP'
		else 
			SET @lk='BT'
		return 1
	end	
	else
		return 2

DECLARE  @makh CHAR(10), @tongtienMH int,@lk nvarchar(3), @kq int;
set @makh='KH02'
select @tongtienMH=Sum(TONGTIEN)
from HOADON
where MAKH=@makh
exec @kq = sp_trangthai @makh, @tongtienMH, @lk out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+  N' Co tong tien mat hang la: '+cast(@tongtienMH as nvarchar(20)) + N' Co trang thai la: ' +@lk
else
	print N'Không có khách hàng : '+@makh 
--1.8. Tạo cột Loại Khách hàng trong bảng lưu thông tin khách hàng và cập nhật lại loại khách hàng đã lưu trong biến @lk cho khách hàng có mã lưu trong biến @makh .
--ALTER TABLE dbo.KHACHHANG
--ADD LOAIKHACH CHAR(10);
UPDATE dbo.KHACHHANG
SET LOAIKHACH=@lk
WHERE MAKH=@makh

Alter table KHACHHANG
ADD LOAIKHACHHANG nvarchar(10)

create proc SP_CAPNHAT_LOAIKHACH @makh char(10)
as
begin
		declare @lk char(10), @kq int
		exec @kq = sp_trangthai @makh, @lk out
		if @kq = 1
		begin
			update KHACHHANG
			set LOAIKHACHHANG = @lk
			where MAKH = @makh
		end
		return @kq
end
-------------Thực thi thủ tục----------------------
declare @makh char(10), @kq int
set @makh = 'KH01'
exec @kq = SP_CAPNHAT_LOAIKHACH @makh
if @kq = 1 
	print N'Cập nhật thành công'
else 
	print N'Cập nhật thất bại'

--1.9. Tạo biến @soVC để lưu số lượng voucher mà khách hàng sẽ được nhận.Kiểm tra nếu ngày mua hàng của khách hàng từ ngày 9/9/2022 đến ngày 20/9/2022 thì khách hàng sẽ nhận được 1 voucher giảm giá 100. 
DECLARE @soVC INT,@Ngaymua DATE;

SET @soVC=0;
SELECT @Ngaymua=NGAY
FROM dbo.HOADON

IF (@Ngaymua >= '2022/9/9' AND @Ngaymua <= '2022/9/20')
	SET @soVC=@soVC+1

PRINT N'câu 1.9: '
PRINT @soVC

---viet thu tuc
alter proc sp_voucher @ngaybd date, @ngaykt date, @soVC int out
as
	if exists(select* from HOADON where NGAY between  @ngaybd and @ngaykt)
	begin
		IF (@ngaybd >= '2022/9/9' AND @ngaykt <= '2022/9/20')
			SET @soVC=@soVC+1
		return 1
		
	end	
	else
		return 2
---thuc thi thu tuc
declare @ngaybd date, @ngaykt date,@soVC int, @kq int
set @ngayBD = '2022/9/9' 
set @ngayKT = '2022/9/20'
exec @kq = sp_voucher @ngayBD, @ngayKT, @soVC out
print 'Số voucher là : '+cast(@soVC as varchar(10))
--1.10. Tạo biến @nmh11 để lưu ngày mua hàng của khách hàng @makh với mã hóa đơn là @hd11.
---viet thu tuc
create proc sp_ngaymua  @makh char(10), @hd11 char(10) , @ngaymuahang date out
as
	if exists(select *from HOADON where MAHD=@hd11 AND MAKH=@makh)
	begin
		SELECT @ngaymuahang=NGAY
		FROM HOADON 
		WHERE MAKH=@makh and MAHD=@hd11
		return 1
		
	end	
	else
		return 2
---thuc thi thu tuc
DECLARE  @ngaymuahang date, @hd11 char(10), @makh char(10), @kq int
set @makh='KH01'
select @hd11=MAHD
from HOADON
where MAKH=@makh
exec @kq = sp_ngaymua @makh, @hd11, @ngaymuahang out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+  N' Co ma hoa don la: '+@hd11 + ' co ngay mua hang la: ' + cast(@ngaymuahang as nvarchar(15))
else
	print N'Không có khách hàng : '+@makh 
--1.11. Tạo biến @nmh12 để lưu ngày mua hàng của khách hàng @makh với mã hóa đơn là @hd12.
DECLARE  @nmh12 DATE;
SELECT @nmh12=NGAY
FROM dbo.HOADON
WHERE MAKH=@makh AND MAHD=@hd12
PRINT N'câu 1.11: '
PRINT @nmh12

---viet thu tuc
create proc sp_ngaymua2  @makh char(10), @hd12 char(10) , @nmh12 date out
as
	if exists(select *from HOADON where MAHD=@hd12 AND MAKH=@makh)
	begin
		SELECT @nmh12=NGAY
		FROM HOADON 
		WHERE MAKH=@makh and MAHD=@hd12
		return 1
		
	end	
	else
		return 2
---thuc thi thu tuc
DECLARE  @nmh12 date, @hd12 char(10), @makh char(10), @kq int
set @makh='KH02'
select @hd12=MAHD
from HOADON
where MAKH=@makh
exec @kq = sp_ngaymua @makh, @hd12, @nmh12 out
if @kq = 1
	print N'Khách hàng có ma là: '+@makh+  N' Co ma hoa don la: '+@hd12 + ' co ngay mua hang la: ' + cast(@nmh12 as nvarchar(15))
else
	print N'Không có khách hàng : '+@makh 
--1.12. Kiểm tra xem với quy định hiện tại thì khách hàng @makh nhận được bao nhiêu voucher dựa trên biến @nmh11 và @nmh12 sau đó lưu kết quả vào biến @soVC. 
SET @Ngaymua=@nmh11
IF (@Ngaymua >= '2022/9/9' AND @Ngaymua <= '2022/9/20')
	SET @soVC=@soVC+1
SET @Ngaymua=@nmh12
IF (@Ngaymua >= '2022/9/9' AND @Ngaymua <= '2022/9/20')
	SET @soVC=@soVC+1
PRINT N'câu 1.12: '
PRINT @soVC
--1.13. Tạo cột Số Voucher kế bên cột Loại khách hàng và cập nhật số voucher cho khách hàng có mã @makh với số lượng voucher lưu trong biến @soVC. Lưu ý rằng mỗi khách hàng chỉ có tối đa 5 voucher.
ALTER TABLE dbo.KHACHHANG
ADD Sovoucher INT;
IF (@soVC<=5)	
	UPDATE dbo.KHACHHANG
	SET Sovoucher=@soVC
	WHERE MAKH=@makh
--1.14. Tạo cột số Tiền Voucher kế bên cột Số Voucher và cập nhật số tiền giảm giá cho khách hàng có mã @makh. Lưu ý rằng : nếu Loại KH là ‘VIP’ thì giá trị voucher tăng 50%.
ALTER TABLE dbo.KHACHHANG
ADD Tienvoucher INT;
DECLARE @Tiengiam INT;
SET @Tiengiam=100*@soVC;
IF (@lk='VIP')
	SET @Tiengiam=@Tiengiam+@Tiengiam*0.5;
	UPDATE dbo.KHACHHANG
	SET Tienvoucher=@Tiengiam
	WHERE MAKH=@makh
PRINT N'câu 1.14: '
PRINT @Tiengiam
GO
SELECT * FROM dbo.KHACHHANG
--1.15. Đặt biến tương tự và cập nhật thông tin Loại Khách hàng, Số Voucher, Tiền Voucher cho những khách hàng còn lại.
DECLARE @Stt CHAR(10);
DECLARE	cr_update  CURSOR 
SCROLL
FOR	SELECT  MAKH  FROM	dbo.KHACHHANG

OPEN cr_update

FETCH FIRST FROM cr_update INTO @Stt

PRINT @Stt
DECLARE @tongtienMH INT,@lk CHAR(10),@soVC INT,@Ngaymua DATE, @Tiengiam INT;
	
WHILE @@FETCH_STATUS=0
BEGIN
	SET @soVC=0;
	--Loại khách hàng
	SELECT @tongtienMH=SUM(TONGTIEN)
	FROM dbo.HOADON
	WHERE MAKH=@Stt


	IF @tongtienMH >8000
		SET @lk='VIP'
	ELSE
		SET @lk='BT'

	UPDATE dbo.KHACHHANG
	SET LOAIKHACH=@lk
	WHERE MAKH=@Stt
	--Số voucher
	SELECT @Ngaymua=NGAY
	FROM dbo.HOADON
	WHERE MAKH=@Stt AND NGAY >= '2022/9/9' AND NGAY <= '2022/9/20'

	SET @soVC=COUNT(@Ngaymua)

	IF (COUNT(@Ngaymua)<=5)	
		UPDATE dbo.KHACHHANG
		SET Sovoucher=@soVC
		WHERE MAKH=@Stt
	IF (COUNT(@Ngaymua)>5)	
		UPDATE dbo.KHACHHANG
		SET Sovoucher=5
		WHERE MAKH=@Stt
	--Tiền voucher
	SET @Tiengiam=100*@soVC;
	IF (@lk='VIP')
		SET @Tiengiam=@Tiengiam+@Tiengiam*0.5;
		UPDATE dbo.KHACHHANG
		SET Tienvoucher=@Tiengiam
	WHERE MAKH=@Stt
	FETCH NEXT FROM cr_update INTO @Stt
END


CLOSE cr_update
DEALLOCATE cr_update

SELECT * FROM dbo.KHACHHANG
--2. Đặt biến để lưu các thông tin nhân viên như sau.
--2.1. Đặt biến @manv để lưu mã của nhân viên là ‘NV01’.
DECLARE @manv CHAR(10);
SELECT @manv=MANV
FROM dbo.NHANVIEN
WHERE MANV='NV01'
PRINT N'câu 2.1: '
PRINT @manv
--2.2. Đặt biến @ttb để lưu thông tin tổng số tiền bán hàng của nhân viên có mã là @manv. Lưu ý chỉ tính những đơn hàng Đã Giao.
DECLARE @ttb INT;
SELECT @ttb=SUM(TONGTIEN)
FROM dbo.HOADON
WHERE TRANGTHAI=N'Đã giao' AND MANV=@manv
PRINT N'câu 2.2: '
PRINT @ttb
--2.3. Đặt biến @dgh để lưu số lượng đơn hàng đã giao của nhân viên có mã là @manv.
DECLARE @dgh INT;
SELECT @dgh=COUNT(TRANGTHAI)
FROM dbo.HOADON
WHERE TRANGTHAI=N'Đã giao' AND MANV=@manv
PRINT N'câu 2.3: '
PRINT @dgh
--2.4. Thêm Cột Lương kết bên cột Hệ số TT trong bảng thông tin nhân viên, tính lương nhân viên có mã là @manv bằng công thức:
-- Nếu @ttb < 15000 và @dgh <= 2 thì Lương = @ttb * Hệ số TT.
-- Nếu @ttb >= 15000 và @dgh < 2 thì Lương = @ttb * Hệ số TT+300.
-- Nếu @ttb >= 15000 và @dgh > 2 thì Lương = @ttb * Hệ số TT+500.--ALTER TABLE dbo.NHANVIEN
--ADD Luong REAL;
IF (@ttb<15000 AND @dgh <=2)
	UPDATE dbo.NHANVIEN
	SET Luong=@ttb*HESOTT
	WHERE MANV=@manv
IF (@ttb>=15000 AND @dgh <2)
	UPDATE dbo.NHANVIEN
	SET Luong=@ttb*HESOTT+300
	WHERE MANV=@manv
IF (@ttb>=15000 AND @dgh >2)
	UPDATE dbo.NHANVIEN
	SET Luong=@ttb*HESOTT+500
	WHERE MANV=@manv
--2.5. Đặt biến @SoVCB để lưu thông tin về số voucher mà nhân viên @manv đã trao cho khách hàng biết rằng cứ mỗi hóa đơn bán trong thời gian từ ngày 9/9/2022 đến ngày 20/9/2022 thì nhân viên sẽ trao 1 voucher cho khách hàng.
DECLARE @SoVCB INT;
SELECT @SoVCB=COUNT(NGAY)
FROM dbo.HOADON
WHERE MANV=@manv AND NGAY >= '2022/9/9' AND NGAY <= '2022/9/20'
PRINT N'câu 2.5: '
PRINT @SoVCB
--2.6. Kiểm tra @SoVCB nếu nhỏ hơn hoặc bằng 30 thì giữ nguyên còn lớn hơn thì gán lại bằng 30.
IF (@SoVCB >=30)
	SET @SoVCB=30
PRINT N'câu 2.6: '
PRINT @SoVCB
--2.7. Đặt biến @SHDVC lưu số hóa đơn mà nhân viên @manv bán từ ngày 9/9/2022 đến ngày 20/9/2022.
DECLARE @SHDVC INT;
SELECT @SHDVC=COUNT(NGAY)
FROM dbo.HOADON
WHERE MANV=@manv AND NGAY >= '2022/9/9' AND NGAY <= '2022/9/20'
PRINT N'câu 2.7: '
PRINT @SHDVC
---viet thu tuc
create proc SP_SOHDNV @manv char(10), @SHDVC int out
as 
begin 
		declare @ngayBD date, @ngayKT date
		set @ngayBD = '2022/9/9' 
		set @ngayKT = '2022/9/20'
		exec SP_VOUCHERBAN @manv ,@ngayBD, @ngayKT, @SHDVC out
end
---thu thi thu tuc
declare @manv char(10), @SHDVC int
exec SP_SOHDNV @manv, @SHDVC out
print 'Số hoá đơn là : '+cast(@SHDVC as varchar(10))
--2.8. Dựa vào biến @SHDVC và @SoVCB để kiểm tra nếu nhân viên @manv có bán hàng từ ngày 9/9/2022 đến ngày 20/9/2022 và đã phát từ 2 voucher trở lên thì lưu biến @ChiTieu là “Hoàn thành chỉ tiêu”.
DECLARE @ChiTieu NVARCHAR(20);
IF (@SHDVC>=2 AND @SoVCB >=2)
	SET @ChiTieu=N'Hoàn thành chỉ tiêu'
PRINT N'câu 2.8: '
PRINT @ChiTieu
--2.9. Tạo cột Chỉ tiêu bên cạnh cột lương và cập nhật chỉ tiêu cho nhân viên có mã là @manv.
--ALTER TABLE dbo.NHANVIEN
--ADD Chitieu NVARCHAR(20);
UPDATE dbo.NHANVIEN
SET Chitieu=@ChiTieu
WHERE MANV=@manv
go
--2.10. Tạo cột Thưởng bên cạnh cột Chỉ tiêu và cập nhật cột thưởng cho nhân viên @manv như sau:
--- Nếu nhân viên “Hoàn thành chỉ tiêu” và Lương <=1000, thì thưởng bằng 10% lương.
--- Nếu nhân viên “Hoàn thành chỉ tiêu” và Lương >=1000, thì thưởng bằng 15% lương.
--- Nếu nhân viên không hoàn thành chỉ tiêu thì không có thưởng.
--ALTER TABLE dbo.NHANVIEN
--ADD Thuong INT;DECLARE @Chitieu NVARCHAR(20),@Luong INT,@manv CHAR(10);SELECT @Chitieu=ChitieuFROM dbo.NHANVIENWHERE MANV='NV01'SELECT @Luong=LuongFROM dbo.NHANVIENWHERE MANV='NV01'SET @manv='NV01';IF (@Chitieu=N'Hoàn thành chỉ tiêu' AND @Luong <=1000)	UPDATE dbo.NHANVIEN	SET Thuong=Luong*0.1	WHERE MANV=@manvIF (@Chitieu=N'Hoàn thành chỉ tiêu' AND @Luong >=1000)	UPDATE dbo.NHANVIEN	SET Thuong=Luong*0.15	WHERE MANV=@manvIF (@Chitieu!=N'Hoàn thành chỉ tiêu')	UPDATE dbo.NHANVIEN	SET Thuong=0	WHERE MANV=@manvgo--2.11.Đặt biến tương tự để cập nhật thông tin cho nhân viên NV02.DECLARE @STT CHAR(10);
DECLARE	cr_update  CURSOR 
SCROLL
FOR	SELECT  MANV  FROM	dbo.NHANVIEN

OPEN cr_update

FETCH FIRST FROM cr_update INTO @Stt

PRINT @Stt
DECLARE @ttb INT,@dgh INT,@SoVCB INT,@SHDVC INT,@ChiTieu NVARCHAR(20),@Luong INT;
	
WHILE @@FETCH_STATUS=0
BEGIN
	SELECT @ttb=SUM(TONGTIEN)
	FROM dbo.HOADON
	WHERE TRANGTHAI=N'Đã giao' AND MANV=@Stt

	SELECT @dgh=COUNT(TRANGTHAI)
	FROM dbo.HOADON
	WHERE TRANGTHAI=N'Đã giao' AND MANV=@Stt

	IF (@ttb<15000 AND @dgh <=2)
		UPDATE dbo.NHANVIEN
		SET Luong=@ttb*HESOTT
		WHERE MANV=@Stt
	IF (@ttb>=15000 AND @dgh <2)
		UPDATE dbo.NHANVIEN
		SET Luong=@ttb*HESOTT+300
		WHERE MANV=@Stt
	IF (@ttb>=15000 AND @dgh >2)
		UPDATE dbo.NHANVIEN
		SET Luong=@ttb*HESOTT+500
		WHERE MANV=@Stt
	--Chỉ tiêu
	SELECT @SoVCB=COUNT(NGAY)
	FROM dbo.HOADON
	WHERE MANV=@Stt AND NGAY >= '2022/9/9' AND NGAY <= '2022/9/20'
	
	IF (@SoVCB >=30)
		SET @SoVCB=30

	SELECT @SHDVC=COUNT(NGAY)
	FROM dbo.HOADON
	WHERE MANV=@Stt AND NGAY >= '2022/9/9' AND NGAY <= '2022/9/20'

	IF (@SHDVC>=2 AND @SoVCB >=2)
		SET @ChiTieu=N'Hoàn thành chỉ tiêu'

	UPDATE dbo.NHANVIEN
	SET Chitieu=@ChiTieu
	WHERE MANV=@Stt
	--Thưởng
	SELECT @Luong=Luong	FROM dbo.NHANVIEN	WHERE MANV=@Stt
	IF (@Chitieu=N'Hoàn thành chỉ tiêu' AND @Luong <=1000)		UPDATE dbo.NHANVIEN		SET Thuong=Luong*0.1		WHERE MANV=@Stt	IF (@Chitieu=N'Hoàn thành chỉ tiêu' AND @Luong >=1000)		UPDATE dbo.NHANVIEN		SET Thuong=Luong*0.15		WHERE MANV=@Stt	IF (@Chitieu!=N'Hoàn thành chỉ tiêu')		UPDATE dbo.NHANVIEN		SET Thuong=0		WHERE MANV=@Stt
	FETCH NEXT FROM cr_update INTO @Stt
END

CLOSE cr_update
DEALLOCATE cr_update--3. Lập bảng tổng hợp doanh thu cho chi nhánh như sau:CREATE TABLE DOANHTHU(
	CHINHANH NVARCHAR(20) PRIMARY KEY,
	SONV INT,
	SOHD INT,
	SOKH INT,
	TONGTIENHD INT
);INSERT INTO dbo.DOANHTHU
(
    CHINHANH,
    SONV,
    SOHD,
    SOKH,
    TONGTIENHD
)
VALUES
(N'Chi nhánh HocMon',NULL,NULL,NULL,NULL)--3.1. Tạo biến @SoNVCN lưu số nhân viên của chi nhánh HocMon biết rằng số nhân viên được đếm từ bảng thông tin nhân viên.
DECLARE @SoNVCN INT;
SELECT @SoNVCN=COUNT(MANV)
FROM dbo.NHANVIEN
PRINT N'câu 3.1: '
PRINT @SoNVCN
--3.2. Tạo biến @SoHDCN lưu số hóa đơn bán được của chi nhánh HocMon biết rằng số hóa đơn được đếm từ bảng thông tin hóa đơn
DECLARE @SoHDCN INT;
SELECT @SoHDCN=COUNT(MAHD)
FROM dbo.HOADON
PRINT N'câu 3.2: '
PRINT @SoHDCN
--3.3. Tạo biến @TTHDCN lưu tổng số tiền mà chi nhánh HocMon thu được từ các hóa đơn.
DECLARE @TTHDCN INT;
SELECT @TTHDCN=SUM(TONGTIEN)
FROM dbo.HOADON
PRINT N'câu 3.3: '
PRINT @TTHDCN
--3.4. Tạo biến @SoKHCN lưu tổng số khách hàng của chi nhánh HocMon biết rằng số khách hàng được đếm từ bảng thông tin khách hàng.
DECLARE @SoKHCN INT;
SELECT @SoKHCN=COUNT(MAKH)
FROM dbo.KHACHHANG
PRINT N'câu 3.4: '
PRINT @SoKHCN
--3.5. Cập nhật các thông tin cho bảng tổng hợp doanh thu chi nhánh HocMon từ các biến @SoNVCN, @SoHDCN, @TTHDCN, @SoKHCN.
UPDATE dbo.DOANHTHUSET SONV=@SoNVCN,SOHD=@SoHDCN,SOKH=@SoKHCN,TONGTIENHD=@TTHDCN
WHERE CHINHANH=N'Chi nhánh HocMon'
--3.6. Thêm vào cột Trạng thái chi nhánh kế bên cột Tổng tiền hóa đơn trong bảng tổng hợp.
--ALTER TABLE dbo.DOANHTHU
--ADD Trangthai NVARCHAR(20);
--3.7. Cập nhật thông tin cho cột trạng thái chi nhánh HocMon như sau:
--- Nếu số nhân viên < 5 và số khách hàng >2 và Tổng tiền hóa đơn trên 20000 thì Trạng thái là ‘Đạt’.
--- Ngược lại thì cập nhật trạng thái là ‘Chưa Đạt’
IF (@SoNVCN<5 AND @SoKHCN >2 AND @TTHDCN >20000)
	UPDATE dbo.DOANHTHU
	SET Trangthai=N'Đạt'
	WHERE CHINHANH=N'Chi nhánh HocMon'
ELSE
	UPDATE dbo.DOANHTHU
	SET Trangthai=N' Chưa Đạt'
	WHERE CHINHANH=N'Chi nhánh HocMon'

SELECT * FROM dbo.NHANVIEN
SELECT * FROM dbo.KHACHHANG
SELECT * FROM dbo.HOADON
SELECT * FROM dbo.DOANHTHU