# 定义新的前缀
$newPrefix = "newPrefix"

# 定义旧的前缀
$oldPrefix = "oldPrefix"

# 定义文件夹路径
$folderPath = "your folder path"

# 获取指定文件夹下的所有文件
$files = Get-ChildItem -Path $folderPath -File

# 遍历所有文件
foreach ($file in $files) {
    # 获取文件名（不包括扩展名）
    $name = $file.BaseName

    # 检查文件名是否已经包含旧的前缀
    if ($name -match "^$oldPrefix") {
        # 如果已经包含旧的前缀，替换为新的前缀
        $newName = $name -replace "^$oldPrefix", $newPrefix
    } else {
        # 如果没有包含旧的前缀，添加新的前缀
        $newName = $newPrefix + $name
    }

    # 重命名文件
    Rename-Item -Path $file.FullName -NewName ($newName + $file.Extension)
}