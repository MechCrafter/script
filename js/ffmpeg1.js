const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');

/*这是 ffmpeg -i "your_video" -i "your_audio" -c:a aac -strict experimental "your_video.mp4" 的批量处理程序*/
/*批量处理合并视频和音频*/
// 输入文件路径
const videoPath = "D:\\ffmpeg\\ffmpeg_video";
const audioPath = "D:\\ffmpeg\\ffmpeg_audio";

// 输出文件夹路径
const outputPath = "D:\\ffmpeg\\ffmpeg";

// 执行 ffmpeg 命令的函数
function processFiles(videoFile, audioFile) {
    const videoFileName = path.basename(videoFile);
    const outputFilePath = path.join(outputPath, `${videoFileName}.mp4`);

    const command = `ffmpeg -i "${videoFile}" -i "${audioFile}" -c:a aac -strict experimental "${outputFilePath}"`;

    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`错误: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`ffmpeg stderr: ${stderr}`);
            return;
        }
        console.log(`处理文件: ${videoFile}`);
    });
}

// 处理输入文件夹中的所有文件
function processAllFiles() {
    // 获取视频文件列表
    const videoFiles = fs.readdirSync(videoPath);

    // 获取音频文件列表
    const audioFiles = fs.readdirSync(audioPath);

    // 处理每对视频和音频文件
    videoFiles.forEach((videoFile, index) => {
        const audioFile = audioFiles[index];
        if (audioFile) {
            const videoFilePath = path.join(videoPath, videoFile);
            const audioFilePath = path.join(audioPath, audioFile);
            processFiles(videoFilePath, audioFilePath);
        }
    });
}

// 开始批量处理
processAllFiles();
