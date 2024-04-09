# 定义文件夹路径
$folderPath = "E:\。。。\非固态硬盘\时长在2h-2.5h之间的"

# 定义输出 txt 文件路径
$outputFilePath = "C:\Users\admin\Desktop\新建 文本文档 (3).txt"

# 定义文件大小阈值（500 * 2MB）
$sizeThreshold = 500 * 2MB

# 获取超过文件大小阈值的文件
$largeFiles = Get-ChildItem -Path $folderPath -Recurse | Where-Object { $_.Length -gt $sizeThreshold }

# 提取文件名，并将结果输出到指定文件
$largeFiles | ForEach-Object { Split-Path $_.FullName -Leaf } | Out-File -FilePath $outputFilePath