// AI助手前端交互逻辑

// 初始化页面
function initAIAssistant() {
    // 绑定事件监听器
    document.getElementById('sendButton').addEventListener('click', sendQuestion);
    document.getElementById('questionInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            sendQuestion();
        }
    });

    document.getElementById('analyzeButton').addEventListener('click', analyzeMolecule);
    document.getElementById('predictButton').addEventListener('click', predictReaction);

    console.log('AI Assistant initialized');
}

// 发送问题给AI助手
function sendQuestion() {
    const questionInput = document.getElementById('questionInput');
    const question = questionInput.value.trim();

    if (!question) {
        alert('请输入问题');
        return;
    }

    // 添加用户消息到聊天窗口
    addMessage(question, 'user');
    questionInput.value = '';

    // 显示AI正在输入的状态
    const typingIndicator = addTypingIndicator();

    // 调用AI服务API
    fetch('/api/ai/ask', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ question: question })
    })
    .then(response => response.json())
    .then(data => {
        // 移除输入状态指示
        typingIndicator.remove();

        if (data.success) {
            // 添加AI回答到聊天窗口
            addMessage(data.answer, 'ai');
        } else {
            // 显示错误信息
            addMessage('抱歉，我无法回答这个问题。请稍后再试。', 'ai');
        }
    })
    .catch(error => {
        // 移除输入状态指示
        typingIndicator.remove();

        // 显示错误信息
        addMessage('抱歉，服务暂时不可用。请稍后再试。', 'ai');
        console.error('Error sending question:', error);
    });
}

// 添加消息到聊天窗口
function addMessage(text, sender) {
    const chatContainer = document.getElementById('chatContainer');
    const messageDiv = document.createElement('div');
    messageDiv.className = `chat-message ${sender === 'user' ? 'user-message' : 'ai-message'}`;
    messageDiv.innerHTML = `<p>${text}</p>`;
    chatContainer.appendChild(messageDiv);
    
    // 滚动到底部
    chatContainer.scrollTop = chatContainer.scrollHeight;
}

// 添加AI正在输入的指示
function addTypingIndicator() {
    const chatContainer = document.getElementById('chatContainer');
    const typingDiv = document.createElement('div');
    typingDiv.className = 'chat-message ai-message';
    typingDiv.innerHTML = `
        <div class="typing-indicator">
            <span></span>
            <span></span>
            <span></span>
        </div>
    `;
    chatContainer.appendChild(typingDiv);
    
    // 滚动到底部
    chatContainer.scrollTop = chatContainer.scrollHeight;
    
    return typingDiv;
}

// 分析分子结构
function analyzeMolecule() {
    const moleculeInput = document.getElementById('moleculeInput');
    const molecule = moleculeInput.value.trim();
    const resultDiv = document.getElementById('moleculeResult');

    if (!molecule) {
        alert('请输入分子结构');
        return;
    }

    // 显示加载状态
    resultDiv.innerHTML = '<div class="typing-indicator"><span></span><span></span><span></span></div>';

    // 调用AI服务API
    fetch('/api/ai/analyze-molecule', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ molecule: molecule })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // 显示分析结果
            resultDiv.innerHTML = `<p>${data.analysis}</p>`;
        } else {
            // 显示错误信息
            resultDiv.innerHTML = `<p class="text-danger">${data.message || '分析失败，请重试'}</p>`;
        }
    })
    .catch(error => {
        // 显示错误信息
        resultDiv.innerHTML = '<p class="text-danger">服务暂时不可用，请稍后再试</p>';
        console.error('Error analyzing molecule:', error);
    });
}

// 预测化学反应
function predictReaction() {
    const reactionInput = document.getElementById('reactionInput');
    const reactants = reactionInput.value.trim();
    const resultDiv = document.getElementById('reactionResult');

    if (!reactants) {
        alert('请输入反应物');
        return;
    }

    // 显示加载状态
    resultDiv.innerHTML = '<div class="typing-indicator"><span></span><span></span><span></span></div>';

    // 调用AI服务API
    fetch('/api/ai/predict-reaction', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ reactants: reactants })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // 显示预测结果
            resultDiv.innerHTML = `<p>${data.prediction}</p>`;
        } else {
            // 显示错误信息
            resultDiv.innerHTML = `<p class="text-danger">${data.message || '预测失败，请重试'}</p>`;
        }
    })
    .catch(error => {
        // 显示错误信息
        resultDiv.innerHTML = '<p class="text-danger">服务暂时不可用，请稍后再试</p>';
        console.error('Error predicting reaction:', error);
    });
}

// 页面加载完成后初始化
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initAIAssistant);
} else {
    initAIAssistant();
}