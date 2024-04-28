# 这是 ffmpeg -i "your_video" -i "your_audio" -c:a aac -strict experimental "your_video.mp4" 的批量处理程序，
# 是批量合并音频和视频的程序，通过相同文件名匹配

# 定义视频和音频文件夹路径以及输出文件夹路径
$videoDir = "D:\workspace\ffmpeg\ffmpeg_video"
$audioDir = "D:\workspace\ffmpeg\ffmpeg_audio"
$outputDir = "D:\workspace\ffmpeg\ffmpeg"

# 确保输出文件夹存在
if (!(Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir
}

# 获取视频和音频文件
$videoFiles = Get-ChildItem -Path $videoDir -File
$audioFiles = Get-ChildItem -Path $audioDir -File

# 遍历视频文件夹中的每个视频文件
foreach ($videoFile in $videoFiles) {
    # 获取视频文件名（不含扩展名）
    $videoName = [IO.Path]::GetFileNameWithoutExtension($videoFile.Name)

    # 查找相同名称的音频文件
    $audioFile = $audioFiles | Where-Object { [IO.Path]::GetFileNameWithoutExtension($_.Name) -eq $videoName }

    # 如果找到相应的音频文件，则合并
    if ($null -ne $audioFile) {
        # 构建输出文件的路径
        $outputFilename = $videoName + "_processed.mp4"
        $outputPath = Join-Path -Path $outputDir -ChildPath $outputFilename

        # 构建FFmpeg命令并执行
        & ffmpeg -i (Join-Path -Path $videoDir -ChildPath $videoFile.Name) -i (Join-Path -Path $audioDir -ChildPath $audioFile.Name) -c:v copy -c:a aac -strict experimental $outputPath
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Error processing file: $videoFile.Name"
            continue
        }
        Write-Host "Processed file $videoFile.Name"
    } else {
        Write-Host "No matching audio file found for $videoFile.Name"
    }
}