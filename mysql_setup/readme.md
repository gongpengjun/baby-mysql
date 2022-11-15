# MySQL数据库安装和使用

[TOC]

## 1、安装准备

### 1.1、`docker`

```shell
$ docker --version
Docker version 20.10.12, build e91ed57
```

### 1.2、`docker-compose`

```shell
$ docker-compose --version
docker-compose version 1.29.2, build 5becea4c
```

## 2、安装文件

### 2.1、目录结构

```shell
$ tree mysql_setup
mysql_setup
├── docker
│  ├── config
│  │  └── my.cnf
│  ├── data
│  └── initdb
├── docker-compose.yml
├── mysql.sh -> tools/mysql_user_gongpengjun.sh
├── run.md
└── tools
    ├── mysql_user_gongpengjun.sh
    ├── mysql_user_root.sh
    ├── show_mysql_uptime.sql    
    ├── rows_count.sh
    ├── rows_sample.sh
    ├── table_users_create.sql
    ├── table_users_init.sql
    └── table_users_show.sql
```

### 2.2、`my.cnf`

MySQL配置文件，简单配置即可。

### 2.3、`data`

MySQL数据存储目录，留空即可。

### 2.4、`initdb`

存放MySQL初始化SQL和初始化脚本，可以留空。

### 2.5、`docker-compose.yml`

docker-compose配置文件。


## 3、安装MySQL

### 3.1、启动


```shell
$ docker-compose up -d
```

### 3.2、登录MySQL - `root`

```shell
$ tools/mysql_user_root.sh tools/show_mysql_uptime.sql
Uptime	119
```

### 3.3、登录MySQL - `gongpengjun`

```shell
$ tools/mysql_user_gongpengjun.sh tools/show_mysql_uptime.sql
Uptime	158
$ ./mysql.sh tools/show_mysql_uptime.sql
Uptime	191
```

### 3.4、登录phpmyadmin

[http://localhost:3308/](http://localhost:3308/)

## 4、初始化MySQL表 `users`

### 4.1、表`users` - 创建

```sql
$ ./mysql.sh tools/table_users_create.sql
```

### 4.2、表`users` - 填数据

```shell
$ ./mysql.sh tools/table_users_init.sql
```


### 4.3、表`users` - 查看

数据库 `baby_database` 中表`users`数据采样：

```shell
$ tools/rows_sample.sh baby_database users
id  avatar_url  created_at  updated_at
1   https://old.gongpengjun.com/baby-public/a.png   2022-11-15 21:06:41 2022-11-15 21:06:41
2   https://old.gongpengjun.com/baby-public/b.png   2022-11-15 21:06:41 2022-11-15 21:06:41
3   https://old.gongpengjun.com/baby-public/c.png   2022-11-15 21:06:41 2022-11-15 21:06:41
```

数据库 `baby_database` 中表`users`行数统计：

```shell
$ tools/rows_count.sh baby_database users
Rows in table: baby_database.users
3
```

## 5、关闭MySQL

### 5.1、启动MySQL

```shell
$ docker-compose up -d
```

### 5.2、查看MySQL启动状态

```shell
$ docker-compose ps
```

实际执行：

```shell
gongpengjun@mbp mysql_setup$ docker-compose ps
     Name                    Command               State                 Ports
--------------------------------------------------------------------------------------------
baby_mysql        docker-entrypoint.sh mysql ...   Up      0.0.0.0:3307->3306/tcp, 33060/tcp
baby_phpmyadmin   /docker-entrypoint.sh apac ...   Up      0.0.0.0:3308->80/tcp
```

### 5.3、关闭MySQL

```shell
$ docker-compose down
```

