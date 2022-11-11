# `redis`

`set key value`

~~~cmd
set name lingnian
~~~

`get key`

~~~cmd
get name
~~~

- Redis 常用操作命令(https://zhuanlan.zhihu.com/p/47692277)

1. 启动`redis` --`redis-server [--port 6379]`-----`redis-server [xx/xx/redis.conf]`

~~~cmd
redis-server --port 6379
#通过配置文件启动
redis-server xx/xx/redis.conf
#打开redis
redis-cli
~~~

2. 连接`redis`--`redis-cli [-h 127.0.0.1 -p 6379 -a password]`

~~~cmd
redis-cli -h 127.0.0.1 -p 6379
~~~

3. 停止`redis`

~~~cmd
redis-cli shutdown
kill redis-pid
~~~

4. 发送命令

~~~cmd
#redis-cli带参数运行
redis-cli shutdown
#不带参数
shutdown
~~~

5. 测试联通性

~~~cmd
127.0.0.1:6379> ping
PONG
~~~

6. `keys key` `keys *`获取所有键 --`keys pattern`

~~~cmd
keys name
keys na*
# * 表示通配符,生产环境不推荐使用
keys *
~~~

7. 获取键总数

~~~cmd
dbsize
~~~

8. 查询键是否存在--`exist key [key ...]`

~~~cmd
exists name age
~~~

9. 删除键 `del key [key ...]`

~~~cmd
del name age
~~~

10. 查询键类型--`type key`

~~~cmd
type name
~~~

11. 移动键 --`move key db`

~~~cmd
#
move name 2
#
select 2
#
key *
~~~

12. 查询`key`的生命周期(秒)---秒语法:`ttl key`,毫秒语法: `pttl key`

~~~cmd
ttl name
#(integer)  / -1 ---永不过期
~~~

13. 设置过期时间---秒语法:`expire key seconds`---毫秒语法: `pexpire key milliseconds`

~~~cmd
expire name 60
ttl name
~~~





























