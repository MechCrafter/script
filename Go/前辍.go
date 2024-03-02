package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	// 指定工作路径
	dir := "D:\\workspace\\新建文件夹 (2)"
	// 指定旧前缀和新前缀
	oldPrefix := "添加成功2023"
	newPrefix := ""

	// 读取目录中的所有文件
	files, err := ioutil.ReadDir(dir)
	if err != nil {
		fmt.Println("Error reading directory:", err)
		return
	}

	// 遍历文件
	for _, file := range files {
		if !file.IsDir() {
			// 获取文件名
			filename := file.Name()

			// 检查文件名是否有旧前缀
			if strings.HasPrefix(filename, oldPrefix) {
				// 构建新文件名
				newFilename := strings.Replace(filename, oldPrefix, newPrefix, 1)

				// 移动文件
				err := os.Rename(filepath.Join(dir, filename), filepath.Join(dir, newFilename))
				if err != nil {
					fmt.Printf("Error renaming file %s: %s\n", filename, err)
				} else {
					fmt.Printf("Renamed file %s to %s\n", filename, newFilename)
				}
			}
		}
	}
}
