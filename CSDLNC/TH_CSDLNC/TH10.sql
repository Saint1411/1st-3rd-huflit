use TH08

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
--6. Khi thêm hoặc sửa dữ liệu trong bảng Khách hàng , Họ tên khách hàng phải khác nhau.
--7. Khi thêm hoặc sửa dữ liệu trong bảng Khách hàng , Số lượng khách hàng loại VIP phải nhỏ hơn hoặc bằng số
--lượng khách hàng loại TT.
--8. Khi thêm hoặc sửa dữ liệu trong bảng Hóa đơn , Số lượng phải lớn 0 và phải nhỏ hơn hoặc bằng 100.
--9. Khi thêm hoặc sửa dữ liệu trong bảng Hóa đơn , trong cùng 1 ngày một khách hàng không được mua quá 4 loại 
--sản phẩm khác nhau.
--10. Khi thêm hoặc sửa dữ liệu trong bảng Hóa đơn, trong cùng một ngày, tổng số lượng sản phẩm mua của 1 
--khách hàng không vượt quá 1000.
--11. Sử dụng trigger để kiểm tra dữ liệu thay cho khóa ngoại, khi thêm một hóa đơn mới thì mã sản phẩm phải có 
--trong bảng sản phẩm và mã khách hàng phải có trong bảng khách hàng.
--12. Khi xóa dữ liệu trong bảng sản phẩm, nếu mã sản phẩm bị xóa có trong bảng hóa đơn thì không cho xóa.
--13. Khi xóa dữ liệu trong bảng khách hàng, nếu mã khách hàng bị xóa có trong bảng hóa đơn thì không cho xóa.
--14. Khi xóa dữ liệu trong bảng loại khách hàng, nếu mã loại bị xóa có trong bảng khách hàng thì không cho xóa.
--15. Không được xóa những hóa đơn của khách hàng tên “Lý Hân