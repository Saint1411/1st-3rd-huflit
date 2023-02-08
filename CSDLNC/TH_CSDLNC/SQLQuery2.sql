use master

Create database TH06
Use TH06

Create table CHAMCONG
(
	NGAY DATE,
	MANV CHAR(10),
	SOGIO INT
)
Create table NHANVIEN
(
	MANV CHAR(10) PRIMARY KEY,
	HOTEN NVARCHAR(20),
	GIOITINH NVARCHAR(3)
)

INSERT INTO dbo.NHANVIEN
(
    MANV,
    HOTEN,
	GIOITINH
)
VALUES
('NV01',N'Nguyễn Kiên',N'Nam'),
('NV02',N'Lưu Tú',N'Nữ'),
('NV03',N'Đinh Hiền',N'Nữ');


set dateformat dmy
INSERT INTO dbo.CHAMCONG
(
    NGAY,
	MANV,
	SOGIO
)
VALUES
('31/8/2020','NV01',7),
('31/8/2020','NV02',7),
('31/8/2020','NV03',8),
('1/9/2020','NV01',4),
('1/9/2020','NV02',8),
('2/9/2020','NV01',2),
('2/9/2020','NV02',8),
('2/9/2020','NV03',8);


select *
from NHANVIEN

select *
from CHAMCONG

--Yêu cầu: Viết mã nguồn SQL sử dụng biến con trỏ và cập nhật dữ liệu cho các cột sau.
--1. Thêm vào cột Số ngày làm việc vào bảng lưu thông tin nhân viên.
alter table NHANVIEN
	ADD SONGAYLAMVIEC INT

----Thủ tục
create proc sp_SoNgayLamViec  ---k có tham số đầu vào, ra
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		declare @SoNgayCong int		---khai báo biến cục bộ ngày công

		while @@FETCH_STATUS=0
		begin
			select @SoNgayCong=COUNT(NGAY)
			from CHAMCONG
			where CHAMCONG.MANV=@manv
			---cap nhat cột songaylamviec trong bảng nv
			update NHANVIEN
			set SONGAYLAMVIEC=@SoNgayCong
			WHERE MANV=@manv
			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

---Thực thi
exec sp_SoNgayLamViec
select * from NHANVIEN
--2. Thêm vào cột Số ngày làm việc trong tháng 8 vào bảng lưu thông tin nhân viên.
alter table NHANVIEN
	ADD SONGAYLAMVIECT8 INT

---Viết thủ tục
create proc sp_SoNgayLamViecT8
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		declare @SoNgayCong int		---khai báo biến cục bộ ngày công

		while @@FETCH_STATUS=0
		begin
			select @SoNgayCong=COUNT(NGAY)
			from CHAMCONG
			where CHAMCONG.MANV=@manv AND MONTH(NGAY)=8
			---cap nhat cột songaylamviec trong bảng nv
			update NHANVIEN
			set SONGAYLAMVIECT8=@SoNgayCong
			WHERE MANV=@manv
			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_SoNgayLamViecT8
select * from NHANVIEN

----3. Thêm vào cột Số ngày làm việc trong tháng 9 vào bảng lưu thông tin nhân viên.
alter table NHANVIEN
	ADD SONGAYLAMVIECT9 INT

select* from NHANVIEN
	---Viết thủ tục
create proc sp_SoNgayLamViecT9
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		declare @SoNgayCong int		---khai báo biến cục bộ ngày công

		while @@FETCH_STATUS=0
		begin
			select @SoNgayCong=COUNT(NGAY)
			from CHAMCONG
			where CHAMCONG.MANV=@manv AND MONTH(NGAY)=9
			---cap nhat cột songaylamviec trong bảng nv
			update NHANVIEN
			set SONGAYLAMVIECT9=@SoNgayCong
			WHERE MANV=@manv
			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_SoNgayLamViecT9
select * from NHANVIEN
----4. Thêm vào cột Số giờ làm việc trong tháng 8 vào bảng lưu thông tin nhân viên.
alter table NHANVIEN
	ADD SONGIOLAMVIECT8 INT

create proc sp_SoGioLamViecT8
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		declare @SoGioLamViec int		---khai báo biến cục bộ ngày công

		while @@FETCH_STATUS=0
		begin
			select @SoGioLamViec=SOGIO
			from CHAMCONG
			where CHAMCONG.MANV=@manv and MONTH(NGAY)=8
			---cap nhat cột songaylamviec trong bảng nv
			update NHANVIEN
			set SONGIOLAMVIECT8=@SoGioLamViec
			WHERE MANV=@manv
			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_SoGioLamViecT8
select * from NHANVIEN
----5. Thêm vào cột Số giờ làm việc trong tháng 9 vào bảng lưu thông tin nhân viên.
alter table NHANVIEN
	ADD SONGIOLAMVIECT9 INT



create proc sp_SoGioLamViecT9
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		declare @SoGioLamViec int		---khai báo biến cục bộ ngày công

		while @@FETCH_STATUS=0
		begin
			select @SoGioLamViec=SOGIO
			from CHAMCONG
			where CHAMCONG.MANV=@manv and MONTH(NGAY)=9
			---cap nhat cột songaylamviec trong bảng nv
			update NHANVIEN
			set SONGIOLAMVIECT9=@SoGioLamViec
			WHERE MANV=@manv
			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_SoGioLamViecT9
select * from NHANVIEN
----Biết rằng tiền công mỗi giờ của nhân viên là 300.
----6. Thêm cột Tiền công tháng 8 vào bảng lưu thông tin nhân viên.
alter table NHANVIEN
	ADD TIENCONGT8 INT

create proc sp_TienCongT8
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		declare @tiencong int		---khai báo biến cục bộ ngày công

		while @@FETCH_STATUS=0
		begin
			select @tiencong=SOGIO*300
			from CHAMCONG
			where CHAMCONG.MANV=@manv and MONTH(NGAY)=8
			---cap nhat cột songaylamviec trong bảng nv
			update NHANVIEN
			set TIENCONGT8=@tiencong
			WHERE MANV=@manv
			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_TienCongT8
select * from NHANVIEN
----7. Thêm cột Tiền công tháng 9 vào bảng lưu thông tin nhân viên.
alter table NHANVIEN
	ADD TIENCONGT9 INT


create proc sp_TienCongT9
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		declare @tiencong int		---khai báo biến cục bộ ngày công

		while @@FETCH_STATUS=0
		begin
			select @tiencong=SOGIO*300
			from CHAMCONG
			where CHAMCONG.MANV=@manv and MONTH(NGAY)=9
			---cap nhat cột songaylamviec trong bảng nv
			update NHANVIEN
			set TIENCONGT9=@tiencong
			WHERE MANV=@manv
			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_TienCongT9
select * from NHANVIEN
--Biết rằng trong tháng, nếu nhân viên làm việc từ 2 ngày trở lên sẽ được được nhận phụ cấp.
--8. Thêm cột có phụ cấp tháng 8 vào bảng nhân viên nếu nhân viên được nhận phụ cấp thì ghi “Có Phụ cấp”

alter table NHANVIEN
	ADD PHUCAP NVARCHAR(20)



alter proc sp_phucap
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		

		while @@FETCH_STATUS=0
		begin
			declare @phucap nvarchar(20)
			declare @kq int
			select @kq =SONGAYLAMVIECT8
			from NHANVIEN
			where MANV=@manv
			if @kq>2
				begin
					SET @phucap=N'Có phụ cấp'
					update NHANVIEN
					set PHUCAP=@phucap
					WHERE MANV=@manv
				end
			else
					SET @phucap=N'không có phụ cấp'
					update NHANVIEN
					set PHUCAP=@phucap
					WHERE MANV=@manv
			---cap nhat cột songaylamviec trong bảng nv

			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_phucap
select * from NHANVIEN
--9. Thêm cột có phụ cấp tháng 9 vào bảng nhân viên nếu nhân viên được nhận phụ cấp thì ghi “Có Phụ cấp”
alter table NHANVIEN
	ADD PHUCAPT9 NVARCHAR(20)
SELECT* FROM NHANVIEN

CREATE proc sp_phucapT9
as
	begin
		Declare @manv char(10)  ---khai báo biến cục bộ
		---B1: khai báo con trỏ
		declare cr_update cursor ----khai báo biến con trỏ
		for select MANV from NHANVIEN ---lấy ra mã nhân viên

		---B2: mở con trỏ
		open cr_update
		---B3: Xử lý
		fetch next from cr_update into @manv ---di chuyển con trỏ đến Record đầu tiên để đọc dữ liệu MAVN vào trong @manv

		

		while @@FETCH_STATUS=0
		begin
			declare @phucap nvarchar(20)
			declare @kq int
			select @kq =SONGAYLAMVIECT9
			from NHANVIEN
			where MANV=@manv
			if @kq>2
				begin
					SET @phucap=N'Có phụ cấp'
					update NHANVIEN
					set PHUCAPT9=@phucap
					WHERE MANV=@manv
				end
			else
					SET @phucap=N'không có phụ cấp'
					update NHANVIEN
					set PHUCAPT9=@phucap
					WHERE MANV=@manv
			---cap nhat cột songaylamviec trong bảng nv

			---di chuyển con trỏ qua record kế tiếp, đọc MANV -> @manv
			fetch next from cr_update into @manv
		end ---end của while
		close cr_update
		deallocate cr_update
	end ---end của proc

exec sp_phucapT9
select * from NHANVIEN
--Biết rằng tiền phụ cấp được tính như sau: 1) Nếu số ngày từ 2 đến 3 ngày thì phụ cấp bằng 20% Tiền công. 2) Nếu 
--số ngày trên 3 thì phụ cấp bằng 30% Tiền công. 3) Nếu giới tính của nhân viên là Nữ thì cộng thêm 15% Tiền công.
--10. Thêm cột Tiền phụ cấp tháng 8 vào bảng lưu thông tin nhân viên.
--11. Thêm cột Tiền phụ cấp tháng 9 vào bảng lưu thông tin nhân viên.
--Biết rằng số giờ công trong tháng của nhân viên từ 10 trở lên thì nhân viên sẽ được thưởng. Tiền thưởng bằng 10% 
--tiền công và nếu là nhân viên nữ thì mỗi giờ công làm được sẽ được thưởng thêm 1% tương ứng với mỗi giờ. Ví dụ
--nữ nhân viên làm 10 giờ công thì được thưởng 10% cộng thêm 10% là 20%.
--12. Thêm cột tiền Thưởng tháng 8 vào bảng nhân viên.
--13. Thêm cột tiền Thưởng tháng 9 vào bảng nhân viên.
--Biết rằng nếu trong một tháng mà nhân viên làm dưới 8 tiếng thì sẽ bị trừ 10% tiền công cả tháng.
--14. Thêm cột Tiền Phạt tháng 8 vào bảng lưu thông tin nhân viên.
--15. Thêm cột Tiền Phạt tháng 9 vào bảng lưu thông tin nhân viên.
--Biết rằng tiền lương = Tiền công + Phụ cấp + Tiền thưởng - tiền phạt.
--16. Thêm cột Tiền Lương tháng 8 vào bảng lưu thông tin nhân viên.
--17. Thêm cột Tiền Lương tháng 9 vào bảng lưu thông tin nhân viên.
--Cuối tháng, công ty sẽ đánh giá chỉ tiêu của nhân viên. Nếu nhân viên làm dưới 8 tiếng thì Chỉ Tiêu là “Chưa Đạt”. 
--Nếu nhân viên làm từ 8 tiếng trở lên thì ghi là “Đạt”.
--18. Thêm cột Chỉ Tiêu tháng 8 vào bảng lưu thông tin nhân viên.
--19. Thêm cột Chỉ Tiêu tháng 9 vào bảng lưu thông tin nhân viên.
--Nếu nhân viên có Chỉ Tiêu là Chưa Đạt trong 2 tháng liên tiếp thì sẽ bị kỷ luật.
--20. Thêm cột Kỷ Luật vào bảng lưu thông tin nhân viên.
--21. Xuất ra thông tin của nhân viên bị kỷ luật.
--Biết rằng nếu nhân viên bị kỷ luật thì sẽ không được nhận lương tháng 9 mà còn bị phạt thêm 10% lương tháng 9 trừ 
--thẳng vào lương tháng 8.
--22. Thêm cột tiền lương 2 tháng và cập nhật tiền lương cho từng nhân viên.
--23. Biết rằng nếu nhân viên được có thái độ Đạt trong 2 tháng 8 và 9 thì được thưởng thêm 30% tiền lương cả 2 
--tháng 8 và 9. Thêm cột Tiền Thưởng Chỉ Tiêu vào bảng lưu thông tin nhân viên.
--24. Tính tổng số tiền mà mỗi nhân viên sẽ nhận sau 2 tháng