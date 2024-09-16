
# 描述

此项目为北理工大三小学期qt实践项目的前端，要求是开发一个医疗系统终端，包含登陆注册，挂号，聊天等等功能，难度不小。我只写了前端部分，由于初次接触qt并不熟练，在写交互的cpp代码时并没有按照标准的信号槽和通信等机制，导致函数的接受值和返回值与qt并不兼容，因此随处可见地使用了一种编码器和译码器。
# 来源

UI来自github上的[FluentUI](https://github.com/zhuzichu520/FluentUI)，将windows自带的UI写为qml格式
聊天界面部分来自学长fdd开源项目[FluentChat](https://github.com/flwfdd/FluentChat?tab=readme-ov-file)。

# 使用方法

使用你的Qt Creator打文件下的cmakelist文件即可。
或者在主文件夹
```
cmake .
```
然后
```
make
```
生成可执行文件，在终端运行即可
# 配置方法
最外层的 cmakelists.txt 文件中的 `set(CMAKE_PREFIX_PATH "/home/shinku/Qt/6.6.3/gcc_64")` 改为自己的gcc_64路径即可

p.s. QT6其以上的cmake均可 

# TODO

这个项目里还有一些bug...