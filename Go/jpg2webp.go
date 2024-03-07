package main

import (
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func main() {
	dir := "D:\\workspace\\ffmpeg\\jpg2webp" // 要处理的目录

	err := filepath.Walk(dir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		ext := strings.ToLower(filepath.Ext(path))
		if ext == ".jpg" || ext == ".png" || ext == ".jpeg" {
			output := filepath.Base(path)
			output = output[0:len(output)-len(filepath.Ext(output))] + ".webp"

			outputPath := filepath.Join(filepath.Dir(path), output)

			cmd := exec.Command("ffmpeg", "-i", path, outputPath)
			err := cmd.Run()
			if err != nil {
				log.Printf("Error converting file: %s", err)
			}
		}

		return nil
	})

	if err != nil {
		log.Printf("Error walking the directory: %s", err)
	}
}