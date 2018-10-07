create database QLDeTai
go 
use QLDeTai
go
create table THAMGIADT(
	MAGV char(3),
	MADT char(3),
	STT int,
	PHUCAP float,
	KETQUA nvarchar(3),
	primary key(MAGV,MADT,STT)
);

create table KHOA(
	MAKHOA varchar(4),
	TENKHOA nvarchar(30),
	NAMTL int,
	PHONG char(3),
	DIENTHOAI varchar(11),
	TRUONGKHOA char(3),
	NGAYNHANCHUC date,
	primary key(MAKHOA)
);
create table BOMON(
	MABM nvarchar(4),
	TENBM nvarchar(30),
	PHONG char(3),
	DIENTHOAI varchar(11),
	TRUONGBM char(3),
	MAKHOA varchar(4),
	NGAYNHANCHUC date,
	primary key(MABM)
);

create table CONGVIEC(
	MADT char(3),
	SOTT int,
	TENCV nvarchar(30),
	NGAYBD date,
	NGAYKT date,
	primary key(MADT,SOTT)
);
create table GIAOVIEN(
	MAGV char(3),
	HOTEN nvarchar(30),
	LUONG float,
	PHAI nvarchar(3),
	NGSINH date,
	DIACHI nvarchar(50),
	GVQLCM char(3),
	MABM nvarchar(4),
	primary key(MAGV)
);
create table GV_DT(
	MAGV char(3),
	DIENTHOAI varchar(11),
	primary key(MAGV,DIENTHOAI)
);
create table DETAI(
	MADT char(3),
	TENDT nvarchar(50),
	CAPQL nvarchar(20),
	KINHPHI float,
	NGAYBD date,
	NGAYKT date,
	MACD nchar(4),
	GVCNDT char(3),
	primary key(MADT)
);
create table CHUDE(
	MACD nchar(4),
	TENCD nvarchar(30),
	primary key(MACD)
);
create table NGUOITHAN(
	MAGV char(3),
	TEN nvarchar(30),
	NGAYSINH date,
	PHAI nvarchar(3),
	primary key(MAGV,TEN)
);

go
alter table THAMGIADT ADD
	CONSTRAINT FK_THAMGIADT_CONGVIEC FOREIGN KEY (MADT,STT) REFERENCES CONGVIEC(MADT,SOTT),
	CONSTRAINT FK_THAMGIADT_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT CK_THAMGIADT CHECK (PHUCAP>=0 AND KETQUA = N'Đạt')

alter table KHOA ADD
	CONSTRAINT FK_KHOA_GIAOVIEN FOREIGN KEY (TRUONGKHOA) REFERENCES GIAOVIEN(MAGV)

alter table BOMON ADD
	CONSTRAINT FK_BOMON_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA),
	CONSTRAINT FK_BOMON_GIAOVIEN FOREIGN KEY (TRUONGBM) REFERENCES GIAOVIEN(MAGV)

alter table CONGVIEC ADD
	CONSTRAINT FK_CONGVIEC_DETAI FOREIGN KEY (MADT) REFERENCES DETAI(MADT),
	CONSTRAINT CK_CONGVIEC CHECK (NGAYBD<NGAYKT)

alter table GIAOVIEN ADD
	CONSTRAINT FK_GIAOVIEN_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT FK_GIAOVIEN_BOMON FOREIGN KEY (MABM) REFERENCES BOMON(MABM),
	CONSTRAINT CK_GIAOVIEN CHECK (PHAI in (N'Nam',N'Nữ') AND LUONG>=0)

alter table GV_DT ADD
	CONSTRAINT FK_GV_DT_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
	
alter table DETAI ADD
	CONSTRAINT FK_DETAI_GIAOVIEN FOREIGN KEY (GVCNDT) REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT FK_DETAI_CHUDE FOREIGN KEY (MACD) REFERENCES CHUDE(MACD)

alter table NGUOITHAN ADD
	CONSTRAINT FK_NGUOITHAN_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT CK_NGUOITHAN CHECK (PHAI in (N'Nam',N'Nữ'))
go
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM) values
	('001',N'Nguyễn Hoài An',2000,N'Nam','2/15/1973',N'25/3 Lạc Long Quân, Q.10, TP HCM',NULL,NULL),
	('002',N'Trần Trà Hương',2500,N'Nữ','6/20/1960',N'125 Trần Hưng Đạo, Q.1, TP HCM',NULL,NULL),
	('003',N'Nguyễn Ngọc Ánh',2200,N'Nữ','5/11/1975',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM',NULL,NULL),
	('004',N'Trương Nam Sơn',2300,N'Nam','6/20/1959',N'215 Lý Thường Kiệt, TP Biên Hòa',NULL,NULL),
	('005',N'Lý Hoàng Hà',2500,N'Nam','10/23/1954',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM',NULL,NULL),
	('006',N'Trần Bạch Tuyết',1500,N'Nữ','5/20/1980',N'127 Hùng Vương, TP Mỹ Tho',NULL,NULL),
	('007',N'Nguyễn An Trung',2100,N'Nam','6/5/1967',N'234 3/2, TP Biên Hòa',NULL,NULL),
	('008',N'Trần Trung Hiếu',1800,N'Nam','8/6/1977',N'22/11 Lý Thường Kiệt, TP Mỹ Tho',NULL,NULL),
	('009',N'Trần Hoàng Nam',2000,N'Nam','11/22/1975',N'234 Trấn Não, An Phú, TP HCM',NULL,NULL),
	('010',N'Phạm Nam Thanh',1500,N'Nam','12/12/1980',N'221 Hùng Vương, Q.5, TP HCM',NULL,NULL)
	
insert into CHUDE(MACD,TENCD) values
	(N'NCPT',N'Nghiên cứu phát triển'),
	(N'QLGD',N'Quản lý giáo dục'),
	(N'ƯDCN',N'Ứng dụng công nghệ')

go
insert into GV_DT(MAGV,DIENTHOAI) values
	('001','0838912112'),
	('001','0903123123'),
	('002','0913454545'),
	('003','0838121212'),
	('003','0903656565'),
	('003','0937125125'),
	('006','0937888888'),
	('008','0653717171'),
	('008','0913232323')

insert into NGUOITHAN values
	('001',N'Hùng','1/14/1990',N'Nam'),
	('001',N'Thủy','12/8/1994',N'Nữ'),
	('003',N'Hà','9/3/1998',N'Nữ'),
	('003',N'Thu','9/3/1998',N'Nữ'),
	('007',N'Mai','3/26/2003',N'Nữ'),	
	('007',N'Vy','2/14/2000',N'Nữ'),
	('008',N'Nam','5/6/1991',N'Nam'),
	('009',N'An','8/19/1996',N'Nam'),
	('010',N'Nguyệt','1/14/2006',N'Nữ')
	
insert into KHOA(MAKHOA,TENKHOA,NAMTL,DIENTHOAI,PHONG,NGAYNHANCHUC) values
	('CNTT',N'Công nghệ thông tin',1995,'0838123456','B11','2/20/2005'),
	('HH',N'Hóa học',1980,'0838456456','B41','10/15/2001'),
 	('SH',N'Sinh học',1980,'0838454545','B31','10/11/2000'),
	('VL',N'Vật lý',1976,'0838223223','B21','9/18/2003')

go
insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT) values
	('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20,'10/20/2007','10/20/2008',N'QLGD','002'),
	('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường',20,'10/12/2000','10/12/2001',N'QLGD','002'),
	('003',N'Nghiên cứu chế tạo sợi Nanô Platin',N'ĐHQG',300,'5/15/2008','5/15/2010',N'NCPT','005'),
	('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100,'1/1/2007','12/31/2009',N'NCPT','004'),
	('005',N'Ứng dụng hóa học xanh',N'Trường',200,'10/10/2003','12/10/2004',N'ƯDCN','007'),
	('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000,'10/20/2006','10/20/2009',N'NCPT','004'),
	('007',N'HTTT quản lý các thư viện ở các trường ĐH',N'Trường',20,'5/10/2009','5/10/2010',N'QLGD','001')

	insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC) values
	(N'CNTT',N'Công nghệ tri thức','B15','0838126126',NULL,'CNTT',NULL),
	(N'HHC',N'Hóa hữu cơ','B44','0838222222',NULL,'HH',NULL),
	(N'HL',N'Hóa lý','B42','0838878787',NULL,'HH',NULL),
	(N'HPT',N'Hóa phân tích','B43','0838777777','007','HH','10/15/2007'),
	(N'HTTT',N'Hệ thống thông tin','B13','0838125125','002','CNTT','9/20/2004'),
	(N'MMT',N'Mạng máy tính','B16','0838676767','001','CNTT','5/15/2005'),
	(N'SH',N'Sinh hóa','B33','0838898989',NULL,'SH',NULL),
	(N'VLĐT',N'Vật lý điện tử','B23','0838234234',NULL,'VL',NULL),
	(N'VLƯD',N'Vật lý ứng dụng','B24','0838454545','005','VL','2/18/2006'),
	(N'VS',N'Vi sinh','B32','08389090','004','SH','1/1/2007')
go
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT) values 
	('001',1,N'Khởi tạo và Lập kế hoạch','10/20/2007','12/20/2008'),
	('001',2,N'Xác định yêu cầu','12/21/2008','3/21/2009'),
	('001',3,N'Phân tích hệ thống','3/22/2008','5/22/2008'),
	('001',4,N'Thiết kế hệ thống','5/23/2008','6/23/2008'),
	('001',5,N'Cài đặt thử nghiệm','6/24/2008','10/20/2008'),
	('002',1,N'Khởi tạọ và Lập kế hoạch','5/10/2009','7/10/2009'),
	('002',2,N'Xác định yêu cầu','7/11/2009','10/11/2009'),
	('002',3,N'Phân tích hệ thống','10/12/2009','12/20/2009'),
	('002',4,N'Thiết kế hệ thống','12/21/2009','3/22/2010'),
	('002',5,N'Cài đặt thử nghiệm','3/23/2010','5/10/2010'),
	('006',1,N'Lấy mẫu','10/20/2006','2/20/2007'),
	('006',2,N'Nuôi cấy','2/21/2007','8/21/2008')

	go
	insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA) values
	('001','002',1,0,NULL),
	('001','002',2,2,NULL),
	('002','001',4,2,N'Đạt'),
	('003','001',1,1,N'Đạt'),
	('003','001',2,0,N'Đạt'),
	('003','001',4,1,N'Đạt'),
	('003','002',2,0,NULL),
	('004','006',1,0,N'Đạt'),
	('004','006',2,1,N'Đạt'),
	('006','006',2,1.5,N'Đạt'),
	('009','002',3,0.5,NULL),
	('009','002',4,1.5,NULL)

update GIAOVIEN
	set GVQLCM=
	case MAGV 
		when '003' then '002'
		when '006' then '004'
		when '008' then '007'
		when '009' then '001'
		when '010' then '007'
		else NULL
	end

update GIAOVIEN
	set MABM=
	case MAGV 
		when '001' then N'MMT'
		when '002' then N'HTTT'
		when '003' then N'HTTT'
		when '004' then N'VS'
		when '005' then N'VLĐT'
		when '006' then N'VS'
		when '007' then N'HPT'
		when '008' then N'HPT'
		when '009' then N'MMT'
		when '010' then N'HPT'
		else NULL
	end

update KHOA
	set TRUONGKHOA=
	case MAKHOA
		when 'CNTT' then '002'
		when 'HH' then '007'
		when 'SH' then '004'
		when 'VL' then '005'
		else NULL
	end

--Q1. Cho biết họ tên và mức lương của các giáo viên nữ.
select gv.HOTEN,gv.LUONG from GIAOVIEN gv where PHAI=N'Nữ'
--Q2. Cho biết họ tên của các giáo viên và lương của họ sau khi tăng 10%.
select gv.HOTEN,gv.LUONG*1.1 as LUONGMOI from GIAOVIEN gv 
--Q3. Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 hoặc giáo viên là trưởng bộ môn nhận chức sau năm 1995.
select gv.MAGV
from GIAOVIEN gv left join BOMON bm on gv.MAGV=bm.TRUONGBM
where (gv.HOTEN like N'Nguyễn%' AND gv.LUONG>2000) OR year(bm.NGAYNHANCHUC)>1995
--Q4. Cho biết tên những giáo viên khoa Công nghệ thông tin.
select gv.HOTEN from GIAOVIEN gv join BOMON bm on gv.MABM=bm.MABM
where bm.MAKHOA='CNTT'
--Q5. Cho biết thông tin của bộ môn cùng thông tin giảng viên làm trưởng bộ môn đó.
select * 
from BOMON bm left join GIAOVIEN gv on gv.MAGV=bm.TRUONGBM
--Q6. Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
select * from GIAOVIEN gv left join BOMON bm on gv.MABM=bm.MABM
--Q7. Cho biết tên đề tài và giáo viên chủ nhiệm đề tài.
select dt.TENDT,gv.* from GIAOVIEN gv right join DETAI dt on gv.MAGV=dt.GVCNDT
--Q8. Với mỗi khoa cho biết thông tin trưởng khoa.
select * from KHOA k left join GIAOVIEN gv on k.TRUONGKHOA=gv.MAGV
--Q9. Cho biết các giáo viên của bộ môn “Vi sinh” có tham gia đề tài 006.
select gv.* from GIAOVIEN gv join BOMON bm on bm.MABM=gv.MABM
where bm.TENBM=N'Vi sinh'
intersect
select gv.*
from GIAOVIEN gv join THAMGIADT tgdt on gv.MAGV=tgdt.MAGV
where tgdt.MADT='006'
--Q10. Với những đề tài thuộc cấp quản lý “Thành phố”, cho biết mã đề tài, đề tài thuộc về chủ đề nào, họ tên người chủ nghiệm đề tài cùng với ngày sinh và địa chỉ của người ấy.
select dt.MADT,dt.MACD, cd.TENCD,gv.HOTEN as N'GVCNDT',gv.DIACHI, gv.NGSINH
from DETAI dt join CHUDE cd on dt.MACD=cd.MACD join GIAOVIEN gv on dt.GVCNDT=gv.MAGV
where dt.CAPQL=N'Thành phố'
--Q11. Tìm họ tên của từng giáo viên và người phụ trách chuyên môn trực tiếp của giáo viên đó.
select gv1.HOTEN as 'GV', gv2.HOTEN as N'NQLCM'
from GIAOVIEN gv1 left join GIAOVIEN gv2 on gv1.GVQLCM=gv2.MAGV
--Q12. Tìm họ tên của những giáo viên được “Nguyễn Thanh Tùng” phụ trách trực tiếp.
select gv1.HOTEN
from GIAOVIEN gv1 join GIAOVIEN gv2 on gv1.GVQLCM=gv2.MAGV
where gv2.HOTEN=N'Nguyễn Thanh Tùng'
--Q13. Cho biết tên giáo viên là trưởng bộ môn Hệ thống thông tin.
select gv.HOTEN
from GIAOVIEN gv join BOMON bm on bm.TRUONGBM=gv.MAGV
where bm.TENBM=N'Hệ thống thông tin'
--?????Q14. Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề Quản lý giáo dục.
select gv.HOTEN
from DETAI dt join CHUDE cd on dt.MACD=cd.MACD join GIAOVIEN gv on dt.GVCNDT=gv.MAGV
where cd.TENCD=N'Quản lý giáo dục'
intersect
select gv.HOTEN
from GIAOVIEN gv join DETAI dt on gv.MAGV=dt.GVCNDT
--Q15. Cho biết tên các công việc của đề tài HTTT quản lý các trường ĐH có thời gian bắt đầu trong tháng 3/2008.
select cv.TENCV
from DETAI dt join CONGVIEC cv on dt.MADT=cv.MADT
where dt.TENDT = N'HTTT quản lý các trường ĐH' and (cv.NGAYBD between '2008/03/01' and '2008/03/31')
--Q16. Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
select gv1.HOTEN as 'TENGV', gv2.HOTEN as N'TEN NQLCM'
from GIAOVIEN gv1 left join GIAOVIEN gv2 on gv1.GVQLCM=gv2.MAGV
--Q17. Cho các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007.
select *
from CONGVIEC cv
where cv.NGAYBD between '2007/01/01' AND '2007/08/01'
--Q18. Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”
select gv1.HOTEN
from GIAOVIEN gv1 join GIAOVIEN gv2 on gv1.MABM=gv2.MABM
where gv2.HOTEN=N'Trần Trà Hương' 
except 
select gv.HOTEN
from GIAOVIEN gv
where gv.HOTEN=N'Trần Trà Hương' 
--Q19. Tìm những giáo viên vừa là trưởng bộ môn vừa chủ nhiệm đề tài.
select gv.*
from GIAOVIEN gv join BOMON bm on gv.MAGV=bm.TRUONGBM
intersect
select gv.*
from GIAOVIEN gv join DETAI dt on dt.GVCNDT=gv.MAGV
--Q20. Cho biết tên những giáo viên vừa là trưởng khoa và vừa là trưởng bộ môn.
select gv.*
from GIAOVIEN gv join KHOA k on gv.MAGV=k.TRUONGKHOA join BOMON bm on bm.TRUONGBM=gv.MAGV
--Q21. Cho biết tên những trưởng bộ môn mà vừa chủ nhiệm đề tài 
select gv.HOTEN from BOMON bm join GIAOVIEN gv on gv.MAGV=bm.TRUONGBM
intersect
select gv.HOTEN from GIAOVIEN gv join DETAI dt on gv.MAGV=dt.GVCNDT
--Q22. Cho biết mã số các trưởng khoa có chủ nhiệm đề tài.
select k.TRUONGKHOA from KHOA k 
intersect
select gv.MAGV 
from GIAOVIEN gv join DETAI dt on gv.MAGV=dt.GVCNDT
--Q23. Cho biết mã số các giáo viên thuộc bộ môn HTTT hoặc có tham gia đề tài mã 001.
select gv.MAGV from GIAOVIEN gv
where gv.MABM='HTTT'
union
select tgdt.MAGV from THAMGIADT tgdt
where tgdt.MADT='001'
--Q24. Cho biết giáo viên làm việc cùng bộ môn với giáo viên 002.
select gv1.* from GIAOVIEN gv1 join GIAOVIEN gv2 on gv1.MABM=gv2.MABM
where gv2.MAGV='002' 
except
select gv.*
from GIAOVIEN gv
where gv.MAGV='002'
--Q25. Tìm những giáo viên là trưởng bộ môn.
select gv.* from GIAOVIEN gv join BOMON bm on gv.MAGV=bm.TRUONGBM
--Q26. Cho biết họ tên và mức lương của các giáo viên.
select gv.HOTEN,gv.LUONG from GIAOVIEN gv
---------------------------------------------------------------------------------------------------------
--Q27. Cho"biết"số lượng"giáo"viên"viên"và"tổng"lương"của"họ.
select count(gv.MAGV) as 'SLGV',sum(gv.LUONG) as 'TONG LUONG'
from GIAOVIEN gv
--Q28. Cho"biết"số lượng"giáo"viên"và"lương"trung"bình"của"từng"bộ môn.
select gv.MABM, count(gv.MAGV),AVG(gv.LUONG)
from GIAOVIEN gv
group by gv.MABM
--Q29. Cho"biết"tên"chủ đề và"số lượng"đề tài"thuộc"về chủ đề đó.
select cd.TENCD, count(dt.MADT)
from DETAI dt join CHUDE cd on dt.MACD=cd.MACD
group by dt.MACD, cd.TENCD
--Q30. Cho"biết"tên"giáo"viên"và"số lượng"đề tài"mà"giáo"viên"đó"tham"gia.
select gv.HOTEN,count(distinct tg.MADT)
from THAMGIADT tg join GIAOVIEN gv on tg.MAGV=gv.MAGV
group by tg.MAGV, gv.HOTEN
--Q31. Cho"biết"tên"giáo"viên"và"số lượng"đề tài"mà"giáo"viên"đó"làm"chủ nhiệm.
select GV.HOTEN,COUNT(DT.MADT)
from DETAI dt join GIAOVIEN gv on dt.GVCNDT=GV.MAGV
GROUP BY dt.GVCNDT,gv.HOTEN
--Q32. Với"mỗi"giáo"viên"cho"tên"giáo"viên"và"số người"thân"của"giáo"viên"đó.
select gv.HOTEN,COUNT(distinct NT.TEN)
from NGUOITHAN nt join GIAOVIEN gv on nt.MAGV=gv.MAGV
group by nt.MAGV,gv.HOTEN
--Q33. Cho"biết"tên"những"giáo"viên"đã"tham"gia"từ 3"đề tài"trở lên.
select gv.HOTEN
from GIAOVIEN gv join THAMGIADT tg on gv.MAGV=tg.MAGV
group by gv.MAGV,gv.HOTEN
having count(distinct tg.MADT)>=3
--Q34. Cho"biết"số lượng"giáo"viên"đã"tham"gia"vào"đề tài"Ứng"dụng"hóa"học"xanh.
select count(distinct tg.MAGV)
from THAMGIADT tg join DETAI dt on tg.MADT=dt.MADT
where dt.TENDT=N'Ứng dụng hóa học xanh'
group by tg.MADT
--Q35. Cho"biết"mức"lương"cao"nhất"của"các"giảng"viên.
select distinct gv.LUONG
from GIAOVIEN gv
where gv.LUONG>=all(select gv2.LUONG from GIAOVIEN gv2)
--Q36. Cho"biết"những"giáo"viên"có"lương"lớn"nhất.
select gv.*
from GIAOVIEN gv
where gv.LUONG>=all(select gv2.LUONG from GIAOVIEN gv2)
--Q37. Cho"biết"lương"cao"nhất"trong"bộ môn"“HTTT”.
select distinct gv.LUONG
from GIAOVIEN gv
where gv.MABM='MMT' and gv.LUONG>=all(select gv2.LUONG from GIAOVIEN gv2 where gv2.MABM='MMT')
--Q38. Cho"biết"tên"giáo"viên"lớn"tuổi"nhất"của"bộ môn"Hệ thống"thông"tin.
select gv.HOTEN
from GIAOVIEN gv join BOMON bm on bm.MABM=gv.MABM
where bm.TENBM=N'Hệ thống thông tin' 
and gv.NGSINH<=all(select gv2.NGSINH from GIAOVIEN gv2 join BOMON bm2 on bm2.MABM=gv2.MABM where bm2.TENBM=N'Hệ thống thông tin')
--Q39. Cho"biết"tên"giáo"viên"nhỏ tuổi"nhất"khoa"Công"nghệ thông"tin.
select GV.HOTEN
from GIAOVIEN gv join BOMON bm on gv.MABM=bm.MABM join KHOA k on k.MAKHOA=bm.MAKHOA
where k.TENKHOA=N'Công nghệ thông tin'
and year(gv.NGSINH)>=all(select year(gv2.NGSINH) from GIAOVIEN gv2 join BOMON bm2 on gv2.MABM=bm2.MABM join KHOA k2 on k2.MAKHOA=bm2.MAKHOA
where k2.TENKHOA=N'Công nghệ thông tin')
--Q40. Cho"biết"tên"giáo"viên"và"tên"khoa"của"giáo"viên"có"lương"cao"nhất.
select GV.HOTEN, k.TENKHOA
from GIAOVIEN gv join BOMON bm on gv.MABM=bm.MABM join KHOA k on k.MAKHOA=bm.MAKHOA
where gv.LUONG>=all(select gv2.LUONG from GIAOVIEN gv2)
--Q41. Cho"biết"những"giáo"viên"có"lương"lớn"nhất"trong"bộ môn"của"họ.
select gv.HOTEN
from GIAOVIEN gv 
group by gv.MABM, gv.HOTEN, gv.LUONG
having gv.LUONG>=all(select gv2.LUONG from GIAOVIEN gv2 group by gv2.MABM, gv2.LUONG having gv2.MABM=gv.MABM)
--Q42. Cho"biết"tên"những"đề tài"mà"giáo"viên"Nguyễn"Hoài"An"chưa"tham"gia.
select dt.TENDT
from DETAI dt
where dt.MADT not in (select tg.MADT from GIAOVIEN gv join THAMGIADT tg on tg.MAGV=GV.MAGV where gv.HOTEN=N'Nguyễn Hoài An')
--Q43. Cho"biết"những"đề tài"mà"giáo"viên"Nguyễn"Hoài"An"chưa"tham"gia."Xuất"ra"tên"đề tài,"tên"người"chủ nhiệm"đề tài.
select dt.TENDT,gv2.HOTEN
from DETAI dt join GIAOVIEN gv2 on dt.GVCNDT=gv2.MAGV
where dt.MADT not in (select tg.MADT from GIAOVIEN gv join THAMGIADT tg on tg.MAGV=GV.MAGV where gv.HOTEN=N'Nguyễn Hoài An')
-->Đề tài mà ko thuộc những đề tài mà gv Nguyễn Hoài An tham gia
--Q44. Cho"biết"tên"những"giáo"viên"khoa"Công"nghệ thông"tin"mà"chưa"tham"gia"đề tài"nào.
select gv.HOTEN
from GIAOVIEN gv join BOMON bm on bm.MABM=gv.MABM join KHOA k on k.MAKHOA=bm.MAKHOA
where k.TENKHOA=N'Công nghệ thông tin'
and gv.MAGV not in (select tg.MAGV from THAMGIADT tg)
-->Giáo viên khoa CNTT mà ko nằm trong bảng THAMGIADT
--Q45. Tìm"những"giáo"viên"không"tham"gia"bất"kỳ đề tài"nào
select gv.HOTEN
from GIAOVIEN gv
where gv.MAGV not in (select tg.MAGV from THAMGIADT tg)
--Q46. Cho"biết"giáo"viên"có"lương"lớn"hơn"lương"của"giáo"viên"“Nguyễn"Hoài"An”
select gv.*
from GIAOVIEN gv
where gv.LUONG>(select gv2.LUONG from GIAOVIEN gv2 where gv2.HOTEN=N'Nguyễn Hoài An')
--Q47. Tìm"những"trưởng"bộ môn"tham"gia"tối"thiểu"1"đề tài
select gv.*
from BOMON bm join GIAOVIEN gv on bm.TRUONGBM=gv.MAGV
where gv.MAGV in (select tg.MAGV from THAMGIADT tg)
--Q48. Tìm"giáo"viên"trùng"tên"và"cùng"giới"tính"với"giáo"viên"khác"trong"cùng"bộ môn
select gv.*
from GIAOVIEN gv
where exists (select * from GIAOVIEN gv2 where gv2.HOTEN=gv.HOTEN and gv2.PHAI=gv.PHAI and gv2.MABM=gv.MABM and gv2.MAGV!=gv.MAGV)
--Q49. Tìm"những"giáo"viên"có"lương"lớn"hơn"lương"của"ít"nhất"một"giáo"viên"bộ môn"“Công"nghệ phần"mềm”
select gv.*
from GIAOVIEN gv 
where gv.LUONG>any(select gv2.LUONG from GIAOVIEN gv2 join BOMON bm2 on bm2.MABM=gv2.MABM where bm2.TENBM=N'Công nghệ phần mềm')
--Q50. Tìm"những"giáo"viên"có"lương"lớn"hơn"lương"của"tất"cả giáo"viên"thuộc"bộ môn"“Hệ thống"thông"tin”
select gv.*
from GIAOVIEN gv 
where gv.LUONG>all(select gv2.LUONG from GIAOVIEN gv2 join BOMON bm2 on bm2.MABM=gv2.MABM where bm2.TENBM=N'Hệ thống thông tin')
--Q51. Cho biết"tên"khoa"có"đông"giáo"viên"nhất
select k.TENKHOA
from GIAOVIEN gv join BOMON bm on bm.MABM=gv.MABM join KHOA k on k.MAKHOA=bm.MAKHOA
group by k.MAKHOA,k.TENKHOA
having count(gv.MAGV)>=all(select count(gv2.MAGV)
from GIAOVIEN gv2 join BOMON bm2 on bm2.MABM=gv2.MABM join KHOA k2 on k2.MAKHOA=bm2.MAKHOA group by k2.MAKHOA)
--Q52. Cho"biết"họ tên"giáo"viên"chủ nhiệm"nhiều"đề tài"nhất
select gv.HOTEN
from GIAOVIEN gv join DETAI dt on dt.GVCNDT=gv.MAGV
group by dt.GVCNDT,gv.HOTEN
having count(dt.MADT)>=all(select count(dt2.MADT) from DETAI dt2 group by dt2.GVCNDT)
--Q53. Cho"biết"mã"bộ môn"có"nhiều"giáo"viên"nhất
select BM.MABM
from BOMON bm join GIAOVIEN gv on gv.MABM=bm.MABM
group by bm.MABM
having count(gv.MAGV)>=all(select count(gv2.MAGV) from BOMON bm2 join GIAOVIEN gv2 on gv2.MABM=bm2.MABM group by bm2.MABM)
--Q54. Cho"biết"tên"giáo"viên"và"tên"bộ môn"của"giáo"viên"tham"gia"nhiều"đề tài"nhất.
select GV.HOTEN,BM.TENBM
from GIAOVIEN gv join THAMGIADT tg on tg.MAGV=gv.MAGV join BOMON bm on bm.MABM=GV.MABM
group by tg.MAGV,gv.HOTEN, bm.TENBM
having count(distinct tg.MADT)>=all(select count(distinct tg2.MADT) from THAMGIADT tg2 group by tg2.MAGV)
--Q55. Cho"biết"tên"giáo"viên"tham"gia"nhiều"đề tài"nhất"của"bộ môn"HTTT.
SELECT GV.HOTEN
FROM GIAOVIEN GV JOIN THAMGIADT TG ON TG.MAGV=GV.MAGV
WHERE GV.MABM='HTTT'
GROUP BY TG.MAGV,GV.HOTEN
HAVING COUNT(DISTINCT TG.MADT)>=ALL(SELECT COUNT(DISTINCT TG2.MADT) FROM THAMGIADT TG2 GROUP BY TG2.MAGV)
--Q56. Cho"biết"tên"giáo"viên"và"tên"bộ môn"của"giáo"viên"có"nhiều"người"thân"nhất.
SELECT GV.HOTEN,BM.TENBM
FROM GIAOVIEN GV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN NGUOITHAN NT ON NT.MAGV=GV.MAGV
GROUP BY NT.MAGV,GV.HOTEN,BM.TENBM
HAVING COUNT(NT.TEN)>=ALL(SELECT COUNT(NT2.TEN) FROM NGUOITHAN NT2 GROUP BY NT2.MAGV)
--Q57. Cho"biết"tên"trưởng"bộ môn"mà"chủ nhiệm"nhiều"đề tài"nhất.
SELECT GV.HOTEN
FROM GIAOVIEN GV JOIN BOMON BM ON BM.TRUONGBM=GV.MAGV JOIN DETAI DT ON DT.GVCNDT=GV.MAGV
GROUP BY BM.TRUONGBM,GV.HOTEN
HAVING COUNT(DT.GVCNDT)>=ALL(SELECT COUNT(DT2.GVCNDT) FROM BOMON BM2 JOIN DETAI DT2 ON BM2.TRUONGBM=DT2.GVCNDT GROUP BY BM2.TRUONGBM)
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--Q58. Cho"biết"tên"giáo"viên"nào"mà"tham"gia"đề tài"đủ tất"cả các"chủ đề.
SELECT GV.HOTEN
FROM GIAOVIEN GV JOIN THAMGIADT TG ON GV.MAGV=TG.MAGV JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM CHUDE CD 
	WHERE NOT EXISTS (SELECT * FROM THAMGIADT TG2 JOIN DETAI DT2 ON DT2.MADT=TG2.MADT 
		WHERE DT2.MACD=CD.MACD AND DT2.MADT=DT.MADT))
		--> ???????
--Q59. Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"bộ môn"HTTT"tham"gia.
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV WHERE GV.MABM='HTTT' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2  WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV.MAGV))
	---> ???
--Q60. Cho"biết"tên"đề tài"có"tất"cả giảng"viên"bộ môn"“Hệ thống"thông"tin” tham"gia
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV JOIN BOMON BM ON BM.MABM=GV.MABM WHERE BM.TENBM=N'Hệ thống thông tin' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2  WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV.MAGV))
	---> ???
--Q61. Cho"biết"giáo"viên"nào"đã"tham"gia"tất"cả các"đề tài"có"mã"chủ đề là"QLGD.
SELECT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT WHERE DT.MACD='QLGD' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))
--Q62. Cho"biết"tên"giáo"viên"nào"tham"gia"tất"cả các"đề tài"mà"giáo"viên"Trần"Trà"Hương"đã"tham"gia.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE GV.HOTEN!=N'Trần Trà Hương' AND 
	NOT EXISTS (SELECT * FROM DETAI DT JOIN THAMGIADT TG2 ON TG2.MADT=DT.MADT JOIN GIAOVIEN GV2 ON GV2.MAGV=TG2.MAGV 
		WHERE GV2.HOTEN=N'Trần Trà Hương' AND
			NOT EXISTS (SELECT * FROM THAMGIADT TG3 WHERE TG3.MADT=DT.MADT AND TG3.MAGV=TG.MAGV))
--Q63. Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"bộ môn"Hóa"Hữu"Cơ"tham"gia.
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE GV.MABM='HHC' AND NOT EXISTS (SELECT * FROM GIAOVIEN GV2 WHERE GV2.MABM='HHC' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2  WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV2.MAGV))
--> Nhập nhằn

--SELECT * FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT
--SELECT * FROM THAMGIADT TG JOIN CONGVIEC CV ON CV.MADT=TG.MADT AND CV.SOTT=TG.STT JOIN DETAI DT ON DT.MADT=CV.MADT

--Q64. Cho"biết"tên"giáo"viên"nào"mà"tham"gia"tất"cả các"công"việc"của"đề tài"006.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV 
WHERE NOT EXISTS (SELECT * FROM CONGVIEC CV WHERE CV.MADT='006' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))
--Q65. Cho"biết"giáo"viên"nào"đã"tham"gia"tất"cả các"đề tài"của"chủ đề Ứng"dụng"công"nghệ.
SELECT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT JOIN CHUDE CD ON DT.MACD=CD.MACD WHERE CD.TENCD=N'Ứng dụng công nghệ' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))
--Q66. Cho"biết"tên"giáo"viên"nào"đã"tham"gia"tất"cả các"đề tài"của"do"Trần"Trà"Hương"làm"chủ nhiệm.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT JOIN GIAOVIEN GV2 ON GV2.MAGV=DT.GVCNDT WHERE GV2.HOTEN=N'Trần Trà Hương' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))
--Q67. Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"khoa"CNTT"tham"gia.
SELECT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM=BM.MABM WHERE BM.MAKHOA='CNTT' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV.MAGV))
--Q68. Cho"biết"tên"giáo"viên"nào"mà"tham"gia"tất"cả các"công"việc"của"đề tài"Nghiên"cứu"tế bào"gốc.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV 
WHERE NOT EXISTS (SELECT * FROM CONGVIEC CV JOIN DETAI DT ON CV.MADT=DT.MADT WHERE DT.TENDT=N'Nghiên cứu tế bào gốc' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))
--Q69. Tìm"tên"các"giáo"viên"được"phân"công"làm"tất"cả các"đề tài"có"kinh"phí"trên"100"triệu?
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT WHERE DT.KINHPHI>100 AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))
--Q70. Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"khoa"Sinh"Học"tham"gia.
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON TG.MADT=DT.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA
	WHERE K.TENKHOA=N'Sinh học' AND NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=GV.MAGV AND TG2.MADT=TG.MADT))
--Q71. Cho"biết"mã"số,"họ tên,"ngày"sinh"của"giáo"viên"tham"gia"tất"cả các"công"việc"của"đề tài"“Ứng"dụng"hóa"học"xanh”.
SELECT DISTINCT GV.MAGV,GV.HOTEN,GV.NGSINH
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV JOIN DETAI DT2 ON DT2.MADT=TG.MADT
WHERE DT2.TENDT=N'Ứng dụng hóa học xanh' AND NOT EXISTS (SELECT * FROM CONGVIEC CV JOIN DETAI DT ON CV.MADT=DT.MADT WHERE DT.TENDT=N'Ứng dụng hóa học xanh' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))
--Q72. Cho"biết"mã"số,"họ tên,"tên"bộ môn"và"tên"người"quản"lý"chuyên"môn"của"giáo"viên"tham"gia"tất"cả các"đề
--tài"thuộc"chủ đề “Nghiên"cứu"phát"triển”.
SELECT GV.MAGV,GV.HOTEN, BM.TENBM, GV2.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN GIAOVIEN GV2 ON GV2.MAGV=GV.GVQLCM
WHERE NOT EXISTS (SELECT * FROM DETAI DT JOIN CHUDE CD ON DT.MACD=CD.MACD WHERE CD.TENCD=N'Nghiên cứu phát triển' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))
--Q73. Cho"biết"họ tên,"ngày"sinh,"tên"khoa,"tên"trưởng"khoa"của"giáo"viên"tham"gia"tất"cả các"đề tài"có"giáo"viên"
--“Nguyễn"Hoài"An” tham"gia.
SELECT DISTINCT GV.HOTEN,GV.NGSINH,K.TENKHOA,GV2.HOTEN AS 'TEN TRUONG KHOA'
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV 
	JOIN BOMON BM ON BM.MABM=GV.MABM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA JOIN GIAOVIEN GV2 ON GV2.MAGV=K.TRUONGKHOA
WHERE GV.HOTEN!=N'Nguyễn Hoài An' AND NOT EXISTS (SELECT * FROM DETAI DT JOIN THAMGIADT TG2 ON TG2.MADT=DT.MADT JOIN GIAOVIEN GV3 ON GV3.MAGV=TG2.MAGV
	WHERE GV3.HOTEN=N'Nguyễn Hoài An' AND 
		NOT EXISTS (SELECT * FROM THAMGIADT TG3 WHERE TG3.MADT=DT.MADT AND TG3.MAGV=TG.MAGV))
--Q74. Cho"biết"họ tên"giáo"viên"khoa"“Công"nghệ thông"tin” tham"gia"tất"cả các"công"việc"của"đề tài"có"trưởng"bộ
--môn"của"bộ môn"đông"nhất"khoa"“Công"nghệ thông"tin” làm"chủ nhiệm.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA
WHERE K.TENKHOA=N'Công nghệ thông tin' 
AND GV.MAGV NOT IN (SELECT GV3.MAGV FROM GIAOVIEN GV3 JOIN BOMON BM3 ON GV3.MAGV=BM3.TRUONGBM)--GV in ra ko đc là trưởng bộ môn của khoa CNTT
AND 
	NOT EXISTS(SELECT * FROM CONGVIEC CV JOIN DETAI DT ON DT.MADT=CV.MADT JOIN GIAOVIEN GV2 ON GV2.MAGV=DT.GVCNDT JOIN BOMON BM2 ON BM2.TRUONGBM=GV2.MAGV 
		WHERE BM2.MABM IN (SELECT BM3.MABM FROM BOMON BM3 JOIN GIAOVIEN GV3 ON GV3.MABM=BM3.MABM JOIN KHOA K2 ON K2.MAKHOA=BM3.MAKHOA GROUP BY BM3.MABM,K2.TENKHOA HAVING K2.TENKHOA=N'Công nghệ thông tin' AND
			COUNT(GV3.MAGV)>=ALL(SELECT COUNT(GV4.MAGV) FROM GIAOVIEN GV4 JOIN BOMON BM4 ON BM4.MABM=GV4.MABM JOIN KHOA K3 ON K3.MAKHOA=BM4.MAKHOA GROUP BY BM4.MABM,K3.TENKHOA HAVING K3.TENKHOA=N'Công nghệ thông tin'))
				AND NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))
--Cho"biết"họ tên"giáo"viên"khoa"“Sinh học” tham"gia"tất"cả các"công"việc"của"đề tài"có"trưởng"bộ
--môn"của"bộ môn"đông"nhất"khoa"“Sinh học” làm"chủ nhiệm.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA
WHERE K.TENKHOA=N'Sinh học' 
AND GV.MAGV NOT IN (SELECT GV3.MAGV FROM GIAOVIEN GV3 JOIN BOMON BM3 ON GV3.MAGV=BM3.TRUONGBM)
AND 
	NOT EXISTS(SELECT * FROM CONGVIEC CV JOIN DETAI DT ON DT.MADT=CV.MADT JOIN GIAOVIEN GV2 ON GV2.MAGV=DT.GVCNDT JOIN BOMON BM2 ON BM2.TRUONGBM=GV2.MAGV 
		WHERE BM2.MABM IN (SELECT BM3.MABM FROM BOMON BM3 JOIN GIAOVIEN GV3 ON GV3.MABM=BM3.MABM JOIN KHOA K2 ON K2.MAKHOA=BM3.MAKHOA GROUP BY BM3.MABM,K2.TENKHOA HAVING K2.TENKHOA=N'Sinh học' AND
			COUNT(GV3.MAGV)>=ALL(SELECT COUNT(GV4.MAGV) FROM GIAOVIEN GV4 JOIN BOMON BM4 ON BM4.MABM=GV4.MABM JOIN KHOA K3 ON K3.MAKHOA=BM4.MAKHOA GROUP BY BM4.MABM,K3.TENKHOA HAVING K3.TENKHOA=N'Sinh học'))
				AND NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))
--
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA
WHERE  K.TENKHOA=N'Công nghệ thông tin'
--AND BM.MABM='MMT' 
AND GV.MAGV NOT IN (SELECT GV3.MAGV FROM GIAOVIEN GV3 JOIN BOMON BM3 ON GV3.MAGV=BM3.TRUONGBM)
AND 
	NOT EXISTS(SELECT * FROM CONGVIEC CV JOIN DETAI DT ON DT.MADT=CV.MADT JOIN GIAOVIEN GV2 ON GV2.MAGV=DT.GVCNDT JOIN BOMON BM2 ON BM2.TRUONGBM=GV2.MAGV 
		WHERE BM2.MABM = 'MMT'
				AND NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))

--Tìm mã bộ môn có động gv nhất thuộc khoa CNTT
SELECT BM3.MABM 
FROM BOMON BM3 JOIN GIAOVIEN GV3 ON GV3.MABM=BM3.MABM JOIN KHOA K2 ON K2.MAKHOA=BM3.MAKHOA 
GROUP BY BM3.MABM,K2.TENKHOA 
HAVING K2.TENKHOA=N'Công nghệ thông tin' AND
		COUNT(GV3.MAGV)>=ALL(SELECT COUNT(GV4.MAGV) 
							FROM GIAOVIEN GV4 JOIN BOMON BM4 ON BM4.MABM=GV4.MABM JOIN KHOA K3 ON K3.MAKHOA=BM4.MAKHOA 
							GROUP BY BM4.MABM,K3.TENKHOA 
							HAVING K3.TENKHOA=N'Công nghệ thông tin')
--Q75. Cho"biết"họ tên"giáo"viên"và"tên"bộ môn"họ làm"trưởng"bộ môn"nếu"có
SELECT GV.HOTEN, BM.TENBM
FROM GIAOVIEN GV LEFT JOIN BOMON BM ON BM.TRUONGBM=GV.MAGV

--Q76. Cho"danh"sách"tên"bộ môn"và"họ tên"trưởng"bộ môn"đó"nếu"có
SELECT BM.TENBM,GV.HOTEN
FROM BOMON BM LEFT JOIN GIAOVIEN GV ON GV.MAGV=BM.TRUONGBM
--Q77. Cho"danh"sách"tên"giáo"viên"và"các"đề tài"giáo"viên"đó"chủ nhiệm"nếu"có
SELECT GV.HOTEN,DT.TENDT
FROM GIAOVIEN GV LEFT JOIN DETAI DT ON DT.GVCNDT=GV.MAGV
--Q78. Xóa"các"đề tài"thuộc"chủ đề “NCPT”.

--Q79. Xuất ra"thông"tin"của"giáo"viên"(MAGV,"HOTEN)"và"mức"lương"của"giáo"viên."Mức"lương"được"xếp"theo"
--quy"tắc:"Lương"của"giáo"viên"<"$1800":"“THẤP”";""Từ $1800"đến"$2200:"TRUNG"BÌNH;"Lương">"$2200:"“CAO”

--Q80. Xuất"ra"thông"tin"giáo"viên"(MAGV,"HOTEN)"và"xếp"hạng"dựa"vào"mức"lương."Nếu"giáo"viên"có"lương"cao"
--nhất"thì"hạng"là"1.

--Q81. Xuất"ra"thông"tin"thu"nhập"của"giáo"viên."Thu"nhập"của"giáo"viên"được"tính"bằng"LƯƠNG"+"PHỤ CẤP."Nếu"
--giáo"viên"là"trưởng"bộ môn"thì"PHỤ CẤP"là"300,"và"giáo"viên"là"trưởng"khoa"thì"PHỤ CẤP"là"600.

--Q82. Xuất"ra"năm"mà"giáo"viên"dự kiến"sẽ nghĩ"hưu"với"quy"định:"Tuổi"nghỉ hưu"của"Nam"là"60,"của"Nữ là"55.

--Q83. Cho biết tên công việc có nhiều giáo viên làm nhất
select tg.MADT,tg.STT,CV.TENCV
from THAMGIADT tg join CONGVIEC cv on cv.MADT=TG.MADT and cv.SOTT=tg.STT
group by tg.MADT,tg.STT, cv.TENCV
having count(tg.MAGV) >= all(select count(tg2.MAGV) from THAMGIADT tg2 group by tg2.MADT,tg2.STT)

