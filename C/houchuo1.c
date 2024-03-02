/*另一个修改文件后辍的C语言程序*/
#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <stdlib.h>

int changeFileExtensionInDirectory(char *dirPath, char *oldExtension, char *newExtension) {
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
        if (strstr(entry->d_name, oldExtension) == entry->d_name + strlen(entry->d_name) - strlen(oldExtension)) {
            sprintf(oldName, "%s/%s", dirPath, entry->d_name);
            strncpy(newName, oldName, strlen(oldName) - strlen(oldExtension));
            newName[strlen(oldName) - strlen(oldExtension)] = '\0';
            strcat(newName, newExtension);
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
    char oldExtension[256];
    char newExtension[256];
    int result;

    printf("请输入目录路径: ");
    scanf("%s", dirPath);
    printf("请输入旧的文件后缀（包括.，例如.txt）: ");
    scanf("%s", oldExtension);
    printf("请输入新的文件后缀（包括.，例如.doc）: ");
    scanf("%s", newExtension);

    result = changeFileExtensionInDirectory(dirPath, oldExtension, newExtension);

    if (result == 0) {
        printf("操作成功完成\n");
    } else {
        printf("操作失败\n");
    }

    return 0;
}