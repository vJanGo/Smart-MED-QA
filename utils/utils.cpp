#include "utils.h"
#include <string.h>

std::vector<std::string> split(const std::string& str, char delimiter) {
    std::vector<std::string> tokens;
    std::istringstream tokenStream(str);
    std::string token;
    while (std::getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }
    return tokens;
}

std::string SentencePieces(const std::string& str, int start_index, int max_len) {
    if(start_index + max_len >= str.length()) {
        return str.substr(start_index);
    } else {
        return str.substr(start_index, max_len);
    }
}

std::string HeaderEncoder(int type, int function, int limits, int package_id, int resend){
    // Change the header to the 32 bit string

    type = type & 3;
    function = function & 15;
    limits = limits & 3;
    package_id = package_id & 0xFFFF;
    resend = resend & 1;

    int header = type << 30 | function << 26 | limits << 24 | package_id << 8 | resend;
    std::bitset<32> binary(header);
    return binary.to_string();
}

int* HeaderDecoder(const std::string& str) {

    std::bitset<32> binary(str);
    int* header = new int[5];
    header[0] = binary.to_ulong() >> 30;
    header[1] = (binary.to_ulong() >> 26) & 15;
    header[2] = (binary.to_ulong() >> 24) & 3;
    header[3] = (binary.to_ulong() >> 8) & 0xFFFF;
    header[4] = (binary.to_ulong()) & 1;
    return header;
}

std::stringstream MapEncoder(const std::unordered_map<std::string, std::string>& map) {
    std::string key_value_seperator = "<|KVG|>";
    std::string component_seperator = "<|EOC|>";

    std::stringstream ss;
    for ( auto it = map.begin(); it != map.end(); it++) {
        std::pair<std::string, std::string> kv = *it;
        ss << kv.first << key_value_seperator << kv.second << component_seperator;
    }
    return ss;
}

std::vector<std::string> SpeSplit(const std::string& str, std::string& delimiter) {
    // seperate the string by a special delimiter, and return a vector

    std::regex re(delimiter);
    std::sregex_token_iterator iter(str.begin(), str.end(), re, -1);
    std::sregex_token_iterator end;

    std::vector<std::string> tokens;
    while (iter != end) {
        tokens.push_back(*iter++);
    }
    if (tokens.size() > 0) {
        return tokens;
    }
    else{
        tokens.push_back(str);
        return tokens;
    }
}


std::unordered_map<std::string, std::string> MapDecoder(const std::string& str) {
    std::string key_value_seperator = "<\\|KVG\\|>";
    std::string component_seperator = "<\\|EOC\\|>";
    std::unordered_map<std::string, std::string> map;

    std::vector<std::string> tokens = SpeSplit(str, component_seperator);

    for (size_t i = 0; i < tokens.size(); i++) {
        std::string token = tokens[i];
        std::vector<std::string> kv = SpeSplit(token, key_value_seperator);
        if (kv.size() == 2) {
            map[kv[0]] = kv[1];
        }
    }
    return map;

}

// 一个生成患者请求报文的函数，通过这个函数自动生成一个请求数据的报文

std::string PatientRequest(int function, const std::string& username) {
    std::string head = HeaderEncoder(0, function, 0, 1, 0);

    std::unordered_map<std::string, std::string> map;
    map["request"] = "1";
    map["username"] = username;
    std::stringstream ss = MapEncoder(map);

    std::string content = head + ss.str();
    return content;
}

std::vector<std::string> PackageGenerator(int type, int function, const std::unordered_map<std::string, std::string>& map, int limit, int resend, int BUFFER_SIZE) {
    std::stringstream encoded_map = MapEncoder(map);
    std::string info = encoded_map.str();
    std::vector<std::string> package;
    std::string package_seperator = "<|EOP|>";
    std::string package_ender = "<END>";
    for (int i = 0; i < info.length() / BUFFER_SIZE + 1; i++){
        std::string str = SentencePieces(info, i * BUFFER_SIZE, BUFFER_SIZE);
        std::string head = HeaderEncoder(type, function, limit, i + 1, resend);
        
        if (info.length() / BUFFER_SIZE + 1 > 1 && i != info.length() / BUFFER_SIZE){
            package.push_back(head + str + package_seperator);
        } else {
            package.push_back(head + str + package_ender);
        }
    }
    return package;
}

// 拟采用桶排解决报文顺序问题，通过这个方法来将报文进行处理，并排序
// 同时返回一个结构体，这个结构体包括map和头信息，用于后续处理


PackageInfo PackageUnziper(std::vector<std::string> package){
    std::string **arr = new std::string*[package.size()];
    std::unordered_map<std::string, std::string> map;

    // 保存些许头部信息，从而便于后续功能进行
    int* headinfo = new int[5];
    bool save_info = false;
    // 桶排序
    for (size_t i = 0; i < package.size(); i++) {
        std::string str = package[i];
        int* head = HeaderDecoder(str.substr(0, 32));
        if (save_info == false) {
            headinfo[0] = head[0];
            headinfo[1] = head[1];
            headinfo[2] = head[2];
            headinfo[3] = package.size();
            headinfo[4] = head[4];
            save_info = true;
        }
        int place = head[3] - 1;
        std::string package_seperator = "<\\|EOP\\|>";

        // 使用正则表达式提取每个报文段的正文
        std::string content = SpeSplit(str.substr(32), package_seperator)[0];
        arr[place] = new std::string(content);
    }
    // 将排列好的字符串进行拼接
    std::string info = "";
    for (size_t i = 0; i < package.size(); i++) {
        std::string str = *arr[i];
        info = info + str;    //  todo 效率低下，要改
    }
    // 去除报文末尾的标识符
    info = info.substr(0, info.length() - 5);
    map = MapDecoder(info);
    PackageInfo packageinfo;
    packageinfo.headinfo = headinfo;
    packageinfo.map = map;
    return packageinfo;
}

std::string Cstr2str(const char* cstr) {
    std::string str = std::string(cstr);
    return str;
}

/* 用于处理服务器端的错误打印 */
std::string getCurrentTime() {
    auto now = std::chrono::system_clock::now();
    std::time_t now_time = std::chrono::system_clock::to_time_t(now);
    char buffer[80];
    std::strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", std::localtime(&now_time));
    return std::string(buffer);
}
void printError(const std::string& message, const std::string& ip, int port) {
    std::ostringstream oss;
    oss << "[" << getCurrentTime() << "] " << message;
    if (!ip.empty()) {
        oss << " (IP: " << ip << ", Port: " << port << ")";
    }
    std::
    
    cerr << oss.str() << std::endl;
}

// 接受报文的封装函数,  todo  加入错误判断机制
PackageInfo PackageReciever(int sock_cli, int BUFFER){
    std::vector<std::string> package;
    int package_number = 0;
    int all_package_number = 0;
    bool end = false;
    while(1){
        char recvbuf[BUFFER + 1];
        recv(sock_cli, recvbuf, sizeof(recvbuf), 0);
        // recvbuf[BUFFER] = '\0';    // 防止越界
        std::string str = std::string(recvbuf);
        package_number += 1;
        if (str.find("<END>") != std::string::npos ){
            all_package_number = HeaderDecoder(str.substr(0, 32))[3];
            end = true;
        }
        package.push_back(str);
        memset(recvbuf, 0, sizeof(recvbuf));
        if (package_number == all_package_number and end){
            break;
        }
    }
    return PackageUnziper(package);
}

int ConnectCheckout(int socket_fd) {
    struct tcp_info info;     // 结构体定义在 netinet/tcp.h
    int len=sizeof(info);
    getsockopt(socket_fd, IPPROTO_TCP, TCP_INFO, &info, (socklen_t *)&len);   // IPPPROTO 在 netinet/in.h 中
    if((info.tcpi_state==TCP_ESTABLISHED)) {
        return 1;
    }
    return 0;
}
