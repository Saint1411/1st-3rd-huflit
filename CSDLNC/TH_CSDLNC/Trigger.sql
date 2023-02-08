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
('C03', N'Nước rửa chén', 88000),
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

('14/9/2022','E05', 'KH03', 4);



--Yêu cầu : Xây dựng Trigger kiểm tra dữ liệu THÊM hoặc XÓA hoặc SỬA thỏa điều kiện sau.
--1. Khi thêm hoặc sửa dữ liệu trong bản Sản Phẩm, Đơn giá phải lớn hơn 1000.
Create Trigger trg_cau1
ON SANPHAM FOR INSERT, update
AS
	BEGIN
		if exists (select* from inserted where DONGIA<1000)
		begin
			raiserror(N'Thêm thất bại (don gia <1000)', 16,1)
			rollback tran
		end
	end

select* from SANPHAM
insert into dbo.SANPHAM
(
	MASP,
	TENSANPHAM,
	DONGIA
)
VALUES
('G06', N'Con mèo lười biếng', 1300);
--2. Khi thêm hoặc sửa dữ liệu trong bản Sản Phẩm, Tên sản phẩm không được trùng.
--3. Khi thêm hoặc sửa dữ liệu trong bảng Loại khách hàng , Chiết khấu không được là số âm.
Create Trigger trg_cau3
ON LOAI FOR INSERT, update
AS
	BEGIN
		if exists (select* from inserted where CHIETKHAU<0)
		begin
			raiserror(N'Thêm thất bại (CHIEU KHAU<0)', 16,1)
			rollback tran
		end
	end

INSERT INTO LOAI
(
	MALOAI,
	TENLOAI,
	CHIETKHAU
)
VALUES
('CM', N'Con mèo', -1);

---
INSERT INTO LOAI
(
	MALOAI,
	TENLOAI,
	CHIETKHAU
)
VALUES
('KM', N'Kon mèo', 5);
select* from LOAI

--4. Khi thêm hoặc sửa dữ liệu trong bảng Loại khách hàng , Chiết khấu không được vượt quá 50%.

alter Trigger trg_cau4
ON LOAI FOR INSERT, update
AS
	BEGIN
		if exists (select* from inserted where CHIETKHAU>0.5)
		begin
			raiserror(N'Thêm thất bại', 16,1)
			rollback tran
		end
	end
INSERT INTO LOAI
(
	MALOAI,
	TENLOAI,
	CHIETKHAU
)
VALUES
('CVV', N'Con mèo siêng năm', 2);

---
INSERT INTO LOAI
(
	MALOAI,
	TENLOAI,
	CHIETKHAU
)
VALUES
('CMSN', N'Kon mèo siêng năng', 0.5);
select* from LOAI
--5. Khi thêm hoặc sửa dữ liệu trong bảng Loại khách hàng, Tên loại phải khác nhau.
select*from LOAI
alter trigger trg_cau5
on loai for insert, update
as
	begin
	declare @count int=0;
	select @count= COUNT(*)  
	FROM inserted, LOAI
	where LOAI.TENLOAI =inserted.TENLOAI
	if @count>1
	begin
			raiserror(N'Thêm thất bại', 16,1)
			rollback tran
		end
	end

INSERT INTO LOAI
(
	MALOAI,
	TENLOAI,
	CHIETKHAU
)
VALUES
('CMSN2', N'Chưa đăng ký lại', 0.5);
--6. Khi thêm hoặc sửa dữ liệu trong bảng Khách hàng , Họ tên khách hàng phải khác nhau.
create trigger trg_cau6
on khachhang for insert, update
as
	begin
	declare @count int=0;
	select @count= COUNT(*)  
	FROM inserted, KHACHHANG
	where KHACHHANG.HOTEN =inserted.HOTEN
	if @count>1
	begin
			raiserror(N'Thêm thất bại', 16,1)
			rollback tran
		end
	end

INSERT INTO KHACHHANG
(
	MAKH,
	HOTEN,
	LOAIKH
)
VALUES
('vnnn1', N'Nguyễn Duy', 'CD');

--7. Khi thêm hoặc sửa dữ liệu trong bảng Khách hàng , Số lượng khách hàng loại VIP phải nhỏ hơn hoặc bằng số
--lượng khách hàng loại TT.
select* from KHACHHANG
create trigger trg_cau7
on khachhang for insert, update
as
	begin
	declare @countvip int, @counttt int;
	select @countvip= COUNT(LOAIKH)  
	FROM KHACHHANG
	where LOAIKH ='VIP'
	group by LOAIKH
	
	select @counttt =COUNT(LOAIKH) 
	FROM KHACHHANG
	where LOAIKH ='TT'
	group by LOAIKH

	if(@counttt<@countvip)
	begin
			raiserror(N'Thêm thất bại', 16,1)
			rollback tran
		end
	end


INSERT INTO KHACHHANG
(
	MAKH,
	HOTEN,
	LOAIKH
)
VALUES
('vnnn3', N'Bá Duy', 'VIP');
--8. Khi thêm hoặc sửa dữ liệu trong bảng Hóa đơn , Số lượng phải lớn 0 và phải nhỏ hơn hoặc bằng 100.
alter trigger trg_cau8
on hoadon for insert, update
as
	begin

	if exists (select* from inserted where SOLUONG<0 or SOLUONG>100)
	begin
			raiserror(N'Thêm thất bại', 16,1)
			rollback tran
		end
	end

INSERT INTO HOADON
(
	NGAY,
	MASANPHAM,
	MAKHACHHANG,
	SOLUONG
)
VALUES
('14/9/2022','E05', 'CDK04', 101);
select* from HOADON

--9. Khi thêm hoặc sửa dữ liệu trong bảng Hóa đơn , trong cùng 1 ngày một khách hàng không được mua quá 4 loại 
--sản phẩm khác nhau.

create trigger trg_cau9
on hoadon for insert, update
as
	begin
	declare @count int;
	select @count= COUNT(MASANPHAM)
	from HOADON
	GROUP BY MAKHACHHANG

	IF(@count>4)
	raiserror(N'Thêm thất bại', 16,1)
			rollback tran
		end
	end

INSERT INTO HOADON
(
	NGAY,
	MASANPHAM,
	MAKHACHHANG,
	SOLUONG
)
VALUES
('14/9/2022','A01', 'CDK04', 101),
('14/9/2022','B02', 'CDK04', 101),
('14/9/2022','C03', 'CDK04', 101),
('14/9/2022','D04', 'CDK04', 101),
('14/9/2022','E05', 'CDK04', 101);
select* from HOADON

--10. Khi thêm hoặc sửa dữ liệu trong bảng Hóa đơn, trong cùng một ngày, tổng số lượng sản phẩm mua của 1 
--khách hàng không vượt quá 1000.
--11. Sử dụng trigger để kiểm tra dữ liệu thay cho khóa ngoại, khi thêm một hóa đơn mới thì mã sản phẩm phải có 
--trong bảng sản phẩm và mã khách hàng phải có trong bảng khách hàng.
--12. Khi xóa dữ liệu trong bảng sản phẩm, nếu mã sản phẩm bị xóa có trong bảng hóa đơn thì không cho xóa.
--13. Khi xóa dữ liệu trong bảng khách hàng, nếu mã khách hàng bị xóa có trong bảng hóa đơn thì không cho xóa.
--14. Khi xóa dữ liệu trong bảng loại khách hàng, nếu mã loại bị xóa có trong bảng khách hàng thì không cho xóa.
--15. Không được xóa những hóa đơn của khách hàng tên “Lý Hân"