CREATE DATABASE IF NOT EXISTS wordpress;

CREATE USER 'cboutier'@'%';
SET PASSWORD FOR 'cboutier'@'%' = PASSWORD('MARIADB_PWD');
GRANT ALL PRIVILEGES ON wordpress.* TO 'cboutier'@'%' IDENTIFIED BY 'MARIADB_PWD';
FLUSH PRIVILEGES; --reload the grant tables after granting some privileges

ALTER USER 'root'@'localhost' IDENTIFIED BY 'MARIADB_ROOT_PWD'; --configuring a default root password
FLUSH PRIVILEGES;


