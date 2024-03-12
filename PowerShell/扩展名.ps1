# 定义新的扩展名
$newExtension = ".newExtension"

# 定义旧的扩展名
$oldExtension = ".oldExtension"

# 定义文件夹路径
$folderPath = "your folder path"

# 获取指定文件夹下的所有文件
$files = Get-ChildItem -Path $folderPath -File

# 遍历所有文件
foreach ($file in $files) {
    # 获取文件的扩展名
    $extension = $file.Extension

    # 检查扩展名是否是旧的扩展名
    if ($extension -eq $oldExtension) {
        # 如果是旧的扩展名，修改为新的扩展名
        $newName = $file.BaseName + $newExtension
        Rename-Item -Path $file.FullName -NewName $newName
    }
}