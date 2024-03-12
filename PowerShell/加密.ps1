# 需要安装 OpenSSL 并将其添加到环境变量中。
# 指定要加密的文件夹
$folderPath = "your folder path"

# 获取指定文件夹下的所有文件
$files = Get-ChildItem -Path $folderPath -File -Recurse

# 遍历每个文件
foreach ($file in $files) {
    # 获取文件的相对路径
    $relativePath = $file.FullName.Substring($folderPath.Length)

    # 构造加密后的文件名
    $encryptedFileName = "$folderPath$relativePath.enc"

    # 确保目标文件夹存在
    $destinationFolder = [System.IO.Path]::GetDirectoryName($encryptedFileName)
    if (!(Test-Path -Path $destinationFolder)) {
        New-Item -ItemType Directory -Force -Path $destinationFolder
    }

    # 使用 OpenSSL 进行加密
    openssl enc -aes-256-cbc -salt -pbkdf2 -iter 10000 -in $file.FullName -out $encryptedFileName -pass pass:yourpassword

    # 如果加密成功，删除原文件
    if ($?) {
        Remove-Item -Path $file.FullName
    }
}