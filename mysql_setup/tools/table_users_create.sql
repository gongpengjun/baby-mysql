USE `baby_database`;
CREATE TABLE `users` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `avatar_url` varchar(255) NOT NULL DEFAULT 'https://gongpengjun.com/baby-public/a.png' COMMENT '用户头像',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
