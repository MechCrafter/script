/*修改文件前辍的撤程序*/
#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <stdlib.h>

int renameFilesInDirectory(char *dirPath, char *oldPrefix, char *newPrefix) {
    DIR *dir = opendir(dirPath);
    struct dirent *entry;
    char oldName[256];
    char newName[256];
    int renameResult;

    if (dir == NULL) {
        printf("无法打开目录 %s\n", dirPath);
        return -1;
    }

    while ((entry = readdir(dir)) != NULL) {
        if (strstr(entry->d_name, oldPrefix) == entry->d_name) {
            sprintf(oldName, "%s/%s", dirPath, entry->d_name);
            sprintf(newName, "%s/%s%s", dirPath, newPrefix, entry->d_name + strlen(oldPrefix));
            renameResult = rename(oldName, newName);
            if (renameResult != 0) {
                closedir(dir);
                return -1;
            }
        }
    }

    closedir(dir);
    return 0;
}

int main() {
    char dirPath[256];
    char oldPrefix[256];
    char newPrefix[256];
    int result;

    printf("请输入目录路径: ");
    scanf("%s", dirPath);
    printf("请输入旧的前缀（如果没有，请输入NONE）: ");
    scanf("%s", oldPrefix);
    printf("请输入新的前缀: ");
    scanf("%s", newPrefix);

    if (strcmp(oldPrefix, "NONE") == 0) {
        oldPrefix[0] = '\0';
    }

    result = renameFilesInDirectory(dirPath, oldPrefix, newPrefix);

    if (result == 0) {
        printf("操作成功完成\n");
    } else {
        printf("操作失败\n");
    }

    return 0;
}