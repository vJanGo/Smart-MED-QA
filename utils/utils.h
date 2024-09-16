#ifndef UTILS_H
#define UTILS_H

#include <string>
#include <vector>
#include <sstream>
#include <locale>
#include <iostream>
#include <unordered_map>
#include <regex>
#include <chrono>
#include <ctime>
#include <sys/socket.h>
#include <netinet/tcp.h>
#include <netinet/in.h>


// 分割字符串的辅助函数, 用来在服务端解析命令
std::vector<std::string> split(const std::string& str, char delimiter);

//  ...
std::string SentencePieces(const std::string& str, int start_index, int max_len);

// package头部 编码器
std::string HeaderEncoder(int type, int function, int limits, int package_id, int resend);

// package头部 解码器
int* HeaderDecoder(const std::string& str);

// package编码器
std::stringstream MapEncoder(const std::unordered_map<std::string, std::string>& map);

// 带正则匹配的字符串split
std::vector<std::string> SpeSplit(const std::string& str, std::string& delimiter);

// package解码器
std::unordered_map<std::string, std::string> MapDecoder(const std::string& str);

// 获取当前时间的字符串形式
std::string getCurrentTime();

// 打印错误信息，包含时间、IP地址和端口等信息
void printError(const std::string& message, const std::string& ip = "", int port = 0);

// 将char列表的字符串转化为std::string的字符串
std::string Cstr2str(const char* cstr);

// 网络传输信息解包后的输出类型
struct PackageInfo {
    std::unordered_map<std::string, std::string> map;
    int* headinfo;
};
typedef struct PackageInfo package_info;

// 从字典到报文的封装函数
std::vector<std::string> PackageGenerator(int type, int function, const std::unordered_map<std::string, std::string>& map, int limit = 0, int resend = 0, int BUFFER_SIZE = 1024);

// 从报文到字典和PackageInfo类的解包函数
PackageInfo PackageUnziper(std::vector<std::string> packageStrings);

// 使用socket_fd 接收信息
PackageInfo PackageReciever(int sock_cli, int BUFFERSIZE = 1124);

// 通过socket确认连接
int ConnectCheckout(int socket_fd);

#endif // UTILS_H
