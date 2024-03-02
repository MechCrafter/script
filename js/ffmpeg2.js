/*这是 ffmpeg -i input.mp4 -vf "scale=3840:2160" output.mp4 的批量处理程序*/
/*批量改变画质的程序*/
const { exec } = require('child_process');
const path = require('path');

const inputDir = 'path/to/input/videos'; // 输入视频文件夹路径
const outputDir = 'path/to/output/videos'; // 输出视频文件夹路径
const resolution = '3840x2160'; // 分辨率

// 获取输入文件夹中所有视频文件的列表
const files = fs.readdirSync(inputDir).filter(file => path.extname(file).toLowerCase() === '.mp4');

// 处理每个视频文件
files.forEach(file => {
    const inputPath = path.join(inputDir, file);
    const outputFileName = `output_${file}`;
    const outputPath = path.join(outputDir, outputFileName);

    // 运行 FFmpeg 命令来增加分辨率
    const command = `ffmpeg -i "${inputPath}" -vf "scale=${resolution}" "${outputPath}"`;
    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`处理 ${file} 时出错: ${error.message}`);
        } else {
            console.log(`成功处理 ${file}`);
        }
    });
});
