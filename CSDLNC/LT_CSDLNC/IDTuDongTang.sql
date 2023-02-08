--tu sinh masp
Create function	func_MaSP_TuDong (@lastMaSP varchar(10), @prefix varchar(3), @size int)
	returns varchar(10)
as
begin
	if(@lastMaSP='')
		set @lastMaSP=@prefix + REPLICATE (0,@size-LEN(@prefix))
	declare @numNextMaSP int, @nextMaSP varchar(10)
	set @lastMaSP = LTRIM(RTRIM(@lastMaSP))
	set @numNextMaSP = REPLACE(@lastMaSP,@prefix,'')+1
	set @size =@size - LEN(@prefix)
	set @nextMaSP = @prefix + REPLICATE (0,@size-LEN(@prefix))
	set @nextMaSP=@prefix+RIGHT(REPLICATE(0,@size) + CONVERT (varchar(Max),@numNextMaSP),@size)
	return @nextMaSP
end

alter trigger trg_NextMaSP 
on SANPHAM
for insert
as
	begin
		declare @lastMaSP varchar(10)
		set @lastMaSP = (select top 1 MASP from SANPHAM order by MASP desc)
		update SANPHAM
		set MASP= dbo.func_MaSP_TuDong (@lastMaSP, 'SP',4) where MASP=''
	end

insert into SANPHAM
(
	MASP,
	TENSP,
	LOAISP,
	DONGIA
)
values ('', 'Canh đậu', 'LSP01', 200);

select* from SANPHAM


--tu sinh ma nguyenlieu

Create function	func_MaNL_TuDong (@lastMaNL varchar(10), @prefix varchar(3), @size int)
	returns varchar(10)
as
begin
	if(@lastMaNL='')
		set @lastMaNL=@prefix + REPLICATE (0,@size-LEN(@prefix))
	declare @numNextMaNL int, @nextMaNL varchar(10)
	set @lastMaNL = LTRIM(RTRIM(@lastMaNL))
	set @numNextMaNL = REPLACE(@lastMaNL,@prefix,'')+1
	set @size =@size - LEN(@prefix)
	set @nextMaNL = @prefix + REPLICATE (0,@size-LEN(@prefix))
	set @nextMaNL=@prefix+RIGHT(REPLICATE(0,@size) + CONVERT (varchar(Max),@numNextMaNL),@size)
	return @nextMaNL
end

alter trigger trg_NextMaNL
on NGUYENLIEU
for insert
as
	begin
		declare @lastMaNL varchar(10)
		set @lastMaNL = (select top 1 MANL from NGUYENLIEU order by MANL desc)
		update NGUYENLIEU
		set MANL= dbo.func_MaSP_TuDong (@lastMaNL, 'NL',4) where MANL=''
	end


--tu sinh mahd
Create function	func_MaHD_TuDong (@lastMaHD varchar(10), @prefix varchar(3), @size int)
	returns varchar(10)
as
begin
	if(@lastMaHD=NULL)
		set @lastMaHD=@prefix + REPLICATE (0,@size-LEN(@prefix))
	declare @numNextMaHD int, @nextMaHD varchar(10)
	set @lastMaHD = LTRIM(RTRIM(@lastMaHD))
	set @numNextMaHD = REPLACE(@lastMaHD,@prefix,'')+1
	set @size =@size - LEN(@prefix)
	set @nextMaHD = @prefix + REPLICATE (0,@size-LEN(@prefix))
	set @nextMaHD=@prefix+RIGHT(REPLICATE(0,@size) + CONVERT (varchar(Max),@nextMaHD),@size)
	return @nextMaHD
end

alter trigger trg_NextMaSP 
on SANPHAM
for insert
as
	begin
		declare @lastMaSP varchar(10)
		set @lastMaSP = (select top 1 MASP from SANPHAM order by MASP desc)
		update SANPHAM
		set MASP= dbo.func_MaSP_TuDong (@lastMaSP, 'SP',4) where MASP=''
	end
