use master
create database TH08
use TH08


create table SANPHAM(
MASP VARCHAR(10) PRIMARY KEY,
TENSANPHAM NVARCHAR(20),
DONGIA INT 
);

CREATE TABLE KHACHHANG(
MAKH NVARCHAR(10) PRIMARY KEY,
HOTEN NVARCHAR(20),
LOAIKH varchar(10) FOREIGN KEY REFERENCES LOAI(MALOAI),
);

CREATE table LOAI(
MALOAI varchar(10) PRIMARY KEY,
TENLOAI NVARCHAR(25),
CHIETKHAU float
);

CREATE TABLE HOADON(
NGAY DATE,
MASANPHAM VARCHAR(10) FOREIGN KEY REFERENCES SANPHAM(MASP),
MAKHACHHANG NVARCHAR(10) FOREIGN KEY REFERENCES KHACHHANG(MAKH),
SOLUONG INT
);

insert into dbo.SANPHAM
(
	MASP,
	TENSANPHAM,
	DONGIA
)
VALUES
('A01', N'Dầu gội đầu', 60000),
('B02', N'Bột giặt', 140000),
('C03', N'Nước rửa chén', 880000),
('D04', N'Nước lau sàn', 25000),
('E05', N'Kem đánh răng ', 38000);


INSERT INTO LOAI
(
	MALOAI,
	TENLOAI,
	CHIETKHAU
)
VALUES
('VIP', N'Khách hàng VIP', 0.15),
('TT', N'Khách hàng thân thiết', 0.1),
('VT', N'Khách hàng thân thiết', 0.05),
('CD', N'Chưa đăng ký', 0);

INSERT INTO KHACHHANG
(
	MAKH,
	HOTEN,
	LOAIKH
)
VALUES
('KH01', N'Lý Hân', 'VIP'),
('KH02', N'Lê Dân', 'TT'),
('KH03', N'Đinh Hòa', 'VT'),
('CDK04', N'Nguyễn Kiên', 'CD');

set dateformat dmy
INSERT INTO HOADON
(
	NGAY,
	MASANPHAM,
	MAKHACHHANG,
	SOLUONG
)
VALUES
('13/9/2022','A01', 'KH01', 2),
('13/9/2022','B02', 'KH01', 2),
('13/9/2022','C03', 'KH01', 2),
('13/9/2022','B02', 'KH02', 2),
('13/9/2022','C03', 'KH02', 2),
('13/9/2022','D04', 'KH02', 2),
('13/9/2022','E05', 'KH02', 2),
('13/9/2022','A01', 'KH03', 2),
('13/9/2022','D04', 'KH03', 2),
('13/9/2022','E05', 'KH03', 2),
('14/9/2022','D04', 'KH01', 2),
('14/9/2022','E05', 'KH01', 2),
('14/9/2022','A01', 'KH02', 2),
('14/9/2022','C03', 'KH03', 2),
('14/9/2022','A01', 'CDK04', 2),
('14/9/2022','E05', 'CDK04', 2);

set dateformat dmy
INSERT INTO HOADON
(
	NGAY,
	MASANPHAM,
	MAKHACHHANG,
	SOLUONG
)
VALUES
('14/9/2022','E05', 'CDK04', 4)
('13/9/2022','E05', 'CDK04', 4);

INSERT INTO HOADON
(
	NGAY,
	MASANPHAM,
	MAKHACHHANG,
	SOLUONG
)
VALUES

('14/9/2022','E05', 'KH03', 4);


--Yêu cầu : Xây dựng thủ tục nội tại (Store Procedure) có trả về kết quả để thực hiện các công việc sau.
--Lưu ý: Giá trị trong điều kiện Where chính là tham số hàm.
--1. Nhận tham số đầu vào là MaSP; trả về Tên SP và đơn giá.
---Viết thủ tục
alter proc sp_TenSpVaDongia @masp varchar(10), @ten nvarchar(20) out, @dongia int out
as
	if exists (SELECT * FROM SANPHAM WHERE MASP=@masp)
	begin
		select @ten=TENSANPHAM, @dongia =DONGIA
		from SANPHAM
		where MASP=@masp
	end

---thực thi thủ tục
declare @ten nvarchar(20), @dongia int, @masp varchar(10) 
select @masp=MASP
from SANPHAM
exec sp_TenSpVaDongia  @masp, @ten out, @dongia out
print N'Sản phẩm: '+@ten+ ' có đơn giá là: ' + cast(@dongia as nvarchar(20))
--2. Nhận tham số đầu vào là Ngày, Mã SP, MaKH; trả về số lượng sản phẩm đã mua.

alter proc sp_SoLuongSpDaMua @ngay date, @makh nvarchar(10), @masp varchar(10), @soluong int out
as
	if exists (SELECT * FROM HOADON WHERE MASANPHAM=@masp and MAKHACHHANG=@makh and NGAY=@ngay)
	begin
		select @soluong=SOLUONG
		from HOADON
		where NGAY=@ngay and MAKHACHHANG=@makh and MASANPHAM=@masp
	end

---thực thi
declare @ngay date, @makh nvarchar(10), @masp varchar(10), @soluong int
select @ngay= NGAY, @makh=MAKHACHHANG, @masp=MASANPHAM
from HOADON
exec sp_SoLuongSpDaMua @ngay, @makh, @masp, @soluong out
--exec sp_SoLuongSpDaMua '2022-09-14', 'CDK04 ', 'E05', @soluong out
print N'Ngày: '+cast(@ngay as nvarchar(20)) + N' số lượng: ' + cast (@soluong as varchar(20))
--3. Nhận tham số đầu vào là MaKH; trả về Họ Tên, Tên Loại, Chiết khấu của khách hàng đó.
alter proc sp_ChietKhau @makh nvarchar(10), @hoten nvarchar(20) out, @tenloai varchar(10) out, @chietkhau float out
as
	if exists(select* from KHACHHANG kh, LOAI l where  kh.MAKH=@makh and l.MALOAI=kh.LOAIKH)
	begin
		select @hoten= kh.HOTEN, @tenloai=l.TENLOAI, @chietkhau=l.CHIETKHAU
		from KHACHHANG kh, LOAI l
		where kh.MAKH=@makh and l.MALOAI=kh.LOAIKH
	end

---thuc thi
declare  @makh nvarchar(10), @hoten nvarchar(20), @tenloai varchar(10), @chietkhau float
select @makh=MAKH
from KHACHHANG 
--exec sp_ChietKhau 'KH01', @hoten out, @tenloai out, @chietkhau out
exec sp_ChietKhau @makh, @hoten out, @tenloai out, @chietkhau out
print @hoten + N' thuộc loại '+ @tenloai+ N' có chiết khấu: ' + cast(@chietkhau as varchar(10))

--4. Nhận tham số đầu vào là Ngày; trả về số lượng sản phẩm đã bán trong ngày đó.

ALTER proc sp_SoLuongBanTrongNgay @ngay date, @soluong int out
as
	if exists(select* from HOADON where NGAY=@ngay)
	begin
		
		select @soluong=SUM(soluong)
		FROM HOADON
		WHERE NGAY=@ngay
		group by NGAY

	END

--THỰC THI
DECLARE @NGAY date, @soluong int
select @ngay=NGAY
FROM HOADON
--EXEC sp_SoLuongBanTrongNgay '2022-09-13', @soluong out
EXEC sp_SoLuongBanTrongNgay @NGAY, @soluong out
print N'Ngày '+cast(@ngay as varchar(20)) + N' bán được số lượng sản phẩm là: '+ cast(@soluong as varchar(10))
--5. Nhận tham số đầu vào là MaSP; trả về số lượng bán của sản phẩm đó.
create proc sp_SoLuongBanTheoSp @masp varchar(10), @soluong int out
as
	if exists (select* from HOADON where MASANPHAM=@masp)
	begin
		select @soluong=SUM(SOLUONG)
		from HOADON
		where MASANPHAM=@masp
		GROUP BY MASANPHAM
	END
-------------------------------------
DECLARE @MASP VARCHAR(10), @SOLUONG INT
--set @masp='B02'
--EXEC sp_SoLuongBanTheoSp @masp, @SOLUONG OUT
SELECT @masp=MASANPHAM
FROM HOADON
EXEC sp_SoLuongBanTheoSp @MASP, @SOLUONG OUT
PRINT N'mã sản phẩm: ' + @masp+ N' bán được số lượng là: '+cast(@soluong as varchar(5))
--6. Nhập vào mã khách hàng; trả về số lượng sản phẩm mà khách hàng đó mua.
create proc sp_SoLuongSpKhachMua @makh varchar(10), @soluong int out
as
	if exists(select* from HOADON where MAKHACHHANG=@makh)
	begin
		select @soluong=SUM(soluong)
		from HOADON 
		where MAKHACHHANG=@makh
		group by MAKHACHHANG
	end
--------------------------------------
DECLARE @makh varchar(10), @soluong int
--set @makh='KH01'
--EXEC sp_SoLuongSpKhachMua @makh, @SOLUON G OUT
SELECT @makh=MAKHACHHANG
FROM HOADON
EXEC sp_SoLuongSpKhachMua @makh, @SOLUONG OUT
PRINT N'Khách hàng có mã: ' + @makh+ N' đã mua số lượng là: '+cast(@soluong as varchar(5))
--Biết rằng, số tiền bán của một loại sản phẩm được tính bằng công thức: Thành Tiền= Số lượng * Đơn giá
--7. Nhận tham số đầu vào là MaSP; trả về tổng số tiền bán của sản phẩm đó.
alter proc sp_TongSoTienSp @masp varchar(10), @sotien int out
as
	if exists (select*from HOADON hd, SANPHAM sp where hd.MASANPHAM=@masp and hd.MASANPHAM=sp.MASP)
	begin
		declare @soluong int
		exec sp_SoLuongBanTheoSp @masp , @soluong out
		select @sotien=@soluong*dongia
		from HOADON hd, SANPHAM sp
		where hd.MASANPHAM=@masp and hd.MASANPHAM=sp.MASP
	end

-------------------------
declare @masp varchar(10), @sotien int
select @masp=MASANPHAM
from HOADON
exec sp_TongSoTienSp @masp, @sotien out
print N'Mã sản phẩm: '+ @masp+ N' đã bán được số tiền: '+ cast(@sotien as varchar(20))
--8. Nhận tham số đầu vào là Ngày và MaSP; trả về tổng số tiền bán sản phẩm đó trong ngày.
alter proc sp_SoTienBanSpTrongNgay @masp varchar(10),@ngay date ,@tongtien int out
as
	if exists (select* from HOADON hd, SANPHAM sp where hd.MASANPHAM=sp.MASP and hd.NGAY=@ngay and hd.MASANPHAM=@masp)
	begin
		
		select @tongtien=sum(hd.soluong)*sp.DONGIA
		from HOADON hd, SANPHAM sp
		where hd.MASANPHAM=sp.MASP and hd.NGAY=@ngay and hd.MASANPHAM=@masp
		group by sp.DONGIA, hd.NGAY
	end

-------------------------------
declare @masp varchar(10),@ngay date ,@tongtien int 
set @masp='C03 '
select @ngay=NGAY
from HOADON
exec sp_SoTienBanSpTrongNgay @masp, @ngay, @tongtien out
print N'Ngày:'+cast(@ngay as varchar(20)) +N' Mã sản phẩm: '+ @masp+ N' đã bán được số tiền: '+ cast(@tongtien as varchar(20))
--9. Nhận tham số đầu vào là Ngày; trả về tổng số tiền bán tất cả sản phẩm trong ngày.
alter proc sp_TongTienBanTrongNgay @ngay date, @tongtien int out
as
	if exists (select* from HOADON dh, SANPHAM sp where dh.NGAY=@ngay and dh.MASANPHAM= sp.MASP)
	begin
		select @ngay=dh.NGAY, @tongtien=sum(dh.SOLUONG*sp.DONGIA)
		from HOADON dh, SANPHAM sp
		where dh.NGAY=@ngay and dh.MASANPHAM= sp.MASP
		group by dh.NGAY
	end

------------------------
declare @ngay date, @tongtien int 
select @ngay =NGAY
from HOADON
exec sp_TongTienBanTrongNgay @ngay, @tongtien out
print N'Ngày ' +cast(@ngay as varchar (20)) +N' đã bán được số tiền là: '+ cast(@tongtien as varchar(20))
--10. Nhận tham số đầu vào là Ngày và MaKH; trả về tổng số tiền mà khách hàng đã trả trong ngày đó.
alter proc sp_TongTienKhach @ngay date, @makh varchar(10), @tongtien int out
as
	if exists (select* from HOADON dh, SANPHAM sp where dh.NGAY=@ngay and dh.MASANPHAM= sp.MASP and dh.MAKHACHHANG=@makh)
	begin
		select @makh =dh.MAKHACHHANG, @ngay=dh.NGAY, @tongtien = Sum(dh.soluong*sp.DONGIA)
		from HOADON dh, SANPHAM sp 
		where dh.NGAY=@ngay and dh.MASANPHAM= sp.MASP and dh.MAKHACHHANG=@makh
		group by  dh.NGAY, dh.MAKHACHHANG
	end

		
---------
declare @ngay date, @makh varchar(10), @tongtien int 
select @ngay=NGAY, @makh=MAKHACHHANG
from HOADON
exec sp_TongTienKhach @ngay, @makh, @tongtien out
print N'Ngày '+ cast(@ngay as varchar(20)) +N' khách hàng mã '+ @makh + N' đã trả tổng tiền: '+cast(@tongtien as varchar(20))
--11. Nhận tham số đầu vào là Ngày và MaKH; trả về tổng số tiền mà khách hàng phải trả trước khi áp dụng Chiết 
--Khấu và sau khi áp dụng Chiết khấu.
alter proc sp_TongTienTruocChietKhau @ngay date ,@makh varchar(10), @tongtien int out
as
	if exists (select* from KHACHHANG kh, LOAI l where kh.LOAIKH=l.MALOAI)
	begin
	    -- trước khi áp dụng chiêt khấu
		declare @tongtien10 int
		exec sp_TongTienKhach @ngay, @makh, @tongtien10 out
		select @tongtien=@tongtien10 + (@tongtien10*l.CHIETKHAU)
		from KHACHHANG kh, LOAI l
		where kh.LOAIKH=l.MALOAI and kh.MAKH=@makh
		print N'Ngày '+ cast(@ngay as varchar(20)) +N' khách hàng mã '+ @makh + N' đã trả tổng tiền: '+cast(@tongtien10 as varchar(20)) +N' chưa áp dụng chiết khấu'
		print N'Ngày '+ cast(@ngay as varchar(20)) +N' khách hàng mã '+ @makh + N' đã trả tổng tiền: '+cast(@tongtien as varchar(20)) +N' đã áp dụng chiết khấu'
	end

------------
declare @ngay date, @makh varchar(10), @tongtien int 
select @ngay=NGAY, @makh=MAKHACHHANG
from HOADON
exec sp_TongTienTruocChietKhau @ngay, @makh, @tongtien out

--12. Nhận vào tham số là Ngày; trả về MaKH và số lượng mua hàng của khách hàng mua nhiều sản phẩm nhất.
alter PROC sp_MuaNhieuNhat @ngay date, @makh varchar(10) out, @soluong int out
as
	if exists (SELECT * FROM HOADON WHERE NGAY=@ngay)
	begin
		if exists (SELECT * FROM HOADON WHERE NGAY=@ngay)
		select @makh=MAKHACHHANG, @soluong=Max(SOLUONG)
		from HOADON
		where NGAY=@ngay 
		group by MAKHACHHANG, NGAY
	end




declare @ngay date, @makh varchar(10), @soluong int
select @ngay=NGAY
from HOADON
exec sp_MuaNhieuNhat @ngay, @makh out, @soluong out
print N'khách hàng mã: '+@makh+ N' mua sản phẩm nhiều nhất là:' +cast(@soluong as varchar(10))
--13. Nhận vào tham số là Ngày; trả về MaKH và số tiền mua hàng của khách hàng mua nhiều tiền nhất.
alter PROC SP_MuaNhieuTienNhat @ngay date, @makh varchar(10) out, @tienmua int out
as
	begin
		select @makh =hd.MAKHACHHANG, @tienmua = sum(hd.SOLUONG*sp.DONGIA)
		from HOADON hd, SANPHAM sp
		where hd.MASANPHAM=sp.MASP and NGAY =@ngay
		group by hd.MAKHACHHANG
	end

-----------
declare @ngay date, @makh varchar(10), @tienmua int
select @ngay =NGAY
from HOADON
exec SP_MuaNhieuTienNhat @ngay, @makh out, @tienmua out
print N'khách hàng: ' +@makh+ N'  số tiền đã mua nhiều tiền nhất là: ' +cast(@tienmua as varchar(10))
--14. Nhận tham số đầu vào là Ngày; trả về MaSP và số lượng bán được của sản phẩm bán nhiều nhất trong ngày.
create proc sp_MuaNhieuNhatTrongNgay @ngay date, @masp varchar(10) out, @soluong int out
as
	begin
		select @masp=MASANPHAM, @soluong=SUM(soluong)
		from HOADON
		where NGAY=@ngay
		group by NGAY, MASANPHAM
	end

---------
declare @ngay date, @masp varchar(10), @soluong int
select @ngay=NGAY
from HOADON
exec sp_MuaNhieuNhatTrongNgay @ngay, @masp out, @soluong out
print cast(@ngay as varchar(20))+ ' mua nhieu nhat ' +@masp+ ' '+cast(@soluong as varchar(10))
--15. Nhận vào tham số là MaSP; trả về MaKH và số lượng mua của khách hàng mua sản phẩm đó nhiều nhất.
create proc sp_SoSpMuaNhieuNhat @masp varchar (10), @makh varchar(10) out, @soluongmua int out
as
	begin
		select @makh=MAKHACHHANG, @soluongmua=MAX(soluong)
		from HOADON 
		where MASANPHAM=@masp
		group by MAKHACHHANG, MASANPHAM
	end

-----------
declare @masp varchar (10), @makh varchar(10), @soluongmua int
select @masp=MASANPHAM
from HOADON
exec sp_SoSpMuaNhieuNhat @masp, @makh out, @soluongmua out
print @makh + ' mua nhieu nhat ' + cast(@soluongmua as varchar(10))
--16. Nhận vào tham số là Ngay và một giá trị hdtype kiểu bit. 
--• Nếu hdtype = 1 : Trả về MaSP và số lượng bán được của sản phẩm bán nhiều nhất trong ngày.
--• Ngược lại: Trả về MaSP và số lượng bán được của sản phẩm bán ít nhất trong ngà