create database QLTV
go
use QLTV
go

create table docgia (
ma_docgia int identity(1,1) primary key,
ho nvarchar(50),
tenlot nvarchar(50),
ten nvarchar(50),
ngaysinh date,
)

create table treem (
ma_docgia int primary key,
ma_docgia_nguoilon int,
)

create table nguoilon (
ma_docgia int primary key,
sonha int,
duong nvarchar(50),
quan nvarchar(50),
dienthoai nvarchar(50),
han_sd date,
)

create table tuasach (
ma_tuasach int identity(1, 1) primary key,
tuasach nvarchar(50),
tacgia nvarchar(50),
tomtat ntext,
)

create table dausach (
isbn int primary key,
ma_tuasach int,
ngonngu nvarchar(50),
bia nvarchar(50),
trang_thai char(1),
)

create table cuonsach (
isbn int,
ma_cuonsach int,
tinhtrang char(1),
primary key (isbn, ma_cuonsach),
)

create table muon (
isbn int,
ma_cuonsach int,
ma_docgia int,
ngaygio_muon datetime,
ngay_hethan datetime,
primary key (isbn, ma_cuonsach),
)

create table dangky (
isbn int,
ma_docgia int,
ngaygio_dk datetime,
ghichu ntext,
primary key (isbn, ma_docgia),
)

create table quatrinhmuon (
isbn int,
ma_cuonsach int,
ngaygio_muon datetime,
ma_docgia int,
ngay_hethan datetime,
ngaygio_tra datetime,
tien_muon money,
tien_datra money,
tien_datcoc money,
ghichu ntext,
primary key (isbn, ma_cuonsach, ngaygio_muon),
)
go

alter table docgia add foreign key (ma_docgia) references nguoilon(ma_docgia)
alter table docgia add foreign key (ma_docgia) references treem(ma_docgia)

alter table treem add foreign key (ma_docgia) references docgia(ma_docgia)
alter table treem add foreign key (ma_docgia_nguoilon) references nguoilon(ma_docgia)

alter table nguoilon add foreign key (ma_docgia) references docgia(ma_docgia)

alter table dausach add foreign key (ma_tuasach) references tuasach(ma_tuasach)

alter table dangky add foreign key (ma_docgia) references docgia(ma_docgia)
alter table dangky add foreign key (isbn) references dausach(isbn)

alter table muon add foreign key (isbn, ma_cuonsach) references cuonsach(isbn, ma_cuonsach)
alter table muon add foreign key (ma_docgia) references docgia(ma_docgia)

alter table cuonsach add foreign key (isbn) references dausach(isbn)
-- alter table cuonsach add foreign key (isbn, ma_cuonsach) references muon(isbn, ma_cuonsach)

alter table quatrinhmuon add foreign key (isbn, ma_cuonsach) references cuonsach(isbn, ma_cuonsach)
alter table quatrinhmuon add foreign key (ma_docgia) references docgia(ma_docgia)
go


/*
//  create stored procedure

create procedure p_name @param data_type input/ouput
as
 / Todo /
 return value -- co the co hoac khong

khai bao bien
	declare @param data_type
gan gia tri
	set @param=value
	select @param = column_name from ...
in thong bao
	print N''
thong bao loi
	raiserror(N'', 16,1)
if () begin end else begin end
while () begin end
Thuc thi
exec @bien = p_name param1, param2

// create function

create function f_name(@param data_type)
returns data_type
as begin
	return (value...)
end
ham tra ve gia tri bang
returns table
return (select command)

// create trigger

create trigger t_name
on table_name
for [insert, delete, update]
as 
if update(cot)
begin
end

// delete trigger
	drop trigger
// update trigger
	alter ....
	
// vi pham RBTV
	raiserror(...)
	rollback
// cac bang dac biet

inserted : chua cac dong moi them vao
deleted: chua cac dong moi xoa

voi thao tac update, deleted chua du lieu cu, inserted chua cac du lieu moi

// kiem tra ton tai
	if exists (select * from ...) 

	
*/
