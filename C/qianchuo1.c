/*修改文件前辍的撤程序*/
#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <stdlib.h>

int addPrefixToFilesInDirectory(char *dirPath, char *prefix) {
    DIR *dir = opendir(dirPath);
    struct dirent *entry;
    char oldName[256];
    char newName[256];
    struct stat st;
    int renameResult;

    if (dir == NULL) {
        printf("无法打开目录 %s\n", dirPath);
        return -1;
    }

    while ((entry = readdir(dir)) != NULL) {
        sprintf(oldName, "%s/%s", dirPath, entry->d_name);
        if (stat(oldName, &st) == 0 && S_ISREG(st.st_mode)) {
            sprintf(newName, "%s/%s%s", dirPath, prefix, entry->d_name);
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
    char prefix[256];
    int result;

    printf("请输入目录路径: ");
    scanf("%s", dirPath);
    printf("请输入要添加的前缀: ");
    scanf("%s", prefix);

    result = addPrefixToFilesInDirectory(dirPath, prefix);

    if (result == 0) {
        printf("操作成功完成\n");
    } else {
        printf("操作失败\n");
    }

    return 0;
}