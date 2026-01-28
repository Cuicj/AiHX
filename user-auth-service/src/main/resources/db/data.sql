-- 插入默认用户数据
INSERT INTO users (username, password, email, phone, role, status)
VALUES
    ('admin', '$2a$10$1qAz2wSx3eDc4rFv5tGb5e1qAz2wSx3eDc4rFv5tGb5e1qAz2wSx3eDc4rFv', 'admin@example.com', '13800138000', 'ADMIN', 'ACTIVE');

INSERT INTO users (username, password, email, phone, role, status)
VALUES
    ('user1', '$2a$10$1qAz2wSx3eDc4rFv5tGb5e1qAz2wSx3eDc4rFv5tGb5e1qAz2wSx3eDc4rFv', 'user1@example.com', '13900139000', 'USER', 'ACTIVE');