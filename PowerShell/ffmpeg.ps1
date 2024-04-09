# 这是一个使用 PowerShell 脚本调用 ffmpeg 获取视频文件时长的示例，然后根据时长筛选视频文件并输出到文本文件。

# 设置视频文件夹路径
$videoFolderPath = "E:\。。。\非固态硬盘\0.5h之下的"
# 设置输出文本文件路径
$outputFilePath = "C:\Users\admin\Desktop\0.5h之下的\时长在 5分钟到10分钟 的.txt"

# 获取视频文件列表
$videoFiles = Get-ChildItem -Path $videoFolderPath -Filter "*.mp4" -File

# 遍历视频文件
foreach ($videoFile in $videoFiles) {
    # 使用 ffmpeg 获取视频时长
    $duration = & ffmpeg -i $videoFile.FullName 2>&1 | Select-String -Pattern "Duration: (\d+):(\d+):(\d+)"

    # 解析时长
    if ($duration) {
        $hours = [int]$duration.Matches.Groups[1].Value
        $minutes = [int]$duration.Matches.Groups[2].Value
        $seconds = [int]$duration.Matches.Groups[3].Value

        # 检查视频时长是否超过 300 秒，这里输入时长单位为秒
        $totalSeconds = ($hours * 3600) + ($minutes * 60) + $seconds
        if ($totalSeconds -ge 300) {
            # 输出视频文件名到文本文件
            Add-Content -Path $outputFilePath -Value $videoFile.Name
        }
    }
}
