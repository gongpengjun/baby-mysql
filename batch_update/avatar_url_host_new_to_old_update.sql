#execute: generate_new_to_old_update_sql.sql
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "new.gongpengjun.com", "old.gongpengjun.com") WHERE id = 1;
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "new.gongpengjun.com", "old.gongpengjun.com") WHERE id = 2;
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "new.gongpengjun.com", "old.gongpengjun.com") WHERE id = 3;
