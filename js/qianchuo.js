/*这是一个批量修改文件前辍的 JavaScript 程序*/
const fs = require('fs');
const path = require('path');

function modifyFilePrefix(directoryPath, oldPrefix, newPrefix) {
    fs.readdir(directoryPath, (err, files) => {
        if (err) {
            console.error('Error reading directory:', err);
            return;
        }

        files.forEach((file) => {
            const filePath = path.join(directoryPath, file);
            const stats = fs.statSync(filePath);

            if (stats.isFile()) {
                const extname = path.extname(filePath);
                const basename = path.basename(filePath, extname);

                let newBasename = '';

                if (basename === '') {
                    newBasename = newPrefix;
                } else if (basename.startsWith(oldPrefix)) {
                    newBasename = basename.replace(oldPrefix, newPrefix);
                } else {
                    newBasename = basename;
                }

                const newPath = path.join(directoryPath, `${newBasename}${extname}`);

                fs.rename(filePath, newPath, (err) => {
                    if (err) {
                        console.error('Error modifying file prefix:', err);
                    } else {
                        console.log(`文件前辍修改成功: ${filePath}`);
                    }
                });
            } else if (stats.isDirectory()) {
                modifyFilePrefix(filePath, oldPrefix, newPrefix);
            }
        });
    });
}

// 使用示例
modifyFilePrefix("D:\\workspace\\test", 'oldoldoldPre', '修改成功');//如果没有前辍，则前一个 '' 留空，后一个 '' 里填入新前辍
