/**
 * 页面切换特效系统
 * 提供多种页面切换特效，如淡入淡出、滑动、缩放等
 */
class PageTransition {
    constructor() {
        this.effects = [
            'fade-in-out',
            'slide-left-right',
            'slide-right-left',
            'slide-top-bottom',
            'slide-bottom-top',
            'scale-in-out',
            'rotate-in-out',
            'circle-expand',
            'wave-effect'
        ];
        this.currentEffect = 'fade-in-out';
        this.transitionDuration = 500;
        this.init();
    }

    /**
     * 初始化页面切换特效系统
     */
    init() {
        // 为所有带有data-transition属性的链接添加点击事件
        document.addEventListener('DOMContentLoaded', () => {
            this.bindEvents();
            // 页面加载时添加进入动画
            this.addPageEnterAnimation();
        });
    }

    /**
     * 绑定事件
     */
    bindEvents() {
        // 为所有链接添加点击事件
        const links = document.querySelectorAll('a[href]');
        links.forEach(link => {
            // 只处理站内链接
            if (link.href.startsWith(window.location.origin) || link.href.startsWith('/')) {
                link.addEventListener('click', (e) => {
                    // 如果链接有data-transition属性，则使用指定的特效
                    const effect = link.getAttribute('data-transition') || this.currentEffect;
                    this.navigateTo(link.href, effect);
                    e.preventDefault();
                });
            }
        });

        // 为所有带有data-transition属性的按钮添加点击事件
        const buttons = document.querySelectorAll('button[data-href]');
        buttons.forEach(button => {
            button.addEventListener('click', () => {
                const href = button.getAttribute('data-href');
                const effect = button.getAttribute('data-transition') || this.currentEffect;
                if (href) {
                    this.navigateTo(href, effect);
                }
            });
        });
    }

    /**
     * 添加页面进入动画
     */
    addPageEnterAnimation() {
        document.body.classList.add('page-enter');
        setTimeout(() => {
            document.body.classList.remove('page-enter');
        }, 600);
    }

    /**
     * 导航到指定URL，应用页面切换特效
     * @param {string} url - 目标URL
     * @param {string} effect - 特效名称
     */
    navigateTo(url, effect = 'fade-in-out') {
        // 创建特效元素
        const transitionElement = this.createTransitionElement(effect);
        document.body.appendChild(transitionElement);

        // 触发特效
        setTimeout(() => {
            transitionElement.classList.add('active');
        }, 10);

        // 等待特效完成后跳转
        setTimeout(() => {
            window.location.href = url;
        }, this.transitionDuration);
    }

    /**
     * 创建特效元素
     * @param {string} effect - 特效名称
     * @returns {HTMLElement} 特效元素
     */
    createTransitionElement(effect) {
        const element = document.createElement('div');
        element.className = `page-transition ${effect}`;

        // 为网格效果创建网格单元格
        if (effect === 'grid-effect') {
            for (let i = 0; i < 25; i++) {
                const cell = document.createElement('div');
                cell.className = 'grid-cell';
                element.appendChild(cell);
            }
        }

        return element;
    }

    /**
     * 设置默认特效
     * @param {string} effect - 特效名称
     */
    setDefaultEffect(effect) {
        if (this.effects.includes(effect)) {
            this.currentEffect = effect;
        }
    }

    /**
     * 设置过渡持续时间
     * @param {number} duration - 持续时间（毫秒）
     */
    setTransitionDuration(duration) {
        this.transitionDuration = duration;
    }

    /**
     * 获取可用的特效列表
     * @returns {string[]} 特效列表
     */
    getAvailableEffects() {
        return this.effects;
    }

    /**
     * 随机选择一个特效
     * @returns {string} 特效名称
     */
    getRandomEffect() {
        const randomIndex = Math.floor(Math.random() * this.effects.length);
        return this.effects[randomIndex];
    }
}

// 创建全局实例
const pageTransition = new PageTransition();

// 扩展window对象，方便在全局使用
window.PageTransition = PageTransition;
window.pageTransition = pageTransition;

// 添加便捷方法
window.navigateTo = function(url, effect) {
    pageTransition.navigateTo(url, effect);
};

// 为常用的页面跳转函数添加特效支持
if (typeof window.location !== 'undefined') {
    const originalAssign = window.location.assign;
    window.location.assign = function(url) {
        pageTransition.navigateTo(url);
    };

    // 保留原始方法
    window.location.originalAssign = originalAssign;
}

/**
 * 页面跳转辅助函数
 * @param {string} url - 目标URL
 * @param {string} effect - 特效名称
 */
function goTo(url, effect) {
    pageTransition.navigateTo(url, effect);
}

/**
 * 刷新页面，应用特效
 * @param {string} effect - 特效名称
 */
function refreshPage(effect) {
    pageTransition.navigateTo(window.location.href, effect);
}
