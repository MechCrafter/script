# 这是一个调用 ffmpeg 获取视频时长的脚本，其结果会输出到一个 json 文件中。

# 设置文件夹路径
$folderPath = "E:\。。。\非固态硬盘"

# 获取文件夹中的所有视频文件
$videoFiles = Get-ChildItem -Path $folderPath -Filter "*.mp4" -File

# 创建一个空数组来存储视频信息
$videoInfo = @()

# 遍历每个视频文件
foreach ($file in $videoFiles) {
    # 使用 ffmpeg 获取视频时长
    $duration = & ffmpeg -i $file.FullName 2>&1 | Select-String -Pattern "Duration: (\d{2}):(\d{2}):(\d{2})"

    # 从时长字符串中提取小时、分钟和秒数
    $hours = $duration.Matches.Groups[1].Value
    $minutes = $duration.Matches.Groups[2].Value
    $seconds = $duration.Matches.Groups[3].Value

    # 创建一个哈希表，包含视频名称和时长
    $videoInfoHash = @{
        "name" = $file.Name
        "time" = "$hours h.$minutes m.$seconds s"
    }

    # 将视频信息哈希表添加到 videoInfo 数组中
    $videoInfo += $videoInfoHash
}

# 将视频信息转换为 JSON 格式
$json = $videoInfo | ConvertTo-Json

# 将 JSON 写入文件
$json | Out-File -FilePath "C:\Users\admin\Desktop\shichnag.json"
