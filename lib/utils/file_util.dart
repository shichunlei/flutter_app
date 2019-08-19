import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  static FileUtil _instance;

  static FileUtil getInstance() {
    if (_instance == null) {
      _instance = FileUtil._internal();
    }
    return _instance;
  }

  FileUtil._internal();

  Future<String> getFolderPath(String folderPath) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String path = tempDir.path + folderPath;
    Directory directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return path;
  }

  void copyFile(String oldPath, String newPath) {
    File file = File(oldPath);
    if (file.existsSync()) {
      file.copy(newPath);
    }
  }

  Future<List<String>> getDirChildren(String path) async {
    Directory directory = Directory(path);
    final childrenDir = directory.listSync();
    List<String> pathList = [];
    for (var o in childrenDir) {
      final filename = o.path.split("/").last;
      if (filename.contains(".")) {
        pathList.add(o.path);
      }
    }
    return pathList;
  }

  /// assetPath 例子 'images/'
  /// assetName 例子 '1.jpg'
  /// filePath 例子:'/myFile/'
  /// name  例子 'girl.jpg'
  Future<String> copyAssetToFile(String assetPath, String assetName,
      String filePath, String fileName) async {
    String newPath = await getFolderPath(filePath);
    String name = fileName;
    bool exists = await File(newPath + name).exists();
    if (!exists) {
      var data = await rootBundle.load(assetPath + assetName);
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(newPath + name).writeAsBytes(bytes);
      return newPath + name;
    } else
      return newPath + name;
  }

  /// getLocalFile函数，获取本地文件目录文件
  Future<File> getLocalFile(String folderPath, String fileName) async {
    try {
      /// 获取应用目录// 获取本地文档目录 /// 文档目录，该目录用于存储只有自己可以访问的文件。只有当应用程序被卸载时，系统才会清除该目录。在iOS上，这对应于NSDocumentDirectory。在Android上，这是AppData目录。
      var appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path + folderPath;
      File file = File('$appDocPath/$fileName');
      if (file.existsSync()) {
        return file;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<String> getLocalPath() async {
    try {
      /// 获取应用目录// 获取本地文档目录 /// 文档目录，该目录用于存储只有自己可以访问的文件。只有当应用程序被卸载时，系统才会清除该目录。在iOS上，这对应于NSDocumentDirectory。在Android上，这是AppData目录。
      var appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path + '/';
      return appDocPath;
    } catch (err) {
      print(err);
      return null;
    }
  }

  /// getTempFile函数，获取本地临时目录文件
  Future<File> getTempFile(String folderPath, String fileName) async {
    try {
      /// 获取应用目录// 获取本地临时目录 /// 临时目录, 系统可随时清除的临时目录（缓存）。在iOS上，这对应于NSTemporaryDirectory() 返回的值。在Android上，这是getCacheDir()返回的值。
      var appDocDir = await getTemporaryDirectory();
      String tempDir = appDocDir.path + folderPath;
      File file = File('$tempDir/$fileName');
      if (!await file.exists()) {
        await file.create();
      }
      return file;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
