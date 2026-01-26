// 机器人验证逻辑

class RobotVerification {
    constructor() {
        this.calcAnswer = null;
        this.puzzleSolution = null;
        this.init();
    }

    init() {
        // 初始化页面元素
        this.initElements();
        // 绑定事件
        this.bindEvents();
        // 初始化计算题
        this.generateCalcQuestion();
        // 初始化拼图
        this.generatePuzzle();
    }

    initElements() {
        // 验证方式选择
        this.calcVerifyRadio = document.getElementById('calcVerify');
        this.puzzleVerifyRadio = document.getElementById('puzzleVerify');
        
        // 验证区域
        this.calcVerification = document.getElementById('calcVerification');
        this.puzzleVerification = document.getElementById('puzzleVerification');
        
        // 计算题相关
        this.calcQuestion = document.getElementById('calcQuestion');
        this.calcAnswerInput = document.getElementById('calcAnswer');
        this.refreshCalcBtn = document.getElementById('refreshCalc');
        
        // 拼图相关
        this.puzzleBoard = document.getElementById('puzzleBoard');
        this.puzzlePieces = document.getElementById('puzzlePieces');
        this.refreshPuzzleBtn = document.getElementById('refreshPuzzle');
        
        // 按钮
        this.verifyBtn = document.getElementById('verifyBtn');
        this.cancelBtn = document.getElementById('cancelBtn');
        
        // 验证结果
        this.verificationResult = document.getElementById('verificationResult');
        this.resultAlert = this.verificationResult.querySelector('.alert');
    }

    bindEvents() {
        // 验证方式切换
        this.calcVerifyRadio.addEventListener('change', () => {
            this.showVerificationSection('calc');
        });

        this.puzzleVerifyRadio.addEventListener('change', () => {
            this.showVerificationSection('puzzle');
        });

        // 刷新计算题
        this.refreshCalcBtn.addEventListener('click', () => {
            this.generateCalcQuestion();
        });

        // 刷新拼图
        this.refreshPuzzleBtn.addEventListener('click', () => {
            this.generatePuzzle();
        });

        // 验证按钮
        this.verifyBtn.addEventListener('click', () => {
            this.verify();
        });

        // 取消按钮
        this.cancelBtn.addEventListener('click', () => {
            this.cancel();
        });
    }

    showVerificationSection(type) {
        if (type === 'calc') {
            this.calcVerification.classList.remove('d-none');
            this.puzzleVerification.classList.add('d-none');
        } else if (type === 'puzzle') {
            this.calcVerification.classList.add('d-none');
            this.puzzleVerification.classList.remove('d-none');
        }
        // 隐藏验证结果
        this.verificationResult.classList.add('d-none');
    }

    // 生成计算题
    generateCalcQuestion() {
        const num1 = Math.floor(Math.random() * 10) + 1;
        const num2 = Math.floor(Math.random() * 10) + 1;
        const operators = ['+', '-', '*'];
        const operator = operators[Math.floor(Math.random() * operators.length)];

        let question = '';
        switch (operator) {
            case '+':
                this.calcAnswer = num1 + num2;
                question = `${num1} + ${num2} = ?`;
                break;
            case '-':
                // 确保结果为正数
                if (num1 < num2) {
                    [num1, num2] = [num2, num1];
                }
                this.calcAnswer = num1 - num2;
                question = `${num1} - ${num2} = ?`;
                break;
            case '*':
                this.calcAnswer = num1 * num2;
                question = `${num1} × ${num2} = ?`;
                break;
        }

        this.calcQuestion.textContent = question;
        this.calcAnswerInput.value = '';
        this.verificationResult.classList.add('d-none');
    }

    // 生成拼图
    generatePuzzle() {
        // 清空拼图板和碎片区域
        this.puzzleBoard.innerHTML = '';
        this.puzzlePieces.innerHTML = '';

        // 生成1-8的数字数组
        const numbers = [1, 2, 3, 4, 5, 6, 7, 8];
        // 随机打乱数组
        this.shuffleArray(numbers);
        // 添加空位置
        numbers.push(null);

        this.puzzleSolution = [1, 2, 3, 4, 5, 6, 7, 8, null];

        // 创建拼图板
        numbers.forEach((num, index) => {
            const piece = document.createElement('div');
            piece.className = `puzzle-piece ${num === null ? 'empty' : ''}`;
            piece.dataset.index = index;
            if (num !== null) {
                piece.textContent = num;
                piece.dataset.value = num;
            }
            this.puzzleBoard.appendChild(piece);
        });

        // 创建拼图碎片
        const shuffledNumbers = [...numbers.filter(n => n !== null)];
        this.shuffleArray(shuffledNumbers);
        shuffledNumbers.forEach(num => {
            const piece = document.createElement('div');
            piece.className = 'puzzle-piece';
            piece.textContent = num;
            piece.dataset.value = num;
            piece.draggable = true;
            
            // 添加拖拽事件
            piece.addEventListener('dragstart', (e) => {
                e.dataTransfer.setData('text/plain', num);
            });
            
            this.puzzlePieces.appendChild(piece);
        });

        // 添加拼图板的放置事件
        this.puzzleBoard.addEventListener('dragover', (e) => {
            e.preventDefault();
        });

        this.puzzleBoard.addEventListener('drop', (e) => {
            e.preventDefault();
            const value = parseInt(e.dataTransfer.getData('text/plain'));
            const target = e.target;
            
            // 检查目标是否是空位置
            if (target.classList.contains('puzzle-piece') && target.classList.contains('empty')) {
                // 放置拼图碎片
                target.textContent = value;
                target.dataset.value = value;
                target.classList.remove('empty');
                
                // 从碎片区域移除该碎片
                const pieceToRemove = Array.from(this.puzzlePieces.children).find(p => p.dataset.value == value);
                if (pieceToRemove) {
                    this.puzzlePieces.removeChild(pieceToRemove);
                }
                
                // 检查拼图是否完成
                this.checkPuzzleCompletion();
            }
        });

        this.verificationResult.classList.add('d-none');
    }

    // 打乱数组
    shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
    }

    // 检查拼图是否完成
    checkPuzzleCompletion() {
        const pieces = Array.from(this.puzzleBoard.children);
        const currentState = pieces.map(piece => piece.dataset.value ? parseInt(piece.dataset.value) : null);
        
        // 检查是否与解决方案匹配
        return JSON.stringify(currentState) === JSON.stringify(this.puzzleSolution);
    }

    // 验证
    verify() {
        let isVerified = false;
        
        if (this.calcVerifyRadio.checked) {
            // 验证计算题
            const userAnswer = parseInt(this.calcAnswerInput.value);
            isVerified = !isNaN(userAnswer) && userAnswer === this.calcAnswer;
        } else if (this.puzzleVerifyRadio.checked) {
            // 验证拼图
            isVerified = this.checkPuzzleCompletion();
        }

        // 显示验证结果
        this.showVerificationResult(isVerified);

        // 触发验证完成事件
        if (isVerified) {
            this.onVerificationSuccess();
        }
    }

    // 显示验证结果
    showVerificationResult(isSuccess) {
        this.verificationResult.classList.remove('d-none');
        
        if (isSuccess) {
            this.resultAlert.className = 'alert alert-success';
            this.resultAlert.textContent = '验证成功！您不是机器人。';
        } else {
            this.resultAlert.className = 'alert alert-danger';
            this.resultAlert.textContent = '验证失败！请重试。';
        }
    }

    // 取消验证
    cancel() {
        // 可以添加取消逻辑，例如关闭弹窗等
        window.history.back();
    }

    // 验证成功回调
    onVerificationSuccess() {
        // 存储验证状态到本地存储
        localStorage.setItem('robotVerified', 'true');
        localStorage.setItem('robotVerifiedAt', Date.now().toString());
        
        // 检查URL参数，是否有回调URL
        const urlParams = new URLSearchParams(window.location.search);
        const callbackUrl = urlParams.get('callback');
        
        if (callbackUrl) {
            // 跳转到回调URL
            window.location.href = callbackUrl;
        } else {
            // 显示成功消息，3秒后自动关闭
            setTimeout(() => {
                window.close();
            }, 3000);
        }
    }

    // 生成计算题
    generateCalcQuestion() {
        this.generateCalcQuestion();
    }

    // 生成拼图
    generatePuzzle() {
        this.generatePuzzle();
    }
}

// 页面加载完成后初始化
window.addEventListener('DOMContentLoaded', () => {
    new RobotVerification();
});

// 暴露验证状态检查函数到全局
window.isRobotVerified = function() {
    const verified = localStorage.getItem('robotVerified');
    const verifiedAt = localStorage.getItem('robotVerifiedAt');
    
    if (!verified || !verifiedAt) {
        return false;
    }
    
    // 验证状态有效期为1小时
    const oneHour = 60 * 60 * 1000;
    const now = Date.now();
    const verifiedTime = parseInt(verifiedAt);
    
    return verified === 'true' && (now - verifiedTime) < oneHour;
};

// 暴露获取验证页面URL的函数
window.getRobotVerificationUrl = function(callbackUrl) {
    return `robot-verification.html${callbackUrl ? `?callback=${encodeURIComponent(callbackUrl)}` : ''}`;
};
