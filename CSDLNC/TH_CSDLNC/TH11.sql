use TH08

--Yêu cầu : Xây dựng Trigger kiểm tra dữ liệu THÊM hoặc XÓA hoặc SỬA thỏa điều kiện sau.
--1. Thêm vào bảng Sản phẩm cột Số lượng bán. 
alter table Sanpham
add soluongban int

select*from SANPHAM
select*from HOADON
--1.1. Cập nhật dữ liệu cho cột Số lượng bán trong bảng sản phẩm bằng tổng số lượng bán của sản phẩm đó trong 
--bảng hóa đơn.
alter Trigger trg_Cau1
on SANPHAM
for insert, update
as
	begin
		declare @soluong int
		select @soluong=COUNT(hd.soluong)
		from HOADON hd, inserted
		where inserted.MASP=hd.MASANPHAM
		group by hd.MASANPHAM
		update SANPHAM
		set soluongban=@soluong from SANPHAM, inserted where inserted.MASP=dbo.SANPHAM.MASP
	end
--1.2. Mỗi khi thêm hoặc xóa một dòng dữ liệu trong bảng hóa đơn thì cập nhật lại dữ liệu cho bảng sản phẩm.
--2. Thêm vào bảng sản phẩm cột Số Tiền Bán Hàng.
--2.1. Cập nhật dữ liệu cho cột số tiền bán trong bảng sản phẩm bằng tổng số tiền bán sản phẩm đo trong bảng hóa 
--đơn.
--2.2. Mỗi khi thêm hoặc xóa một dòng dữ liệu trong bảng hóa đơn thì cập nhật lại dữ liệu cho bảng sản phẩm.
--3. Thêm cột Số Tiền Mua Hàng vào bảng khách hàng.
--3.1. Cập nhật dữ liệu số tiền mua hàng trong bảng khách hàng bằng tổng số tiền mua hàng của khách hàng đó trong 
--bảng hóa đơn.
--3.2. Mỗi khi thêm hoặc xóa một dòng dữ liệu trong bảng hóa đơn thì cập nhật lại dữ liệu cho bảng khách hàng.
--3.3. Sau mỗi lần cập nhật, thực hiện kiểm tra lại số tiền mua hàng của mỗi khách hàng.
--• Nếu khách hàng có tổng số tiền mua hàng từ 5.000.000 trở lên thì cập nhật loại khách hàng từ CD lên TV
--• Nếu khách hàng có tổng số tiền mua hàng từ 10.000.000 trở lên thì cập nhật loại khách hàng từ TV lên TT
--• Nếu khách hàng có tổng số tiền mua hàng từ 15.000.000 trở lên thì cập nhật loại khách hàng từ TT lên VIP
--4. Khi khách hàng mua sản phẩm thì kiểm tra loại khách hàng và giới hạn số lượng mua như sau:
--4.1. Nếu Loại khách hàng là VIP thì không được mua quá 100 sản phẩm trong cùng 1 ngày.
--4.2. Nếu Loại khách hàng là TT thì không được mua quá 150 sản phẩm trong cùng 1 ngày.
--4.3. Nếu Loại khách hàng là TV thì không được mua quá 200 sản phẩm trong cùng 1 ngày.
--4.4. Nếu Loại khách hàng là CD thì không bị ràng buộc về số lượng mua
--5. Thêm vào bảng Sản Phẩm cột Số lượng trong kho và cập nhật số lượng của mỗi sản phẩm theo thứ tự là 300, 400, 
--500, 600, 700 (Cụ thể thì A01 sẽ có số lượng trong kho là 300 và E05 có số lượng trong kho là 700).
--5.1. Khi thêm hoặc cập nhật số lượng của một dòng trong bảng hóa đơn thì kiểm tra số lượng bán của sản phẩm đó 
--có vượt quá số lượng trong kho hay không, nếu vượt quá số lượng trong kho thì không cho thêm.
--6. Khi xóa một sản phẩm thì xóa tất cả dòng dữ liệu liên quan đến sản phẩm đó trong bảng hóa đơn.
--7. Khi xóa một sản phẩm thì xóa tất cả dòng dữ liệu liên quan đến sản phẩm đó trong bảng hóa đơn. Tuy nhiên, nếu 
--khách hàng tên Lý Hân có mua sản phẩm đó thì không được xóa.
--8. Khi xóa thông tin khách hàng thì phải xóa tất cả dòng dữ liệu liên quan đến khách hàng đó trong bảng hóa đơn. Sau 
--khi xóa xong thì cập nhật lại số lượng sản phẩm và số tiền bán hàng trong bảng sản phẩm.
--9. Tạo bảng log lưu lại thông tin về mã sản phẩm, mã khách hàng, Ngày bán, và số lượng mỗi khi người dùng thêm 
--hoặc xóa một dòng dữ liệu trong bảng hóa đơn. Đồng thời phải lưu lại thời gian thêm hoặc xóa dữ liệu đó.
--10. Tạo bảng log lưu lại thông tin của của thao tác cập nhật dữ liệu trong bảng hóa đơn. Lưu cả dữ liệu trước khi cập 
--nhật và sau khi cập nhật vào bảng log. Đồng thời phải lưu lại thời gian cập nhật dữ liệu