// 元素周期表数据
const periodicTableData = [
    // 第1周期
    { atomicNumber: 1, symbol: "H", name: "氢", atomicMass: 1.008, category: "nonmetal", period: 1, group: 1 },
    { atomicNumber: 2, symbol: "He", name: "氦", atomicMass: 4.0026, category: "noble-gas", period: 1, group: 18 },
    
    // 第2周期
    { atomicNumber: 3, symbol: "Li", name: "锂", atomicMass: 6.94, category: "alkali-metal", period: 2, group: 1 },
    { atomicNumber: 4, symbol: "Be", name: "铍", atomicMass: 9.0122, category: "alkaline-earth-metal", period: 2, group: 2 },
    { atomicNumber: 5, symbol: "B", name: "硼", atomicMass: 10.81, category: "metalloid", period: 2, group: 13 },
    { atomicNumber: 6, symbol: "C", name: "碳", atomicMass: 12.011, category: "nonmetal", period: 2, group: 14 },
    { atomicNumber: 7, symbol: "N", name: "氮", atomicMass: 14.007, category: "nonmetal", period: 2, group: 15 },
    { atomicNumber: 8, symbol: "O", name: "氧", atomicMass: 15.999, category: "nonmetal", period: 2, group: 16 },
    { atomicNumber: 9, symbol: "F", name: "氟", atomicMass: 18.998, category: "halogen", period: 2, group: 17 },
    { atomicNumber: 10, symbol: "Ne", name: "氖", atomicMass: 20.180, category: "noble-gas", period: 2, group: 18 },
    
    // 第3周期
    { atomicNumber: 11, symbol: "Na", name: "钠", atomicMass: 22.990, category: "alkali-metal", period: 3, group: 1 },
    { atomicNumber: 12, symbol: "Mg", name: "镁", atomicMass: 24.305, category: "alkaline-earth-metal", period: 3, group: 2 },
    { atomicNumber: 13, symbol: "Al", name: "铝", atomicMass: 26.982, category: "post-transition-metal", period: 3, group: 13 },
    { atomicNumber: 14, symbol: "Si", name: "硅", atomicMass: 28.085, category: "metalloid", period: 3, group: 14 },
    { atomicNumber: 15, symbol: "P", name: "磷", atomicMass: 30.974, category: "nonmetal", period: 3, group: 15 },
    { atomicNumber: 16, symbol: "S", name: "硫", atomicMass: 32.06, category: "nonmetal", period: 3, group: 16 },
    { atomicNumber: 17, symbol: "Cl", name: "氯", atomicMass: 35.45, category: "halogen", period: 3, group: 17 },
    { atomicNumber: 18, symbol: "Ar", name: "氩", atomicMass: 39.948, category: "noble-gas", period: 3, group: 18 },
    
    // 第4周期
    { atomicNumber: 19, symbol: "K", name: "钾", atomicMass: 39.098, category: "alkali-metal", period: 4, group: 1 },
    { atomicNumber: 20, symbol: "Ca", name: "钙", atomicMass: 40.078, category: "alkaline-earth-metal", period: 4, group: 2 },
    { atomicNumber: 21, symbol: "Sc", name: "钪", atomicMass: 44.956, category: "transition-metal", period: 4, group: 3 },
    { atomicNumber: 22, symbol: "Ti", name: "钛", atomicMass: 47.867, category: "transition-metal", period: 4, group: 4 },
    { atomicNumber: 23, symbol: "V", name: "钒", atomicMass: 50.942, category: "transition-metal", period: 4, group: 5 },
    { atomicNumber: 24, symbol: "Cr", name: "铬", atomicMass: 51.996, category: "transition-metal", period: 4, group: 6 },
    { atomicNumber: 25, symbol: "Mn", name: "锰", atomicMass: 54.938, category: "transition-metal", period: 4, group: 7 },
    { atomicNumber: 26, symbol: "Fe", name: "铁", atomicMass: 55.845, category: "transition-metal", period: 4, group: 8 },
    { atomicNumber: 27, symbol: "Co", name: "钴", atomicMass: 58.933, category: "transition-metal", period: 4, group: 9 },
    { atomicNumber: 28, symbol: "Ni", name: "镍", atomicMass: 58.693, category: "transition-metal", period: 4, group: 10 },
    { atomicNumber: 29, symbol: "Cu", name: "铜", atomicMass: 63.546, category: "transition-metal", period: 4, group: 11 },
    { atomicNumber: 30, symbol: "Zn", name: "锌", atomicMass: 65.38, category: "transition-metal", period: 4, group: 12 },
    { atomicNumber: 31, symbol: "Ga", name: "镓", atomicMass: 69.723, category: "post-transition-metal", period: 4, group: 13 },
    { atomicNumber: 32, symbol: "Ge", name: "锗", atomicMass: 72.630, category: "metalloid", period: 4, group: 14 },
    { atomicNumber: 33, symbol: "As", name: "砷", atomicMass: 74.922, category: "metalloid", period: 4, group: 15 },
    { atomicNumber: 34, symbol: "Se", name: "硒", atomicMass: 78.971, category: "nonmetal", period: 4, group: 16 },
    { atomicNumber: 35, symbol: "Br", name: "溴", atomicMass: 79.904, category: "halogen", period: 4, group: 17 },
    { atomicNumber: 36, symbol: "Kr", name: "氪", atomicMass: 83.798, category: "noble-gas", period: 4, group: 18 },
    
    // 第5周期
    { atomicNumber: 37, symbol: "Rb", name: "铷", atomicMass: 85.468, category: "alkali-metal", period: 5, group: 1 },
    { atomicNumber: 38, symbol: "Sr", name: "锶", atomicMass: 87.62, category: "alkaline-earth-metal", period: 5, group: 2 },
    { atomicNumber: 39, symbol: "Y", name: "钇", atomicMass: 88.906, category: "transition-metal", period: 5, group: 3 },
    { atomicNumber: 40, symbol: "Zr", name: "锆", atomicMass: 91.224, category: "transition-metal", period: 5, group: 4 },
    { atomicNumber: 41, symbol: "Nb", name: "铌", atomicMass: 92.906, category: "transition-metal", period: 5, group: 5 },
    { atomicNumber: 42, symbol: "Mo", name: "钼", atomicMass: 95.95, category: "transition-metal", period: 5, group: 6 },
    { atomicNumber: 43, symbol: "Tc", name: "锝", atomicMass: 97.907, category: "transition-metal", period: 5, group: 7 },
    { atomicNumber: 44, symbol: "Ru", name: "钌", atomicMass: 101.07, category: "transition-metal", period: 5, group: 8 },
    { atomicNumber: 45, symbol: "Rh", name: "铑", atomicMass: 102.91, category: "transition-metal", period: 5, group: 9 },
    { atomicNumber: 46, symbol: "Pd", name: "钯", atomicMass: 106.42, category: "transition-metal", period: 5, group: 10 },
    { atomicNumber: 47, symbol: "Ag", name: "银", atomicMass: 107.87, category: "transition-metal", period: 5, group: 11 },
    { atomicNumber: 48, symbol: "Cd", name: "镉", atomicMass: 112.41, category: "transition-metal", period: 5, group: 12 },
    { atomicNumber: 49, symbol: "In", name: "铟", atomicMass: 114.82, category: "post-transition-metal", period: 5, group: 13 },
    { atomicNumber: 50, symbol: "Sn", name: "锡", atomicMass: 118.71, category: "post-transition-metal", period: 5, group: 14 },
    { atomicNumber: 51, symbol: "Sb", name: "锑", atomicMass: 121.76, category: "metalloid", period: 5, group: 15 },
    { atomicNumber: 52, symbol: "Te", name: "碲", atomicMass: 127.60, category: "metalloid", period: 5, group: 16 },
    { atomicNumber: 53, symbol: "I", name: "碘", atomicMass: 126.90, category: "halogen", period: 5, group: 17 },
    { atomicNumber: 54, symbol: "Xe", name: "氙", atomicMass: 131.29, category: "noble-gas", period: 5, group: 18 },
    
    // 第6周期
    { atomicNumber: 55, symbol: "Cs", name: "铯", atomicMass: 132.91, category: "alkali-metal", period: 6, group: 1 },
    { atomicNumber: 56, symbol: "Ba", name: "钡", atomicMass: 137.33, category: "alkaline-earth-metal", period: 6, group: 2 },
    { atomicNumber: 57, symbol: "La", name: "镧", atomicMass: 138.91, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 72, symbol: "Hf", name: "铪", atomicMass: 178.49, category: "transition-metal", period: 6, group: 4 },
    { atomicNumber: 73, symbol: "Ta", name: "钽", atomicMass: 180.95, category: "transition-metal", period: 6, group: 5 },
    { atomicNumber: 74, symbol: "W", name: "钨", atomicMass: 183.84, category: "transition-metal", period: 6, group: 6 },
    { atomicNumber: 75, symbol: "Re", name: "铼", atomicMass: 186.21, category: "transition-metal", period: 6, group: 7 },
    { atomicNumber: 76, symbol: "Os", name: "锇", atomicMass: 190.23, category: "transition-metal", period: 6, group: 8 },
    { atomicNumber: 77, symbol: "Ir", name: "铱", atomicMass: 192.22, category: "transition-metal", period: 6, group: 9 },
    { atomicNumber: 78, symbol: "Pt", name: "铂", atomicMass: 195.08, category: "transition-metal", period: 6, group: 10 },
    { atomicNumber: 79, symbol: "Au", name: "金", atomicMass: 196.97, category: "transition-metal", period: 6, group: 11 },
    { atomicNumber: 80, symbol: "Hg", name: "汞", atomicMass: 200.59, category: "transition-metal", period: 6, group: 12 },
    { atomicNumber: 81, symbol: "Tl", name: "铊", atomicMass: 204.38, category: "post-transition-metal", period: 6, group: 13 },
    { atomicNumber: 82, symbol: "Pb", name: "铅", atomicMass: 207.2, category: "post-transition-metal", period: 6, group: 14 },
    { atomicNumber: 83, symbol: "Bi", name: "铋", atomicMass: 208.98, category: "post-transition-metal", period: 6, group: 15 },
    { atomicNumber: 84, symbol: "Po", name: "钋", atomicMass: 208.98, category: "post-transition-metal", period: 6, group: 16 },
    { atomicNumber: 85, symbol: "At", name: "砹", atomicMass: 209.99, category: "halogen", period: 6, group: 17 },
    { atomicNumber: 86, symbol: "Rn", name: "氡", atomicMass: 222.02, category: "noble-gas", period: 6, group: 18 },
    
    // 第7周期
    { atomicNumber: 87, symbol: "Fr", name: "钫", atomicMass: 223.02, category: "alkali-metal", period: 7, group: 1 },
    { atomicNumber: 88, symbol: "Ra", name: "镭", atomicMass: 226.03, category: "alkaline-earth-metal", period: 7, group: 2 },
    { atomicNumber: 89, symbol: "Ac", name: "锕", atomicMass: 227.03, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 104, symbol: "Rf", name: "𬬻", atomicMass: 267.12, category: "transition-metal", period: 7, group: 4 },
    { atomicNumber: 105, symbol: "Db", name: "𬭊", atomicMass: 268.13, category: "transition-metal", period: 7, group: 5 },
    { atomicNumber: 106, symbol: "Sg", name: "𬭳", atomicMass: 269.13, category: "transition-metal", period: 7, group: 6 },
    { atomicNumber: 107, symbol: "Bh", name: "𬭛", atomicMass: 270.13, category: "transition-metal", period: 7, group: 7 },
    { atomicNumber: 108, symbol: "Hs", name: "𬭶", atomicMass: 277, category: "transition-metal", period: 7, group: 8 },
    { atomicNumber: 109, symbol: "Mt", name: "鿏", atomicMass: 276, category: "transition-metal", period: 7, group: 9 },
    { atomicNumber: 110, symbol: "Ds", name: "𫟼", atomicMass: 281, category: "transition-metal", period: 7, group: 10 },
    { atomicNumber: 111, symbol: "Rg", name: "𬬭", atomicMass: 280, category: "transition-metal", period: 7, group: 11 },
    { atomicNumber: 112, symbol: "Cn", name: "鎶", atomicMass: 285, category: "transition-metal", period: 7, group: 12 },
    { atomicNumber: 113, symbol: "Nh", name: "鉨", atomicMass: 284, category: "post-transition-metal", period: 7, group: 13 },
    { atomicNumber: 114, symbol: "Fl", name: "鈇", atomicMass: 289, category: "post-transition-metal", period: 7, group: 14 },
    { atomicNumber: 115, symbol: "Mc", name: "镆", atomicMass: 288, category: "post-transition-metal", period: 7, group: 15 },
    { atomicNumber: 116, symbol: "Lv", name: "鉝", atomicMass: 293, category: "post-transition-metal", period: 7, group: 16 },
    { atomicNumber: 117, symbol: "Ts", name: "鿬", atomicMass: 294, category: "halogen", period: 7, group: 17 },
    { atomicNumber: 118, symbol: "Og", name: "鿏", atomicMass: 294, category: "noble-gas", period: 7, group: 18 },
    
    // 镧系元素
    { atomicNumber: 58, symbol: "Ce", name: "铈", atomicMass: 140.12, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 59, symbol: "Pr", name: "镨", atomicMass: 140.91, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 60, symbol: "Nd", name: "钕", atomicMass: 144.24, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 61, symbol: "Pm", name: "钷", atomicMass: 144.91, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 62, symbol: "Sm", name: "钐", atomicMass: 150.36, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 63, symbol: "Eu", name: "铕", atomicMass: 151.96, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 64, symbol: "Gd", name: "钆", atomicMass: 157.25, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 65, symbol: "Tb", name: "铽", atomicMass: 158.93, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 66, symbol: "Dy", name: "镝", atomicMass: 162.50, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 67, symbol: "Ho", name: "钬", atomicMass: 164.93, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 68, symbol: "Er", name: "铒", atomicMass: 167.26, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 69, symbol: "Tm", name: "铥", atomicMass: 168.93, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 70, symbol: "Yb", name: "镱", atomicMass: 173.05, category: "lanthanoid", period: 6, group: 3 },
    { atomicNumber: 71, symbol: "Lu", name: "镥", atomicMass: 174.97, category: "lanthanoid", period: 6, group: 3 },
    
    // 锕系元素
    { atomicNumber: 90, symbol: "Th", name: "钍", atomicMass: 232.04, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 91, symbol: "Pa", name: "镤", atomicMass: 231.04, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 92, symbol: "U", name: "铀", atomicMass: 238.03, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 93, symbol: "Np", name: "镎", atomicMass: 237.05, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 94, symbol: "Pu", name: "钚", atomicMass: 244.06, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 95, symbol: "Am", name: "镅", atomicMass: 243.06, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 96, symbol: "Cm", name: "锔", atomicMass: 247.07, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 97, symbol: "Bk", name: "锫", atomicMass: 247.07, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 98, symbol: "Cf", name: "锎", atomicMass: 251.08, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 99, symbol: "Es", name: "锿", atomicMass: 252.08, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 100, symbol: "Fm", name: "镄", atomicMass: 257.10, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 101, symbol: "Md", name: "钔", atomicMass: 258.10, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 102, symbol: "No", name: "锘", atomicMass: 259.10, category: "actinoid", period: 7, group: 3 },
    { atomicNumber: 103, symbol: "Lr", name: "铹", atomicMass: 262.11, category: "actinoid", period: 7, group: 3 }
];

// 生成元素周期表
function generatePeriodicTable() {
    const periodicTableContainer = document.querySelector('.periodic-table');
    if (!periodicTableContainer) return;
    
    // 清空容器
    periodicTableContainer.innerHTML = '';
    
    // 创建元素卡片
    periodicTableData.forEach(element => {
        const elementCard = document.createElement('div');
        elementCard.className = `element ${element.category}`;
        elementCard.style.gridRow = element.period;
        elementCard.style.gridColumn = element.group;
        
        // 特殊处理镧系和锕系元素
        if (element.atomicNumber >= 57 && element.atomicNumber <= 71) {
            elementCard.style.gridRow = 8;
            elementCard.style.gridColumn = element.atomicNumber - 54;
        }
        
        if (element.atomicNumber >= 89 && element.atomicNumber <= 103) {
            elementCard.style.gridRow = 9;
            elementCard.style.gridColumn = element.atomicNumber - 86;
        }
        
        elementCard.innerHTML = `
            <div class="element-number">${element.atomicNumber}</div>
            <div class="element-symbol">${element.symbol}</div>
            <div class="element-name">${element.name}</div>
            <div class="element-mass">${element.atomicMass}</div>
        `;
        
        // 添加点击事件
        elementCard.addEventListener('click', () => {
            showElementDetails(element);
        });
        
        periodicTableContainer.appendChild(elementCard);
    });
}

// 显示元素详情
function showElementDetails(element) {
    alert(`
元素: ${element.name} (${element.symbol})
原子序数: ${element.atomicNumber}
原子量: ${element.atomicMass}
类别: ${getCategoryName(element.category)}
周期: ${element.period}
族: ${element.group}
    `);
}

// 获取元素类别名称
function getCategoryName(category) {
    const categoryMap = {
        'alkali-metal': '碱金属',
        'alkaline-earth-metal': '碱土金属',
        'transition-metal': '过渡金属',
        'post-transition-metal': '后过渡金属',
        'metalloid': '类金属',
        'nonmetal': '非金属',
        'halogen': '卤素',
        'noble-gas': '稀有气体',
        'lanthanoid': '镧系元素',
        'actinoid': '锕系元素'
    };
    
    return categoryMap[category] || category;
}

// 页面加载完成后生成元素周期表
document.addEventListener('DOMContentLoaded', generatePeriodicTable);