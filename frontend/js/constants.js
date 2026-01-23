// 化学学习项目常量定义
const CONSTANTS = {
    // 页面标题和描述
    PAGE_TITLE: "化学：从生活日常到宇宙星辰的认知进阶",
    PAGE_DESCRIPTION: "以\"化学是研究物质及其变化规律的科学\"为核心，遵循\"认知从浅到深、场景从近到远、尺度从大到小\"的逻辑，构建完整的化学认知体系，从生活现象到宇宙奥秘，探索物质世界的本质规律。",
    
    // 导航链接
    NAV_LINKS: {
        HOME: "#",
        EXPLORE: "#explore",
        ELEMENTS: "/api/chemistry/elements",
        USERS: "/api/user/users",
        PROGRESS: "/api/progress/progresses"
    },
    
    // 第一部分：初级化学认知
    BASIC_CHEMISTRY: {
        TITLE: "第一部分：初级化学认知——推开物质世界的大门",
        SUBTITLE: "基础层 · 建立化学思维的基础框架",
        SECTIONS: {
            SUBSTANCE_CHANGE: {
                TITLE: "物质\"变身\"科学",
                DESCRIPTION: "研究物质的变化规律",
                POINTS: [
                    "化学变化生成新物质，区别于物理变化",
                    "核心三问：物质构成？如何变化？伴随什么？",
                    "实用价值：解释\"饭煮熟\"\"铁生锈\"等日常现象"
                ],
                IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=chemical%20reaction%20experiment%20colorful%20science%20education&image_size=landscape_4_3"
            },
            SUBSTANCE_CLASSIFICATION: {
                TITLE: "物质分类",
                DESCRIPTION: "物质的分类方法",
                POINTS: [
                    "纯净物（单质、化合物）与混合物",
                    "常见元素：O、C、H、Fe、Ca等生活高频元素",
                    "基本反应：化合、分解、置换反应类型",
                    "变化特征：发光、发热、颜色变化、气体生成"
                ],
                IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=periodic%20table%20of%20elements%20colorful%20chemistry%20education&image_size=landscape_4_3"
            },
            SIMPLE_EXPERIMENTS: {
                TITLE: "简单实验",
                DESCRIPTION: "基础化学实验",
                POINTS: [
                    "蜡烛燃烧、铁生锈、醋泡鸡蛋壳",
                    "基础工具：天平、量筒、pH试纸的使用",
                    "化学语言：元素符号、化学式、方程式"
                ],
                IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=chemistry%20laboratory%20equipment%20beakers%20test%20tubes%20science&image_size=landscape_4_3"
            }
        }
    },
    
    // 第二部分：生活中的化学
    DAILY_CHEMISTRY: {
        TITLE: "第二部分：生活中的化学——化学与日常的深度绑定",
        SUBTITLE: "应用层 · 化学知识在日常生活中的具体应用",
        SECTIONS: {
            DAILY_LIFE: {
                TITLE: "衣食住行中的化学",
                CATEGORIES: {
                    FOOD: {
                        TITLE: "食",
                        POINTS: [
                            "食物消化：淀粉→葡萄糖，蛋白质氧化供能",
                            "食品添加剂：防腐剂、增味剂、色素",
                            "烹饪化学：加醋去腥、面团发酵"
                        ],
                        IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=food%20chemistry%20cooking%20nutrition%20science&image_size=landscape_4_3"
                    },
                    CLOTHING: {
                        TITLE: "衣",
                        POINTS: [
                            "纤维分类：天然纤维vs合成纤维",
                            "聚合反应：涤纶、尼龙的形成",
                            "洗涤原理：表面活性剂、漂白剂"
                        ],
                        IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=textile%20chemistry%20fabric%20synthetic%20fibers%20clothing&image_size=landscape_4_3"
                    },
                    HOUSING: {
                        TITLE: "住",
                        POINTS: [
                            "建筑材料：水泥水化、玻璃熔融",
                            "室内环境：甲醛危害、活性炭吸附",
                            "涂料防腐：化学防护原理"
                        ],
                        IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=building%20materials%20chemistry%20construction%20cement%20glass&image_size=landscape_4_3"
                    },
                    TRANSPORTATION: {
                        TITLE: "行",
                        POINTS: [
                            "能源化学：燃烧反应与能量转化",
                            "电池原理：充放电化学机制",
                            "金属防护：涂层、电镀技术"
                        ],
                        IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=energy%20chemistry%20batteries%20fuel%20cells%20transportation&image_size=landscape_4_3"
                    }
                }
            },
            HEALTH: {
                TITLE: "健康与医药中的化学",
                POINTS: [
                    "人体化学平衡：血液pH缓冲、电解质功能",
                    "药物化学：阿司匹林合成、中药成分提取",
                    "消毒防疫：酒精、84消毒液原理"
                ],
                IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=medical%20chemistry%20pharmaceuticals%20human%20body%20health&image_size=landscape_16_9"
            },
            ENVIRONMENT: {
                TITLE: "环境与能源中的化学",
                POINTS: [
                    "环境问题：酸雨、温室效应、白色污染",
                    "能源转型：化石燃料、可再生能源、氢能",
                    "绿色化学：原子经济性、清洁生产"
                ],
                IMAGE_URL: "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=environmental%20chemistry%20green%20energy%20sustainability%20pollution&image_size=landscape_16_9"
            }
        }
    },
    
    // 服务接口
    API_ENDPOINTS: {
        CHEMISTRY: {
            ELEMENTS: "/api/chemistry/elements"
        },
        USER: {
            USERS: "/api/user/users"
        },
        PROGRESS: {
            PROGRESSES: "/api/progress/progresses"
        }
    },
    
    // 系统服务
    SYSTEM_SERVICES: {
        EUREKA_SERVER: "http://localhost:8761",
        API_GATEWAY: "http://localhost:8080",
        CHEMISTRY_SERVICE: "http://localhost:8081",
        USER_SERVICE: "http://localhost:8082",
        LEARNING_PROGRESS_SERVICE: "http://localhost:8085"
    },
    
    // 颜色主题
    COLORS: {
        PRIMARY: "#667eea",
        SECONDARY: "#764ba2",
        BACKGROUND: "#f8f9fa",
        TEXT: "#333333",
        TEXT_LIGHT: "#4a5568",
        TEXT_DARK: "#2d3748"
    },
    
    // 动画配置
    ANIMATION: {
        DURATION: "0.8s",
        DELAY_STEP: "0.2s"
    }
};

// 导出常量（如果在模块化环境中使用）
if (typeof module !== 'undefined' && module.exports) {
    module.exports = CONSTANTS;
}
