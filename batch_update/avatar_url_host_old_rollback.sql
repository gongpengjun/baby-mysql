UPDATE `baby_database`.`users` SET `avatar_url` = "https://old.gongpengjun.com/baby-public/a.png", `updated_at` = "2022-11-15 21:06:41" WHERE `id` = 1 LIMIT 1;
UPDATE `baby_database`.`users` SET `avatar_url` = "https://old.gongpengjun.com/baby-public/b.png", `updated_at` = "2022-11-15 21:06:41" WHERE `id` = 2 LIMIT 1;
DO SLEEP(1); /* wait for a second */
UPDATE `baby_database`.`users` SET `avatar_url` = "https://old.gongpengjun.com/baby-public/c.png", `updated_at` = "2022-11-15 21:06:41" WHERE `id` = 3 LIMIT 1;
