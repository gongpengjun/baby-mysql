select
  concat(
    'UPDATE `baby_database`.`users` ',
    'SET `avatar_url` = REPLACE(`avatar_url`, "new.gongpengjun.com", "old.gongpengjun.com"), `updated_at` = `updated_at` ',
    'WHERE id = ',
    id,
    ' LIMIT 1;'
  ) AS `baby_database.users.avatar_url.new2old.update.sql`
from
  `baby_database`.`users`
where
  substring_index(substring_index(avatar_url, '/', 3), '/', -1) = 'new.gongpengjun.com';
