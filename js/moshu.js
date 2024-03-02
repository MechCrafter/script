const fs = require('fs');

/*这是一个检测文件魔数的 JavaScript 程序*/

function checkMagicNumber(filePath) {
    const fileBuffer = fs.readFileSync(filePath);
    const magicNumber = Array.from(fileBuffer).map(byte => byte.toString(16).padStart(2, '0')).join(' ');
    return magicNumber.substring(0, 12).split(' ').slice(0, 4).join(' '); // 返回前四个魔数
}

const filePath = "D:\\workspace\\study\\JavaScript\\package-lock.json"; // 替换为实际文件路径
const magicNumber = checkMagicNumber(filePath);
console.log(`魔数序列: ${magicNumber}`);
