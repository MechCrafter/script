/*这是 ffmpeg -i "your_video" -i "your_audio" -c:a aac -strict experimental "your_video.mp4" 的批量处理程序，
是批量合并音频和视频的程序，通过相同文件名匹配*/
package main

import (
    "fmt"
    "io/ioutil"
    "os"
    "os/exec"
    "path/filepath"
    "strings"
)

func main() {
    // 定义视频和音频文件夹路径以及输出文件夹路径
    videoDir := "D:\\workspace\\ffmpeg\\ffmpeg_video"
    audioDir := "D:\\workspace\\ffmpeg\\ffmpeg_audio"
    outputDir := "D:\\workspace\\ffmpeg\\ffmpeg"

    // 遍历视频文件夹
    videoFiles, err := ioutil.ReadDir(videoDir)
    if err != nil {
        fmt.Println("Error reading video directory:", err)
        return
    }

    // 遍历音频文件夹
    audioFiles, err := ioutil.ReadDir(audioDir)
    if err != nil {
        fmt.Println("Error reading audio directory:", err)
        return
    }

    // 确保输出文件夹存在
    if _, err := os.Stat(outputDir); os.IsNotExist(err) {
        os.MkdirAll(outputDir, 0755)
    }

    // 遍历视频文件夹中的每个视频文件
    for _, videoFile := range videoFiles {
        if !videoFile.IsDir() {
            // 获取视频文件名（不含扩展名）
            videoName := strings.TrimSuffix(videoFile.Name(), filepath.Ext(videoFile.Name()))

            // 查找相同名称的音频文件
            var audioPath string
            for _, audioFile := range audioFiles {
                if !audioFile.IsDir() && strings.TrimSuffix(audioFile.Name(), filepath.Ext(audioFile.Name())) == videoName {
                    audioPath = filepath.Join(audioDir, audioFile.Name())
                    break
                }
            }

            // 如果找到相应的音频文件，则合并
            if audioPath != "" {
                // 构建输出文件的路径
                outputFilename := videoName + "_processed.mp4"
                outputPath := filepath.Join(outputDir, outputFilename)

                // 构建FFmpeg命令
                cmd := exec.Command("ffmpeg", "-i", filepath.Join(videoDir, videoFile.Name()), "-i", audioPath, "-c:v", "copy", "-c:a", "aac", "-strict", "experimental", outputPath)
                // 执行命令
                err := cmd.Run()
                if err != nil {
                    fmt.Println("Error processing file:", err)
                    continue
                }
                fmt.Printf("Processed file %s\n", videoFile.Name())
            } else {
                fmt.Printf("No matching audio file found for %s\n", videoFile.Name())
            }
        }
    }
}
