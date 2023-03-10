USE [QuanLyQuanAn]
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[ID] [varchar](10) NOT NULL,
	[USERNAME] [varchar](50) NOT NULL,
	[PASSWORD] [varchar](10) NOT NULL,
	[PHANQUYEN] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BAOCAO]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAOCAO](
	[MABAOCAO] [varchar](10) NOT NULL,
	[LOAIBAOCAO] [nvarchar](30) NULL,
	[NGAYTAO] [date] NULL,
	[TONGDOANHTHU] [money] NULL,
	[GHICHU] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MABAOCAO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIETGIAOHANG]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETGIAOHANG](
	[MACTGH] [varchar](10) NOT NULL,
	[MAGH] [varchar](10) NULL,
	[NGAYVANCHUYEN] [date] NULL,
	[NGAYNHANHANG] [date] NULL,
	[TRANGTHAi] [nvarchar](40) NULL,
	[CHIPHIGH] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MACTGH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIETHOADONBAN]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETHOADONBAN](
	[MACTHDB] [varchar](10) NOT NULL,
	[MAHDBAN] [varchar](10) NULL,
	[MASP] [varchar](10) NULL,
	[SLBAN] [int] NULL,
	[THANHTIEN] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MACTHDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIETHOADONNHAP]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETHOADONNHAP](
	[MACTHDNHAP] [varchar](10) NOT NULL,
	[MAHDNHAP] [varchar](10) NULL,
	[MANL] [varchar](10) NULL,
	[SLNHAP] [int] NULL,
	[THANHTIEN] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MACTHDNHAP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GIAOHANG]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOHANG](
	[MAGH] [varchar](10) NOT NULL,
	[MAHDBAN] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MAGH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOADONBAN]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADONBAN](
	[MAHDBAN] [varchar](10) NOT NULL,
	[Ngay] [date] NULL,
	[MAKH] [varchar](10) NULL,
	[MANV] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MAHDBAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOADONNHAP]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADONNHAP](
	[MAHDNHAP] [varchar](10) NOT NULL,
	[NGAYNHAP] [date] NULL,
	[MANV] [varchar](10) NULL,
	[MANCC] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MAHDNHAP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOPDONG]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOPDONG](
	[MAHD] [varchar](10) NOT NULL,
	[MANCC] [varchar](10) NULL,
	[CAMKET] [text] NULL,
	[DIEUKHOAN] [text] NULL,
	[NGAYKYKET] [date] NULL,
	[NGAYKETTHUC] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MAHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHACHHANG](
	[MAKH] [varchar](10) NOT NULL,
	[HOTEN] [nvarchar](20) NOT NULL,
	[NAMSINH] [date] NULL,
	[SDT] [varchar](20) NULL,
	[DIACHI] [nvarchar](50) NULL,
	[EMAIL] [nvarchar](50) NULL,
	[SLDONDAMUA] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHUYENMAI]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHUYENMAI](
	[MAKM] [varchar](10) NOT NULL,
	[LOAIKM] [nvarchar](20) NULL,
	[CHIETKHAU] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MAKM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAISANPHAM]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAISANPHAM](
	[MALOAI] [varchar](10) NOT NULL,
	[TENLOAI] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MALOAI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NGUYENLIEU]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NGUYENLIEU](
	[MANL] [varchar](10) NOT NULL,
	[TENNL] [nvarchar](40) NOT NULL,
	[SOLUONG] [int] NULL,
	[DONVITINH] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MANL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHACUNGCAP]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHACUNGCAP](
	[MANCC] [varchar](10) NOT NULL,
	[TENNCC] [nvarchar](40) NOT NULL,
	[LIENHE] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MANCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN](
	[MANV] [varchar](10) NOT NULL,
	[HOTEN] [varchar](60) NOT NULL,
	[NAMSINH] [date] NULL,
	[SDT] [char](10) NULL,
	[DIACHI] [nvarchar](100) NULL,
	[EMAIL] [nvarchar](50) NULL,
	[CCCD] [nvarchar](12) NULL,
	[TRANGTHAI] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MANV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SANPHAM]    Script Date: 12/15/2022 10:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANPHAM](
	[MASP] [varchar](10) NOT NULL,
	[TENSP] [nvarchar](20) NOT NULL,
	[LOAISP] [varchar](10) NULL,
	[DONGIA] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[MASP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[KHACHHANG] ([MAKH], [HOTEN], [NAMSINH], [SDT], [DIACHI], [EMAIL], [SLDONDAMUA]) VALUES (N'KH01', N'Đỗ Trường Kỳ', CAST(N'2002-12-13' AS Date), N'031231231', N'12 Cầu Giấy', N'mothaiba@gmail.com', 4)
INSERT [dbo].[KHACHHANG] ([MAKH], [HOTEN], [NAMSINH], [SDT], [DIACHI], [EMAIL], [SLDONDAMUA]) VALUES (N'KH02', N'Lê Văn Phong', CAST(N'2002-10-09' AS Date), N'012314415', N'13 Cộng Hòa ', N'bonnamsau@gmail.com', 12)
GO
INSERT [dbo].[LOAISANPHAM] ([MALOAI], [TENLOAI]) VALUES (N'LSP01', N'Đồ ăn mặn')
INSERT [dbo].[LOAISANPHAM] ([MALOAI], [TENLOAI]) VALUES (N'LSP02', N'Đồ chay')
INSERT [dbo].[LOAISANPHAM] ([MALOAI], [TENLOAI]) VALUES (N'LSP03', N'Tráng miệng')
INSERT [dbo].[LOAISANPHAM] ([MALOAI], [TENLOAI]) VALUES (N'LSP04', N'Thức uống')
GO
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL01', N'Tôm hùm', 4, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL02', N'Bào ngư', 20, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL03', N'Vi cá mập', 10, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL04', N'Bạch tuộc', 12, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL05', N'Thịt bò kobe', 10, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL06', N'Sườn bò', 10, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL07', N'Đậu hũ non', 12, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL08', N'Đậu hà lan', 20, N'Hộp')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL09', N'Bông cải Brussels', 5, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL10', N'Măng tây', 6, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL11', N'Dưa hấu', 10, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL12', N'Siro', 10, N'Chai')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL13', N'Pepsi', 10, N'Thùng')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL14', N'Coca cola', 10, N'Thùng')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL15', N'Thơm', 10, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL16', N'Dầu oliu', 10, N'Chai')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL17', N'Bột ngọt', 10, N'Thùng')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL18', N'Muối', 10, N'Thùng')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL19', N'Đường đen', 5, N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MANL], [TENNL], [SOLUONG], [DONVITINH]) VALUES (N'NL20', N'Đường nâu', 10, N'Kg')
GO
INSERT [dbo].[NHANVIEN] ([MANV], [HOTEN], [NAMSINH], [SDT], [DIACHI], [EMAIL], [CCCD], [TRANGTHAI]) VALUES (N'NV01', N'Do Anh Duy', CAST(N'2001-11-14' AS Date), N'012310121 ', N'22 Tấn Hải', N'Toilaconmeo@gmail.com', N'123123121', 1)
INSERT [dbo].[NHANVIEN] ([MANV], [HOTEN], [NAMSINH], [SDT], [DIACHI], [EMAIL], [CCCD], [TRANGTHAI]) VALUES (N'NV02', N'Bui Chi Cuong', CAST(N'2002-10-12' AS Date), N'0123125144', N'11 Sư Vạn Hạnh', N'Conmeomapmap@gmail.com', N'41231231', 1)
INSERT [dbo].[NHANVIEN] ([MANV], [HOTEN], [NAMSINH], [SDT], [DIACHI], [EMAIL], [CCCD], [TRANGTHAI]) VALUES (N'NV03', N'Lam Trung Nghia', CAST(N'2002-01-03' AS Date), N'089765567 ', N'33 Lý Chính Thắng', N'Conmeobietyeu@gmail.com', N'9871412', 0)
INSERT [dbo].[NHANVIEN] ([MANV], [HOTEN], [NAMSINH], [SDT], [DIACHI], [EMAIL], [CCCD], [TRANGTHAI]) VALUES (N'NV04', N'Tran Anh Khoa', CAST(N'2002-07-11' AS Date), N'0456763123', N'44 Điện Biên Phủ', N'Conmeongungok@gmail.com', N'668975121', 1)
INSERT [dbo].[NHANVIEN] ([MANV], [HOTEN], [NAMSINH], [SDT], [DIACHI], [EMAIL], [CCCD], [TRANGTHAI]) VALUES (N'NV05', N'Nguyen Anh Tuan', CAST(N'2002-12-12' AS Date), N'0344412121', N'55 Lý Thường Kiệt', N'Conmeoluoibieng@gmail.com', N'09123134', 0)
GO
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP01', N'Cơm tấm', N'LSP01', CAST(35.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP02', N'Bún cá', N'LSP01', CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP03', N'Bún riu cua', N'LSP01', CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP04', N'Bún bò', N'LSP01', CAST(45.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP05', N'Bún thịt nướng ', N'LSP01', CAST(50.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP06', N'Mì quảng', N'LSP01', CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP07', N'Miến trộn', N'LSP01', CAST(32.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP08', N'Phở bò', N'LSP01', CAST(35.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP09', N'Mì chay', N'LSP02', CAST(45.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP10', N'Cơm chay', N'LSP02', CAST(55.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP11', N'Bánh mouse', N'LSP03', CAST(25.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP12', N'Bánh triramisu', N'LSP03', CAST(20.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP13', N'Bánh mật', N'LSP03', CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP14', N'Bánh tráng trộn', N'LSP03', CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP15', N'Bánh nhãn', N'LSP03', CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP16', N'Bánh plan', N'LSP03', CAST(17.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP17', N'Thạch', N'LSP03', CAST(12.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP18', N'Chè đậu khúc bạch', N'LSP03', CAST(32.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP19', N'Chè dưỡng nhan', N'LSP03', CAST(37.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP20', N'Chè bưởi', N'LSP03', CAST(22.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP21', N'Coca Cola', N'LSP04', CAST(12.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP22', N'Pepsi', N'LSP04', CAST(12.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP23', N'Nước ép thơm', N'LSP04', CAST(17.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP24', N'Nước ép dưa hấu', N'LSP04', CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP25', N'Nước ép ổi', N'LSP04', CAST(16.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP26', N'Soda đại dương', N'LSP04', CAST(22.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP27', N'Trà ô long', N'LSP04', CAST(26.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP28', N'Trà hoa cúc', N'LSP04', CAST(32.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP29', N'Trà xanh', N'LSP04', CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP30', N'Trà sữa thái xanh', N'LSP04', CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP31', N'Trà sữa truyền thống', N'LSP04', CAST(32.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP32', N'Trà nhài', N'LSP04', CAST(17.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP33', N'Trà đen', N'LSP04', CAST(14.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP34', N'Trà atiso đỏ', N'LSP04', CAST(18.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP35', N'Trà la mã', N'LSP04', CAST(22.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP36', N'Hồng trà', N'LSP04', CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP37', N'Trà hoa hồng', N'LSP04', CAST(12.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP38', N'Trà cam quế', N'LSP04', CAST(19.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP39', N'Trà chanh ', N'LSP04', CAST(16.00 AS Decimal(18, 2)))
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [LOAISP], [DONGIA]) VALUES (N'SP40', N'Cà phê đen đá', N'LSP04', CAST(15.00 AS Decimal(18, 2)))
GO
ALTER TABLE [dbo].[CHITIETGIAOHANG]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETGIAOHANG_GIAOHANG] FOREIGN KEY([MAGH])
REFERENCES [dbo].[GIAOHANG] ([MAGH])
GO
ALTER TABLE [dbo].[CHITIETGIAOHANG] CHECK CONSTRAINT [FK_CHITIETGIAOHANG_GIAOHANG]
GO
ALTER TABLE [dbo].[CHITIETHOADONBAN]  WITH CHECK ADD  CONSTRAINT [FK_CTHD_MAHD] FOREIGN KEY([MAHDBAN])
REFERENCES [dbo].[HOADONBAN] ([MAHDBAN])
GO
ALTER TABLE [dbo].[CHITIETHOADONBAN] CHECK CONSTRAINT [FK_CTHD_MAHD]
GO
ALTER TABLE [dbo].[CHITIETHOADONBAN]  WITH CHECK ADD  CONSTRAINT [FK_CTHDB_SANPHAM] FOREIGN KEY([MASP])
REFERENCES [dbo].[SANPHAM] ([MASP])
GO
ALTER TABLE [dbo].[CHITIETHOADONBAN] CHECK CONSTRAINT [FK_CTHDB_SANPHAM]
GO
ALTER TABLE [dbo].[CHITIETHOADONNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CTHDNHAP_MAHDNHAP] FOREIGN KEY([MAHDNHAP])
REFERENCES [dbo].[HOADONNHAP] ([MAHDNHAP])
GO
ALTER TABLE [dbo].[CHITIETHOADONNHAP] CHECK CONSTRAINT [FK_CTHDNHAP_MAHDNHAP]
GO
ALTER TABLE [dbo].[CHITIETHOADONNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CTHDNHAP_NGUYENLIEU] FOREIGN KEY([MANL])
REFERENCES [dbo].[NGUYENLIEU] ([MANL])
GO
ALTER TABLE [dbo].[CHITIETHOADONNHAP] CHECK CONSTRAINT [FK_CTHDNHAP_NGUYENLIEU]
GO
ALTER TABLE [dbo].[GIAOHANG]  WITH CHECK ADD  CONSTRAINT [FK_GIAOHANG_MAHDBAN] FOREIGN KEY([MAHDBAN])
REFERENCES [dbo].[HOADONBAN] ([MAHDBAN])
GO
ALTER TABLE [dbo].[GIAOHANG] CHECK CONSTRAINT [FK_GIAOHANG_MAHDBAN]
GO
ALTER TABLE [dbo].[HOADONBAN]  WITH CHECK ADD  CONSTRAINT [FK_HDBAN_KHACHHANG] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHACHHANG] ([MAKH])
GO
ALTER TABLE [dbo].[HOADONBAN] CHECK CONSTRAINT [FK_HDBAN_KHACHHANG]
GO
ALTER TABLE [dbo].[HOADONBAN]  WITH CHECK ADD  CONSTRAINT [FK_HDBAN_NHANVIEN] FOREIGN KEY([MANV])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[HOADONBAN] CHECK CONSTRAINT [FK_HDBAN_NHANVIEN]
GO
ALTER TABLE [dbo].[HOADONNHAP]  WITH CHECK ADD  CONSTRAINT [FK_HDNHAP_NHACUNGCAP] FOREIGN KEY([MANCC])
REFERENCES [dbo].[NHACUNGCAP] ([MANCC])
GO
ALTER TABLE [dbo].[HOADONNHAP] CHECK CONSTRAINT [FK_HDNHAP_NHACUNGCAP]
GO
ALTER TABLE [dbo].[HOADONNHAP]  WITH CHECK ADD  CONSTRAINT [FK_HDNHAP_NHANVIEN] FOREIGN KEY([MANV])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[HOADONNHAP] CHECK CONSTRAINT [FK_HDNHAP_NHANVIEN]
GO
ALTER TABLE [dbo].[HOPDONG]  WITH CHECK ADD  CONSTRAINT [FK_HOPDONG_NHACUNGCAP] FOREIGN KEY([MANCC])
REFERENCES [dbo].[NHACUNGCAP] ([MANCC])
GO
ALTER TABLE [dbo].[HOPDONG] CHECK CONSTRAINT [FK_HOPDONG_NHACUNGCAP]
GO
ALTER TABLE [dbo].[SANPHAM]  WITH CHECK ADD  CONSTRAINT [FK_SP_LOAISP] FOREIGN KEY([LOAISP])
REFERENCES [dbo].[LOAISANPHAM] ([MALOAI])
GO
ALTER TABLE [dbo].[SANPHAM] CHECK CONSTRAINT [FK_SP_LOAISP]
GO
