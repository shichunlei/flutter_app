import 'dart:convert' as convert;
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;

/// MD5加密
///
String generateMd5(String data) {
  var content = convert.Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

/// Base64加密
///
String base64Encode(String data) {
  if (data == null) throw ArgumentError("The argument is null");
  var content = convert.utf8.encode(data);
  var digest = convert.base64Encode(content);
  return digest;
}

/// Base64解密
///
String base64Decode(String data) {
  if (data == null) throw new ArgumentError("encodedString is null");
  List<int> bytes = convert.base64Decode(data);
// 网上找的很多都是String.fromCharCodes，这个中文会乱码
//String txt1 = String.fromCharCodes(bytes);
  String result = convert.utf8.decode(bytes);
  return result;
}

/// 通过图片路径将图片转换成Base64字符串
///
/// [path] 图片路径
///
Future image2Base64(String path) async {
  File file = new File(path);
  List<int> imageBytes = await file.readAsBytes();
  return convert.base64Encode(imageBytes);
}

/// 将图片文件转换成Base64字符串
///
/// [file] 图片文件
///
Future imageFile2Base64(File file) async {
  List<int> imageBytes = await file.readAsBytes();
  return convert.base64Encode(imageBytes);
}

/// 将Base64字符串的图片转换成图片
///
/// [base64Txt] Base64字符串
///
base642Image(String base64Txt) async {
  var decodeTxt = convert.base64.decode(base64Txt);
  return Image.memory(
    decodeTxt,
    width: 100, fit: BoxFit.fitWidth,
    gaplessPlayback: true, // 防止重绘
  );
}

/// aes加密 AES/CBC/NOPadding
///
/// [content] 待加密的内容
/// [strKey] 秘钥
///
String aesEncode(String content, String strKey) {
  try {
    final key = Key.fromUtf8(strKey);
    final encrypter =
        Encrypter(AES(key, mode: AESMode.cbc, padding: 'NOPadding'));
    final encrypted = encrypter.encrypt(content);
    return encrypted.base64;
  } catch (err) {
    print("aes encode error:$err");
    return content;
  }
}

/// aes解密 AES/CBC/NOPadding
///
/// [content] 待解密的内容
/// [strKey] 秘钥
///
dynamic aesDecode(dynamic base64, String strKey) {
  try {
    final key = Key.fromUtf8(strKey);
    final encrypter =
        Encrypter(AES(key, mode: AESMode.cbc, padding: 'NOPadding'));
    return encrypter.decrypt64(base64, iv: IV.fromUtf8(strKey));
  } catch (err) {
    print("aes decode error:$err");
    return base64;
  }
}
