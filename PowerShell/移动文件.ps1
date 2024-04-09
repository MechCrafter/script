# 这是一个 PowerShell 脚本，用于将源文件夹中的文件移动到目标文件夹中，文件名由输入文本文件提供。

# 设置源文件夹路径
$sourceFolderPath = "E:\。。。\非固态硬盘\0.5h之下的"

# 设置目标文件夹路径
$targetFolderPath = "E:\。。。\非固态硬盘\时长在 5分钟到10分钟 的"

# 设置输入文本文件路径
$inputFilePath = "C:\Users\admin\Desktop\0.5h之下的\时长在 5分钟到10分钟 的.txt"

# 读取文本文件中的每一行
$fileNames = Get-Content -Path $inputFilePath

# 遍历文件名
foreach ($fileName in $fileNames) {
    # 构建源文件路径
    $sourceFilePath = Join-Path -Path $sourceFolderPath -ChildPath $fileName

    # 检查文件是否存在
    if (Test-Path -Path $sourceFilePath) {
        # 构建目标文件路径
        $targetFilePath = Join-Path -Path $targetFolderPath -ChildPath $fileName

        # 移动文件
        Move-Item -Path $sourceFilePath -Destination $targetFilePath
    } else {
        Write-Output "File $fileName does not exist in the source folder."
    }
}