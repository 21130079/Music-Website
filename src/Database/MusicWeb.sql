create database MusicWeb;
use MusicWeb;

--create table
create table singers(
	id_singer varchar(20) primary key,
	name_singer nvarchar(255) not null,
	yearOfBirth int 
);

create table songs(
	id_song varchar(20) primary key,
	id_singer varchar(20) foreign key  references singers(id_singer),
	name_song nvarchar(255) not null,
	duration time not null,
	genre nvarchar(255) not null,
	urlImg varchar(255) not null,
	urlAudio varchar(255) not null,
	songview int
);

create table accounts(
	username varchar(255) primary key,
	email varchar(255)not null,
	password_account nvarchar(255) not null,
);

create table roles_accounts (
	username varchar(255) foreign key references  accounts(username),
	roleUser varchar(255),
	primary key(roleUser,username)
)

create table history_premium_accounts(
	id int PRIMARY KEY IDENTITY,
	username varchar(255) foreign key references  accounts(username),
	type_premium int ,
	started_date date,
	finish_date date,
);

--x quan ly playlist-nhac
create table playlists(
	id_playlist varchar(20) ,
	name_playlist nvarchar(20) not null,
	username varchar(255) foreign key references  accounts(username),
	primary key(id_playlist,username)
	
);
	CREATE SEQUENCE seq_Playlist
	START WITH 1  INCREMENT BY 1;

	ALTER TABLE playlists
	ADD CONSTRAINT playlist_insert 
	DEFAULT  'PLA' + CAST(NEXT VALUE FOR seq_Playlist AS VARCHAR(17))
	FOR id_playlist ;

create table playlists_songs (
	username varchar(255) ,
	id_playlist varchar(20),
	id_song varchar(20) foreign key references songs(id_song),
	 foreign key(id_playlist,username) references playlists(id_playlist,username),
	primary key(id_playlist,id_song)
);
--(x) ds yeu thich
create table favorites(
	id_song varchar(20) foreign key references songs(id_song),
	username varchar(255) foreign key references  accounts(username),
	primary key(username,id_song)
);

create table logs(
	id_log varchar(255) primary key,
	nationality varchar(255) not null ,
	level_log varchar(255) not null,
	address_performing varchar(255) not null,
	pre_value varchar(255) ,
	current_value varchar(255),
	updated_date DATETIME DEFAULT GETDATE() not null ,
	exec_status char(25) not null
);
CREATE SEQUENCE seq_logs
	START WITH 1  INCREMENT BY 1;

	ALTER TABLE logs
	ADD CONSTRAINT logs_insert 
	DEFAULT  'lOG' + CAST(NEXT VALUE FOR seq_logs AS VARCHAR(252))
	FOR id_log ;


--VALUE	
--singer
INSERT INTO SINGERS (id_singer,name_Singer)
VALUES	('SN1', N'Anh Quân Idol, FreakD'),
		('SN2', N'Như Việt'),
		('SN3', N'EmceeL, Muoii'),
		('SN4', N'Bích Phương'),
		('SN5', N'Orange'),
		('SN6', N'PhongMax'),
		('SN7', N'Lil Zpoet'),
		('SN8', N'Phạm Nguyên Ngọc, Vanh'),
		('SN9', N'Nguyễn Trần Trung Quân, Nguyễn Thương, Air'),
		('SN10', N'Tăng Phúc'),

		('SN11', N'Double2T'),
		('SN12', N'DatG'),
		('SN13', N'Binz'),
		('SN14', N'Sơn Tùng MTP'),
		('SN15', N'Hoài Lâm'),
		('SN16', N'Thành Đạt'),
		('SN17', N'Soobin Hoàng Sơn'),
		('SN18', N'Hoàng Dũng'),
		('SN19', 'JungKook, JackHarlow'),
		('SN20', 'BRay'),

		('SN21', 'ONEUS'),
		('SN22', N'Tăng Duy Tân, Drum7'),
		('SN23', 'NCT127'),
		('SN24', 'LeagueOfLegends,NewJeans'),
		('SN25', 'DICKSON'),
		('SN26', N'Vũ Phụng Tiên, DT'),
		('SN27', 'MrSiro'),
		('SN28', 'Sean, Freaky'),
		('SN29', 'RichieDICY, Obito'),
		('SN30', N'Trịnh Đình Quang'),

		('SN31', 'XG'),
		('SN32', N'Vũ Thảo My'),
		('SN33', 'JENNIE'),
		('SN34', N'Anh Quân Idol'),
		('SN35', 'LilWuyn'),
		('SN36', N'BRay, Hoàng Tôn, Bảo Hân Helia'),
		('SN37', N'Double2T, Hòa Minzy, DươngK'),
		('SN38', N'AndreeRightHand'),
		('SN39', N'HIEUTHUHAI,HURRYKNG'),
		('SN40', N'HIEUTHUHAI,Kewtiie'),

		('SN41', N'Wxrdie,QNT'),
		('SN42', N'HIEUTHUHAI,HoangTon,Kewtiie'),
		('SN43', 'BRay,HanSara'),
		('SN44', N'Lê Quyên'),
		('SN45', N'Lưu Ánh Loan, Lê Sang'),
		('SN46', N'Quang Lê'),
		('SN47', N'Mạnh Quỳnh, Phi Nhung'),
		('SN48', N'Như Quỳnh'),
		('SN49', N'Như Quỳnh, Mạnh Quỳnh'),
		('SN50', N'Quang Lê, Hương Thủy'),

		('SN51', N'Phi Nhung'),
		('SN52', N'BRay, Masew');

--SONG

INSERT INTO SONGS(id_song,name_song,duration,genre,urlImg,urlAudio,songview,id_singer) VALUES
('SO01','3D', '00:03:20', 'POP', '/MusicWebsite/assets/img/POP/3D - JungKook,JackHarlow.png', '/MusicWebsite/assets/audio/POP/3D - JungKook,JackHarlow.mp3', 0,'SN19'),
('SO02', N'Anh Luôn Như Vậy', '00:03:32', 'POP',  '/MusicWebsite/assets/img/POP/AnhLuonNhuVay - BRay.png',  '/MusicWebsite/assets/audio/POP/AnhLuonNhuVay - BRay.mp3', 0,'SN20'),
('SO03', N'BailaConmigo', '00:03:04', 'POP',  '/MusicWebsite/assets/img/POP/BailaConmigo - ONEUS.png', '/MusicWebsite/assets/audio/POP/BailaConmigo - ONEUS.mp3', 0,'SN21'),
('SO04', N'Cắt Đôi Nổi Sầu', '00:03:02', 'POP',  '/MusicWebsite/assets/img/POP/CatDoiNoiSau - TangDuyTan,Drum7.png', '/MusicWebsite/assets/audio/POP/CatDoiNoiSau - TangDuyTan,Drum7.mp3', 0,'SN22'),
('SO05', N'E Là Không Thể', '00:05:09', 'POP',  '/MusicWebsite/assets/img/POP/ELaKhongThe - AnhQuanIdol.png', '/MusicWebsite/assets/audio/POP/ELaKhongThe - AnhQuanIdol.mp3', 0,'SN34'),
('SO06', 'Fact Check', '00:03:04', 'US-UK',  '/MusicWebsite/assets/img/US-UK/FactCheck - NCT127.png', '/MusicWebsite/assets/audio/US-UK/FactCheck - NCT127.mp3', 0,'SN23'),
('SO07', 'GODS', '00:03:40', 'US-UK',  '/MusicWebsite/assets/img/US-UK/GODS - LeagueOfLegends,NewJeans.png', '/MusicWebsite/assets/audio/US-UK/GODS - LeagueOfLegends,NewJeans.mp3', 0,'SN24'),
('SO08', N'Kiêu Ngạo', '00:03:56', 'POP'	,  '/MusicWebsite/assets/img/POP/KieuNgao - DICKSON.png', '/MusicWebsite/assets/audio/POP/KieuNgao - DICKSON.mp3', 0,'SN25'),
('SO09',N'Lệ Lưu Ly', '00:03:20', 'POP', '/MusicWebsite/assets/img/POP/LeLuuLy - VuPhungTien,DT.png', '/MusicWebsite/assets/audio/POP/LeLuuLy - VuPhungTien,DT.mp3', 0,'SN26'),
('SO10', N'Mẹ Hiểu Con Không', '00:04:58', 'POP',  '/MusicWebsite/assets/img/POP/MeHieuConKhong - MrSiro.png',  '/MusicWebsite/assets/audio/POP/MeHieuConKhong - MrSiro.mp3', 0,'SN27'),

('SO11', 'NgooNger', '00:02:56', 'POP',  '/MusicWebsite/assets/img/POP/NgooNger - Sean, Freaky.png', '/MusicWebsite/assets/audio/POP/NgooNger - Sean, Freaky.mp3', 0,'SN28'),
('SO12', 'NoBoundary', '00:02:33', 'US-UK',  '/MusicWebsite/assets/img/POP/NoBoundary - RichieDICY,Obito.png', '/MusicWebsite/assets/audio/US-UK/NoBoundary - RichieDICY,Obito.mp3', 0,'SN29'),
('SO13', N'Nói Anh Nghe', '00:05:11', 'POP',  '/MusicWebsite/assets/img/POP/NoiAnhNghe - TrinhDinhQuang.png', '/MusicWebsite/assets/audio/POP/NoiAnhNghe - TrinhDinhQuang.mp3', 0,'SN30'),
('SO14', 'PUPPETSHOW', '00:03:20', 'POP',  '/MusicWebsite/assets/img/POP/PUPPETSHOW - XG.png', '/MusicWebsite/assets/audio/POP/PUPPETSHOW - XG.mp3', 0,'SN31'),
('SO15', 'Silence', '00:03:53', 'POP',  '/MusicWebsite/assets/img/POP/Silence - VuThaoMy.png', '/MusicWebsite/assets/audio/POP/Silence - VuThaoMy.mp3', 0,'SN32'),
('SO16', 'YouMe', '00:02:59', 'KPOP',  '/MusicWebsite/assets/img/POP/YouMe - JENNIE.png', '/MusicWebsite/assets/audio/POP/YouMe - JENNIE.mp3', 0,'SN33'),
('SO17', N'À Lôi', '00:03:17', 'POP',  '/MusicWebsite/assets/img/POP/ALoi - Double2T.png', '/MusicWebsite/assets/audio/POP/ALoi - Double2T.mp3', 0,'SN11'),
('SO18', N'Anh Tự Do Nhưng Cô Đơn',  '00:04:52', 'POP',  '/MusicWebsite/assets/img/POP/AnhTuDoNhungCoDon - DatG.png', '/MusicWebsite/assets/audio/POP/AnhTuDoNhungCoDon - DatG.mp3', 0,'SN12'),
('SO19', 'Bigcityboi',  '00:03:21', 'POP',  '/MusicWebsite/assets/img/POP/Bigcityboi - Binz.png', '/MusicWebsite/assets/audio/POP/Bigcityboi - Binz.mp3', 0,'SN13'),
('SO20', N'Hoa Nở Không Màu',  '00:05:28', 'POP',  '/MusicWebsite/assets/img/POP/HoaNoKhongMau - HoaiLam.png','/MusicWebsite/assets/audio/POP/HoaNoKhongMau - HoaiLam.mp3', 0,'SN14'),		

('SO21', N'Hãy Trao Cho Anh',  '00:04:05', 'POP',  '/MusicWebsite/assets/img/POP/HayTraoChoAnh - SonTungMTP.png', '/MusicWebsite/assets/audio/POP/HayTraoChoAnh - SonTungMTP.mp3', 0,'SN15'),
('SO22', N'Ngày Mai Em Đi Mất',  '00:04:09', 'POP',  '/MusicWebsite/assets/img/POP/NgayMaiEmDiMat - DatG.png', '/MusicWebsite/assets/audio/POP/NgayMaiEmDiMat - DatG.mp3', 0,'SN12'),
('SO23', N'Ngày Mai Người Ta Lấy Chồng',  '00:06:01', 'POP', '/MusicWebsite/assets/img/POP/NgayMaiNguoiTaLayChong - ThanhDat.png', '/MusicWebsite/assets/audio/POP/NgayMaiNguoiTaLayChong - ThanhDat.mp3', 0,'SN16'),
('SO24', N'Như Những Phút Ban Đầu',  '00:05:34', 'POP',  '/MusicWebsite/assets/img/POP/NhuNhungPhutBanDau - HoaiLam.png', '/MusicWebsite/assets/audio/POP/NhuNhungPhutBanDau - HoaiLam.mp3', 0,'SN15'),
('SO25', N'Tháng Năm',  '00:03:01', 'POP',  '/MusicWebsite/assets/img/POP/ThangNam - SoobinHoangSon.png', '/MusicWebsite/assets/audio/POP/ThangNam - SoobinHoangSon.mp3', 0,'SN17'),
('SO26', N'Nàng Thơ',  '00:04:14', 'POP',  '/MusicWebsite/assets/img/Lofi Chill/NangTho - HoangDung.png', '/MusicWebsite/assets/audio/Lofi Chill/NangTho - HoangDung.mp3', 0,'SN18'),
('SO27', N'Anh Mệt Rồi',  '00:04:56', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/AnhMetRoi - AnhQuanIdol,FreakD.png', '/MusicWebsite/assets/audio/Lofi Chill/AnhMetRoi - AnhQuanIdol,FreakD.mp3', 0,'SN1'),
('SO28', N'Bông Hoa Chẳng Thuộc Về Ta',  '00:03:36', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/BongHoaChangThuocVeTa - NhuViet.png', '/MusicWebsite/assets/audio/Lofi Chill/BongHoaChangThuocVeTa - NhuViet.mp3', 0,'SN2'),
('SO29', N'Chuyện Đôi Ta',  '00:03:28', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/ChuyenDoiTa - EmceeL,Muoii.png', '/MusicWebsite/assets/audio/Lofi Chill/ChuyenDoiTa - EmceeL,Muoii.mp3', 0,'SN3'),	
('SO30', N'AN',  '00:03:09','Rap',  '/MusicWebsite/assets/img/Rap/AN - LilWuyn.png', '/MusicWebsite/assets/audio/Rap/AN - LilWuyn.mp3', 0,'SN35'),

('SO31', N'Em Bỏ Hút Thuốc Chưa',  '00:03:36', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/EmBoHutThuocChua - BichPhuong.png', '/MusicWebsite/assets/audio/Lofi Chill/EmBoHutThuocChua - BichPhuong.mp3', 0,'SN4'),
('SO32', N'Ai Hát Em Nghe',  '00:03:19', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/EmHatAiNghe - Orange.png', '/MusicWebsite/assets/audio/Lofi Chill/EmHatAiNghe - Orange.mp3', 0,'SN5'),	
('SO33', N'Hoa Cỏ Lau',  '00:03:11', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/HoaCoLau - PhongMax.png', '/MusicWebsite/assets/audio/Lofi Chill/HoaCoLau - PhongMax.mp3', 0,'SN6'),
('SO34', N'Kẻ Điên Tin Vào Tình Yêu',  '00:04:36', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/KeDienTinVaoTinhYeu - LilZ.png', '/MusicWebsite/assets/audio/Lofi Chill/KeDienTinVaoTinhYeu - LilZ.mp3', 0,'SN7'),
('SO35', N'Mặt Mộc',  '00:03:34', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/MatMoc - PhamNguyenNgoc,Vanh,BMZ.png', '/MusicWebsite/assets/audio/Lofi Chill/MatMoc - PhamNguyenNgoc,Vanh,BMZ.mp3', 0,'SN8'),
('SO36', N'Người Về Tương Lai Mơ Mộng',  '00:02:41', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/NguoiVeTuongLaiMoMong - NguyenTranTrungQuan,NguyenThuong,Air.png', '/MusicWebsite/assets/audio/Lofi Chill/NguoiVeTuongLaiMoMong - NguyenTranTrungQuan,NguyenThuong,Air.mp3', 0,'SN9'),
('SO37', N'Sau Này',  '00:03:53', 'Lofi Chill',  '/MusicWebsite/assets/img/Lofi Chill/SauNay - TangPhuc.png', '/MusicWebsite/assets/audio/Lofi Chill/SauNay - TangPhuc.mp3', 0,'SN10'),
('SO38', N'Bí Mật Nhỏ',  '00:03:53','Rap',  '/MusicWebsite/assets/img/Rap/BiMatNho - BRay,HoangTon,BaoHanHelia.png', '/MusicWebsite/assets/audio/Rap/BiMatNho - BRay,HoangTon,BaoHanHelia.mp3', 0,'SN36'),
('SO39', N'Chài Điếp Noọng',  '00:04:18','Rap',  '/MusicWebsite/assets/img/Rap/ChaiDiepNoong -  Double2T,HoaMinzy,DuongK.png', '/MusicWebsite/assets/audio/Rap/ChaiDiepNoong -  Double2T,HoaMinzy,DuongK.mp3', 0,'SN37'),
('SO40', N'Chơi Như Tụi Mỹ',  '00:02:40','Rap',  '/MusicWebsite/assets/img/Rap/ChoiNhuTuiMy - AndreeRightHand.png', '/MusicWebsite/assets/audio/Rap/ChoiNhuTuiMy - AndreeRightHand.mp3', 0,'SN38'),

('SO41', N'Con Trai Cưng',  '00:02:38','Rap',  '/MusicWebsite/assets/img/Rap/ConTraiCung - BRay,Masew.png', '/MusicWebsite/assets/audio/Rap/ConTraiCung - BRay,Masew.mp3', 0,'SN52'),
('SO42', 'Dynamic Duo',  '00:03:04','Rap',  '/MusicWebsite/assets/img/Rap/DYNAMICDUO - HIEUTHUHAI,HURRYKNG.png', '/MusicWebsite/assets/audio/Rap/DYNAMICDUO - HIEUTHUHAI,HURRYKNG.mp3', 0,'SN39'),
('SO43', 'ILYMAMA',  '00:02:47','Rap',  '/MusicWebsite/assets/img/Rap/ILYMAMA - Wxrdie,QNT.png', '/MusicWebsite/assets/audio/Rap/ILYMAMA - Wxrdie,QNT.mp3', 0,'SN41'),
('SO44', N'Vệ Tình',  '00:03:39','Rap',  '/MusicWebsite/assets/img/Rap/VeTinh - HIEUTHUHAI,HoangTon,Kewtiie.png', '/MusicWebsite/assets/audio/Rap/VeTinh - HIEUTHUHAI,HoangTon,Kewtiie.mp3', 0,'SN42'),
('SO45', N'Xin Đừng Nhấc Máy',  '00:03:07','Rap',  '/MusicWebsite/assets/img/Rap/XinDungNhacMay - BRay,HanSara.png', '/MusicWebsite/assets/audio/Rap/XinDungNhacMay - BRay,HanSara.mp3', 0,'SN43'),
('SO46', N'Ai Khổ Vì Ai',  '00:05:28', 'Ballad',  '/MusicWebsite/assets/img/Ballad/AiKhoViAi - LeQuyen.png', '/MusicWebsite/assets/audio/Ballad/AiKhoViAi - LeQuyen.mp3', 0,'SN44'),
('SO47', N'Con Đường Xưa Em Đi',  '00:04:46', 'Ballad',  '/MusicWebsite/assets/img/Ballad/ConDuongXuaEmDi - LuuAnhLoan,LeSang.png', '/MusicWebsite/assets/audio/Ballad/ConDuongXuaEmDi - LuuAnhLoan,LeSang.mp3', 0,'SN45'),
('SO48', N'Đập Vỡ Cây Đàn',  '00:05:03', 'Ballad',  '/MusicWebsite/assets/img/Ballad/DapVoCayDan - QuangLe.png', '/MusicWebsite/assets/audio/Ballad/DapVoCayDan - QuangLe.mp3', 0,'SN46'),
('SO49', N'Giờ Thì Ai Cười', '00:03:16','Rap',  '/MusicWebsite/assets/img/Rap/GioThiAiCuoi - HIEUTHUHAI,Kewtiie.png', '/MusicWebsite/assets/audio/Rap/GioThiAiCuoi - HIEUTHUHAI,Kewtiie.mp3', 0,'SN40'),
('SO50', N'Đừng Nói Xa Nhau',  '00:08:00', 'Ballad',  '/MusicWebsite/assets/img/Ballad/DungNoiXaNhau - ManhQuynh,PhiNhung.png', '/MusicWebsite/assets/audio/Ballad/DungNoiXaNhau - ManhQuynh,PhiNhung.mp3', 0,'SN47'),

('SO51', N'Duyên Phận',  '00:05:44', 'Ballad',  '/MusicWebsite/assets/img/Ballad/DuyenPhan - NhuQuynh.png', '/MusicWebsite/assets/audio/Ballad/DuyenPhan - NhuQuynh.mp3', 0,'SN48'),
('SO52', N'Nối Lại Tình Xưa',  '00:04:35', 'Ballad',  '/MusicWebsite/assets/img/Ballad/NoiLaiTinhXua - NhuQuynh,ManhQuynh.png', '/MusicWebsite/assets/audio/Ballad/NoiLaiTinhXua - NhuQuynh,ManhQuynh.mp3', 0,'SN49'),
('SO53', N'Tình Nhỏ Mau Quên', '00:04:47', 'Ballad',  '/MusicWebsite/assets/img/Ballad/TinhNhoMauQuen - QuangLe,HuongThuy.png', '/MusicWebsite/assets/audio/Ballad/TinhNhoMauQuen - QuangLe,HuongThuy.mp3', 0,'SN50'),
('SO54', N'Trách Ai Vô Tình', '00:04:38', 'Ballad',  '/MusicWebsite/assets/img/Ballad/TrachAiVoTinh - PhiNhung.png', '/MusicWebsite/assets/audio/Ballad/TrachAiVoTinh - PhiNhung.mp3', 0,'SN51'),
('SO55', N'Vùng Lá Me Bay', '00:05:16', 'Ballad',  '/MusicWebsite/assets/img/Ballad/VungLaMeBay - NhuQuynh.png', '/MusicWebsite/assets/audio/Ballad/VungLaMeBay - NhuQuynh.mp3', 0,'SN48');
	

	

	CREATE SEQUENCE seq_songs
	START WITH 56  INCREMENT BY 1;

	ALTER TABLE songs
	ADD CONSTRAINT song_insert 
	DEFAULT  'SO' + CAST(NEXT VALUE FOR seq_songs AS VARCHAR(17))
	FOR id_song ;

	CREATE SEQUENCE seq_singers
	START WITH 53  INCREMENT BY 1;

	ALTER TABLE singers
	ADD CONSTRAINT singers_insert 
	DEFAULT  'SN' + CAST(NEXT VALUE FOR seq_singers AS VARCHAR(17))
	FOR id_singer ;

	ALTER TABLE roles_accounts
	ADD CONSTRAINT role_contraint
	DEFAULT  'user'
	FOR roleUser ;


	-- trigger account
	Create TRIGGER insertAcc_Trigger ON accounts AFTER INSERT, DELETE
AS
BEGIN
    -- Check for INSERT operation
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        DECLARE @usernameinsert VARCHAR(255);

        -- Assuming there is only one row being inserted
        SELECT @usernameinsert = username FROM inserted;

        IF EXISTS (SELECT 1 FROM accounts WHERE username = @usernameinsert)
        BEGIN
            INSERT INTO roles_accounts (username) VALUES (@usernameinsert);
        END
    END

END;

-- trigger premium
CREATE TRIGGER update_start_and_finish_date_on_insert
ON history_premium_accounts
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @Username varchar(255);
    DECLARE @TypePremium int;
    DECLARE @StartedDate date;
    DECLARE @FinishDate date;

    SELECT @Username = i.username,
           @TypePremium = i.type_premium,
           @StartedDate = i.started_date,
           @FinishDate = i.finish_date
    FROM inserted i;

    IF EXISTS (
        SELECT 1
        FROM history_premium_accounts h
        WHERE h.username = @Username
          AND @StartedDate between h.started_date and h.finish_date
          
    )
    BEGIN
        DECLARE @LastFinishDate date;

        SELECT TOP 1 @LastFinishDate = finish_date
        FROM history_premium_accounts
        WHERE username = @Username
        ORDER BY finish_date DESC;

		  IF @TypePremium = 1
            SET @FinishDate = DATEADD(DAY, 1, @LastFinishDate);
        ELSE IF @TypePremium = 2
            SET @FinishDate = DATEADD(WEEK, 1, @LastFinishDate);
        ELSE IF @TypePremium IN (3, 5)
            SET @FinishDate = DATEADD(MONTH, 2, @LastFinishDate);
        ELSE IF @TypePremium IN (4, 6)
            SET @FinishDate = DATEADD(MONTH, 6, @LastFinishDate);

        INSERT INTO history_premium_accounts (username, type_premium, started_date, finish_date)
        VALUES (@Username, @TypePremium, DATEADD(DAY,1,@LastFinishDate), DATEADD(DAY,1,@FinishDate));
    END
    ELSE
    BEGIN
        IF @TypePremium = 1
            SET @FinishDate = DATEADD(DAY, 1, @StartedDate);
        ELSE IF @TypePremium = 2
            SET @FinishDate = DATEADD(WEEK, 1, @StartedDate);
        ELSE IF @TypePremium IN (3, 5)
            SET @FinishDate = DATEADD(MONTH, 2, @StartedDate);
        ELSE IF @TypePremium IN (4, 6)
            SET @FinishDate = DATEADD(MONTH, 6, @StartedDate);

        INSERT INTO history_premium_accounts (username, type_premium, started_date, finish_date)
        VALUES (@Username, @TypePremium, @StartedDate, @FinishDate);
    END
END;
	
	Insert into accounts(username,password_account,email)
	VALUES ('user','12dea96fec20593566ab75692c9949596833adc9','user@gmail.com');

	Insert into accounts(username,password_account,email)
	VALUES ('vvmtam','be1e329741ecc2be4562018d6e50c57ae91d11aa','21130168@st.hcmuaf.edu.vn');

	Insert into accounts(username,password_account,email)
	VALUES ('pldat','bf23fa1e1fe7c3d7c81a11ab021667a3d2b47c93','21130022@st.hcmuaf.edu.vn');

	Insert into accounts(username,password_account,email)
	VALUES ('ngtnkhoa','9b4dc469c95f3d9b0665ee14e8eeeda3f4dcef3e','21130079@st.hcmuaf.edu.vn');

	Insert into accounts(username,password_account,email)
	VALUES ('admin','d033e22ae348aeb5660fc2140aec35850c4da997','admin@gmail.com');
	update roles_accounts set roleUser = 'admin' where username = 'admin'

	select * from roles_accounts


	