/*这是 ffmpeg -i input.mp4 -vf "scale=3840:2160" output.mp4 的批量处理程序，是改变视频分辨率的程序*/
package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
)

func main() {
	// 定义输入和输出文件夹路径
	inputDir := "D:\\ffmpeg\\test"
	outputDir := "D:\\ffmpeg\\test1"

	// 确保输出文件夹存在
	if _, err := os.Stat(outputDir); os.IsNotExist(err) {
		os.MkdirAll(outputDir, 0755)
	}

	// 读取输入文件夹中的所有文件
	files, err := ioutil.ReadDir(inputDir)
	if err != nil {
		fmt.Println("Error reading input directory:", err)
		return
	}

	// 遍历文件夹中的每个文件
	for _, file := range files {
		if !file.IsDir() {
			// 构建输入文件的完整路径
			inputPath := filepath.Join(inputDir, file.Name())

			// 构建输出文件的完整路径
			outputPath := filepath.Join(outputDir, file.Name())

			// 调用FFmpeg命令进行处理
			cmd := exec.Command("ffmpeg", "-i", inputPath, "-vf", "scale=3840:2160", outputPath)
			err := cmd.Run()
			if err != nil {
				fmt.Println("Error processing file:", err)
				continue
			}
			fmt.Printf("Processed file %s\n", file.Name())
		}
	}
}
