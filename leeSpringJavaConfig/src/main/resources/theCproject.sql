--------------------------------------------------------
--  파일이 생성됨 - 화요일-3월-22-2022   
--------------------------------------------------------

--------------------------------------------------------
--  BOARD_CATEGORY
--------------------------------------------------------
create table board_category(
    board_category_num number not null,
    category_name varchar2(50) not null,
    constraint pk_board_category_num primary key(board_category_num)
);
CREATE SEQUENCE seq_board_category INCREMENT BY 1 START WITH 1 NOMAXVALUE;

Insert into BOARD_CATEGORY (BOARD_CATEGORY_NUM,CATEGORY_NAME) values (1,'공지사항');
Insert into BOARD_CATEGORY (BOARD_CATEGORY_NUM,CATEGORY_NAME) values (2,'2');
Insert into BOARD_CATEGORY (BOARD_CATEGORY_NUM,CATEGORY_NAME) values (3,'3');
Insert into BOARD_CATEGORY (BOARD_CATEGORY_NUM,CATEGORY_NAME) values (4,'4');
Insert into BOARD_CATEGORY (BOARD_CATEGORY_NUM,CATEGORY_NAME) values (5,'상품QNA');
Insert into BOARD_CATEGORY (BOARD_CATEGORY_NUM,CATEGORY_NAME) values (6,'QNA');
Insert into BOARD_CATEGORY (BOARD_CATEGORY_NUM,CATEGORY_NAME) values (7,'POST');

--------------------------------------------------------
--  BOARD
--------------------------------------------------------
create table board(
    board_num number not null,
    user_id varchar2(50) not null,
    user_name varchar2(50) not null,
    subject varchar2(255) not null,
    content varchar2(4000) not null,
    group_num number,
    layer number default 0,
    orders number default 0,
    hit number default 0, 
    parant_num number default 0, 
    insertDate date default sysdate,
    updateDate date default sysdate, 
    board_category_num number,
    REPLY number default 0,
    board_pwd varchar2(50),
    constraint pk_board_num primary key(board_num),
    constraint fk_board_member_id foreign key(member_id) references member(member_id),
    constraint fk_board_category_num foreign key(board_category_num) references board_category(board_category_num)
);

CREATE SEQUENCE seq_board INCREMENT BY 1 START WITH 1 NOMAXVALUE;
--------------------------------------------------------
--  BOARDFILE
--------------------------------------------------------
create table BoardFile(
      boardfile_id number not null,
      uuid varchar2(200) not null,
      uploadPath varchar2(200) not null,
      fileName varchar2(200) not null,
      Board_Num number not null,
      constraint pk_boardfile_id primary key(boardfile_id),
      constraint fk_BoardFile_Board_Num foreign key(Board_Num) references board(Board_Num)
);
CREATE SEQUENCE seq_boardfile_id INCREMENT BY 1 START WITH 1 NOMAXVALUE;

--------------------------------------------------------
--  PRODUCTFILE
--------------------------------------------------------
create table ProductFile(
      ProductFile_id number not null,
      uuid varchar2(200) not null,
      uploadPath varchar2(200) not null,
      fileName varchar2(200) not null,
      product_num number not null,
      constraint pk_ProductFile_id primary key(ProductFile_id),
      constraint product_num foreign key(product_num) references product(product_num)
);
CREATE SEQUENCE seq_productfile_id INCREMENT BY 1 START WITH 1 NOMAXVALUE;

--------------------------------------------------------
--  REPLY
--------------------------------------------------------
  create table Reply(
    reply_num number not null,
    board_num number not null,
    replyer varchar2(50) not null,
    content varchar2(4000) not null,
    replyDate date default sysdate, 
    updateDate date default sysdate,
    constraint pk_reply_num primary key(reply_num),
    constraint fk_reply_board_num foreign key(board_num) references board(board_num)
);

CREATE SEQUENCE seq_reply INCREMENT BY 1 START WITH 1 NOMAXVALUE;


CREATE TABLE PRODUCT_CATEGORY(
    PRODUCT_CATEGORY_NUM NUMBER, 
	PRODUCT_CATEGORY_NAME VARCHAR2(500),
    PRODUCT_CATEGORY_NUM_REF NUMBER not null,
    constraint pk_PRODUCT_CATEGORY_NUM primary key(PRODUCT_CATEGORY_NUM),
    constraint fk_PRODUCT_CATEGORY_NUM_REF foreign key(PRODUCT_CATEGORY_NUM_REF) references PRODUCT_CATEGORY(PRODUCT_CATEGORY_NUM)
);
CREATE SEQUENCE seq_PRODUCT_CATEGORY_NUM INCREMENT BY 1 START WITH 10000 NOMAXVALUE;

CREATE TABLE PRODUCT(
    product_num NUMBER, 
	product_name VARCHAR2(200),
    brand_name VARCHAR2(200),
    cateCode1 NUMBER,
    cateCode2 NUMBER,
    cateCode3 NUMBER,
    brandCategory NUMBER,
    product_price NUMBER,
    product_descrip VARCHAR2(4000),
    legDate date default sysdate, 
    updateDate date default sysdate,
    constraint pk_PRODUCT_NUM primary key(product_num),
    constraint fk_PRODUCT_brandCategory foreign key(brandCategory) references PRODUCT_CATEGORY(PRODUCT_CATEGORY_NUM)
);

CREATE SEQUENCE seq_PRODUCT_ID INCREMENT BY 1 START WITH 1 NOMAXVALUE;

CREATE TABLE PRODUCT_CATEGORY_LINK(
    product_num NUMBER,
    product_category_num NUMBER, 
    constraint fk_link_product_category_num foreign key(product_category_num) references PRODUCT_CATEGORY(product_category_num),
    constraint product_num foreign key(product_num) references product(product_num)
);


create table member(
    member_id varchar2(50) not null,
    rank_num number default 1,
    member_name varchar2(50) not null,
    member_pwd varchar2(50) not null,
    zipcode number not null,
    addr1 varchar2(100) not null,
    addr2 varchar2(50) not null,
    tel1 varchar2(50) not null,
    tel2 varchar2(50) not null,
    tel3 varchar2(50) not null,
    phone1 varchar2(50) not null,
    phone2 varchar2(50) not null,
    phone3 varchar2(50) not null,
    email varchar2(50) not null,
    email_check varchar2(50) not null,
    mileage number default 2000,
    joinDate date default sysdate,
    updateDate date default sysdate,
    constraint pk_member_id primary key(user_id),
    constraint fk_member_rank_num foreign key(rank_num) references member_rank(rank_num)
);

create table user_rank(
    rank_num number not null,
    rank_name varchar2(50) not null,
    constraint pk_rank_num primary key(rank_num)
);


create table BrandFile(
      brandfile_id number not null,
      uuid varchar2(200) not null,
      uploadPath varchar2(200) not null,
      fileName varchar2(200) not null,
      brand_Num number not null,
      constraint pk_brandfile_id primary key(brandfile_id),
      constraint fk_BoardFile_Brand_Num foreign key(brand_Num) references product_category(product_category_num)
);
CREATE SEQUENCE seq_brandfile_id INCREMENT BY 1 START WITH 1 NOMAXVALUE;

create table Product_Size(
    product_size_id number not null,
    product_size varchar2(200) not null,
    product_top_length varchar2(200) not null,
    product_shoulder varchar2(200) not null,
    product_chest varchar2(200) not null,
    product_sleeve varchar2(200) not null,
    product_waist_width varchar2(200) not null,
    product_thigh_width varchar2(200) not null,
    product_bottom_length varchar2(200) not null,
    product_ankle_circumference varchar2(200) not null,
    product_front_rise varchar2(200) not null,
    product_cap_length varchar2(200) not null,
    product_cap_circumference varchar2(200) not null,
    product_cap_depth varchar2(200) not null,
    product_num number not null,
    constraint pk_product_size_id primary key(product_size_id),
    constraint fk_ProductSize_product_num foreign key(product_num) references product(product_num)
);
CREATE SEQUENCE seq_product_size_id INCREMENT BY 1 START WITH 1 NOMAXVALUE;


create table Detail_Product(
    detail_product_id number not null,
    product_size_id number not null,
    product_num number not null,
    status number not null,
    legDate date default sysdate, 
    updateDate date default sysdate,
    constraint pk_detail_product_id primary key(detail_product_id),
    constraint fk_DP_product_size_id foreign key(product_size_id) references Product_Size(product_size_id),
    constraint fk_Detail_Product_product_num foreign key(product_num) references product(product_num)
);
CREATE SEQUENCE seq_detail_product_id INCREMENT BY 1 START WITH 1 NOMAXVALUE;



create table Detail_Order(
    detail_order_id number not null,
    order_id varchar2(200) not null,
    detail_product_id number not null,
    product_price number not null,
    legDate date default sysdate, 
    updateDate date default sysdate,
    constraint pk_detail_order_id primary key(detail_order_id),
    constraint fk_DO_detail_product_id foreign key(detail_product_id) references Detail_Product(detail_product_id)
);
CREATE SEQUENCE seq_detail_order_id INCREMENT BY 1 START WITH 1 NOMAXVALUE;

create table Orders(
    order_id varchar2(200) not null,
    member_id varchar2(200) not null,
    zipcode number not null,
    addr1 varchar2(200) not null,
    addr2 varchar2(200) not null,
    tel1 varchar2(200) not null,
    tel2 varchar2(200) not null,
    tel3 varchar2(200) not null,
    phone1 varchar2(200) not null,
    phone2 varchar2(200) not null,
    phone3 varchar2(200) not null,
    status varchar2(200) not null,
    price number not null,
    deliveryCost number not null,
    legDate date default sysdate, 
    updateDate date default sysdate,
    constraint pk_order_id primary key(order_id),
    constraint fk_Order_member_id foreign key(member_id) references Member(member_id)
);
CREATE SEQUENCE seq_order_id INCREMENT BY 1 START WITH 1 NOMAXVALUE;

CREATE TABLE CART(
    member_id varchar2(50) not null,
	detail_product_id number not null, 
    legDate date default sysdate, 
    updateDate date default sysdate,
    constraint fk_CART_member_id foreign key(member_id) references MEMBER(member_id),
    constraint fk_CART_detail_product_id foreign key(detail_product_id) references Detail_Product(detail_product_id)
);