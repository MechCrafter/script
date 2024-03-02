/*修改文件后戳名*/
#include <stdio.h>
#include <string.h>
#include <dirent.h>

void rename_files_in_directory(const char *directory_path, const char *old_ext, const char *new_ext) {
    DIR *dir = opendir(directory_path);
    if (dir == NULL) {
        printf("无法打开目录\n");
        return;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        char *dot = strrchr(entry->d_name, '.');
        if (dot && strcmp(dot, old_ext) == 0) {
            char old_name[256];
            snprintf(old_name, sizeof(old_name), "%s/%s", directory_path, entry->d_name);

            char new_name[256];
            snprintf(new_name, sizeof(new_name), "%s/%.*s%s", directory_path, (int)(dot - entry->d_name), entry->d_name, new_ext);

            if (rename(old_name, new_name) == 0) {
                printf("已将 %s 重命名为 %s\n", old_name, new_name);
            } else {
                printf("无法重命名 %s\n", old_name);
            }
        }
    }

    closedir(dir);
}

int main() {
    rename_files_in_directory("D:\\Localsend 同步\\kzm", ".png", ".jpg");//从这里输入文件路径和后缀名，前一个是旧后缀名，后一个是新后缀名
    return 0;
}