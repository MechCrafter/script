# 利用通配符检出特定的文件格式

# 设置要搜索文件的目录路径
$directory = "D:\workspace\vault\assets"

# 设置要搜索的文件格式
$fileFormat = "*.pdf"

# 设置输出文本文件的路径
$outputFile = "C:\Users\admin\Desktop\新建 文本文档 (3).txt"

# 获取在目录中与指定格式匹配的文件
$files = Get-ChildItem -Path $directory -Filter $fileFormat

# 遍历每个文件，并将其名称写入输出文件
foreach ($file in $files) {
    $file.Name | Out-File -FilePath $outputFile -Append
}
