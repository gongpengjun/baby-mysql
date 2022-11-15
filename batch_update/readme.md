# 刷新数据库数据

[TOC]

## 1、刷新前数据采样和统计

### 1.1、`sample_record.sql`

```sql
select
  *
from
  `baby_database`.`users`
limit
  3;
```

### 1.2、`count_old_host.sql`

```sql
select
  count(1) as avatar_url_old_host_count
from
  `baby_database`.`users`
where
  substring_index(substring_index(avatar_url, '/', 3), '/', -1) = 'old.gongpengjun.com';
```

### 1.3、`count_new_host.sql`

```sql
select
  count(1) as avatar_url_new_host_count
from
  `baby_database`.`users`
where
  substring_index(substring_index(avatar_url, '/', 3), '/', -1) = 'new.gongpengjun.com';
```

### 1.4、数据采样

```shell
$ ./mysql.sh
mysql> source sample_record.sql
+----+-----------------------------------------------+---------------------+---------------------+
| id | avatar_url                                    | created_at          | updated_at          |
+----+-----------------------------------------------+---------------------+---------------------+
|  1 | https://old.gongpengjun.com/baby-public/a.png | 2022-11-15 21:06:41 | 2022-11-15 21:06:41 |
|  2 | https://old.gongpengjun.com/baby-public/b.png | 2022-11-15 21:06:41 | 2022-11-15 21:06:41 |
|  3 | https://old.gongpengjun.com/baby-public/c.png | 2022-11-15 21:06:41 | 2022-11-15 21:06:41 |
+----+-----------------------------------------------+---------------------+---------------------+
3 rows in set (0.00 sec)
```

### 1.5、数据统计

```shell
$ ./mysql.sh count_old_host.sql
3
$ ./mysql.sh count_new_host.sql
0
```

## 2、执行数据刷新

### 2.1、生成回滚数据SQL


生成回滚数据SQL的SQL `generate_old_rollback_sql.sql`:

```sql
SELECT
  concat(
    'UPDATE `baby_database`.`users` ',
    'SET `avatar_url` = ', '"', avatar_url, '"',
    ', `updated_at` = ', '"', updated_at, '"',
    ' WHERE `id` = ',
    id,
    ' LIMIT 1;'
  ) AS `baby_database.users.avatar_url.rollback.sql`
FROM
  `baby_database`.`users`
WHERE
  substring_index(substring_index(avatar_url, '/', 3), '/', -1) = 'old.gongpengjun.com';
```

实际执行：

```shell
$ ./mysql.sh generate_old_rollback_sql.sql | awk '1;NR%2==0{print "DO SLEEP(1); /* wait for a second */"}' > avatar_url_host_old_rollback.sql
```

生成的回滚SQL `avatar_url_host_old_rollback.sql`：

```sql
UPDATE `baby_database`.`users` SET `avatar_url` = "https://old.gongpengjun.com/baby-public/a.png", `updated_at` = "2022-11-15 21:06:41" WHERE `id` = 1 LIMIT 1;
UPDATE `baby_database`.`users` SET `avatar_url` = "https://old.gongpengjun.com/baby-public/b.png", `updated_at` = "2022-11-15 21:06:41" WHERE `id` = 2 LIMIT 1;
DO SLEEP(1); /* wait for a second */
UPDATE `baby_database`.`users` SET `avatar_url` = "https://old.gongpengjun.com/baby-public/c.png", `updated_at` = "2022-11-15 21:06:41" WHERE `id` = 3 LIMIT 1;
```

注：`NR%2==0`表示每2行输出一行`DO SLEEP(1);`即暂停1秒，实际场景可以使用`NR%500==0`每500行暂停一秒。


### 2.2、生成刷数据SQL

`generate_old_to_new_update_sql.sql`:

```sql
select
  concat(
    'UPDATE `baby_database`.`users` ',
    'SET `avatar_url` = REPLACE(`avatar_url`, "old.gongpengjun.com", "new.gongpengjun.com"), `updated_at` = `updated_at` ',
    'WHERE `id` = ',
    id,
    ' LIMIT 1;'
  ) AS `baby_database.users.avatar_url.old2new.update_sql`
from
  `baby_database`.`users`
where
  substring_index(substring_index(avatar_url, '/', 3), '/', -1) = 'old.gongpengjun.com';
```

实际执行：

```shell
$ ./mysql.sh generate_old_to_new_update_sql.sql | awk '1;NR%2==0{print "DO SLEEP(1); /* wait for a second */"}' > avatar_url_host_old_to_new_update.sql
```

### 2.3、执行刷数据SQL

`avatar_url_host_old_to_new_update.sql`:

```sql
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "old.gongpengjun.com", "new.gongpengjun.com"), `updated_at` = `updated_at` WHERE `id` = 1 LIMIT 1;
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "old.gongpengjun.com", "new.gongpengjun.com"), `updated_at` = `updated_at` WHERE `id` = 2 LIMIT 1;
DO SLEEP(1); /* wait for a second */
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "old.gongpengjun.com", "new.gongpengjun.com"), `updated_at` = `updated_at` WHERE `id` = 3 LIMIT 1;
```

实际执行：

```shell
$ ./mysql.sh avatar_url_host_old_to_new_update.sql
```

## 3、刷新后数据采样和统计

### 3.1、数据采样


```shell
$ ./mysql.sh 
mysql> source sample_record.sql
+----+-----------------------------------------------+---------------------+---------------------+
| id | avatar_url                                    | created_at          | updated_at          |
+----+-----------------------------------------------+---------------------+---------------------+
|  1 | https://new.gongpengjun.com/baby-public/a.png | 2022-11-15 21:06:41 | 2022-11-15 21:06:41 |
|  2 | https://new.gongpengjun.com/baby-public/b.png | 2022-11-15 21:06:41 | 2022-11-15 21:06:41 |
|  3 | https://new.gongpengjun.com/baby-public/c.png | 2022-11-15 21:06:41 | 2022-11-15 21:06:41 |
+----+-----------------------------------------------+---------------------+---------------------+
3 rows in set (0.00 sec)
```

### 3.2、数据统计

```shell
$ ./mysql.sh count_old_host.sql
0
$ ./mysql.sh count_new_host.sql
3
```



