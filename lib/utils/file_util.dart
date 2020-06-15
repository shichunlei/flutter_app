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

  Future<bool> fileExists(String filePath) async {
    File file = File(filePath);
    if (await file.exists())
      return true;
    else
      return false;
  }

  /// 得到本地文件夹路径
  ///
  /// [folderPath] 文件夹
  /// [isTemp] 是否临时路径
  ///
  Future<String> getFolderPath(String folderPath, {bool isTemp: true}) async {
    String dir = isTemp ? await getTempPath() : await getLocalPath();
    String path = dir + folderPath;
    Directory directory = Directory(path);
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    return path;
  }

  /// 复制文件
  ///
  /// [fileName] 文件名称
  /// [oldPath] 原始路径
  /// [newPath] 新路径
  ///
  Future<String> copyFile(
      String fileName, String oldPath, String newPath) async {
    print("====old=======$oldPath$fileName");
    File file = File("$oldPath$fileName");
    if (await file.exists()) {
      print("====new=======$newPath$fileName");
      File newFile = await file.copy("$newPath$fileName");

      return newFile.path;
    } else {
      return null;
    }
  }

  /// 得到某路径下的所有文件列表
  ///
  /// [path] 要得到文件列表的路径
  /// [containsFolder] 是否包含文件夹
  ///
  Future<List<String>> getDirChildren(String path,
      {bool containsFolder: false}) async {
    Directory directory = Directory(path);
    final childrenDir = directory.listSync();
    List<String> pathList = [];
    for (var o in childrenDir) {
      final filename = o.path.split("/").last;

      if (containsFolder) {
        pathList.add(o.path);
      } else {
        if (filename.contains(".")) {
          pathList.add(o.path);
        }
      }
    }

    print(pathList.toString());

    return pathList;
  }

  /// 把项目资源文件夹下的文件复制到设备本地
  ///
  /// [assetPath] 项目资源文件夹 例子 'images/'
  /// [assetName] 资源文件名称 例子 '1.jpg'
  /// [folderName] 要复制的路径 例子:'/myFile/'
  /// [fileName] 复制后的文件名 例子 'girl.jpg'
  /// [isTemp] 是否本地临时路径
  ///
  Future<String> copyAssetFileToLocal(
      String assetPath, String assetName, String folderName, String fileName,
      {bool isTemp: true}) async {
    String folderPath = await getFolderPath(folderName, isTemp: isTemp);
    String name = fileName;
    bool exists = await File(folderPath + name).exists();
    if (!exists) {
      var data = await rootBundle.load(assetPath + assetName);
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(folderPath + name).writeAsBytes(bytes);
      return folderPath + name;
    } else
      return folderPath + name;
  }

  /// 获取本地文档根目录
  ///
  Future<String> getLocalPath() async {
    try {
      /// 文档目录，该目录用于存储只有自己可以访问的文件。只有当应用程序被卸载时，系统才会清除该目录。在iOS上，这对应于NSDocumentDirectory。在Android上，这是AppData目录。
      var appDocDir = await getApplicationDocumentsDirectory();
      return appDocDir.path + "/";
    } catch (err) {
      print(err);
      return null;
    }
  }

  /// 获取本地临时根目录
  ///
  Future<String> getTempPath() async {
    try {
      /// 临时目录, 系统可随时清除的临时目录（缓存）。在iOS上，这对应于NSTemporaryDirectory() 返回的值。在Android上，这是getCacheDir()返回的值。
      Directory tempDir = await getTemporaryDirectory();
      return tempDir.path + "/";
    } catch (err) {
      print(err);
      return null;
    }
  }

  /// 获取SD卡根目录，仅仅在Android平台可以使用
  ///
  Future<String> getSDCardPath() async {
    try {
      var sdDir = await getExternalStorageDirectory();
      return sdDir.path + "/";
    } catch (err) {
      print(err);
      return null;
    }
  }

  /// 获取目录文件
  ///
  /// [folderPath] 文件夹路径
  /// [fileName] 文件名
  /// [isTemp] 是否临时路径
  ///
  Future<File> getPathFile(String fileName,
      {String folderPath: '', bool isTemp: true}) async {
    try {
      String path = await getFolderPath(folderPath, isTemp: isTemp);
      File file = File('$path/$fileName');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      return file;
    } catch (err) {
      print(err);
      return null;
    }
  }

  /// 删除文件目录
  ///
  /// [folderPath] 要删除的文件目录
  ///
  Future<bool> deleteFolder(String folderPath) async {
    try {
      /// 文件的删除操作
      await Directory(folderPath)
          .delete(recursive: true)
          .then((FileSystemEntity fileSystemEntity) {
        print('删除path' + fileSystemEntity.path);
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// 删除文件
  ///
  /// [fileName] 要删除的文件
  ///
  Future<bool> deleteFile(String fileName) async {
    try {
      File file = File(fileName);
      if (file.existsSync()) {
        file.deleteSync();
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// 文件操作：写
  ///
  /// [data] 要写入的内容
  /// [fileName] 文件名称
  /// [folderPath] 文件路径
  /// [isTemp] 文件路径是否是临时路径
  ///
  Future<File> writeDataToFile(String fileName, String data,
      {String folderPath, bool isTemp: true}) async {
    try {
      File file =
          await getPathFile(fileName, folderPath: folderPath, isTemp: isTemp);

      file.writeAsStringSync(data);

      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// 文件操作：读
  ///
  /// [fileName] 文件名称
  /// [folderPath] 文件路径
  /// [isTemp] 文件路径是否是临时路径
  ///
  Future<String> readDataFromFile(String fileName,
      {String folderPath, bool isTemp: true}) async {
    try {
      File file =
          await getPathFile(fileName, folderPath: folderPath, isTemp: isTemp);

      String data = file.readAsStringSync();

      print(data);

      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// 文件操作：读
  ///
  /// [assetsName] 文件名称
  /// [assetsPath] 文件路径
  ///
  Future<String> readDataFromAssets(
      String assetsPath, String assetsName) async {
    String _data = await rootBundle
        .loadString(assetsPath + assetsName)
        .then((String data) {
      print(data);
      return data;
    });

    return _data;
  }
}
