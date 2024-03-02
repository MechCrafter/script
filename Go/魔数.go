package main

import (
    "encoding/hex"
    "fmt"
    "os"
)

func main() {
    // 定义文件路径
    filePath := "example.txt" //填入文件路径

    // 打开文件
    file, err := os.Open(filePath)
    if err != nil {
        fmt.Println("Error opening file:", err)
        return
    }
    defer file.Close()

    // 读取文件的前四个字节
    magicBytes := make([]byte, 4)
    _, err = file.Read(magicBytes)
    if err != nil {
        fmt.Println("Error reading file:", err)
        return
    }

    // 打印魔数
    fmt.Println("Magic bytes:", hex.EncodeToString(magicBytes))
}
