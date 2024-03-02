/*这是一个检测文件魔数的C语言程序*/
#include <stdio.h>

void print_magic_number(const char *file_path) {
    FILE *file = fopen(file_path, "rb");
    if (file == NULL) {
        printf("无法打开文件\n");
        return;
    }

    unsigned char magic_number[4];
    if (fread(magic_number, sizeof(unsigned char), 4, file) != 4) {
        printf("无法读取魔数\n");
    } else {
        printf("魔数: %02X %02X %02X %02X\n", magic_number[0], magic_number[1], magic_number[2], magic_number[3]);
    }

    fclose(file);
}
int main() {
    print_magic_number("D:\Localsend 同步\atlas_0xC7DE4672_public.asc");//这里填写文件路径
    return 0;
}
