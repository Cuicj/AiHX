-- 初始化主库
-- 创建复制用户
CREATE USER 'repl'@'%' IDENTIFIED BY 'repl_password';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
FLUSH PRIVILEGES;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS chemistry_learning CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 切换到chemistry_learning数据库
USE chemistry_learning;

-- 创建表结构

-- 用户表
CREATE TABLE IF NOT EXISTS user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    avatar VARCHAR(255),
    points INT DEFAULT 0,
    level INT DEFAULT 1,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 签到记录表
CREATE TABLE IF NOT EXISTS checkin_record (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    device_id VARCHAR(255) NOT NULL,
    ip_address VARCHAR(50) NOT NULL,
    checkin_date DATE NOT NULL,
    consecutive_days INT DEFAULT 1,
    points_earned INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'SUCCESS',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user_date (user_id, checkin_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 资源分类表
CREATE TABLE IF NOT EXISTS resource_category (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 资源物品表
CREATE TABLE IF NOT EXISTS resource_item (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category_id BIGINT NOT NULL,
    points INT NOT NULL,
    stock INT NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 化学元素表
CREATE TABLE IF NOT EXISTS element (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    atomic_number INT NOT NULL UNIQUE,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL UNIQUE,
    atomic_mass DOUBLE NOT NULL,
    period INT NOT NULL,
    `group` INT NOT NULL,
    category VARCHAR(50),
    electron_configuration VARCHAR(255),
    electronegativity DOUBLE,
    atomic_radius DOUBLE,
    melting_point DOUBLE,
    boiling_point DOUBLE,
    density DOUBLE,
    description TEXT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 题库表
CREATE TABLE IF NOT EXISTS question_bank (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT,
    option_d TEXT,
    correct_answer VARCHAR(10) NOT NULL,
    explanation TEXT,
    difficulty VARCHAR(20) NOT NULL,
    category VARCHAR(50) NOT NULL,
    tags VARCHAR(255),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 答题记录表
CREATE TABLE IF NOT EXISTS quiz_record (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    device_id VARCHAR(255) NOT NULL,
    quiz_date DATETIME NOT NULL,
    total_questions INT NOT NULL,
    correct_count INT NOT NULL,
    score INT NOT NULL,
    time_spent INT NOT NULL,
    status VARCHAR(20) DEFAULT 'COMPLETED',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 答题详情表
CREATE TABLE IF NOT EXISTS quiz_detail (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    quiz_record_id BIGINT NOT NULL,
    question_id BIGINT NOT NULL,
    user_answer VARCHAR(10) NOT NULL,
    is_correct BOOLEAN NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 用户错题表
CREATE TABLE IF NOT EXISTS user_mistake (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    question_id BIGINT NOT NULL,
    collect_date DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user_question (user_id, question_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 学习进度表
CREATE TABLE IF NOT EXISTS learning_progress (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    resource_id BIGINT NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    progress_percent DOUBLE DEFAULT 0,
    completed BOOLEAN DEFAULT FALSE,
    status VARCHAR(20) DEFAULT 'IN_PROGRESS',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 任务表
CREATE TABLE IF NOT EXISTS task (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    task_type VARCHAR(50) NOT NULL,
    task_name VARCHAR(100) NOT NULL,
    task_description TEXT,
    target_count INT NOT NULL,
    current_count INT DEFAULT 0,
    points_reward INT NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 兑换记录表
CREATE TABLE IF NOT EXISTS exchange_record (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    item_id BIGINT NOT NULL,
    item_name VARCHAR(255) NOT NULL,
    points_cost INT NOT NULL,
    exchange_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'SUCCESS',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 库存表
CREATE TABLE IF NOT EXISTS inventory (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    item_id BIGINT NOT NULL UNIQUE,
    item_name VARCHAR(255) NOT NULL,
    current_stock INT NOT NULL,
    min_stock INT DEFAULT 10,
    last_update DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 插入初始化数据

-- 插入用户数据
INSERT INTO user (username, password, nickname, email, phone, points, level) VALUES
('admin', 'admin123', '管理员', 'admin@example.com', '13800138000', 1000, 10),
('user1', 'user123', '用户1', 'user1@example.com', '13800138001', 500, 5),
('user2', 'user123', '用户2', 'user2@example.com', '13800138002', 300, 3);

-- 插入资源分类数据
INSERT INTO resource_category (name, description) VALUES
('化学元素', '化学元素相关资源'),
('化学反应', '化学反应相关资源'),
('化学实验', '化学实验相关资源'),
('化学题库', '化学题库相关资源');

-- 插入资源物品数据
INSERT INTO resource_item (name, description, category_id, points, stock) VALUES
('元素周期表', '完整的元素周期表', 1, 100, 100),
('化学反应手册', '常见化学反应方程式', 2, 150, 80),
('化学实验视频', '基础化学实验视频教程', 3, 200, 50),
('化学题库VIP', '高级化学题库权限', 4, 300, 30);

-- 插入化学元素数据
INSERT INTO element (atomic_number, symbol, name, atomic_mass, period, `group`, category) VALUES
(1, 'H', '氢', 1.008, 1, 1, '非金属'),
(2, 'He', '氦', 4.0026, 1, 18, '稀有气体'),
(3, 'Li', '锂', 6.94, 2, 1, '碱金属'),
(4, 'Be', '铍', 9.0122, 2, 2, '碱土金属'),
(5, 'B', '硼', 10.81, 2, 13, '类金属');

-- 插入题库数据
INSERT INTO question_bank (question, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty, category) VALUES
('下列元素中，原子序数最大的是？', '氢', '氦', '锂', '铍', 'D', '铍的原子序数是4，是选项中最大的', 'EASY', '原子结构'),
('下列哪种元素属于稀有气体？', '氢', '氦', '锂', '铍', 'B', '氦属于稀有气体，化学性质稳定', 'EASY', '元素分类'),
('原子序数为1的元素是？', '氢', '氦', '锂', '铍', 'A', '氢的原子序数是1', 'EASY', '原子结构'),
('下列元素中，属于碱金属的是？', '氢', '氦', '锂', '铍', 'C', '锂属于碱金属，位于元素周期表第1族', 'EASY', '元素分类'),
('铍的原子序数是？', '1', '2', '3', '4', 'D', '铍的原子序数是4', 'EASY', '原子结构');

-- 查看主库状态
SHOW MASTER STATUS;
