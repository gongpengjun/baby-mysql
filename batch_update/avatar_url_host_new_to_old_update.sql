UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "new.gongpengjun.com", "old.gongpengjun.com"), `updated_at` = `updated_at` WHERE id = 1 LIMIT 1;
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "new.gongpengjun.com", "old.gongpengjun.com"), `updated_at` = `updated_at` WHERE id = 2 LIMIT 1;
DO SLEEP(1); /* wait for a second */
UPDATE `baby_database`.`users` SET `avatar_url` = REPLACE(`avatar_url`, "new.gongpengjun.com", "old.gongpengjun.com"), `updated_at` = `updated_at` WHERE id = 3 LIMIT 1;
