-- 元素表结构创建
CREATE TABLE IF NOT EXISTS element (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    atomic_number INT NOT NULL UNIQUE,
    symbol VARCHAR(10) NOT NULL,
    name VARCHAR(50) NOT NULL,
    atomic_mass DOUBLE NOT NULL,
    category VARCHAR(50) NOT NULL,
    period INT NOT NULL,
    `group` INT NOT NULL,
    is_natural BOOLEAN NOT NULL DEFAULT TRUE,
    electron_configuration VARCHAR(255),
    description TEXT,
    discovery_year INT,
    discoverer VARCHAR(100),
    melting_point DOUBLE,
    boiling_point DOUBLE,
    density DOUBLE,
    oxidation_states VARCHAR(255),
    common_states VARCHAR(255),
    chemical_value TEXT,
    commercial_value TEXT,
    applications TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建原子序数索引
CREATE INDEX idx_element_atomic_number ON element(atomic_number);

-- 创建周期和族索引
CREATE INDEX idx_element_period_group ON element(period, `group`);

-- 创建类别索引
CREATE INDEX idx_element_category ON element(category);
