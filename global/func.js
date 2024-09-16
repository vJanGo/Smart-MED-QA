// func.js

function parseStringToMap(inputString) {
    var map = {}; // 创建一个空对象来存储键值对

    // 按照自定义分隔符分隔字符串，得到键值对数组
    var pairs = inputString.split("<|EOC|>");
    console.log(pairs);

    // 遍历每个键值对
    for (var i = 0; i < pairs.length; i++) {
        // 按照自定义分隔符分隔每个键值对，得到键和值
        var keyValue = pairs[i].split("<|KVG|>");
        if (keyValue.length == 2) { // 确保分隔结果有键和值
            var key = keyValue[0].trim(); // 去除可能的多余空格
            var value = keyValue[1].trim();
            map[key] = value; // 将键值对存入对象
        }
    }

    return map; // 返回生成的对象
}

function encodeMapToString(map) {
    var encodedString = "";

    for (var key in map) {
        if (encodedString.length > 0) {
            encodedString += "<|EOC|>"; // 如果已经有内容，添加分隔符
        }
        encodedString += key + "<|KVG|>" + map[key]; // 添加键和值，并用自定义分隔符分隔
    }

    return encodedString; // 返回编码后的字符串
}

