/*这是一个批量修改文件扩展名的程序*/
const fs = require('fs');
const path = require('path');

function modifyFileExtension(directory, oldExtension, newExtension) {
  fs.readdir(directory, (err, files) => {
    if (err) {
      console.error('Error reading directory:', err);
      return;
    }

    files.forEach((file) => {
      const filePath = path.join(directory, file);
      const fileExtension = path.extname(filePath);

      if (fileExtension === oldExtension) {
        const newFilePath = path.join(directory, path.basename(filePath, oldExtension) + newExtension);

        fs.rename(filePath, newFilePath, (err) => {
          if (err) {
            console.error('Error modifying file extension:', err);
          } else {
            console.log('文件扩展名修改成功:', filePath);
          }
        });
      }
    });
  });
}

// Usage example
const directory = 'D:\\workspace\\test';// 这里输入文件夹路径
const oldExtension = '.csv';// 这是旧的扩展名
const newExtension = '.svg';// 这是新的扩展名
modifyFileExtension(directory, oldExtension, newExtension);
