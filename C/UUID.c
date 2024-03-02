/*
根据当前时间戳生成一个 UUID
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void generate_unique_string(char* output) {
    srand(time(NULL)); // 使用当前时间作为随机数生成器的种子
    sprintf(output, "%ld%ld", time(NULL), rand()); // 将当前时间戳和一个随机数结合起来生成一个唯一的字符串
}

int main() {
    char unique_string[50]; // 存储生成的唯一字符串
    generate_unique_string(unique_string); // 调用generate_unique_string函数生成唯一字符串
    printf("生成的唯一字符串: %s\n", unique_string); // 打印生成的唯一字符串
    return 0;
}