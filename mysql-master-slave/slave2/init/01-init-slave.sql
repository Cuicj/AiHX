-- 初始化从库
-- 创建数据库
CREATE DATABASE IF NOT EXISTS chemistry_learning CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 配置主从复制
CHANGE MASTER TO
  MASTER_HOST = 'mysql-master',
  MASTER_USER = 'repl',
  MASTER_PASSWORD = 'repl_password',
  MASTER_PORT = 3306,
  MASTER_AUTO_POSITION = 1;

-- 启动复制
START SLAVE;

-- 查看复制状态
SHOW SLAVE STATUS\G;
