// 关键字解释数据
const keywordExplanations = {
    "化学变化": {
        title: "化学变化",
        content: `
            <p>化学变化是指物质发生本质性的改变，生成新物质的过程。</p>
            <p><strong>特点：</strong></p>
            <ul>
                <li>生成新物质</li>
                <li>伴随能量变化（如放热、吸热）</li>
                <li>变化过程不可逆（通常）</li>
                <li>遵循质量守恒定律</li>
            </ul>
            <p><strong>常见例子：</strong>燃烧、生锈、发酵、酸碱中和等。</p>
        `
    },
    "物理变化": {
        title: "物理变化",
        content: `
            <p>物理变化是指物质的形态、状态发生改变，但没有生成新物质的过程。</p>
            <p><strong>特点：</strong></p>
            <ul>
                <li>不生成新物质</li>
                <li>通常伴随能量变化较小</li>
                <li>变化过程可逆（通常）</li>
                <li>物质的化学性质不变</li>
            </ul>
            <p><strong>常见例子：</strong>熔化、凝固、汽化、液化、升华等。</p>
        `
    },
    "纯净物": {
        title: "纯净物",
        content: `
            <p>纯净物是由一种物质组成的，具有固定的组成和性质。</p>
            <p><strong>分类：</strong></p>
            <ul>
                <li><strong>单质：</strong>由同种元素组成的纯净物，如氧气（O₂）、铁（Fe）等。</li>
                <li><strong>化合物：</strong>由不同种元素组成的纯净物，如水（H₂O）、二氧化碳（CO₂）等。</li>
            </ul>
            <p><strong>特点：</strong>有固定的熔点、沸点和密度等物理性质，以及特定的化学性质。</p>
        `
    },
    "混合物": {
        title: "混合物",
        content: `
            <p>混合物是由两种或两种以上的物质混合而成的，没有固定的组成和性质。</p>
            <p><strong>特点：</strong></p>
            <ul>
                <li>由多种物质组成</li>
                <li>没有固定的组成比例</li>
                <li>各成分保持原有性质</li>
                <li>可以通过物理方法分离</li>
            </ul>
            <p><strong>常见例子：</strong>空气、溶液、合金、土壤等。</p>
        `
    },
    "化合反应": {
        title: "化合反应",
        content: `
            <p>化合反应是指两种或两种以上的物质反应生成一种新物质的化学反应。</p>
            <p><strong>特点：</strong>A + B → AB</p>
            <p><strong>常见例子：</strong></p>
            <ul>
                <li>碳在氧气中燃烧：C + O₂ → CO₂</li>
                <li>铁在氧气中燃烧：3Fe + 2O₂ → Fe₃O₄</li>
                <li>氢气和氧气反应：2H₂ + O₂ → 2H₂O</li>
            </ul>
        `
    },
    "分解反应": {
        title: "分解反应",
        content: `
            <p>分解反应是指一种物质反应生成两种或两种以上新物质的化学反应。</p>
            <p><strong>特点：</strong>AB → A + B</p>
            <p><strong>常见例子：</strong></p>
            <ul>
                <li>水的电解：2H₂O → 2H₂↑ + O₂↑</li>
                <li>过氧化氢分解：2H₂O₂ → 2H₂O + O₂↑</li>
                <li>碳酸钙分解：CaCO₃ → CaO + CO₂↑</li>
            </ul>
        `
    },
    "置换反应": {
        title: "置换反应",
        content: `
            <p>置换反应是指一种单质和一种化合物反应生成另一种单质和另一种化合物的化学反应。</p>
            <p><strong>特点：</strong>A + BC → B + AC</p>
            <p><strong>常见例子：</strong></p>
            <ul>
                <li>锌和稀硫酸反应：Zn + H₂SO₄ → ZnSO₄ + H₂↑</li>
                <li>铁和硫酸铜反应：Fe + CuSO₄ → FeSO₄ + Cu</li>
                <li>氢气还原氧化铜：H₂ + CuO → Cu + H₂O</li>
            </ul>
        `
    },
    "食品添加剂": {
        title: "食品添加剂",
        content: `
            <p>食品添加剂是为改善食品品质和色、香、味，以及为防腐、保鲜和加工工艺的需要而加入食品中的人工合成或者天然物质。</p>
            <p><strong>分类：</strong></p>
            <ul>
                <li><strong>防腐剂：</strong>延长食品保质期，如苯甲酸钠、山梨酸钾等。</li>
                <li><strong>增味剂：</strong>增强食品风味，如味精（谷氨酸钠）等。</li>
                <li><strong>色素：</strong>改善食品色泽，如胭脂红、柠檬黄等。</li>
                <li><strong>抗氧化剂：</strong>防止食品氧化变质，如维生素C、维生素E等。</li>
            </ul>
            <p><strong>安全使用：</strong>按照国家标准规定的种类和用量使用，对人体无害。</p>
        `
    },
    "聚合反应": {
        title: "聚合反应",
        content: `
            <p>聚合反应是指由小分子单体通过化学键连接形成大分子聚合物的化学反应。</p>
            <p><strong>分类：</strong></p>
            <ul>
                <li><strong>加聚反应：</strong>单体通过加成反应形成聚合物，如乙烯聚合生成聚乙烯。</li>
                <li><strong>缩聚反应：</strong>单体通过缩合反应形成聚合物，同时生成小分子副产物，如乙二醇和对苯二甲酸缩聚生成涤纶。</li>
            </ul>
            <p><strong>应用：</strong>生产塑料、合成纤维、橡胶等高分子材料。</p>
        `
    },
    "表面活性剂": {
        title: "表面活性剂",
        content: `
            <p>表面活性剂是一类能够降低液体表面张力，使液体更容易湿润固体表面的物质。</p>
            <p><strong>结构特点：</strong>分子同时具有亲水基团和疏水基团。</p>
            <p><strong>分类：</strong></p>
            <ul>
                <li><strong>阴离子表面活性剂：</strong>如肥皂、洗衣粉等。</li>
                <li><strong>阳离子表面活性剂：</strong>如季铵盐等。</li>
                <li><strong>非离子表面活性剂：</strong>如聚氧乙烯醚等。</li>
            </ul>
            <p><strong>应用：</strong>洗涤剂、乳化剂、发泡剂等。</p>
        `
    },
    "甲醛": {
        title: "甲醛",
        content: `
            <p>甲醛（HCHO）是一种无色、有刺激性气味的有机化合物，易溶于水。</p>
            <p><strong>危害：</strong></p>
            <ul>
                <li>刺激眼睛、鼻子和喉咙</li>
                <li>引起过敏反应</li>
                <li>长期接触可能导致癌症</li>
                <li>对儿童、孕妇和老人危害更大</li>
            </ul>
            <p><strong>来源：</strong>装修材料（如胶合板、刨花板）、家具、涂料、胶粘剂等。</p>
            <p><strong>去除方法：</strong>通风换气、使用活性炭、种植绿色植物、光触媒技术等。</p>
        `
    },
    "燃烧反应": {
        title: "燃烧反应",
        content: `
            <p>燃烧反应是指物质与氧气发生的剧烈氧化反应，通常伴随发光、放热现象。</p>
            <p><strong>条件：</strong></p>
            <ul>
                <li>可燃物</li>
                <li>氧气（或其他助燃剂）</li>
                <li>达到着火点（温度）</li>
            </ul>
            <p><strong>特点：</strong>放热反应，通常生成二氧化碳和水（对于含碳、氢的可燃物）。</p>
            <p><strong>例子：</strong>甲烷燃烧：CH₄ + 2O₂ → CO₂ + 2H₂O + 能量</p>
        `
    },
    "pH缓冲": {
        title: "pH缓冲",
        content: `
            <p>pH缓冲是指溶液抵抗pH值变化的能力，由缓冲对组成。</p>
            <p><strong>血液中的pH缓冲：</strong></p>
            <ul>
                <li>主要缓冲对：碳酸氢盐缓冲对（H₂CO₃/NaHCO₃）</li>
                <li>作用：维持血液pH值在7.35-7.45之间</li>
                <li>机制：当血液中酸性物质增加时，碳酸氢根离子（HCO₃⁻）与氢离子（H⁺）结合；当碱性物质增加时，碳酸（H₂CO₃）分解产生氢离子。</li>
            </ul>
            <p><strong>重要性：</strong>人体各种生理活动都需要在适宜的pH环境中进行，pH值异常会导致疾病。</p>
        `
    },
    "电解质": {
        title: "电解质",
        content: `
            <p>电解质是在水溶液或熔融状态下能够导电的化合物。</p>
            <p><strong>分类：</strong></p>
            <ul>
                <li><strong>强电解质：</strong>在水溶液中完全电离，如强酸、强碱、大多数盐。</li>
                <li><strong>弱电解质：</strong>在水溶液中部分电离，如弱酸、弱碱。</li>
            </ul>
            <p><strong>人体中的电解质：</strong>钠（Na⁺）、钾（K⁺）、钙（Ca²⁺）、镁（Mg²⁺）、氯（Cl⁻）、碳酸氢根（HCO₃⁻）等。</p>
            <p><strong>功能：</strong>维持细胞内外渗透压平衡、调节酸碱平衡、参与神经传导和肌肉收缩等。</p>
        `
    },
    "绿色化学": {
        title: "绿色化学",
        content: `
            <p>绿色化学是一门致力于减少或消除有害物质的使用和产生的化学学科。</p>
            <p><strong>核心原则：</strong></p>
            <ul>
                <li>防止废物产生</li>
                <li>原子经济性（最大化原料利用率）</li>
                <li>设计安全的化学品和产品</li>
                <li>使用安全的溶剂和助剂</li>
                <li>降低能源消耗</li>
                <li>使用可再生原料</li>
                <li>减少衍生物的使用</li>
                <li>设计可降解的产品</li>
                <li>实时分析和污染预防</li>
                <li>安全的化学工艺</li>
            </ul>
            <p><strong>目标：</strong>从源头上减少环境污染，实现化学工业的可持续发展。</p>
        `
    }
};

// 页面初始化
document.addEventListener('DOMContentLoaded', function() {
    // 设置页面标题
    document.title = CONSTANTS.PAGE_TITLE;
    
    // 为关键字添加点击事件
    const keywords = document.querySelectorAll('.keyword');
    keywords.forEach(keyword => {
        keyword.addEventListener('click', function() {
            const keywordText = this.textContent;
            openKeywordModal(keywordText);
        });
    });
    
    // 关闭模态框
    const closeBtn = document.querySelector('.close');
    closeBtn.addEventListener('click', closeKeywordModal);
    
    // 点击模态框外部关闭
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('keywordModal');
        if (event.target == modal) {
            closeKeywordModal();
        }
    });
    
    console.log('页面初始化完成，使用常量定义:', CONSTANTS.PAGE_TITLE);
});

// 打开关键字解释模态框
function openKeywordModal(keyword) {
    const modal = document.getElementById('keywordModal');
    const modalTitle = document.getElementById('modalTitle');
    const modalBody = document.getElementById('modalBody');
    
    if (keywordExplanations[keyword]) {
        modalTitle.textContent = keywordExplanations[keyword].title;
        modalBody.innerHTML = keywordExplanations[keyword].content;
    } else {
        modalTitle.textContent = keyword;
        modalBody.innerHTML = '<p>暂无详细解释。</p>';
    }
    
    modal.style.display = 'block';
    document.body.classList.add('modal-open');
}

// 关闭关键字解释模态框
function closeKeywordModal() {
    const modal = document.getElementById('keywordModal');
    modal.style.display = 'none';
    document.body.classList.remove('modal-open');
}

// 豆包AI浮动框逻辑
document.addEventListener('DOMContentLoaded', function() {
    // 初始化变量
    let freeUsageCount = 3;
    const doubaoBtn = document.getElementById('doubaoBtn');
    const doubaoPanel = document.getElementById('doubaoPanel');
    const doubaoClose = document.getElementById('doubaoClose');
    const doubaoInput = document.getElementById('doubaoInput');
    const doubaoSend = document.getElementById('doubaoSend');
    const doubaoCount = document.getElementById('doubaoCount');
    const doubaoBody = document.getElementById('doubaoBody');
    const doubaoLogin = document.getElementById('doubaoLogin');
    const doubaoLoginBtn = document.getElementById('doubaoLoginBtn');
    
    // 切换豆包面板显示/隐藏
    doubaoBtn.addEventListener('click', function() {
        doubaoPanel.style.display = doubaoPanel.style.display === 'block' ? 'none' : 'block';
    });
    
    // 关闭豆包面板
    doubaoClose.addEventListener('click', function() {
        doubaoPanel.style.display = 'none';
    });
    
    // 点击面板外部关闭
    window.addEventListener('click', function(event) {
        if (!doubaoBtn.contains(event.target) && !doubaoPanel.contains(event.target)) {
            doubaoPanel.style.display = 'none';
        }
    });
    
    // 发送消息
    doubaoSend.addEventListener('click', function() {
        const message = doubaoInput.value.trim();
        if (message) {
            if (freeUsageCount > 0) {
                // 减少免费使用次数
                freeUsageCount--;
                doubaoCount.textContent = `免费使用次数：${freeUsageCount}/3`;
                
                // 显示发送的消息
                showMessage(message, 'user');
                
                // 模拟AI回复
                setTimeout(() => {
                    showMessage('这是豆包AI的回复，您的问题已收到。', 'ai');
                }, 1000);
                
                // 清空输入框
                doubaoInput.value = '';
                
                // 检查是否需要显示登录面板
                if (freeUsageCount === 0) {
                    setTimeout(() => {
                        showLoginPanel();
                    }, 2000);
                }
            } else {
                // 显示登录面板
                showLoginPanel();
            }
        }
    });
    
    // 回车键发送消息
    doubaoInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            doubaoSend.click();
        }
    });
    
    // 打开豆包APP
    doubaoLoginBtn.addEventListener('click', function() {
        // 这里可以添加打开豆包APP的逻辑
        alert('请使用豆包APP扫描二维码登录');
    });
    
    // 显示消息
    function showMessage(text, type) {
        const messageDiv = document.createElement('div');
        messageDiv.style.marginBottom = '10px';
        messageDiv.style.padding = '8px 12px';
        messageDiv.style.borderRadius = '8px';
        messageDiv.style.maxWidth = '80%';
        messageDiv.style.wordBreak = 'break-word';
        
        if (type === 'user') {
            messageDiv.style.backgroundColor = '#f0f0f0';
            messageDiv.style.alignSelf = 'flex-end';
            messageDiv.style.marginLeft = 'auto';
        } else {
            messageDiv.style.backgroundColor = '#e3f2fd';
            messageDiv.style.alignSelf = 'flex-start';
        }
        
        messageDiv.textContent = text;
        doubaoBody.appendChild(messageDiv);
        
        // 滚动到底部
        doubaoBody.scrollTop = doubaoBody.scrollHeight;
    }
    
    // 显示登录面板
    function showLoginPanel() {
        doubaoBody.style.display = 'none';
        document.querySelector('.doubao-footer').style.display = 'none';
        doubaoLogin.style.display = 'block';
    }
});

// 添加模态框结构
const modalHTML = `
    <div id="keywordModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3 class="modal-title" id="modalTitle"></h3>
            <div class="modal-body" id="modalBody"></div>
        </div>
    </div>
    
    <!-- 豆包AI浮动框 -->
    <div class="doubao-float">
        <button class="doubao-btn" id="doubaoBtn">
            <img src="https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=cute%20robot%20assistant%20icon%20blue%20white%20simple%20design&image_size=square" alt="豆包">
        </button>
        <div class="doubao-panel" id="doubaoPanel">
            <div class="doubao-header">
                <span>豆包AI助手</span>
                <span class="doubao-close" id="doubaoClose">&times;</span>
            </div>
            <div class="doubao-body" id="doubaoBody">
                <textarea class="doubao-input" id="doubaoInput" placeholder="请问有什么可以帮助您的？"></textarea>
            </div>
            <div class="doubao-footer">
                <span class="doubao-count" id="doubaoCount">免费使用次数：3/3</span>
                <button class="doubao-send" id="doubaoSend">发送</button>
            </div>
            <div class="doubao-login" id="doubaoLogin" style="display: none;">
                <h4>登录豆包</h4>
                <div class="doubao-qrcode">
                    <img src="https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=QR%20code%20for%20login%20blue%20background%20simple%20clean&image_size=square" alt="登录二维码">
                </div>
                <p>请使用豆包APP扫描二维码登录</p>
                <button class="doubao-login-btn" id="doubaoLoginBtn">打开豆包APP</button>
            </div>
        </div>
    </div>
`;

// 将模态框结构添加到页面末尾
document.body.insertAdjacentHTML('beforeend', modalHTML);

// 与后端API交互的函数
async function fetchElements() {
    try {
        const response = await fetch('/api/chemistry/elements');
        if (!response.ok) {
            throw new Error('Failed to fetch elements');
        }
        const elements = await response.json();
        console.log('Elements fetched:', elements);
        return elements;
    } catch (error) {
        console.error('Error fetching elements:', error);
        return [];
    }
}

// 获取元素详情
async function fetchElementById(id) {
    try {
        const response = await fetch(`/api/chemistry/elements/${id}`);
        if (!response.ok) {
            throw new Error('Failed to fetch element');
        }
        const element = await response.json();
        console.log('Element fetched:', element);
        return element;
    } catch (error) {
        console.error('Error fetching element:', error);
        return null;
    }
}

// 搜索元素
async function searchElement(query) {
    try {
        const response = await fetch(`/api/chemistry/elements/search?query=${encodeURIComponent(query)}`);
        if (!response.ok) {
            throw new Error('Failed to search elements');
        }
        const results = await response.json();
        console.log('Search results:', results);
        return results;
    } catch (error) {
        console.error('Error searching elements:', error);
        return [];
    }
}

// 在页面加载时获取元素数据
window.addEventListener('DOMContentLoaded', async function() {
    console.log('Page loaded, fetching elements...');
    const elements = await fetchElements();
    if (elements.length > 0) {
        console.log(`Fetched ${elements.length} elements from backend`);
        // 可以在这里更新页面内容，例如显示元素列表
    }
});

// 登录页面逻辑
if (window.location.pathname.includes('login')) {
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Login page loaded');
        
        // 密码显示/隐藏功能
        const togglePassword = document.querySelector('.toggle-password');
        if (togglePassword) {
            togglePassword.addEventListener('click', function() {
                const passwordInput = document.getElementById('password');
                const passwordIcon = this.querySelector('svg');
                
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    // 切换为眼睛关闭图标
                    passwordIcon.outerHTML = `
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash" viewBox="0 0 16 16">
                            <path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7.028 7.028 0 0 0-2.79.588l.77.771A5.944 5.944 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.134 13.134 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755-.165.165-.337.328-.517.486l.708.709z"/>
                            <path d="M11.297 9.176a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.829 2.829l.822.822zm-2.943 1.299.822.822a3.5 3.5 0 0 1-4.474-4.474l.823.823a2.5 2.5 0 0 0 2.829 2.829z"/>
                            <path d="M3.35 5.47c-.18.16-.353.322-.518.487A13.134 13.134 0 0 0 1.172 8l.195.288c.335.48.83 1.12 1.465 1.755C4.121 11.332 5.881 12.5 8 12.5c.716 0 1.39-.133 2.02-.36l.77.772A7.029 7.029 0 0 1 8 13.5C3 13.5 0 8 0 8s.939-1.721 2.641-3.238l.708.709zm10.296 8.884-12-12 .708-.708 12 12-.708.708z"/>
                        </svg>
                    `;
                } else {
                    passwordInput.type = 'password';
                    // 切换为眼睛图标
                    passwordIcon.outerHTML = `
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                            <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
                            <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
                        </svg>
                    `;
                }
            });
        }
        
        // 登录表单提交处理
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value.trim();
                
                // 简单表单验证
                if (!username || !password) {
                    alert('请输入用户名和密码');
                    return;
                }
                
                // 模拟登录请求
                console.log('Login attempt with username:', username);
                
                // 显示加载状态
                const loginBtn = document.querySelector('.login-btn');
                const originalText = loginBtn.textContent;
                loginBtn.textContent = '登录中...';
                loginBtn.disabled = true;
                
                // 模拟API请求延迟
                setTimeout(() => {
                    // 模拟登录成功
                    console.log('Login successful');
                    
                    // 恢复按钮状态
                    loginBtn.textContent = originalText;
                    loginBtn.disabled = false;
                    
                    // 跳转到首页
                    window.location.href = 'index.html';
                }, 1500);
            });
        }
        
        // 其他登录方式
        const socialBtns = document.querySelectorAll('.social-btn');
        socialBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const provider = this.textContent.trim();
                console.log(`Login with ${provider}`);
                alert(`请使用${provider}进行登录`);
            });
        });
        
        // 忘记密码链接
        const forgotPassword = document.querySelector('.forgot-password');
        if (forgotPassword) {
            forgotPassword.addEventListener('click', function(e) {
                e.preventDefault();
                alert('忘记密码功能正在开发中');
            });
        }
        
        // 注册链接
        const registerLink = document.querySelector('.register-link');
        if (registerLink) {
            registerLink.addEventListener('click', function(e) {
                e.preventDefault();
                alert('注册功能正在开发中');
            });
        }
    });
}