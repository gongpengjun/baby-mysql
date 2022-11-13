select
  count(1) as avatar_url_new_host_count
from
  `baby_database`.`users`
where
  substring_index(substring_index(avatar_url, '/', 3), '/', -1) = 'new.gongpengjun.com';
