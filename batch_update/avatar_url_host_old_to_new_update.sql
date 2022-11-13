#execute: generate_old_to_new_update_sql.sql
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "old.gongpengjun.com", "new.gongpengjun.com") WHERE `id` = 1;
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "old.gongpengjun.com", "new.gongpengjun.com") WHERE `id` = 2;
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "old.gongpengjun.com", "new.gongpengjun.com") WHERE `id` = 3;
