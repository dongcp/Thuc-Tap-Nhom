USE RestaurantManagement
GO
CREATE FUNCTION GetNewId(@OldId varchar(10)) RETURNS varchar(10)
AS
BEGIN
	DECLARE @Id int
	SET @Id=CAST(RIGHT(@OldId,4) AS int) + 1
	DECLARE @temp varchar(10)
	SET @temp=LEFT(@OldId,LEN(@OldId)-4)+RIGHT('0000'+CAST(@Id AS varchar(10)),4)
	RETURN @temp
END
GO
CREATE PROCEDURE NhapHD @MaNV varchar(10), @GioVao datetime
AS
	DECLARE @NewId varchar(10), @OldId varchar(10)
	SELECT @OldId=MAX(MaHD) FROM HoaDon
	IF(@OldId IS NULL)
		SET @NewId='HD0001'
	ELSE
		SET @NewId=dbo.GetNewId(@OldId)
	INSERT INTO HoaDon VALUES(@NewId, @MaNV, @GioVao, null, null)
GO
-- Promotion table
CREATE PROCEDURE sp_Promotion_Insert @TenKM nvarchar(50), @NgayBatDau datetime, @NgayKetThuc datetime, @GiamGia int
AS
	DECLARE @OldId varchar(10), @NewId varchar(10)
	SELECT @OldId=MAX(MaKM) FROM KhuyenMai
	IF(@OldId IS NULL)
		SET @NewId='KM0001'
	ELSE
		SET @NewId=dbo.GetNewId(@OldId)
	INSERT INTO KhuyenMai VALUES(@NewId,@TenKM,@NgayBatDau,@NgayKetThuc,@GiamGia)
GO
CREATE PROC sp_Promotion_Update @maKm varchar(10), @tenKm nvarchar(50),@ngayBatDau date,@ngayKetThuc date,@giamGia int
AS
BEGIN
	UPDATE KhuyenMai SET TenKM = @tenKm,
						 NgayBatDau = @ngayBatDau,
						 NgayKetThuc = @ngayKetThuc,
						 GiamGia = @giamGia
	WHERE MaKM LIKE @maKm
END
GO
-- Promotion detail table
CREATE PROC sp_PromotionDetail_Insert @tenMa nvarchar(100),@tenKm nvarchar(100)
as
BEGIN
	declare @maKm varchar(10),@maMa varchar(10)
	SELECT @maKm = MaKM from KhuyenMai where @tenKm LIKE TenKM
	SELECT @maMa = MaMA from MonAn where @tenMa LIKE TenMonAn
	insert into ChiTietKM
	values(@maKm,@maMa)
end
GO
CREATE PROC sp_PromotionDetail_Update  @tenMa nvarchar(50),@tenKm nvarchar(50)
as
BEGIN
	declare @maMa varchar(10),@maKm varchar(10)
	SELECT @maMa = MaMA from MonAn where @tenMa = TenMonAn
	SELECT @maKm = MaKM from KhuyenMai where @tenKm = TenKM
	update ChiTietKM set MaMA = @maMa,
						MaKM = @maKm
END
GO
CREATE PROC sp_PromotionDetail_GetAll @TenKM nvarchar(100)
AS
BEGIN
	DECLARE @MaKM varchar(10)
	SELECT @MaKM=MaKM FROM KhuyenMai WHERE @TenKM LIKE TenKM
	SELECT TenMonAn
	FROM MonAn ma,ChiTietKM ctkm
	WHERE ma.MaMA=ctkm.MaMA AND
		  ctkm.MaKM=@MaKM
END
GO
CREATE PROC sp_PromotionDetail_Delete @TenMA nvarchar(100)
AS
BEGIN
	DECLARE @MaMA varchar(10)
	SELECT @MaMA=MaMA FROM MonAn WHERE TenMonAn LIKE @TenMA
	DELETE FROM ChiTietKM WHERE MaMA LIKE @MaMA
END
GO
CREATE PROCEDURE NhapDV @TenDV nvarchar(20)
AS
	DECLARE @OldId varchar(10), @NewId varchar(10)
	SELECT @OldId=MAX(MaDV) FROM DonVi
	IF(@OldId IS NULL)
		SET @NewId='DV0001'
	ELSE
		SET @NewId=dbo.GetNewId(@OldId)
	INSERT INTO DonVi VALUES(@NewId,@TenDV)
GO
CREATE PROCEDURE NhapBan @TenBan nvarchar(20)
AS
	DECLARE @OldId varchar(10), @NewId varchar(10)
	SELECT @OldId=MAX(MaBan) FROM Ban
	IF(@OldId IS NULL)
		SET @NewId='B0001'
	ELSE
		SET @NewId=dbo.GetNewId(@OldId)
	INSERT INTO Ban VALUES(@NewId,@TenBan,0)
GO
-- Food table
CREATE PROCEDURE sp_Food_Insert @TenMA nvarchar(100), @Nhom nvarchar(20), @Loai nvarchar(20), @DonVi nvarchar(20), @GiaTien float
AS
BEGIN
	DECLARE @OldId varchar(10), @NewId varchar(10), @MaDV varchar(10)
	SELECT @OldId=MAX(MaMA) FROM MonAn
	IF(@OldId IS NULL)
		SET @NewId='MA0001'
	ELSE
		SET @NewId=dbo.GetNewId(@OldId)
	SELECT @MaDV=MaDV FROM DonVi WHERE TenDV=@DonVi
	INSERT INTO MonAn VALUES(@NewId,@TenMA,@Nhom,@Loai,@MaDV,@GiaTien,0)
END
GO
CREATE PROC sp_Food_Update @MaMA varchar(10), @TenMA nvarchar(100), @Nhom nvarchar(20), @Loai nvarchar(20), @DonVi nvarchar(20), @GiaTien float, @TrangThai int
AS
BEGIN
	DECLARE @MaDV varchar(10)
	SELECT @MaDV=MaDV FROM DonVi WHERE TenDV=@DonVi
	UPDATE MonAn SET TenMonAn=@TenMA,
					 Nhom=@Nhom,
					 Loai=@Loai,
					 MaDV=@MaDV,
					 GiaTien=@GiaTien,
					 TrangThai=@TrangThai
	WHERE MaMA=@MaMA
END
GO
CREATE PROCEDURE sp_Food_GetAll
AS
BEGIN
	SELECT ma.MaMA, TenMonAn, Nhom, Loai, TenDV, GiaTien, TrangThai
	FROM MonAn ma, DonVi dv
	WHERE ma.MaDV=dv.MaDV
END
GO
CREATE PROC	sp_Food_GetList
AS
BEGIN
	SELECT ma.MaMA, TenMonAn, Nhom, Loai, TenDV, GiaTien, TrangThai
	FROM MonAn ma, DonVi dv
	WHERE ma.MaDV=dv.MaDV AND
		  TrangThai != 1
END
-- Bill table
GO
CREATE PROCEDURE sp_Bill_Insert @TenNV nvarchar(100)
AS
BEGIN
	DECLARE @MaNV varchar(10)
	SELECT @MaNV=MaNV FROM NhanVien WHERE @TenNV LIKE TenNV
	DECLARE @GioVao datetime
	SET @GioVao = GETDATE()
	EXECUTE NhapHD @MaNV, @GioVao
END
GO
CREATE PROCEDURE sp_BillDetail_Insert @mahoadon varchar(10),@tenMA nvarchar(100),@soluong int
AS
BEGIN
	DECLARE @mama varchar(10),@dongia float
	SELECT @mama =MaMA,@dongia = GiaTien FROM MonAn
	WHERE @tenMA = TenMonAn
	INSERT INTO ChiTietHD
	VALUES (@mahoadon,@mama,@dongia,@soluong,null)
END
GO
CREATE PROC sp_Bill_GetAll
AS
BEGIN
	SELECT MaHD, TenNV, CAST(GioVao AS date) Ngay, CAST(GioVao AS time) GioVao, CAST(GioRa AS time) GioRa, TongTien
	FROM HoaDon hd, NhanVien nv
	WHERE hd.MaNV=nv.MaNV
END
GO
CREATE PROCEDURE sp_Bill_Pay @MaHD varchar(10)
AS
BEGIN
	DECLARE @TongTien money, @MaMA varchar(10), @GiamGia int,@GioRa datetime, @DonGia int, @ThanhTien float, @SoLuong int
	DECLARE cur_MaMA cursor
	FORWARD_ONLY
	FOR
		SELECT MaMA
		FROM ChiTietHD
		WHERE @MaHD=MaHD
		OPEN cur_MaMA
		WHILE(0=0)
		BEGIN
			FETCH NEXT FROM cur_MaMA
			INTO @MaMA
			IF(@@FETCH_STATUS<>0)
				BREAK
			SET @GiamGia=NULL
			SELECT @GiamGia = GiamGia
			FROM ChiTietKM ctkm, KhuyenMai km
			WHERE MaMA LIKE @MaMA AND ctkm.MaKM LIKE km.MaKM AND 
				  DATEDIFF(DAY,NgayBatDau,GETDATE())>=0 AND DATEDIFF(DAY, GETDATE(), NgayKetThuc)>=0
			SELECT @DonGia=GiaTien, @SoLuong=SoLuong FROM ChiTietHD WHERE MaMA=@MaMA AND MaHD=@MaHD
			IF @GiamGia IS NULL
				SET @ThanhTien=@DonGia*@SoLuong
			ELSE
				SET @ThanhTien=(@DonGia-@DonGia*@GiamGia/100)*@SoLuong
			UPDATE ChiTietHD SET ThanhTien=@ThanhTien WHERE MaMA=@MaMA
		END
		CLOSE cur_MaMA
		DEALLOCATE cur_MaMA
		SELECT @TongTien=SUM(ThanhTien) FROM ChiTietHD WHERE MaHD=@MaHD
		SELECT @GioRa = GETDATE()
		UPDATE HoaDon SET GioRa=@GioRa, TongTien=@TongTien WHERE MaHD=@MaHD
		-- Set Trang Thai = 0
		DECLARE @MaBan varchar(10)
		DECLARE cur_MaHD cursor
			FORWARD_ONLY
			FOR
				SELECT MaBan FROM BanHD WHERE MaHD=@MaHD
				OPEN cur_MaHD
				WHILE 0=0
				BEGIN
					FETCH NEXT FROM cur_MaHD
					INTO @MaBan
					IF(@@FETCH_STATUS<>0)
						BREAK
					UPDATE Ban SET TrangThai=0 WHERE MaBan=@MaBan
				END
				CLOSE cur_MaHD
				DEALLOCATE cur_MaHD
END
GO
CREATE PROCEDURE sp_BillDetail_GetAll @MaHD varchar(10)
AS
BEGIN
	SELECT TenMonAn, SoLuong, ma.GiaTien, km.GiamGia, ThanhTien
	FROM ChiTietHD cthd, MonAn ma, ChiTietKM ctkm, KhuyenMai km
	WHERE ma.MaMA=cthd.MaMA AND
		  cthd.MaHD=@MaHD AND
		  ctkm.MaKM=km.MaKM AND
		  DATEDIFF(DAY,NgayBatDau,GETDATE())>=0 AND
		  DATEDIFF(DAY,GETDATE(),NgayKetThuc)>=0 AND
		  ctkm.MaMA=ma.MaMA
	UNION
	SELECT TenMonAn, SoLuong, ma.GiaTien, GiamGia=0, ThanhTien
	FROM ChiTietHD cthd, MonAn ma
	WHERE ma.MaMA=cthd.MaMA AND
		  cthd.MaHD=@MaHD AND
		  ma.MaMA NOT IN (SELECT MaMA
						  FROM ChiTietKM ctkm, KhuyenMai km
						  WHERE ctkm.MaKM=km.MaKM AND
								DATEDIFF(DAY,NgayBatDau,GETDATE())>=0 AND
								DATEDIFF(DAY,GETDATE(),NgayKetThuc)>=0)
END
GO
CREATE PROC sp_Bill_Delete @MaHD varchar(10)
AS
BEGIN
	DECLARE @GioVao datetime, @GioRa datetime, @MaBan varchar(10)
	SELECT @GioVao=GioVao FROM HoaDon WHERE MaHD LIKE @MaHD
	IF DATEDIFF(DAY,GETDATE(),@GioVao)=0
	BEGIN
		SELECT @GioRa=GioRa FROM HoaDon WHERE MaHD LIKE @MaHD
		IF @GioRa IS NOT NULL
			DELETE FROM HoaDon WHERE MaHD LIKE @MaHD
		ELSE
		BEGIN
			DECLARE cur_MaHD cursor
			FORWARD_ONLY
			FOR
				SELECT MaBan FROM BanHD WHERE MaHD LIKE @MaHD
				OPEN cur_MaHD
				WHILE 0=0
				BEGIN
					FETCH NEXT FROM cur_MaHD
					INTO @MaBan
					IF(@@FETCH_STATUS<>0)
						BREAK
					UPDATE Ban SET TrangThai=0 WHERE MaBan=@MaBan
				END
				CLOSE cur_MaHD
				DEALLOCATE cur_MaHD
			DELETE FROM HoaDon WHERE MaHD LIKE @MaHD
		END
	END
	ELSE
		DELETE FROM HoaDon WHERE MaHD LIKE @MaHD
END
GO
CREATE procedure sp_BillDetail_Delete @TenMonAn nvarchar(100),@MaHoaDon varchar(10)
as
begin
declare @mama varchar(10)
select @mama =MaMA from MonAn where @TenMonAn = TenMonAn 
	delete from ChiTietHD where MaMA = @mama and MaHD = @MaHoaDon
end
GO
CREATE PROC sp_BillDetail_Update @MaHD varchar(10),@TenMonCu nvarchar(100),@TenMonMoi nvarchar(100),@GiaTien money,@SoLuong int
AS
BEGIN
DECLARE @OldId varchar(10), @NewId varchar(10)
SELECT @OldId = MaMA from MonAn where TenMonAn = @TenMonCu
SELECT @NewId = MaMA from MonAn where TenMonAn = @TenMonMoi
SELECT @GiaTien=GiaTien from MonAn where @NewId LIKE MaMA
UPDATE ChiTietHD SET MaMA = @NewId,GiaTien = @GiaTien,
						SoLuong = @SoLuong
				where MaHD = @MaHD AND @OldId LIKE MaMA
END
GO
-- Menu table
CREATE PROCEDURE sp_Menu_Insert @NgayBatDau date, @NgayKetThuc date
AS
BEGIN
	DECLARE @OldId varchar(10), @NewId varchar(10)
	SELECT @OldId=MAX(MaTD) FROM ThucDon
	IF(@OldId IS NULL)
		SET @NewId='TD0001'
	ELSE
		SET @NewId=dbo.GetNewId(@OldId)
	INSERT INTO ThucDon VALUES(@NewId,@NgayBatDau,@NgayKetThuc)
END
GO
CREATE PROCEDURE sp_MenuDetail_Insert @mathucdon varchar(10),@tenmonan nvarchar(100)
AS 
BEGIN
	DECLARE @mamonan varchar (10)
	SELECT @mamonan=MaMA FROM MonAn WHERE @tenmonan=TenMonAn
	INSERT INTO ChiTietTD VALUES (@mathucdon,@mamonan)
END
GO
CREATE PROCEDURE sp_MenuDetail_GetAll @MaTD varchar(10)
AS
BEGIN
	SELECT TenMonAn, GiaTien, GiamGia
	FROM ChiTietTD cttd,MonAn ma, ChiTietKM ctkm, KhuyenMai km
	WHERE MaTD LIKE @MaTD AND
		  cttd.MaMA=ma.MaMA AND
		  ma.MaMA=ctkm.MaMA AND
		  ctkm.MaKM=km.MaKM AND
		  DATEDIFF(DAY,NgayBatDau,GETDATE())>=0 AND
		  DATEDIFF(DAY,GETDATE(),NgayKetThuc)>=0
	UNION
	SELECT TenMonAn, GiaTien, GiamGia=0
	FROM ChiTietTD cttd, MonAn ma
	WHERE cttd.MaMA=ma.MaMA AND
		  cttd.MaTD=@MaTD AND
		  ma.MaMA NOT IN (SELECT MaMA
						  FROM ChiTietKM ctkm, KhuyenMai km
						  WHERE ctkm.MaKM=km.MaKM AND
							    DATEDIFF(DAY,NgayBatDau,GETDATE())>=0 AND
							    DATEDIFF(DAY,GETDATE(),NgayKetThuc)>=0)
END
GO
CREATE PROC sp_Menu_Update @MaTD varchar(10),@NgayBatDau date,@NgayKetThuc date
AS
BEGIN
	
	UPDATE ThucDon SET 
					   NgayBatDau=@NgayBatDau,
					   NgayKetThuc=@NgayKetThuc
				
	WHERE MaTD LIKE @MaTD
END
go
create proc sp_MenuDetail_Update @MonCu nvarchar(100), @MonMoi nvarchar(100)
as 
begin
	DECLARE @MaCu varchar(10), @MaMoi varchar(10), @GiaTien int
	SELECT @MaCu=MaMA FROM MonAn WHERE TenMonAn LIKE @MonCu
	SELECT @MaMoi=MaMA FROM MonAn WHERE TenMonAn LIKE @MonMoi
	UPDATE ChiTietTD SET MaMA=@MaMoi WHERE MaMA LIKE @MaCu
end
go
create proc sp_MenuDetail_Delete @TenMA nvarchar(100)
as
begin
 Declare @MaMA varchar(10)
 select @MaMA=MaMA from MonAn where TenMonAn LIKE @TenMA
 delete from ChiTietTD where MaMA=@MaMA
end
GO
-- Staff table
CREATE PROCEDURE sp_Staff_Insert @TenNV nvarchar(100), @MatKhau varchar(20), @NgaySinh datetime, @ChucVu int
AS
BEGIN
	DECLARE @OldId varchar(10), @NewId varchar(10)
	SELECT @OldId=MAX(MaNV) FROM NhanVien
	IF(@OldId IS NULL)
		SET @NewId='NV0001'
	ELSE
		SET @NewId=dbo.GetNewId(@OldId)
	IF @MatKhau=''
		SET @MatKhau=@NewId		
	INSERT INTO NhanVien VALUES(@NewId,@TenNV,@MatKhau,@NgaySinh,@ChucVu,1)
END
GO
CREATE PROCEDURE sp_Staff_Update @MaNV varchar(10), @TenNV nvarchar(100), @MatKhau varchar(20), @NgaySinh datetime, @ChucVu int, @TrangThai int
AS
BEGIN
	UPDATE NhanVien SET TenNV=@TenNV,
						MatKhau=@MatKhau,
						NgaySinh=@NgaySinh,
						ChucVu=@ChucVu,
						TrangThai=@TrangThai
	WHERE MaNV LIKE @MaNV
END
GO
CREATE PROC sp_Staff_GetAll
AS
BEGIN
	SELECT MaNV, TenNV, MatKhau, NgaySinh, ChucVu=
	CASE
		WHEN ChucVu = 1 THEN N'Chủ nhà hàng'
		ELSE N'Nhân viên'
	END,
	TrangThai=
	CASE
		WHEN TrangThai=1 THEN N'Đang làm'
		ELSE N'Đã nghỉ'
	END
	FROM NhanVien
END
GO
-- Đưa ra doanh thu theo ngày 
CREATE PROC sp_Income_ByDay
AS
BEGIN
	SELECT N'Ngày' = CAST(GioVao AS date), N'Tổng tiền' = SUM(TongTien)
	FROM HoaDon
	GROUP BY CAST(GioVao AS date)
END
GO
-- Đưa ra doanh thu theo tháng
CREATE PROC sp_Income_ByMonth
AS
BEGIN
	SELECT N'Tháng' = MONTH(GioVao), N'Năm' = YEAR(GioVao), N'Tổng tiền' = SUM(TongTien)
	FROM HoaDon
	GROUP BY MONTH(GioVao), YEAR(GioVao)
END
GO
-- Đưa ra doanh thu theo năm
CREATE PROC sp_Income_ByYear
AS
BEGIN
	SELECT N'Năm' = YEAR(GioVao), N'Tổng tiền' = SUM(TongTien)
	FROM HoaDon
	GROUP BY YEAR(GioVao)
END
GO
--- Đưa ra số lần được gọi của các món ăn theo ngày
CREATE PROC sp_CallFood_ByDay
AS
BEGIN
	SELECT N'Ngày' = CAST(GioVao AS date), N'Mã món ăn'=ma.MaMA, N'Tên món ăn'=ma.TenMonAn, N'Số lần gọi'=SUM(SoLuong)
	FROM ChiTietHD cthd, MonAn ma,HoaDon hd
	WHERE cthd.MaMA=ma.MaMA AND
		  cthd.MaHD=hd.MaHD
	GROUP BY ma.MaMA,ma.TenMonAn,CAST(GioVao AS date)
END
GO
-- Đưa ra số lần được gọi của các món ăn theo tháng
CREATE PROC sp_CallFood_ByMonth
AS
BEGIN
	SELECT N'Tháng' = MONTH(GioVao), N'Năm'=YEAR(GioVao), N'Mã món ăn'=ma.MaMA, N'Tên món ăn'=ma.TenMonAn, N'Số lần gọi'=SUM(SoLuong)
	FROM ChiTietHD cthd, MonAn ma,HoaDon hd
	WHERE cthd.MaMA=ma.MaMA AND
		  cthd.MaHD=hd.MaHD
	GROUP BY ma.MaMA,ma.TenMonAn,MONTH(GioVao),YEAR(GioVao)
END
GO
-- Đưa ra số lần được gọi của các món ăn theo năm
CREATE PROC sp_CallFood_ByYear
AS
BEGIN
	SELECT N'Năm'=YEAR(GioVao), N'Mã món ăn'=ma.MaMA, N'Tên món ăn'=ma.TenMonAn, N'Số lần gọi'=SUM(SoLuong)
	FROM ChiTietHD cthd, MonAn ma,HoaDon hd
	WHERE cthd.MaMA=ma.MaMA AND
		  cthd.MaHD=hd.MaHD
	GROUP BY ma.MaMA, ma.TenMonAn, YEAR(GioVao)
END
GO
-- Đưa ra món ăn được gọi nhiều nhất mỗi ngày
CREATE PROC sp_MaxCall_ByDay
AS
BEGIN
SELECT N'Ngày'=temp3.Ngay, N'Mã món ăn'=MaMA, N'Tên món ăn'=TenMonAn, N'Số lần gọi'=SoLuong
FROM
	(SELECT CAST(GioVao AS date) Ngay, ma.MaMA, TenMonAn, SUM(SoLuong) SoLuong
	FROM ChiTietHD cthd, MonAn ma,HoaDon hd
	WHERE cthd.MaMA=ma.MaMA AND
		  cthd.MaHD=hd.MaHD
	GROUP BY ma.MaMA,TenMonAn,CAST(GioVao AS date)) AS temp3,
	(SELECT Ngay, MAX(SoLanGoi) MaxLan
	 FROM (SELECT  MaMA, CAST(GioVao AS date) Ngay, SUM(SoLuong) SoLanGoi
		   FROM ChiTietHD cthd, HoaDon hd
		   WHERE cthd.MaHD=hd.MaHD
		   GROUP BY MaMA,CAST(GioVao AS date)) AS temp1
	 GROUP BY Ngay) AS temp2
WHERE DATEDIFF(DAY,temp2.Ngay,temp3.Ngay)=0 AND
	  SoLuong=MaxLan
END
GO
-- Đưa ra món ăn được gọi nhiều nhất mỗi tháng
CREATE PROC sp_MaxCall_ByMonth
AS
BEGIN
	SELECT N'Tháng'=temp3.Thang, N'Năm'=temp3.Nam, N'Mã món ăn'=MaMA, N'Tên món ăn'=TenMonAn, N'Số lần gọi'=SoLuong
	FROM
		(SELECT MONTH(GioVao) Thang, YEAR(GioVao) Nam, ma.MaMA, TenMonAn, SUM(SoLuong) SoLuong
		FROM ChiTietHD cthd, MonAn ma,HoaDon hd
		WHERE cthd.MaMA=ma.MaMA AND
			  cthd.MaHD=hd.MaHD
		GROUP BY ma.MaMA, TenMonAn, MONTH(GioVao), YEAR(GioVao)) AS temp3,
		(SELECT Thang, Nam, MAX(SoLanGoi) MaxLan
		 FROM (SELECT  MaMA, MONTH(GioVao) Thang, YEAR(GioVao) Nam, SUM(SoLuong) SoLanGoi
			   FROM ChiTietHD cthd, HoaDon hd
			   WHERE cthd.MaHD=hd.MaHD
			   GROUP BY MaMA, MONTH(GioVao), YEAR(GioVao)) AS temp1
		 GROUP BY Thang, Nam) AS temp2
	WHERE temp2.Thang=temp3.Thang AND
		  temp2.Nam=temp3.Nam AND
		  SoLuong=MaxLan
END
GO
-- Đưa ra món ăn được gọi nhiều nhất mỗi năm
CREATE PROC sp_MaxCall_ByYear
AS
BEGIN
	SELECT N'Năm'=temp3.Nam, N'Mã món ăn'=MaMA, N'Tên món ăn'=TenMonAn, N'Số lần gọi'=SoLuong
	FROM
		(SELECT YEAR(GioVao) Nam, ma.MaMA, TenMonAn, SUM(SoLuong) SoLuong
		FROM ChiTietHD cthd, MonAn ma,HoaDon hd
		WHERE cthd.MaMA=ma.MaMA AND
			  cthd.MaHD=hd.MaHD
		GROUP BY ma.MaMA, TenMonAn, YEAR(GioVao)) AS temp3,
		(SELECT Nam, MAX(SoLanGoi) MaxLan
		 FROM (SELECT  MaMA, YEAR(GioVao) Nam, SUM(SoLuong) SoLanGoi
			   FROM ChiTietHD cthd, HoaDon hd
			   WHERE cthd.MaHD=hd.MaHD
			   GROUP BY MaMA, YEAR(GioVao)) AS temp1
		 GROUP BY Nam) AS temp2
	WHERE temp2.Nam=temp3.Nam AND
		  SoLuong=MaxLan
END
GO
-- Đưa ra món ăn được gọi ít nhất mỗi ngày
CREATE PROC sp_MinCall_ByDay
AS
BEGIN
	SELECT N'Ngày'=temp3.Ngay, N'Mã món ăn'=MaMA, N'Tên món ăn'=TenMonAn, N'Số lần gọi'=SoLuong
	FROM
		(SELECT CAST(GioVao AS date) Ngay, ma.MaMA, TenMonAn, SUM(SoLuong) SoLuong
		FROM ChiTietHD cthd, MonAn ma,HoaDon hd
		WHERE cthd.MaMA=ma.MaMA AND
			  cthd.MaHD=hd.MaHD
		GROUP BY ma.MaMA,TenMonAn,CAST(GioVao AS date)) AS temp3,
		(SELECT Ngay, MIN(SoLanGoi) MinLan
		 FROM (SELECT  MaMA, CAST(GioVao AS date) Ngay, SUM(SoLuong) SoLanGoi
			   FROM ChiTietHD cthd, HoaDon hd
			   WHERE cthd.MaHD=hd.MaHD
			   GROUP BY MaMA,CAST(GioVao AS date)) AS temp1
		 GROUP BY Ngay) AS temp2
	WHERE DATEDIFF(DAY,temp2.Ngay,temp3.Ngay)=0 AND
		  SoLuong=MinLan
END
GO
-- Đưa ra món ăn được gọi ít nhất mỗi tháng
CREATE PROC sp_MinCall_ByMonth
AS
BEGIN
	SELECT N'Tháng'=temp3.Thang, N'Năm'=temp3.Nam, N'Mã món ăn'=MaMA, N'Tên món ăn'=TenMonAn, N'Số lần gọi'=SoLuong
	FROM
		(SELECT MONTH(GioVao) Thang, YEAR(GioVao) Nam, ma.MaMA, TenMonAn, SUM(SoLuong) SoLuong
		FROM ChiTietHD cthd, MonAn ma,HoaDon hd
		WHERE cthd.MaMA=ma.MaMA AND
			  cthd.MaHD=hd.MaHD
		GROUP BY ma.MaMA, TenMonAn, MONTH(GioVao), YEAR(GioVao)) AS temp3,
		(SELECT Thang, Nam, MIN(SoLanGoi) MinLan
		 FROM (SELECT  MaMA, MONTH(GioVao) Thang, YEAR(GioVao) Nam, SUM(SoLuong) SoLanGoi
			   FROM ChiTietHD cthd, HoaDon hd
			   WHERE cthd.MaHD=hd.MaHD
			   GROUP BY MaMA, MONTH(GioVao), YEAR(GioVao)) AS temp1
		 GROUP BY Thang, Nam) AS temp2
	WHERE temp2.Thang=temp3.Thang AND
		  temp2.Nam=temp3.Nam AND
		  SoLuong=MinLan
END
GO
-- Đưa ra món ăn được gọi ít nhất mỗi năm
CREATE PROC sp_MinCall_ByYear
AS
BEGIN
	SELECT N'Năm'=temp3.Nam, N'Mã món ăn'=MaMA, N'Tên món ăn'=TenMonAn, N'Số lần gọi'=SoLuong
	FROM
		(SELECT YEAR(GioVao) Nam, ma.MaMA, TenMonAn, SUM(SoLuong) SoLuong
		FROM ChiTietHD cthd, MonAn ma,HoaDon hd
		WHERE cthd.MaMA=ma.MaMA AND
			  cthd.MaHD=hd.MaHD
		GROUP BY ma.MaMA, TenMonAn, YEAR(GioVao)) AS temp3,
		(SELECT Nam, MIN(SoLanGoi) MinLan
		 FROM (SELECT  MaMA, YEAR(GioVao) Nam, SUM(SoLuong) SoLanGoi
			   FROM ChiTietHD cthd, HoaDon hd
			   WHERE cthd.MaHD=hd.MaHD
			   GROUP BY MaMA, YEAR(GioVao)) AS temp1
		 GROUP BY Nam) AS temp2
	WHERE temp2.Nam=temp3.Nam AND
		  SoLuong=MinLan
END
GO
CREATE PROC sp_BanHD_Insert @MaHD varchar(10), @TenBan nvarchar(50)
AS
BEGIN
	DECLARE @MaBan varchar(10)
	SELECT @MaBan=MaBan FROM Ban WHERE TenBan LIKE @TenBan
	INSERT INTO BanHD
	VALUES(@MaHD,@MaBan)
	UPDATE Ban SET TrangThai=1 WHERE MaBan=@MaBan
END
GO
CREATE PROC sp_BanHD_GetTable @MaHD varchar(10)
AS
BEGIN
	SELECT TenBan
	FROM Ban b, BanHD bhd
	WHERE b.MaBan=bhd.MaBan AND
		  MaHD LIKE @MaHD
END
GO
CREATE PROC sp_BanHD_Update @MaHD varchar(10), @BanCu nvarchar(50), @BanMoi nvarchar(50)
AS
BEGIN
	DECLARE @NewID varchar(10), @OldID varchar(10)
	SELECT @NewID=MaBan FROM Ban WHERE TenBan LIKE @BanMoi
	SELECT @OldID=MaBan FROM Ban WHERE TenBan LIKE @BanCu
	UPDATE BanHD SET MaBan=@NewID WHERE MaBan LIKE @OldID
	UPDATE Ban SET TrangThai=1 WHERE MaBan LIKE @NewID
	UPDATE Ban SET TrangThai=0 WHERE MaBan LIKE @OldID
END
GO
CREATE PROC sp_BanHD_Delete @MaHD varchar(10), @TenBan nvarchar(50)
AS
BEGIN
	DECLARE @MaBan varchar(10)
	SELECT @MaBan=MaBan FROM Ban WHERE TenBan LIKE @TenBan
	DELETE FROM BanHD WHERE MaHD LIKE @MaHD AND MaBan LIKE @MaBan
	UPDATE Ban SET TrangThai=0 WHERE MaBan LIKE @MaBan
END
