import 'package:permission_handler/permission_handler.dart';

class PermissionsUtil {
  /// 请求地图相关权限
  static Future<bool> requestMapPermission() async {
    final permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.location,
      PermissionGroup.storage,
      PermissionGroup.phone,
    ]);

    if (permissions.values.any((status) => status == PermissionStatus.denied)) {
      return false;
    } else {
      return true;
    }
  }

  /// 请求通讯录权限
  static Future<bool> requestContactsPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);

    if (permissions.values.any((status) => status == PermissionStatus.denied)) {
      return false;
    } else {
      return true;
    }
  }

  /// 请求相机权限
  static Future<bool> requestCameraPermission() async {
    final permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);

    if (permissions.values.any((status) => status == PermissionStatus.denied)) {
      return false;
    } else {
      return true;
    }
  }
}
