# 需要安装 OpenSSL 并将其添加到环境变量中。
# 指定要解密的文件夹
$folderPath = "your folder path"

# 获取指定文件夹下的所有 .aes 文件
$files = Get-ChildItem -Path $folderPath -Include *.aes -File -Recurse

# 遍历每个文件
foreach ($file in $files) {
    # 获取文件的相对路径
    $relativePath = $file.FullName.Substring($folderPath.Length)

    # 构造解密后的文件名，移除 .aes 扩展名
    $decryptedFileName = "$folderPath$($relativePath -replace '\.aes$', '')"

    # 确保目标文件夹存在
    $destinationFolder = [System.IO.Path]::GetDirectoryName($decryptedFileName)
    if (!(Test-Path -Path $destinationFolder)) {
        New-Item -ItemType Directory -Force -Path $destinationFolder
    }

    # 使用 OpenSSL 进行解密，把下列的 yourpassword 替换为你的密码
    openssl enc -d -aes-256-cbc -salt -pbkdf2 -iter 10000 -in $file.FullName -out $decryptedFileName -pass pass:yourpassword

    # 如果解密成功，删除原文件
    if ($?) {
        Remove-Item -Path $file.FullName
    }
}