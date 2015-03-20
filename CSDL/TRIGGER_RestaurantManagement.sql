USE RestaurantManagement
GO
CREATE TRIGGER CheckDateTD ON ThucDon
AFTER INSERT, UPDATE
AS
	IF UPDATE(NgayKetThuc)
	BEGIN
		DECLARE @NgayBatDau datetime, @NgayKetThuc datetime
		SELECT @NgayBatDau=NgayBatDau FROM inserted
		SELECT @NgayKetThuc=NgayKetThuc FROM inserted
		IF(@NgayKetThuc<@NgayBatDau)
		BEGIN
			RAISERROR(N'Ngày bắt đầu lớn hơn ngày kết thúc!',16,1)
			ROLLBACK TRAN
			RETURN
		END
	END
GO
CREATE TRIGGER CheckDateKM ON KhuyenMai
AFTER INSERT, UPDATE
AS
	IF UPDATE(NgayKetThuc)
	BEGIN
		DECLARE @NgayBatDau datetime, @NgayKetThuc datetime
		SELECT @NgayBatDau=NgayBatDau FROM inserted
		SELECT @NgayKetThuc=NgayKetThuc FROM inserted
		IF(@NgayKetThuc<@NgayBatDau)
		BEGIN
			RAISERROR(N'Ngày bắt đầu lớn hơn ngày kết thúc!',16,1)
			ROLLBACK TRAN
			RETURN
		END
	END
GO
CREATE TRIGGER CheckMoney ON MonAn
AFTER INSERT, UPDATE
AS
	IF UPDATE(GiaTien)
	BEGIN
		DECLARE @GiaTien money
		SELECT @GiaTien=GiaTien FROM inserted
		IF(@GiaTien<=0)
		BEGIN
			RAISERROR(N'Giá tiền âm!',16,1)
			ROLLBACK TRAN
			RETURN
		END
	END
GO
CREATE TRIGGER CheckIsValidFood ON ChiTietHD
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MaMA varchar(10)
	SELECT @MaMA=MaMA from inserted
	IF @MaMA NOT IN (SELECT MaMA
				 FROM ChiTietTD cttd, ThucDon td
				 WHERE DATEDIFF(DAY,NgayBatDau,GETDATE())>=0 AND
					   DATEDIFF(DAY,GETDATE(),NgayKetThuc)>=0 AND
					   td.MaTD=cttd.MaTD)
	BEGIN
		RAISERROR(N'Món ăn không có trong thực đơn hôm nay!',16,1)
		ROLLBACK TRAN
		RETURN
	END
END
GO
CREATE TRIGGER CheckFood ON ChiTietTD
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MaMA varchar(10), @TrangThai int
	SELECT @MaMA=MaMA FROM inserted
	SELECT @TrangThai=TrangThai FROM MonAn WHERE @MaMA=MaMA
	IF @TrangThai=1
	BEGIN
		RAISERROR('Món ăn không tồn tại!',16,1)
		ROLLBACK TRAN
		RETURN
	END
END
