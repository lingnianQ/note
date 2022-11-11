# `MYSQL 8.x`安装流程(windows)

## 一丶下载安装

- 下载: [MySQL Community Downloads 8.x](https://dev.mysql.com/downloads/mysql//)

- 解压文件

- 在文件夹`mysql-8.0.30-winx64`下创建`mysql`配置文件:
	
	- `data`文件夹
	- `my.ini`文件
	
	~~~cmd
	[mysqld]
	# 设置3306端口
	port=3306
	# 设置mysql的安装目录---切换为自己的安装目录
	basedir=D:\mysql-8.0.30-winx64
	# 设置mysql数据库的数据的存放目录---切换为自己的安装目录
	datadir=D:\mysql-8.0.30-winx64\data
	# 允许最大连接数
	max_connections=200
	# 允许连接失败的次数。这是为了防止有人从该主机试图攻击数据库系统
	max_connect_errors=10
	# 服务端使用的字符集默认为UTF8
	character-set-server=utf8
	# 创建新表时将使用的默认存储引擎
	default-storage-engine=INNODB
	[mysql]
	# 设置mysql客户端默认字符集
	default-character-set=utf8
	[client]
	# 设置mysql客户端连接服务端时默认使用的端口
	port=3306
	default-character-set=utf8
	~~~

- 配置`mysql`环境变量

  - 高级系统设置>环境变量>新建系统变量--
    - 变量名:`MYSQL_HOME`
    - 变量值:`D:\mysql-8.0.30-winx64`--切换为自己的
  - MYSQL_HOME编辑系统环境变量`Path`,添加`%MYSQL_HOME%\bin`
  - `win+R`--输入`cmd`,在`dos`窗口中输入`mysqld --version`,正常显示版本号

- 初始化`mysql`

  - 管理员运行`dos`窗口`cmd`


  ~~~cmd
  mysqld --initialize --user=mysql --console
  ~~~

  - 初始化成功生成密码`password`(切换为自己的)

  - 记住密码--密码前面有空格,注意忽略

- 安装`MySQL`到系统服务

  ~~~cmd
  # 安装服务：
  mysqld install
  # 启动服务：
  net start mysql
  # 关闭服务：
  # net stop mysql
  ~~~

## 二丶登录和使用

- 登录`mysql`,修改`root`用户密码

- `win+R`--输入`cmd`,在`dos`窗口中输入

  ~~~cmd
  mysql -uroot -ppassword
  ~~~

  `password`--(切换为自己的)

- 修改`root`用户密码为`123456`

  ~~~mysql
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';  
  ~~~

- 刷新权限

  ~~~mysql
  flush privileges;
  ~~~

- 允许其他机器访问数据

  ~~~mysql
  -- 查看权限
  use mysql;
  select host from user where user = 'root';
  -- 更新权限
  update user set host='%' where user = 'root';
  -- 刷新权限
  flush privileges;
  ~~~

## 三丶重置密码-创建用户

- 忘记`root`密码重置

  - 先关掉已启动的`mysql`服务，管理员权限的`cmd`下，命令:

  ~~~cmd
  net stop mysql
  ~~~

  - 启动不校验密码的`mysql`服务，命令:

  ~~~cmd
  mysqld --console --skip-grant-tables --shared-memory
  ~~~

  - 重新打开一个`cmd`窗口:

  ~~~cmd
  mysql -uroot -p
  ~~~

  - 修改密码

  ~~~mysql
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
  flush privileges;
  ~~~

  - 创建用户--方法之一

  ~~~mysql
  user mysql;
  INSERT INTO `user` VALUES ('%', 'nick', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '', '', '', '', 0, 0, 0, 0, 'mysql_native_password', '*81F5E21E35407D884A6CD4A731AEBFB6AF209E1B', 'N', '2021-11-24 14:20:16', 0, 'N', 'Y', 'Y', NULL, NULL, NULL, NULL);
  flush privileges;
  ~~~

  - 上面的`*81F5E21E35407D884A6CD4A731AEBFB6AF209E1B`为`mysql`加密后的密码,

    登录时为`root`

~~~cmd
mysql -uroot -proot
~~~

​    









