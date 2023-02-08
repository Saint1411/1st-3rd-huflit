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

