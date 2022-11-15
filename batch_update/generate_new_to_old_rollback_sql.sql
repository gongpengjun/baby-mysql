SELECT
  concat(
    'UPDATE `baby_database`.`users` ',
    'SET `avatar_url` = ', '"', avatar_url, '"',
    ', `updated_at` = ', '"', updated_at, '"',
    ' WHERE `id` = ',
    id,
    ' LIMIT 1;'
  ) AS `baby_database.users.avatar_url.new2old.rollback.sql`
FROM
  `baby_database`.`users`
WHERE
  substring_index(substring_index(avatar_url, '/', 3), '/', -1) = 'new.gongpengjun.com';
