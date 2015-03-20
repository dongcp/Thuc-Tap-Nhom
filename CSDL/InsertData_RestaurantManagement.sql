USE RestaurantManagement
GO
EXECUTE NhapDV N'Bát'
GO
EXECUTE NhapDV N'Đĩa'
GO
EXECUTE NhapDV N'Cốc'
GO
EXECUTE NhapDV N'Lon'
GO
EXECUTE NhapDV N'Chai'
GO
EXECUTE NhapDV N'Chiếc'
GO
EXECUTE sp_Menu_Insert '2014-11-17','2014-11-23'
GO
EXECUTE sp_Menu_Insert '2014-11-24','2014-11-30'
GO
EXECUTE sp_Menu_Insert '2014-12-1','2014-12-7'
GO
EXECUTE sp_Staff_Insert N'Công Phương Đông','','8-26-1994',1
GO
EXECUTE sp_Staff_Insert N'Nguyễn Khoa Hưng','','8-26-1994',2
GO
EXECUTE sp_Staff_Insert N'Nguyễn Hữu Thanh','','8-26-1994',2
GO
EXECUTE sp_Staff_Insert N'Nguyễn Đức Việt','','8-26-1994',2
GO
EXECUTE NhapBan N'Bàn 1'
GO
EXECUTE NhapBan N'Bàn 2'
GO
EXECUTE NhapBan N'Bàn 3'
GO
EXECUTE NhapBan N'Bàn 4'
GO
EXECUTE NhapBan N'Bàn 5'
GO
EXECUTE sp_Promotion_Insert N'Mừng khai trương','2014-11-2','2014-11-9',10
GO
EXECUTE sp_Promotion_Insert N'Giáng sinh','2014-12-24','2014-12-25 23:59:00',15
GO
EXECUTE sp_Promotion_Insert N'Tết tây','2014-12-30','2015-1-2',15
GO
EXECUTE sp_Food_Insert N'Súp gà nấm hương',N'Đồ ăn',N'Món khai vị',N'Bát',13000
GO
EXECUTE sp_Food_Insert N'Nộm hải sản',N'Đồ ăn',N'Món khai vị',N'Đĩa',30000
GO
EXECUTE sp_Food_Insert N'Nộm sứa xoài xanh',N'Đồ ăn',N'Món khai vị',N'Đĩa',30000
GO
EXECUTE sp_Food_Insert N'Súp thập cẩm',N'Đồ ăn',N'Món khai vị',N'Bát',15000
GO
EXECUTE sp_Food_Insert N'Chân giò hun khói cuộn xoài xanh',N'Đồ ăn',N'Món chính',N'Đĩa',60000
GO
EXECUTE sp_Food_Insert N'Vịt om sấu',N'Đồ ăn',N'Món chính',N'Bát',70000
GO
EXECUTE sp_Food_Insert N'Mực tươi chiên bơ',N'Đồ ăn',N'Món chính',N'Đĩa',60000
GO
EXECUTE sp_Food_Insert N'Bò úc Fillet áp chảo sốt rượu vang đỏ',N'Đồ ăn',N'Món chính',N'Đĩa',90000
GO
EXECUTE sp_Food_Insert N'Tôm sú rang muối',N'Đồ ăn',N'Món chính',N'Đĩa',100000
GO
EXECUTE sp_Food_Insert N'Ba ba rang muối',N'Đồ ăn',N'Món chính',N'Đĩa',300000
GO
EXECUTE sp_Food_Insert N'Cơm rang thập cẩm',N'Đồ ăn',N'Món chính',N'Đĩa',60000
GO
EXECUTE sp_Food_Insert N'Cơm tám hương',N'Đồ ăn',N'Món chính',N'Bát',20000
GO
EXECUTE sp_Food_Insert N'Canh mọc nấm tuyết',N'Đồ ăn',N'Món chính',N'Bát',40000
GO
EXECUTE sp_Food_Insert N'Caramel',N'Đồ ăn',N'Món tráng miệng',N'Đĩa',40000
GO
EXECUTE sp_Food_Insert N'Hoa quả',N'Đồ ăn',N'Món tráng miệng',N'Đĩa',50000
GO
EXECUTE sp_Food_Insert N'Vodka',N'Đồ uống',NULL,N'Chai',200000
GO
EXECUTE sp_Food_Insert N'Chivas',N'Đồ uống',NULL,N'Chai',2200000
GO
EXECUTE sp_Food_Insert N'Coca',N'Đồ uống',NULL,N'Lon',15000
GO
EXECUTE sp_Food_Insert N'Lavie',N'Đồ uống',NULL,N'Chai',10000
GO
INSERT INTO ChiTietTD
VALUES('TD0001','MA0001'), ('TD0001','MA0002'), ('TD0001','MA0005'), ('TD0001','MA0006'), ('TD0001','MA0009'), ('TD0001','MA0010'),
	  ('TD0001','MA0013'), ('TD0001','MA0014'), ('TD0001','MA0015'), ('TD0001','MA0016'), ('TD0001','MA0017'), ('TD0001','MA0018'),
	  ('TD0002','MA0003'), ('TD0002','MA0004'), ('TD0002','MA0007'), ('TD0002','MA0008'), ('TD0002','MA0011'), ('TD0002','MA0012'), 
	  ('TD0002','MA0013'), ('TD0002','MA0014'), ('TD0002','MA0015'), ('TD0002','MA0016'), ('TD0002','MA0017'), ('TD0002','MA0018'),
	  ('TD0003','MA0001'), ('TD0003','MA0003'), ('TD0003','MA0005'), ('TD0003','MA0007'), ('TD0003','MA0009'), ('TD0003','MA0010'), 
	  ('TD0003','MA0013'), ('TD0003','MA0014'), ('TD0003','MA0015'), ('TD0003','MA0016'), ('TD0003','MA0017'), ('TD0003','MA0018')
GO
INSERT INTO ChiTietKM
VALUES('KM0001','MA0005'), ('KM0001','MA0006'), ('KM0001','MA0007'), ('KM0001','MA0010'), ('KM0001','MA0013'), ('KM0001','MA0014'),
	  ('KM0002','MA0004'), ('KM0002','MA0008'), ('KM0002','MA0009'), ('KM0002','MA0011'), ('KM0002','MA0012'), ('KM0002','MA0013'),
	  ('KM0003','MA0001'), ('KM0003','MA0002'), ('KM0003','MA0003'), ('KM0003','MA0009'), ('KM0003','MA0011'), ('KM0003','MA0012')
GO


--select * from Ban
--select * from DonVi
--select * from ThucDon
--select * from KhuyenMai
--select * from MonAn
--select * from ChiTietTD
--select * from NhanVien
--select * from HoaDon
--select * from ChiTietHD
--execute sp_Staff_Delete 'NV0003'
--execute sp_Staff_Update 'NV0003',N'Nguyễn Hữu Thanh','NV0003','1994-8-26',2,1
