use TH08

select *
from HOADON


--Yêu cầu : Xây dựng thủ tục nội tại (Store Procedure) để thực hiện các công việc sau.
--Biết rằng, số tiền bán của một loại sản phẩm được tính bằng công thức: Thành Tiền= Số lượng * Đơn giá
--1. Đếm số lượng sản phẩm được bán của từng sản phẩm và lưu vào bảng tạm. Xuất dữ liệu bảng tạm.
CREATE TABLE #SANPHAM_TEMP (
    MASP VARCHAR(10),
	SOLUONGBANDUOC INT
);
alter proc sp_DemSpBanDuoc
as
	begin
		declare @masp varchar(10), @soluong int
		select  @masp=MASANPHAM ,@soluong= SUM(SOLUONG)
		from HOADON
		group by MASANPHAM
		--chèn dl vào bảng tạm
		insert into #SANPHAM_TEMP
		(
			MASP,
			SOLUONGBANDUOC
		)
		values
		(@masp, @soluong)
		
		select*
		from #SANPHAM_TEMP
	end

----thực thi thủ tục
Exec sp_DemSpBanDuoc

--2. Đếm số lượng sản phẩm mà mỗi khách hàng đã mua và lưu vào bảng tạm. Xuất dữ liệu bảng tạm.
CREATE TABLE #KHACHHANG_TEMP (
    MAKH VARCHAR(10),
	DAMUASL INT
);
---THỦ TỤC
ALTER PROC sp_DemSlKhDaMua
as
	begin
		declare @makh varchar(10), @soluong int
		select @makh = MAKHACHHANG, @soluong = sum(SOLUONG)
		from HOADON
		group by MAKHACHHANG
		insert into #KHACHHANG_TEMP
		(
			MAKH,
			DAMUASL
		)
		values
		(@makh, @soluong)
		
		select*
		from #KHACHHANG_TEMP
	end
-----thực thi
exec sp_DemSlKhDaMua
--3. Tính số tiền bán của mỗi sản phẩm và lưu vào bảng tạm. Xuất dữ liệu bảng tạm.
CREATE TABLE #TONGTIENSP_TEMP (
    MASP VARCHAR(10),
	TENSP NVARCHAR(20),
	THANHTIEN INT
);

alter PROC sp_TongTienBanCuaSp
as
	begin
		declare @masp varchar(10), @tensp nvarchar(20), @tongtien int
		select @masp=hd.MASANPHAM, @tensp=sp.TENSANPHAM,@tongtien=sum(hd.SOLUONG)*sp.DONGIA
		from HOADON hd, SANPHAM sp
		where hd.MASANPHAM=sp.MASP
		group by hd.MASANPHAM, sp.DONGIA, sp.TENSANPHAM
		---chèn dl
		insert into #TONGTIENSP_TEMP
		(
			MASP,
			TENSP,
			THANHTIEN
		)
		values
		(@masp, @tensp,@tongtien)
		
		select*
		from #TONGTIENSP_TEMP
	end

-----thực thi
exec sp_TongTienBanCuaSp
--4. Tính số tiền mua hàng của mỗi khách hàng và lưu vào bảng tạm. Xuất dữ liệu bảng tạm.
create table #TEMP
(
	MAKH VARCHAR(10),
	TONGTIN INT
)

CREATE PROC sp_TongTienMoiKhDaMua
as
	begin
		declare @tongtiensp int, @masp varchar(10)
		select @masp=hd.MASANPHAM, @tongtiensp=SUM(hd.SOLUONG*sp.DONGIA)
		from HOADON hd, SANPHAM sp
		where hd.MASANPHAM=sp.MASP
		group by hd.MASANPHAM, sp.DONGIA
		declare @tongtienkh int, @makh varchar(10)
		select @makh=hd.MAKHACHHANG, @tongtienkh=SUM(@tongtiensp)
		from HOADON hd, SANPHAM sp
		where hd.MASANPHAM=sp.MASP
		group by hd.MAKHACHHANG

		insert into #TEMP(
		MAKH,
		TONGTIN
		)
		VALUES(@makh,@tongtienkh)
		SELECT *
		FROM #TEMP
	END

EXEC sp_TongTienMoiKhDaMua
--5. Thêm vào bảng sản phẩm cột Số Tiền Bán Hàng và cập nhật dữ liệu cho cột này từ bảng tạm ở câu 3 (sử dụng 
--kỹ thuật con trỏ).
ALTER TABLE #SANPHAM_TEMP ADD SOTIENBANHANG INT
alter PROC sp_CapNhatSoTienBh
as
	begin
		declare @masp varchar(10), @tongtien int
		declare cr_update cursor
		for select MASP from #SANPHAM_TEMP
		open cr_update
		fetch next from cr_update into @masp
		while @@FETCH_STATUS=0
		begin
			select @masp=hd.MASANPHAM, @tongtien=sum(hd.SOLUONG)*sp.DONGIA
			from HOADON hd, SANPHAM sp
			where hd.MASANPHAM=sp.MASP
			group by hd.MASANPHAM, sp.DONGIA
			update #SANPHAM_TEMP
			set SOTIENBANHANG=@tongtien
			WHERE MASP=@masp
			fetch next from cr_update into @masp
		END
		CLOSE cr_update
		deallocate cr_update
	end

exec sp_CapNhatSoTienBh
select* from #SANPHAM_TEMP
--6. Thêm vào bảng khách hàng cột Số Tiền Mua Hàng và cập nhật dữ liệu cho cột này từ bảng tạm ở câu 4(sử dụng 
--kỹ thuật con trỏ).
alter table #KHACHHANG_TEMP ADD SOTIENMUAHANG INT
alter proc sp_CapNhatSoTienKH
as
	begin
		declare @makh varchar(10), @masp varchar(10), @tongtiensp int
		declare cr_update cursor
		for select MAKH from #KHACHHANG_TEMP
		open cr_update
		fetch next from cr_update into @makh
		while @@FETCH_STATUS=0
		begin
			select @masp=hd.MASANPHAM, @tongtiensp=SUM(hd.SOLUONG*sp.DONGIA)
			from HOADON hd, SANPHAM sp
			where hd.MASANPHAM=sp.MASP
			group by hd.MASANPHAM, sp.DONGIA
			declare @tongtienkh int
			select @makh=hd.MAKHACHHANG, @tongtienkh=SUM(@tongtiensp)
			from HOADON hd, SANPHAM sp
			where hd.MASANPHAM=sp.MASP
			group by hd.MAKHACHHANG

			update #KHACHHANG_TEMP
			SET SOTIENMUAHANG=@tongtienkh
			WHERE MAKH=@makh
			fetch next from cr_update into @makh
		END
		CLOSE cr_update
		deallocate cr_update
	end

EXEC sp_CapNhatSoTienKH
SELECT* FROM #KHACHHANG_TEMP
--7. Cập nhật dữ liệu cho cột Số Tiền Bán Hàng từ bảng tạm ở câu 3 (sử dụng kỹ thuật kết bảng trong update).
--8. Cập nhật dữ liệu cho cột Số Tiền Mua Hàng từ bảng tạm ở câu 4(sử dụng kỹ thuật kết bảng trong update).
--9. Thêm vào bảng hóa đơn cột Thành tiền, cập nhật dữ liệu cho cột thành tiền biết rằng:
--• Thành tiền = số lượng * đơn giá*(1-Chiết khấu)*(1-Tỷ lệ giảm)
--• Nếu khách hàng mua từ 5 sản phẩm trở lên thì Tỷ lệ giảm là 5%
--10. Tính số tiền bán của mỗi sản phẩm dựa trên cột Thành tiền ở câu 9 và lưu vào bảng tạm. Xuất dữ liệu bảng tạm.
--11. Thêm vào bảng sản phẩm cột Số Tiền BHTT và cập nhật dữ liệu cho cột từ bảng tạm ở câu 10 (sử dụng con trỏ
--và kỹ thuật kết bảng trong câu lệnh update).
--12. Thêm vào bảng sản phẩm cột Giá Nhập biết rằng : Giá nhập = Đơn giá * 0.95
--13. Thêm vào bảng sản phẩm cột Số Tiền Nhập và cập nhật giá trị cột này biết rằng để tính số tiền nhập của một 
--sản phẩm sẽ tính bằng công thức: Số tiền nhập = Số lượng * Giá nhập.
--14. Tính Lợi nhuận biết rằng : Lợi nhuận = Số Tiền BHTT – Số tiền nhập.
--15. Giá nhập bằng bao nhiêu phần trăm Đơn giá thì có lời?