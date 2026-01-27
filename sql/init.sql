-- 创建数据库
CREATE DATABASE IF NOT EXISTS chemistry_learning DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE chemistry_learning;

-- 元素表 (chemistry-service)
CREATE TABLE IF NOT EXISTS element (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    atomic_number INT NOT NULL UNIQUE,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL UNIQUE,
    atomic_mass DECIMAL(10,6) NOT NULL,
    period VARCHAR(10) NOT NULL,
    group_number VARCHAR(10),
    category VARCHAR(50),
    electron_configuration VARCHAR(255),
    electronegativity DECIMAL(3,2),
    atomic_radius DECIMAL(10,2),
    melting_point DECIMAL(10,2),
    boiling_point DECIMAL(10,2),
    density DECIMAL(10,6),
    discovered_year INT,
    discovered_by VARCHAR(255),
    is_natural BOOLEAN DEFAULT TRUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_atomic_number (atomic_number),
    INDEX idx_symbol (symbol),
    INDEX idx_name (name)
);

-- 用户表 (user-service)
CREATE TABLE IF NOT EXISTS user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) UNIQUE,
    role VARCHAR(20) DEFAULT 'USER',
    enabled BOOLEAN DEFAULT TRUE,
    points INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_phone (phone),
    INDEX idx_role (role)
);

-- 资源分类表 (积分兑换)
CREATE TABLE IF NOT EXISTS resource_category (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    status VARCHAR(20) DEFAULT 'ACTIVE', -- ACTIVE: 上架, INACTIVE: 下架
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_status (status)
);

-- 资源物品表 (积分兑换)
CREATE TABLE IF NOT EXISTS resource_item (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    points INT NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    status VARCHAR(20) DEFAULT 'ACTIVE', -- ACTIVE: 上架, INACTIVE: 下架
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES resource_category(id) ON DELETE CASCADE,
    INDEX idx_category_id (category_id),
    INDEX idx_name (name),
    INDEX idx_points (points),
    INDEX idx_stock (stock),
    INDEX idx_status (status)
);

-- 积分兑换记录表
CREATE TABLE IF NOT EXISTS points_exchange_record (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    resource_item_id BIGINT NOT NULL,
    exchange_points INT NOT NULL,
    exchange_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'SUCCESS', -- SUCCESS: 成功, FAILED: 失败
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (resource_item_id) REFERENCES resource_item(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_resource_item_id (resource_item_id),
    INDEX idx_exchange_time (exchange_time),
    INDEX idx_status (status)
);

-- 学习进度表 (learning-progress-service)
CREATE TABLE IF NOT EXISTS learning_progress (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    topic VARCHAR(100) NOT NULL,
    progress_percentage INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_topic (user_id, topic),
    INDEX idx_user_id (user_id),
    INDEX idx_topic (topic),
    INDEX idx_completed (completed)
);

-- 消息表 (用于RabbitMQ消息持久化)
CREATE TABLE IF NOT EXISTS message (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    message_id VARCHAR(100) NOT NULL UNIQUE,
    message_type VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    retry_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_message_id (message_id),
    INDEX idx_message_type (message_type),
    INDEX idx_status (status)
);

-- AI模型表 (用于AI服务)
CREATE TABLE IF NOT EXISTS ai_model (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL UNIQUE,
    model_type VARCHAR(50) NOT NULL,
    version VARCHAR(20) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_model_name (model_name),
    INDEX idx_model_type (model_type),
    INDEX idx_is_active (is_active)
);

-- AI训练数据表 (用于AI服务)
CREATE TABLE IF NOT EXISTS ai_training_data (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    model_id BIGINT NOT NULL,
    data_type VARCHAR(50) NOT NULL,
    data_content TEXT NOT NULL,
    label VARCHAR(100),
    accuracy DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (model_id) REFERENCES ai_model(id) ON DELETE CASCADE,
    INDEX idx_model_id (model_id),
    INDEX idx_data_type (data_type),
    INDEX idx_label (label)
);

-- 插入默认元素数据
INSERT INTO element (atomic_number, symbol, name, atomic_mass, period, group_number, category, electron_configuration, electronegativity, atomic_radius, melting_point, boiling_point, density, discovered_year, discovered_by, is_natural, description)
VALUES
(1, 'H', '氢', 1.008, '1', '1', 'nonmetal', '1s1', 2.20, 37.0, -259.16, -252.87, 0.08988, 1766, 'Henry Cavendish', TRUE, '氢是最轻的元素，也是宇宙中最丰富的元素，约占宇宙质量的75%。'),
(2, 'He', '氦', 4.0026, '1', '18', 'noble gas', '1s2', NULL, 32.0, -272.20, -268.93, 0.1785, 1868, 'Pierre Janssen, Norman Lockyer', TRUE, '氦是第二轻的元素，是一种无色无味的惰性气体，在地球上含量很少。'),
(3, 'Li', '锂', 6.94, '2', '1', 'alkali metal', '[He] 2s1', 0.98, 152.0, 180.54, 1342, 0.534, 1817, 'Johan August Arfwedson', TRUE, '锂是最轻的金属元素，在空气中迅速氧化，通常保存在煤油中。'),
(4, 'Be', '铍', 9.0122, '2', '2', 'alkaline earth metal', '[He] 2s2', 1.57, 112.0, 1287, 2469, 1.848, 1798, 'Louis Nicolas Vauquelin', TRUE, '铍是一种坚硬的灰色金属，有毒，用于航空航天和核工业。'),
(5, 'B', '硼', 10.81, '2', '13', 'metalloid', '[He] 2s2 2p1', 2.04, 87.0, 2076, 4000, 2.34, 1808, 'Joseph Louis Gay-Lussac, Louis Jacques Thénard', TRUE, '硼是一种半金属元素，硬度仅次于金刚石，用于制造硼砂和硼酸。'),
(6, 'C', '碳', 12.011, '2', '14', 'nonmetal', '[He] 2s2 2p2', 2.55, 67.0, 3550, 4027, 2.267, -3750, 'Ancient', TRUE, '碳是生命的基础元素，存在多种同素异形体，如金刚石、石墨和富勒烯。'),
(7, 'N', '氮', 14.007, '2', '15', 'nonmetal', '[He] 2s2 2p3', 3.04, 65.0, -210.00, -195.79, 1.2506, 1772, 'Daniel Rutherford', TRUE, '氮是空气中含量最多的元素，约占空气体积的78%，是蛋白质和核酸的重要组成部分。'),
(8, 'O', '氧', 15.999, '2', '16', 'nonmetal', '[He] 2s2 2p4', 3.44, 60.0, -218.79, -182.95, 1.429, 1774, 'Joseph Priestley, Carl Wilhelm Scheele', TRUE, '氧是地壳中含量最多的元素，也是生命呼吸所必需的元素。'),
(9, 'F', '氟', 18.998, '2', '17', 'halogen', '[He] 2s2 2p5', 3.98, 50.0, -219.67, -188.11, 1.696, 1886, 'Henri Moissan', TRUE, '氟是最活泼的非金属元素，也是最具电负性的元素。'),
(10, 'Ne', '氖', 20.180, '2', '18', 'noble gas', '[He] 2s2 2p6', NULL, 38.0, -248.59, -246.08, 0.9002, 1898, 'William Ramsay, Morris Travers', TRUE, '氖是一种惰性气体，用于制造霓虹灯，发出红色光。'),
(11, 'Na', '钠', 22.990, '3', '1', 'alkali metal', '[Ne] 3s1', 0.93, 186.0, 97.79, 882.94, 0.968, 1807, 'Humphry Davy', TRUE, '钠是一种活泼的金属元素，在空气中迅速氧化，与水剧烈反应。'),
(12, 'Mg', '镁', 24.305, '3', '2', 'alkaline earth metal', '[Ne] 3s2', 1.31, 160.0, 650, 1090, 1.738, 1755, 'Joseph Black', TRUE, '镁是一种轻质金属，是叶绿素的重要组成部分，也是人体必需的微量元素。'),
(13, 'Al', '铝', 26.982, '3', '13', 'metal', '[Ne] 3s2 3p1', 1.61, 143.0, 660.32, 2519, 2.698, 1825, 'Hans Christian Ørsted', TRUE, '铝是地壳中含量最多的金属元素，具有良好的导电性和导热性。'),
(14, 'Si', '硅', 28.085, '3', '14', 'metalloid', '[Ne] 3s2 3p2', 1.90, 111.0, 1414, 3265, 2.3296, 1824, 'Jöns Jacob Berzelius', TRUE, '硅是地壳中含量第二多的元素，是半导体工业的基础材料。'),
(15, 'P', '磷', 30.974, '3', '15', 'nonmetal', '[Ne] 3s2 3p3', 2.19, 98.0, 44.15, 280.5, 1.823, 1669, 'Hennig Brand', TRUE, '磷是生命必需的元素，是DNA和RNA的重要组成部分，也是ATP的组成部分。'),
(16, 'S', '硫', 32.06, '3', '16', 'nonmetal', '[Ne] 3s2 3p4', 2.58, 102.0, 115.21, 444.61, 2.067, -500, 'Ancient', TRUE, '硫是一种非金属元素，存在多种同素异形体，用于制造硫酸和橡胶。'),
(17, 'Cl', '氯', 35.45, '3', '17', 'halogen', '[Ne] 3s2 3p5', 3.16, 79.0, -101.5, -34.04, 3.214, 1774, 'Carl Wilhelm Scheele', TRUE, '氯是一种黄绿色有刺激性气味的气体，用于水的消毒和制造氯化物。'),
(18, 'Ar', '氩', 39.948, '3', '18', 'noble gas', '[Ne] 3s2 3p6', NULL, 71.0, -189.35, -185.85, 1.7837, 1894, 'Lord Rayleigh, William Ramsay', TRUE, '氩是空气中含量第三多的气体，是一种惰性气体，用于灯泡和焊接保护。'),
(19, 'K', '钾', 39.098, '4', '1', 'alkali metal', '[Ar] 4s1', 0.82, 227.0, 63.5, 759, 0.862, 1807, 'Humphry Davy', TRUE, '钾是一种活泼的金属元素，是人体必需的常量元素，在细胞内外维持渗透压平衡。'),
(20, 'Ca', '钙', 40.078, '4', '2', 'alkaline earth metal', '[Ar] 4s2', 1.00, 194.0, 842, 1484, 1.54, 1808, 'Humphry Davy', TRUE, '钙是人体中含量最多的矿物质，主要存在于骨骼和牙齿中。');

-- 插入默认用户数据
INSERT INTO user (username, password, email, phone, role, enabled)
VALUES
('admin', '$2a$10$2QZ6f6vK8X3G5F7b9H1i8e9R7t6Y5u4i3o2p1a0s9d8f7g6h5j4k3l2m1n0', 'admin@example.com', '13800138000', 'ADMIN', TRUE),
('user', '$2a$10$2QZ6f6vK8X3G5F7b9H1i8e9R7t6Y5u4i3o2p1a0s9d8f7g6h5j4k3l2m1n0', 'user@example.com', '13900139000', 'USER', TRUE);

-- 插入默认学习进度数据
INSERT INTO learning_progress (user_id, topic, progress_percentage, last_updated, completed)
VALUES
(1, '元素周期表', 100, CURRENT_TIMESTAMP, TRUE),
(1, '化学反应', 75, CURRENT_TIMESTAMP, FALSE),
(2, '元素周期表', 50, CURRENT_TIMESTAMP, FALSE),
(2, '化学键', 30, CURRENT_TIMESTAMP, FALSE);

-- 插入默认AI模型数据
INSERT INTO ai_model (model_name, model_type, version, description, is_active)
VALUES
('chemistry-qa', 'text-generation', '1.0', '化学知识问答模型', TRUE),
('molecule-analyzer', 'image-processing', '1.0', '分子结构分析模型', TRUE),
('reaction-predictor', 'predictive', '1.0', '化学反应预测模型', TRUE);

-- 插入默认AI训练数据
INSERT INTO ai_training_data (model_id, data_type, data_content, label, accuracy)
VALUES
(1, 'text', '什么是元素？', '化学元素是构成物质的基本单位', 98.5),
(1, 'text', '什么是化学反应？', '化学反应是物质发生变化形成新物质的过程', 97.8),
(2, 'image', 'H2O分子结构', '水分子', 99.2),
(2, 'image', 'CO2分子结构', '二氧化碳分子', 98.9),
(3, 'text', 'H2 + O2 ->', 'H2O', 96.5),
(3, 'text', 'NaOH + HCl ->', 'NaCl + H2O', 97.2);

-- 任务表 (task-management-service)
CREATE TABLE IF NOT EXISTS task (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'PENDING',
    priority VARCHAR(20) DEFAULT 'MEDIUM',
    assignee_id BIGINT,
    creator_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    due_date TIMESTAMP,
    FOREIGN KEY (assignee_id) REFERENCES user(id) ON DELETE SET NULL,
    FOREIGN KEY (creator_id) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_priority (priority),
    INDEX idx_assignee_id (assignee_id),
    INDEX idx_creator_id (creator_id),
    INDEX idx_due_date (due_date)
);

-- 插入默认任务数据
INSERT INTO task (title, description, status, priority, assignee_id, creator_id, due_date)
VALUES
('更新元素周期表数据', '添加最新发现的元素数据', 'PENDING', 'HIGH', 1, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 7 DAY)),
('开发化学反应预测功能', '实现基于AI的化学反应预测', 'IN_PROGRESS', 'HIGH', 2, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 14 DAY)),
('优化前端UI界面', '改进元素详情页的用户体验', 'PENDING', 'MEDIUM', 1, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 7 DAY)),
('编写API文档', '为所有微服务编写详细的API文档', 'PENDING', 'LOW', 2, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 21 DAY));

-- 查看所有表
SHOW TABLES;

-- 查看各表数据量
SELECT 'element' AS table_name, COUNT(*) AS row_count FROM element UNION
SELECT 'user' AS table_name, COUNT(*) AS row_count FROM user UNION
SELECT 'learning_progress' AS table_name, COUNT(*) AS row_count FROM learning_progress UNION
SELECT 'message' AS table_name, COUNT(*) AS row_count FROM message UNION
SELECT 'ai_model' AS table_name, COUNT(*) AS row_count FROM ai_model UNION
SELECT 'ai_training_data' AS table_name, COUNT(*) AS row_count FROM ai_training_data UNION
SELECT 'task' AS table_name, COUNT(*) AS row_count FROM task;

-- 库存表 (inventory-service)
CREATE TABLE IF NOT EXISTS inventory (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    item_id BIGINT NOT NULL UNIQUE,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    min_stock INT DEFAULT 10,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_item_id (item_id),
    INDEX idx_status (status),
    INDEX idx_quantity (quantity)
);

-- 积分兑换表 (exchange-service)
CREATE TABLE IF NOT EXISTS exchange_record (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    item_id BIGINT NOT NULL,
    points INT NOT NULL,
    quantity INT DEFAULT 1,
    status VARCHAR(20) DEFAULT 'PENDING',
    transaction_id VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_transaction_id (transaction_id)
);

-- 区块链交易表 (blockchain-service)
CREATE TABLE IF NOT EXISTS blockchain_transaction (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tx_hash VARCHAR(100) UNIQUE,
    from_address VARCHAR(100) NOT NULL,
    to_address VARCHAR(100) NOT NULL,
    network VARCHAR(50) NOT NULL,
    chain_type VARCHAR(50) NOT NULL,
    amount DECIMAL(30,18) NOT NULL,
    gas_price DECIMAL(30,18),
    gas_used BIGINT,
    status VARCHAR(20) DEFAULT 'PENDING',
    transaction_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_tx_hash (tx_hash),
    INDEX idx_network (network),
    INDEX idx_status (status),
    INDEX idx_from_address (from_address),
    INDEX idx_to_address (to_address)
);

-- 区块链网络表 (blockchain-service)
CREATE TABLE IF NOT EXISTS blockchain_network (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    network_name VARCHAR(50) NOT NULL UNIQUE,
    chain_type VARCHAR(50) NOT NULL,
    rpc_url VARCHAR(255) NOT NULL,
    chain_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    gas_price DECIMAL(30,18),
    block_time INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_network_name (network_name),
    INDEX idx_chain_type (chain_type),
    INDEX idx_is_active (is_active)
);

-- 插入默认库存数据
INSERT INTO inventory (item_id, item_name, quantity, min_stock, status)
VALUES
(1, '化学实验套装', 100, 10, 'ACTIVE'),
(2, '元素周期表海报', 200, 20, 'ACTIVE'),
(3, '分子模型套件', 50, 5, 'ACTIVE'),
(4, '化学教科书', 150, 15, 'ACTIVE'),
(5, '实验安全护具', 80, 8, 'ACTIVE');

-- 插入默认区块链网络数据
INSERT INTO blockchain_network (network_name, chain_type, rpc_url, chain_id, is_active, gas_price, block_time)
VALUES
('ethereum', 'mainnet', 'https://mainnet.infura.io/v3/YOUR_INFURA_KEY', 1, TRUE, 30, 15),
('ethereum', 'testnet', 'https://sepolia.infura.io/v3/YOUR_INFURA_KEY', 11155111, TRUE, 10, 15),
('bsc', 'mainnet', 'https://bsc-dataseed.binance.org/', 56, TRUE, 5, 3),
('bsc', 'testnet', 'https://data-seed-prebsc-1-s1.binance.org:8545/', 97, TRUE, 1, 3),
('polygon', 'mainnet', 'https://polygon-rpc.com', 137, TRUE, 30, 2),
('polygon', 'testnet', 'https://rpc-mumbai.maticvigil.com', 80001, TRUE, 10, 2),
('okc', 'mainnet', 'https://exchainrpc.okex.org', 66, TRUE, 1, 2),
('okc', 'testnet', 'https://exchaintestrpc.okex.org', 65, TRUE, 0.1, 2);

-- 查看所有表
SHOW TABLES;

-- 签到记录表 (user-service)
CREATE TABLE IF NOT EXISTS checkin_record (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    device_id VARCHAR(100) NOT NULL,
    points INT DEFAULT 10,
    checkin_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_device_date (user_id, device_id, checkin_date),
    INDEX idx_user_id (user_id),
    INDEX idx_device_id (device_id),
    INDEX idx_checkin_date (checkin_date)
);

-- 查看各表数据量
SELECT 'element' AS table_name, COUNT(*) AS row_count FROM element UNION
SELECT 'user' AS table_name, COUNT(*) AS row_count FROM user UNION
SELECT 'resource_category' AS table_name, COUNT(*) AS row_count FROM resource_category UNION
SELECT 'resource_item' AS table_name, COUNT(*) AS row_count FROM resource_item UNION
SELECT 'points_exchange_record' AS table_name, COUNT(*) AS row_count FROM points_exchange_record UNION
SELECT 'learning_progress' AS table_name, COUNT(*) AS row_count FROM learning_progress UNION
SELECT 'message' AS table_name, COUNT(*) AS row_count FROM message UNION
SELECT 'ai_model' AS table_name, COUNT(*) AS row_count FROM ai_model UNION
SELECT 'ai_training_data' AS table_name, COUNT(*) AS row_count FROM ai_training_data UNION
SELECT 'task' AS table_name, COUNT(*) AS row_count FROM task UNION
SELECT 'inventory' AS table_name, COUNT(*) AS row_count FROM inventory UNION
SELECT 'exchange_record' AS table_name, COUNT(*) AS row_count FROM exchange_record UNION
SELECT 'blockchain_transaction' AS table_name, COUNT(*) AS row_count FROM blockchain_transaction UNION
SELECT 'blockchain_network' AS table_name, COUNT(*) AS row_count FROM blockchain_network UNION
SELECT 'checkin_record' AS table_name, COUNT(*) AS row_count FROM checkin_record;
