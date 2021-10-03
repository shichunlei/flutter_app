import 'package:permission_handler/permission_handler.dart';

class PermissionsUtil {
  /// 请求地图相关权限
  static Future<bool> requestMapPermission() async {
    return await checkPermissionStatus(Permission.location);
  }

  /// 请求通讯录权限
  static Future<bool> requestContactsPermission() async {
    return await checkPermissionStatus(Permission.contacts);
  }

  /// 请求相机权限
  static Future<bool> requestCameraPermission() async {
    return await checkPermissionStatus(Permission.camera);
  }

  /// 检查该权限的状态
  static Future<bool> checkPermissionStatus(Permission permission) async {
    /// 检查是否已有该权限
    bool status = await permission.isGranted;

    /// 判断如果还没拥有读写权限就申请获取权限
    if (!status) {
      return await requestPermission(permission);
    } else {
      return status;
    }
  }

  /// 注册权限
  static Future<bool> requestPermission(Permission permission) async {
    return await permission.request().isGranted;
  }
}
