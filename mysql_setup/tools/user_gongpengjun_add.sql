CREATE USER 'gongpengjun'@'%' IDENTIFIED BY 'g1p2j3';
GRANT ALL PRIVILEGES ON *.* TO 'gongpengjun'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'gongpengjun'@'%';

# https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql
