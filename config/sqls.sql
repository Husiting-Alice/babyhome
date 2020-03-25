DROP DATABASE IF EXISTS BABYHOME


CREATE DATABASE IF NOT EXISTS BABYHOME DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
use BABYHOME;

-- 1 关于我们(使用须知,关于我们)
CREATE TABLE IF NOT EXISTS `aboutus`(
   `aboutus_id` INT UNSIGNED AUTO_INCREMENT,
   `aboutus_type` VARCHAR(15) NOT NULL,
   `content_type` VARCHAR(15) NOT NULL,
   `aboutus_content` VARCHAR(600) NOT NULL,
   `publish_time` DATE NOT NULL,
   `publisher` VARCHAR(20) NOT NULL,
   `delete_flag` INT NOT NULL, 
   PRIMARY KEY ( `aboutus_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2 打拐普法专栏(普法宣传,热映电影,防拐小窍门)
CREATE TABLE IF NOT EXISTS `crackabduction`(
   `crackabduction_id` INT UNSIGNED AUTO_INCREMENT,
   `crackabduction_type` VARCHAR(20) NOT NULL,
   `movieimg_url` VARCHAR(255),
   `crackabduction_content` VARCHAR(400) NOT NULL,
   `publish_time` DATE NOT NULL,
   `delete_flag` INT NOT NULL, 
   PRIMARY KEY ( `crackabduction_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 3 寻人者
CREATE TABLE IF NOT EXISTS `seeker`(
   `seeker_openid` VARCHAR(100) NOT NULL,
   `wechat_nickname` VARCHAR(40) NOT NULL,
   `phone_number` CHAR(11) NOT NULL,
   `seeker_avartar_url` VARCHAR(255) NOT NULL,
   `account_status` INT NOT NULL,
   PRIMARY KEY ( `seeker_openid` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 4 志愿者申请表 --check_status 审核状态 0,不通过,1通过
CREATE TABLE IF NOT EXISTS `volunteer_apply`(
   `volunteer_openid` VARCHAR(100) NOT NULL,
   `account` VARCHAR(20) NOT NULL, -- user,,foreign key
   `v_name` VARCHAR(20) NOT NULL,
   `sex` CHAR(2) NOT NULL,
   `birthday` DATE NOT NULL,
   `idcard` CHAR(18) NOT NULL,
   `phone_number` CHAR(11) NOT NULL,
   `qq` VARCHAR(16) NOT NULL,
   `usual_place` VARCHAR(100) NOT NULL,
   `current_place` VARCHAR(100) NOT NULL,
   `avartar_url` VARCHAR(255) NOT NULL,
   `apply_reason` VARCHAR(300) NOT NULL,
   `check_status` INT NOT NULL,
   PRIMARY KEY ( `volunteer_openid` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 5 用户表(管理员,志愿者)
CREATE TABLE IF NOT EXISTS `user_accounts`(
   `user_account` VARCHAR(20) NOT NULL, -- 志愿者/管理员帐号
   `user_pwd` VARCHAR(20) NOT NULL,
   `authority` VARCHAR(15) NOT NULL,
   `account_status` INT NOT NULL,
   PRIMARY KEY ( `user_account` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 6 用户表, 志愿者/管理员
CREATE TABLE IF NOT EXISTS `user`(
   `user_id` INT UNSIGNED AUTO_INCREMENT,
   `volunteer_openid` VARCHAR(100) DEFAULT '000000' NOT NULL,
   `account` VARCHAR(20) NOT NULL, -- user,,foreign key
   `v_name` VARCHAR(20) NOT NULL,
   `sex` CHAR(2) NOT NULL,
   `birthday` DATE NOT NULL,
   `idcard` CHAR(18) NOT NULL,
   `phone_number` CHAR(11) NOT NULL,
   `qq` VARCHAR(16) NOT NULL,
   `usual_place` VARCHAR(100) NOT NULL,
   `current_place` VARCHAR(100) NOT NULL,
   `avartar_url` VARCHAR(255) NOT NULL,
   `account_status` INT NOT NULL,
   PRIMARY KEY ( `user_id` ),
   CONSTRAINT fk_volunteerapply_user 
   FOREIGN KEY(volunteer_openid) REFERENCES volunteer_apply(volunteer_openid),
   CONSTRAINT fk_useraccount_user 
   FOREIGN KEY(account) REFERENCES user_accounts(user_account)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 6 管理员
-- CREATE TABLE IF NOT EXISTS `administrator`(
--    `admin_account` VARCHAR(20) NOT NULL, -- user,,foreign key
--    `name` VARCHAR(20) NOT NULL,
--    `sex` CHAR(2) NOT NULL,
--    `birthday` DATE NOT NULL,
--    `idcard` CHAR(18) NOT NULL,
--    `phone_number` CHAR(11) NOT NULL,
--    `qq` VARCHAR(16) NOT NULL,
--    `admin_avartar` VARCHAR(255) NOT NULL,
--    PRIMARY KEY ( `admin_account` )
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 6 黑名单 寻亲者
-- CREATE TABLE IF NOT EXISTS `blacklist`(
--    `blacklist_id` INT UNSIGNED AUTO_INCREMENT,
--    `user_openid` VARCHAR(100) NOT NULL, -- 寻人者或志愿者openid,,foreign key,,违反了第一范式,跟进寻人也是,一个字段不能有歧义
--    `volunteer_account` VARCHAR(20) NOT NULL, -- 志愿者帐号,,foreign key
--    `add_time` DATETIME NOT NULL,
--    `add_reason` VARCHAR(50) NOT NULL,
--    PRIMARY KEY ( `user_openid` )
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 7 黑名单 寻亲者
CREATE TABLE IF NOT EXISTS `seeker_blacklist`(
   -- `blacklist_id` INT UNSIGNED AUTO_INCREMENT,
   `seeker_openid` VARCHAR(100) NOT NULL, -- 寻人者标识,,foreign key
   `add_time` DATETIME NOT NULL,
   `add_reason` VARCHAR(50) NOT NULL,
   PRIMARY KEY ( `seeker_openid` ),
   CONSTRAINT fk_blacklist_seeker 
   FOREIGN KEY(seeker_openid) REFERENCES seeker(seeker_openid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 8 黑名单 志愿者
CREATE TABLE IF NOT EXISTS `volunteer_blacklist`(
   -- `blacklist_id` INT UNSIGNED AUTO_INCREMENT,
   `volunteer_account` VARCHAR(20) NOT NULL, -- 志愿者帐号,,foreign key
   `add_time` DATETIME NOT NULL,
   `add_reason` VARCHAR(50) NOT NULL,
   PRIMARY KEY ( `volunteer_account` ),
   CONSTRAINT fk_blacklist_volunteer 
   FOREIGN KEY(volunteer_account) REFERENCES user(account)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 9 意见建议
CREATE TABLE IF NOT EXISTS `advice`(
   `advice_id` INT UNSIGNED AUTO_INCREMENT,
   `email` VARCHAR(30) NOT NULL,
   `advice_content` VARCHAR(100) NOT NULL,
   `refer_time` DATETIME NOT NULL,
   PRIMARY KEY ( `advice_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 10 爱心捐赠
CREATE TABLE IF NOT EXISTS `donate`(
   `donate_id` INT UNSIGNED AUTO_INCREMENT,
   `donator_name` VARCHAR(20) NOT NULL,
   `sum_of_money` float(7,2) NOT NUll,
   `usage_type` VARCHAR(50) NOT NULL,
   `donate_time` DATETIME,
   PRIMARY KEY ( `donate_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 11 捐赠资金支出登记
CREATE TABLE IF NOT EXISTS `expenditure`(
   `expenditure_id` INT UNSIGNED AUTO_INCREMENT,
   `expend_count` float(7,2) NOT NUll,
   `expend_usage_desc` VARCHAR(100) NOT NULL,
   `expend_time` DATETIME NOT NULL,
   PRIMARY KEY ( `expenditure_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 12 寻亲信息-宝贝寻家
CREATE TABLE IF NOT EXISTS `baby_home`(
   `baby_home_id` VARCHAR(15) NOT NULL,
   `seeker_openid` VARCHAR(15) NOT NULL, -- 寻人者 openid,,foreign key
   `findType` VARCHAR(15) NOT NULL, -- 宝贝寻家,家寻宝贝,流浪登记
   `name` VARCHAR(20) NOT NULL,
   `sex` CHAR(2) NOT NULL,
   `birthday` DATE,
   `lose_date` DATETIME,
   `lose_addr` VARCHAR(100) NOT NULL,
   `blood_type` CHAR(2) NOT NULL,
   `lose_height` INT,  -- cm
   `memory` VARCHAR(300) NOT NULL,
   `picture` VARCHAR(255) NOT NULL,
   `notes` VARCHAR(200),
   `contacts_name` VARCHAR(20) NOT NULL,
   `contacts_sex` CHAR(2) NOT NULL,
   `contacts_qq` VARCHAR(16),
   `contacts_addr` VARCHAR(100) NOT NULL,
   `contacts_phone` CHAR(11) NOT NULL,
   `relationship` VARCHAR(10) NOT NULL,
   `follow_status` INT NOT NULL,
   `clues` VARCHAR(200) NOT NULL,
   `update_flag` INT DEFAULT 0 NOT NULL,
   PRIMARY KEY ( `baby_home_id` ),
   CONSTRAINT fk_babyhome_seeker 
   FOREIGN KEY(seeker_openid) REFERENCES seeker(seeker_openid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 13 寻亲信息-家寻宝贝
CREATE TABLE IF NOT EXISTS `home_baby`(
   `home_baby_id` VARCHAR(15) NOT NULL,
   `seeker_openid` VARCHAR(15) NOT NULL, -- 寻人者 openid,,foreign key
   `findType` VARCHAR(15) NOT NULL,
   `name` VARCHAR(20) NOT NULL,
   `sex` CHAR(2) NOT NULL,
   `birthday` DATE,
   `lose_date` DATETIME,
   `lose_addr` VARCHAR(100) NOT NULL,
   `blood_type` CHAR(2) NOT NULL,
   `lose_height` INT,
   `appearance` VARCHAR(200) NOT NULL,
   `picture` VARCHAR(255) NOT NULL,
   `notes` VARCHAR(200),
   `contacts_name` VARCHAR(20) NOT NULL,
   `contacts_sex` CHAR(2) NOT NULL,
   `contacts_qq` VARCHAR(16),
   `contacts_addr` VARCHAR(100) NOT NULL,
   `contacts_phone` CHAR(11) NOT NULL,
   `relationship` VARCHAR(10) NOT NULL,
   `follow_status` INT NOT NULL,
   `clues` VARCHAR(200) NOT NULL,
   `update_flag` INT DEFAULT 0 NOT NULL,
   PRIMARY KEY ( `home_baby_id` ),
   CONSTRAINT fk_homebaby_seeker 
   FOREIGN KEY(seeker_openid) REFERENCES seeker(seeker_openid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 14 寻亲信息-流浪儿登记
CREATE TABLE IF NOT EXISTS `tramp`(
   `tramp_id` VARCHAR(15) NOT NULL,
   `seeker_openid` VARCHAR(15) NOT NULL, -- 寻人者 openid,,foreign key
   `findType` VARCHAR(15) NOT NULL,
   `name` VARCHAR(20) NOT NULL,
   `sex` CHAR(2),
   `about_age` INT,
   `height` INT,
   `find_time` DATETIME NOT NULL,
   `find_addr` VARCHAR(100) NOT NULL,
   `appearance` VARCHAR(200) NOT NULL,
   `picture` VARCHAR(255) NOT NULL,
   `notes` VARCHAR(200),
   `contacts_name` VARCHAR(20) NOT NULL,
   `contacts_sex` CHAR(2) NOT NULL,
   `contacts_qq` VARCHAR(16),
   `contacts_addr` VARCHAR(100) NOT NULL,
   `contacts_phone` CHAR(11) NOT NULL,
   `follow_status` INT NOT NULL,
   `clues` VARCHAR(200) NOT NULL,
   `update_flag` INT DEFAULT 0 NOT NULL,
   PRIMARY KEY ( `tramp_id` ),
   CONSTRAINT fk_tramp_seeker
   FOREIGN KEY(seeker_openid) REFERENCES seeker(seeker_openid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 15 跟进 宝贝寻家
CREATE TABLE IF NOT EXISTS `baby_home_follow`(
   `follow_id` VARCHAR(15) NOT NULL,
   `volunteer_account` VARCHAR(20) NOT NULL,
   `del_state` INT,
   PRIMARY KEY ( `follow_id` ),
   CONSTRAINT fk_babyhome_follow
   FOREIGN KEY(follow_id) REFERENCES baby_home(baby_home_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 16 跟进 家寻宝贝
CREATE TABLE IF NOT EXISTS `home_baby_follow`(
   `follow_id` VARCHAR(15) NOT NULL,
   `volunteer_account` VARCHAR(20) NOT NULL,
   `del_state` INT,
   PRIMARY KEY ( `follow_id` ),
   CONSTRAINT fk_homebaby_follow 
   FOREIGN KEY(follow_id) REFERENCES home_baby(home_baby_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 17 跟进 流浪
CREATE TABLE IF NOT EXISTS `tramp_follow`(
   `follow_id` VARCHAR(15) NOT NULL, 
   `volunteer_account` VARCHAR(20) NOT NULL, 
   `del_state` INT,
   PRIMARY KEY ( `follow_id` ),
   CONSTRAINT fk_tramp_follow 
   FOREIGN KEY(follow_id) REFERENCES tramp(tramp_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 18 成功案例
CREATE TABLE IF NOT EXISTS `success_example`(
   `example_id` INT UNSIGNED AUTO_INCREMENT,
   `example_title` VARCHAR(100) NOT NULL,
   `example_content` VARCHAR(6000) NOT NULL,
   `publish_time` DATETIME,
   `publisher` VARCHAR(20) NOT NULL,
   `delete_flag` INT NOT NULL, 
   PRIMARY KEY ( `example_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 19 举报
CREATE TABLE IF NOT EXISTS `accusation`(
   `accuse_id` INT UNSIGNED AUTO_INCREMENT,
   `accuse_type` VARCHAR(20) NOT NULL,
   `accused`  VARCHAR(20),
   `accused_phone` CHAR(11) NOT NULL,  -- volunteer_phone/seeker_phone
   `notes` VARCHAR(200),
   `picture_url` VARCHAR(255) NOT NULL,
   PRIMARY KEY ( `accuse_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;




------------------------------------------


-- 创建测试数据库
create database exer ;

-- 使用数据库
use exer;

-- 创建表
drop table if exists tb_person;
create table tb_person(
    pid varchar(10),
    name varchar(20),
    age integer,
    sex varchar(1),
    primary key(pid)
);

-- 创建存储过程,如果以前的存在,先删除
drop procedure if exists randSex;
delimiter //
create PROCEDURE randSex(in `name` varchar(20),in age int)
  begin    
    -- 声明字符串变量pKey存放表的pid,sex存放年龄
    declare pKey,sex varchar(10);
    -- 声明int变量,用于存放生成性别的随机数0 - 1
    declare var INT;
    
    -- 查询表tb_person的最大pid,存入pKey中
    select max(pid) into pKey from tb_person;
    
    -- 如果pKey是空的,就设置初始值为'P_0001'   
    if pKey is null then 
        set pKey = 'P_0001';
    else 
    /*
     pKey存在
     1 截取pKey中的数字部分,加1后重新拼接成 'P_0001'的形式
     2 重新赋值给pKey 
    */
    set pKey = concat('P_',lpad(SUBSTRING(pKey,INSTR(pKey,'_')+1)+1,4,0));
    end if;
    
    -- 设置var为rand()函数*2取整数既 0 或者 1 
    set var = floor(rand()*2);
    /*
    如果var = 1 设置sex为男,否则设置为女
    */
    if var = 1 then
        set sex ='男';
    else
    set sex = '女';
    end if;
    
    -- 拼接添加sql,将参数传递进去
    set @sqlcmd = concat('insert into tb_person(pid,name,age,sex) value(\'',pKey,'\',\'',name,'\',',age,',\'',sex,'\')');
    -- 传递给 stmt
    prepare stmt from @sqlcmd;
    -- 执行sql
    execute stmt;
    DEALLOCATE PREPARE stmt;
    
    -- 查看拼接的sql
    select @sqlcmd as `sql`;
  end;
  //
delimiter;

-- 测试
call randSex('张珊',23);
CALL randSex('李四',22);




CREATE TABLE IF NOT EXISTS `runoob_tbl`(
   `runoob_id` INT UNSIGNED AUTO_INCREMENT,
   `runoob_title` VARCHAR(100) NOT NULL,
   `runoob_author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY ( `runoob_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO table_name ( field1, field2,...fieldN )
                       VALUES
                       ( value1, value2,...valueN );

INSERT INTO runoob_tbl
     VALUES
     (0, "JAVA 教程", "RUNOOB.COM", '2016-05-06');

SELECT column_name,column_name
FROM table_name
[WHERE Clause]
[LIMIT N][ OFFSET M]


-- -- 10 寻亲信息-宝贝寻家
-- CREATE TABLE IF NOT EXISTS `baby_home`(
--    `baby_home_id` VARCHAR(15) NOT NULL,
--    `seeker_openid` VARCHAR(15) NOT NULL, -- 寻人者 openid,,foreign key
--    `findType` VARCHAR(15) NOT NULL,
--    `name` VARCHAR(20) NOT NULL,
--    `sex` CHAR(2) NOT NULL,
--    `birthday` DATE,
--    `lose_date` DATETIME,
--    `lose_addr` VARCHAR(100) NOT NULL,
--    `blood_type` CHAR(2) NOT NULL,
--    `lose_height` INT,  -- cm
--    `memory` VARCHAR(300) NOT NULL,
--    `picture` VARCHAR(255) NOT NULL,
--    `notes` VARCHAR(200),
--    `contacts_name` VARCHAR(20) NOT NULL,
--    `contacts_sex` CHAR(2) NOT NULL,
--    `contacts_qq` VARCHAR(16),
--    `contacts_addr` VARCHAR(100) NOT NULL,
--    `contacts_phone` CHAR(11) NOT NULL,
--    `relationship` VARCHAR(10) NOT NULL,
--    `follow_status` INT NOT NULL,
--    `clues` VARCHAR(200) NOT NULL,
--    PRIMARY KEY ( `baby_home_id` )
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -- 11 寻亲信息-家寻宝贝
-- CREATE TABLE IF NOT EXISTS `home_baby`(
--    `home_baby_id` VARCHAR(15) NOT NULL,
--    `seeker_openid` VARCHAR(15) NOT NULL, -- 寻人者 openid,,foreign key
--    `findType` VARCHAR(15) NOT NULL,
--    `name` VARCHAR(20) NOT NULL,
--    `sex` CHAR(2) NOT NULL,
--    `birthday` DATE,
--    `lose_date` DATETIME,
--    `lose_addr` VARCHAR(100) NOT NULL,
--    `blood_type` CHAR(2) NOT NULL,
--    `lose_height` INT,
--    `appearance` VARCHAR(200) NOT NULL
--    `picture` VARCHAR(255) NOT NULL,
--    `notes` VARCHAR(200),
--    `contacts_name` VARCHAR(20) NOT NULL,
--    `contacts_sex` CHAR(2) NOT NULL,
--    `contacts_qq` VARCHAR(16),
--    `contacts_addr` VARCHAR(100) NOT NULL,
--    `contacts_phone` CHAR(11) NOT NULL,
--    `relationship` VARCHAR(10) NOT NULL,
--    `follow_status` INT NOT NULL,
--    `clues` VARCHAR(200) NOT NULL,
--    PRIMARY KEY ( `home_baby_id` )
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -- 12 寻亲信息-流浪儿登记
-- CREATE TABLE IF NOT EXISTS `tramp`(
--    `tramp_id` VARCHAR(15) NOT NULL,
--    `seeker_openid` VARCHAR(15) NOT NULL, -- 寻人者 openid,,foreign key
--    `findType` VARCHAR(15) NOT NULL,
--    `name` VARCHAR(20) NOT NULL,
--    `sex` CHAR(2),
--    `about_age` INT,
--    `height` INT,
--    `find_time` DATETIME NOT NULL,
--    `find_addr` VARCHAR(100) NOT NULL,
--    `appearance` VARCHAR(200) NOT NULL
--    `picture` VARCHAR(255) NOT NULL,
--    `notes` VARCHAR(200),
--    `contacts_name` VARCHAR(20) NOT NULL,
--    `contacts_sex` CHAR(2) NOT NULL,
--    `contacts_qq` VARCHAR(16),
--    `contacts_addr` VARCHAR(100) NOT NULL,
--    `contacts_phone` CHAR(11) NOT NULL,
--    `follow_status` INT NOT NULL, --游离,跟进中,已找到
--    `clues` VARCHAR(200) NOT NULL,
--    PRIMARY KEY ( `tramp_id` )
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -- 13 跟进
-- CREATE TABLE IF NOT EXISTS `follow_up`(
--    `follow_up_id` VARCHAR(15) NOT NULL, --对应tramp_id/baby_home_id/home_baby_id,,foreign key
--    `volunteer_account` VARCHAR(20) NOT NULL, -- volunteer_account,,foreign key
--    `volunteer_name` VARCHAR(20) NOT NULL, -- volunteer_name
--    `follow_time` DATETIME,
--    `del_state` INT,
--    PRIMARY KEY ( `follow_up_id` )
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;


--    [CONSTRAINT <外键名>] FOREIGN KEY 字段名 [，字段名2，…]
--    REFERENCES <主表名> 主键列1 [，主键列2，…]
--    CONSTRAINT fk_emp_dept1
--    FOREIGN KEY(deptId) REFERENCES tb_dept1(id)