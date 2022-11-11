# 地址

代码仓库：

https://gitcode.net/weixin_38305440/jsd2206



王海涛微信： wanght6666666



# 课程安排

- Docker
- Redis
- Rabbitmq
- ELK



# VMware

版本：16+



### 配置NAT网络

网络网段配置成64：

1. 进入虚拟网络编辑器：

   ![image-20220712184255661](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712184255661.png)

2. 点击更改设置获取管理员特权：

   ![image-20220712184352472](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712184352472.png)

3. 选择VMnet8

   ![image-20220712184329766](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712184329766.png)

4. 修改网段，后面两个值改成64.0：

   ![image-20220712184437242](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712184437242.png)



### 虚拟机

centos-9-2007虚拟机中，事先做的配置和安装的环境：

- yum安装源和扩展源配置成了阿里服务器
- 编写了两个脚本，方便设置ip
  - ip-static		设置固定ip
  - ip-dhcp       自动获取ip
- docker
- redis
- rabbitmq
- elasticsearch
- kibana
- kubernetes





1. 课前资料\Centos-7-2009[多快照].7z，解压缩
2. 双击`centos-7-2009.vmx`，加载虚拟机镜像文件
3. 进入快照管理器
   ![image-20220712191611961](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712191611961.png)
4. 切换到 logstash 快照
   ![image-20221015091910722](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20221015091910722.png)
5. 启动虚拟机
6. 按提示选择“已复制该虚拟机”
7. 登录用户名和密码都是`root`
   **注意：输入密码时没有任何提示，但可以输入进去**



### 启动时，如果看到“硬件不兼容”，需要配置VMware版本：

1. 更改硬件兼容性
   ![image-20220712191914588](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712191914588.png)
2. 选择你安装的VMware版本





### 设置IP地址

```shell
ls

./ip-static
IP: 192.168.64.140

# 查看ip设置是否正确
ifconfig ens33

# 如果ip不正确，或者看不到网卡，执行下面命令
systemctl restart network

```



### 客户端终端工具连接服务器

下载绿色版或安装版：

https://mobaxterm.mobatek.net/download-home-edition.html



mobaxterm连接服务器

1. 新建Session - SSH 连接

   ![image-20220712191254256](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712191254256.png)

2. 设置连接信息
   ![image-20220712191401827](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220712191401827.png)

3. 连接，连接时输入密码 `root`



# Docker

容器化技术



用 Docker 启动虚拟机来运行自己的应用

Docker虚拟机对比VMware虚拟机：

- 占资源少
- 启动速度快



### 为什么使用Docker

1. 独立的虚拟环境，在任何场景下应用运行的环境可以保持完全一致
2. 可以充分发挥服务器的运算能力



# 安装docker

参考官方文档，在CentOS中安装

https://docs.docker.com/engine/install/centos/



### 用docker部署应用



###  镜像

- 虚拟机的一组静态磁盘文件

- 可以任意下载、复制、分发

  - hub.docker.com

- 镜像名称，由两部分组成

  - Repository:Tag
  - 名称:标签
  - 如果不写标签，默认标签是`latest`

- 镜像的常用命令

  ```shell
  # 下载镜像
  docker pull 镜像名称
  
  # 镜像列表
  docker images
  
  # 为镜像添加新的名称
  docker tag redis my-redis:v1
  docker tag redis redis-tedu:v2
  
  # 删除镜像的名称
  # 删除最后一个名称时，会把镜像磁盘文件一起删除
  # remove image
  docker rmi my-redis:v1
  docker images
  
  # 导出镜像到压缩文件
  docker save rabbitmq:management benwang6/cerebro:0.9.4 | gzip > a.gz
  
  # 从压缩文件导入，加载镜像
  # 先删除
  docker rmi rabbitmq:management benwang6/cerebro:0.9.4
  # 再导入
  docker load -i a.gz
  ```

  

### 容器

Docker的虚拟机



常用容器命令：

```shell
# 启动tomcat容器
# docker run
#     1. 在本地查找镜像，如果不存在，会自动从仓库下载
#     2. 新创建一个容器
#     3. 在容器中自动运行启动tomcat

# 默认在前台运行，会占用命令行
# Ctrl+c可以退出tomcat
# tomcat退出后，容器中没有任何前台进程运行，那么容器也自动退出
docker run tomcat:8

# 查看镜像构建历史，CMD属性设置的就是默认启动命令
docker history tomcat:8
docker history redis
docker history mariadb
docker history rabbitmq:management

# 查看镜像详情中的CMD属性
docker inspect tomcat:8

# 覆盖CMD，不执行默认命令而是执行自己指定的任意命令
# pwd、ls、env显示完结果后会自动退出，容器也会自动退出
# bash不会自动退出，容器也不会退出
docker run tomcat:8 pwd
docker run tomcat:8 ls -a -l
docker run tomcat:8 env
docker run tomcat:8 bash
catalina.sh start
top
# Ctrl+c退出top
exit #退出bash





# 启动容器
docker run mariadb

# 在前台启动，占用命令行
docker run redis

# 查看容器
docker ps		# 运行状态的容器
docker ps -a   	# all

# 查看镜像中设置的默认启动命令
docker history redis

docker history mariadb

docker history rabbitmq:management

# 覆盖 CMD 设置的默认命令
docker run redis pwd

docker run redis ls -a -l

# -i 交互 -t 终端
docker run -it redis bash

exit

docker ps -a



```



镜像中设置默认启动命令：

- CMD

  ```shell
  CMD ["redis-server"]
  
  # "java -jar /opt/cs/cs.jar"
  CMD ["java", "-jar", "/opt/cs/cs.jar"]
  ```

- ENTRYPOINT

  ```shell
  # "java -jar /opt/cs/cs.jar"
  ENTRYPOINT ["java"]
  CMD ["-jar", "/opt/cs/cs.jar"]
  ```



```SHELL
# 覆盖ENTRYPOINT
docker run --entrypoint ls redis -a -l
```



### -d 后台运行

```shell
docker run -d \
redis

docker ps

docker logs 容器ID前3位
```



### 进入容器，执行容器中的命令

```shell
docker exec -it cbc pwd

docker exec -it cbc touch a.txt

docker exec -it cbc ls -a -l

docker exec -it cbc bash

exit

docker ps

```



### 容器命名

```shell
docker run -d --name r1 \
redis

docker run -d --name r2 \
redis

docker ps

docker logs r1

docker stop r1 r2

docker start r1 r2
```



### --restart=always 让容器可以随系统自动重启

服务器重启，或docker系统服务重启，容器默认是退出状态

```shell
docker run -d --name r3 \
--restart=always \
redis

docker ps

# 重启docker系统服务
systemctl restart docker

docker ps 
```



### --rm 容器关闭时，会被系统自动删除

启动临时容器

- 查看容器中的一些默认设置
- 从容器复制文件到宿主机



```shell
# redis容器启动后，容器内有哪些环境变量
docker run --rm redis env
```



### docker cp 在容器和宿主机之间互相复制文件

```shell
# 从容器复制文件到宿主机
docker cp r3:/data/dump.rdb ~/

ls

# 从宿主机复制文件到容器
docker cp ~/ip-static r3:/data/ip

# 进入容器查看文件
docker exec -it r3 ls /data/
```



### 数据挂载：文件、文件夹、数据卷

```shell
# 启动mariadb数据库，挂载宿主机的一个文件夹存放数据文件
# -v挂载会自动创建宿主机目录
docker run -d --name mysql \
-v /opt/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
mariadb



# 挂载文件
docker run -d --name r4 \
-v /root/redis.conf:/my.conf \
redis \
redis-server /my.conf


docker rm r1 r2 r3
docker rm -f r1 r2 r3

# 清理所有停止的容器
docker container prune
docker container prune -f

# 删除所有容器
# docker ps -aq 列出所有容器的id
docker rm -f $(docker ps -aq)


# 挂载文件夹
# 组主机的文件夹会自动创建
docker run -d --name r1 \
-v /opt/my-app/:/opt/app \
redis

# 访问容器内的路径，创建文件，实际是创建到宿主机挂载的目录下
docker exec -it r1 touch /opt/app/a.txt

# 查看宿主机文件
ls /opt/my-app/
```

### 数据卷挂载

```shell
#  清理容器
docker rm -f $(docker ps -aq)

# 新建数据卷
docker volume create my-vol
# 查看数据卷列表
docker volume ls
# 查看数据卷详情
docker inspect my-vol

# 启动数据库容器，挂载my-vol数据卷
docker run -d --name mysql \
-v my-vol:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
mariadb

# 查看容器的挂载详情
docker inspect mysql



# 启动新的容器，my-vol挂载到容器
docker run -d --name r1 \
-v my-vol:/opt/app/ \
redis

docker exec -it r1 touch /opt/app/a.txt

# ls 数据卷的真实路径
ls /var/lib/docker/volumes/my-vol/_data
```



### 端口映射

#### -p 服务器端口:容器端口

```shell
# 宿主机的6379，映射到容器的6379
docker run -d --name r2 \
-p 6379:6379 \
redis


docker rm -f mysql

# mysql端口映射到服务器
docker run -d --name mysql \
-e MYSQL_ROOT_PASSWORD=root \
-p 3380:3306 \
mariadb

```



#### --net host 让容器直接使用宿主机的网络和端口

```shell
docker run -d --name r3 \
--net host \
redis \
redis-server --port 6380
```



### 虚拟网络

```shell
# 创建网络
docker network create my-net
# 查看网络列表
docker network ls
# 查看网络详情
docker inspect my-net
# 宿主机上创建的虚拟网卡
ifconfig

# 启动容器，连接到my-net网络
docker run -d --name r4 \
--net my-net \
redis

docker run -d --name r5 \
--net my-net \
redis

docker inspect r4
docker inspect r5

# 容器之间和容器与宿主机之间能否互通
ping 172.18.0.2
ping 172.18.0.3

docker exec -it r4 redis-cli -h 172.18.0.3

# 在容器的内部，提供了名字解析环境，可以把容器名，解析成正确的ip
docker exec -it r4 redis-cli -h r5

```



### 构建镜像

使用配置文件，来配置环境安装流程。

Dockerfile配置文件：

```shell
# 选择基础镜像
FROM redis
# 在新构建的镜像中添加 redis.conf
COPY redis.conf /redis.conf
# 设置新的启动命令："redis-server redis.conf的路径"
CMD ["redis-server", "/redis.conf"]
# 设置默认文件件，容器启动后会自动切换到这个目录
WORKDIR /
# 设置默认端口，帮助镜像使用者理解这个镜像
EXPOSE 6379
```



将 Dockerfile 和构建过程中使用的文件，一起放到一个文件夹下

```shell
[redis]
	- Dockerfile
	- redis.conf
	
# 准备文件夹和文件
mkdir /root/redis/
vim /root/redis/Dockerfile # 编辑文件， 把上面内容粘进去
# 按键盘i，进入编辑模式
# 按键盘esc，退出编辑模式
# :进入命令模式，输入wq，保存并退出

cp redis.conf /root/redis/
ls /root/redis/
```



执行构建：

```shell
cd /root/redis/

docker build -t my-reids:v1 ./

docker images
```



![image-20220820092534407](C:\Users\sytsn\Desktop\jsd2206-csmall-passport-teacher\doc\note\Docker.assets\image-20220820092534407.png)



- 镜像是分层结构
- 每一层都可以被重复使用
- 每一层镜像构建出来之后都不可变



### docker 案例

```shell
# 部署halo博客系统
docker run -d --name halo \
-p 8090:8090 \
-v ~/.halo:/root/.halo \
--restart=unless-stopped \
halohub/halo:1.5.4
```



http://192.168.64.140:8090



```shell
CREATE DATABASE wordpress CHARSET utf8mb4;

CREATE USER `root`@`%`;
GRANT ALL PRIVILEGES ON *.* TO `root`@`%`;

# wordpress建站系统
docker run -d --name wordpress \
-e WORDPRESS_DB_HOST=192.168.64.1 \
-e WORDPRESS_DB_USER=root \
-e WORDPRESS_DB_PASSWORD=root \
-e WORDPRESS_DB_NAME=wordpress \
-p 80:80 \
wordpress
```









