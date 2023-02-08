use master
create database TH07
use TH07

create table SANPHAM(
MASP CHAR(3) PRIMARY KEY,
TENSANPHAM NVARCHAR(20),
DONGIA INT 
);

CREATE TABLE KHACHHANG(
MAKH NVARCHAR(10) PRIMARY KEY,
HOTEN NVARCHAR(20),
LOAIKH varchar(5) FOREIGN KEY REFERENCES LOAI(MALOAI),
);


CREATE table LOAI(
MALOAI varchar(5) PRIMARY KEY,
TENLOAI NVARCHAR(25),
CHIETKHAU float
);

CREATE TABLE DONHANG(
NGAY DATE,
MASANPHAM CHAR(3) FOREIGN KEY REFERENCES SANPHAM(MASP),
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
INSERT INTO DONHANG
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

--Yêu cầu : Xây dựng thủ tục nội tại (Store Procedure) để thực hiện các công việc sau.
--Lưu ý: Giá trị trong điều kiện Where chính là tham số hàm.
--1. Xuất ra danh sách các sản phẩm được lưu trong bảng sản phẩm.
--Viết thủ tục hàm
alter PROC sp_danhsachsp @masp char(3)
as
	begin
		SELECT *
		FROM SANPHAM
		--where MASP=@masp
	END;

---thuc thi
DECLARE @masp char(3)
select @masp=MASP
from SANPHAM
where MASP=@masp
exec sp_danhsachsp @masp
--2. Xuất ra danh sách các khách hàng được lưu trong bảng khách hàng.
--Viết thủ tục hàm
alter proc sp_danhsachKH @makh nvarchar(10)
as
	begin
		select*
		from KHACHHANG
	end;

---thuc thi
declare @makh nvarchar(10)
select @makh=MAKH
from KHACHHANG
where MAKH=@makh
exec sp_danhsachKH @makh
--3. Xuất ra thông tin Tên Khách hàng, Tên Loại khách hàng, Chiết khấu của các khách hàng.
--Viết thủ tục hàm
alter proc sp_xuatthongtinKH @makh nvarchar(10), @loai varchar(5)
as
	begin
		select kh.HOTEN, kh.LOAIKH, l.CHIETKHAU
		from KHACHHANG kh, LOAI l
		where kh.LOAIKH=l.MALOAI
	end

---thuc thi
declare @makh nvarchar(10), @loai varchar(5)
select @makh=kh.MAKH, @loai=l.MALOAI
from KHACHHANG kh, LOAI l
exec sp_xuatthongtinKH @makh, @loai
--4. Xuất ra danh sách hóa đơn của khách hàng có mã là KH01.
--Viết thủ tục hàm
alter proc sp_xuatdanhsachHD @makh nvarchar(10)
as
	begin
		select*
		from DONHANG
		where MAKHACHHANG='KH01'
	END

---THỰC THI
DECLARE @makh nvarchar(10)
select @makh=MAKHACHHANG
from DONHANG
exec sp_xuatdanhsachHD @makh
--5. Xuất ra danh sách hóa đơn bán trong ngày 13-9-2022.
---viết thủ tục
create proc sp_danhsachhoadon13 @ngay date
as
	begin
		select*
		from DONHANG
		where NGAY='13-9-2022'
	end

--thực thi
declare @ngay date
select @ngay=NGAY
FROM DONHANG
exec sp_danhsachhoadon13 @ngay
--6. Cho biết sản phẩm A01 được mua trong những hóa đơn nào?
--viết thủ tục
alter proc sp_xuathoadonA01 @mahd  char(3)
as
	begin
		select dh.*
		from DONHANG dh, SANPHAM sp
		where dh.MASANPHAM=sp.MASP and dh.MASANPHAM='A01'
	end

--thực thi
declare @madh char(3)
select @madh=MASANPHAM
FROM DONHANG
exec sp_xuathoadonA01 @madh
--7. Cho biết khách hàng tên Lê Dân đã mua những mặt hàng nào?
--viết thủ tục
create proc sp_khachhangLeDan @ten nvarchar(20)
as
	begin
		select kh.HOTEN, dh.*
		from KHACHHANG kh, DONHANG dh
		where kh.MAKH=dh.MAKHACHHANG and kh.HOTEN=N'Lê Dân'
	end

--thực thi
declare @ten nvarchar(20)
select @ten=HOTEN
FROM KHACHHANG
exec sp_khachhangLeDan @ten
--8. Cho biết khách hàng tên Đinh Hòa đã mua những mặt hàng nào trong ngày 13-9-2022?
--viết thủ tục

alter proc sp_khachhangDinhHoa @ten nvarchar(20)
as
	begin
		select kh.*, dh.NGAY, dh.MASANPHAM, dh.SOLUONG
		from KHACHHANG kh, DONHANG dh
		where kh.MAKH=dh.MAKHACHHANG and dh.NGAY='13-9-2022' and kh.HOTEN=N'Đinh Hòa'
	end

--thực thi
declare @ten nvarchar(20)
select @ten=HOTEN
FROM KHACHHANG
exec sp_khachhangDinhHoa @ten
--9. Cho biết tên những sản phẩm đã được bán trong ngày 14-9-2022.
--Viết thủ tục
create proc sp_sanpham14 @ngay date
as
	begin
		select dh.NGAY, sp.TENSANPHAM
		from DONHANG dh, SANPHAM sp
		where dh.MASANPHAM=sp.MASP and dh.NGAY='14-9-2022'
	end

--thực thi
declare @ngay date
select @ngay=NGAY
from DONHANG
exec sp_sanpham14 @ngay

--10. Cho biết tên những khách hàng nào đã mua sản phẩm “Nước rửa chén”.
---viết thủ tục
alter proc sp_KhachHangMuaNuocRuaChen @tensp nvarchar(20)
as
	begin
		select kh.HOTEN
		from KHACHHANG kh, DONHANG dh, SANPHAM sp
		where kh.MAKH=dh.MAKHACHHANG and sp.MASP=dh.MASANPHAM and sp.TENSANPHAM=N'Nước rửa chén'
	end

--thực thi
declare @tensp nvarchar(20)
select @tensp=TENSANPHAM
from SANPHAM
exec sp_KhachHangMuaNuocRuaChen @tensp
--11. Cho biết Tên sản phẩm và số lượng bán ra của từng sản phẩm.
---Thủ tục
create proc sp_TenSanPhamVaSoLuongBanRa @tensp nvarchar(20)
as
	begin
		select sp.TENSANPHAM, Sum(dh.SOLUONG)
		from DONHANG dh, SANPHAM sp
		where dh.MASANPHAM=sp.MASP
		group by sp.TENSANPHAM
	end

---thực thi
declare @tensp nvarchar(20)
select @tensp=TENSANPHAM
from SANPHAM
exec sp_TenSanPhamVaSoLuongBanRa @tensp
--12. Cho biết Tên khách hàng và số lượng mua của từng khách hàng.
--13. Cho biết mỗi khách hàng đã mua bao nhiêu chai Dầu gội đầu.
--14. Cho biết số lượng sản phẩm bán trong từng ngày.
--15. Biết rằng số tiền bán hàng được tính bằng công thức Thành Tiền = Số Lượng * Đơn Giá. Cho biết tổng số tiền 
--bán hàng trong từng ngày.
--16. Cho biết mỗi khách hàng đã mua bao nhiêu tiền.
--17. Cho biết trước khi áp dụng chiết khấu và sau khi áp dụng chiết khấu thì khách hàng phải trả bao nhiêu tiền.
--18. Thêm một sản phẩm mới vào bảng sản phẩm.
--19. Thêm một hóa đơn mới vào bảng hóa đơn có kiểm tra số lượng mua phải lớn hơn 0.
--20. Cập nhật số lượng mua hàng của hóa đơn của khách hàng Lê Dân mua sản phẩm Nước lau sàn vào ngày 13-9-
--2022, có kiểm tra số lượng sản phẩm phải lớn hơn 0

