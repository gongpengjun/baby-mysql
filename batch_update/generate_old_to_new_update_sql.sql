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
