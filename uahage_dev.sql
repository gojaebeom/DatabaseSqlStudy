-- use json type column
use uahage_dev;

-- create spaces table
create table spaces(
	id int primary key auto_increment, -- pk
    space_code tinyint default 1, -- 장소 종류 코드 >  1:카페,음식점 / 2:병원 / 3:어린이집 / 4:유치원 / 5:키즈카페 / 6:체험관 / 7:유원지 / 8:장난감도서관 / 9:보육센터
    space_name varchar(50), -- 장소 이름
    addr varchar(100), -- 주소
    phone varchar(20), -- 전화번호
    lat dec(10,6) default 0.0, -- 위도
    lon dec(10,6) default 0.0, -- 경도
    add_info json -- 추가정보 
--     created_at datetime default now(), -- 생성일 
--     updated_at datetime -- 수정일 
--     보통 테이블을 만들 때 생성일 , 수정일은 대부분 들어가지만, 크롤링 & 조회용도로만 사용하기 때문에 추가하지 않음
);

-- 조회 예제 1 
select * from spaces;
select * from spaces where space_code = 1; -- 카페&음식점에 대한 장소 조회

-- 조회 예제 2
select 
(case space_code
	when 1 then "카페,음식점"
	when 2 then "병원"
    when 3 then "어린이집"
    when 4 then "유치원"
    when 5 then "키즈카페"
    when 6 then "체험관"
    when 7 then "유원지"
    when 8 then "장난감도서관"
    when 9 then "보육센터"
	end) as "장소코드", 
space_name as "장소명", 
addr as "주소", 
phone as "전화번호",
lat as "위도",
lon as "경도",
json_extract(add_info, '$."examination"') as "검진 종류"
from spaces;

-- 카페, 음식점 생성 예제
insert into 
spaces( space_code, space_name, addr, phone, lat, lon, add_info )
values( 
	1, "oo 병원", "전라남도 나주 빛가람로", "010-1234-1234", 0.0, 0.0, 
	json_object( 
		"carriage",1 ,
        "bed",0 ,
        "tableware",0 ,
        "nursingroom",0 ,
        "meetingroom",0 ,
        "diapers",0 ,
        "playroom",0 ,
        "chair",0 ,
        "menu",0 
	)
);

-- 병원 생성 예제
insert into 
spaces( space_code, space_name, addr, phone, lat, lon, add_info )
values( 
	2, "oo 병원", "광주 남구 수춘길", "010-0000-0000", 0.0, 0.0, 
	json_object( "examination","oo 검진") 
);

