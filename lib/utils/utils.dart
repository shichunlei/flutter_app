import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;

import 'package:flutter/services.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// 获取运行平台是Android还是IOS
  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => Platform.isIOS;

  /// 文字转颜色
  static Color strToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  /// 随机颜色
  static Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }

  /// 屏幕宽
  static double get width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  /// 屏幕高
  static double get height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 复制到剪粘板
  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  static const RollupSize_Units = ["GB", "MB", "KB", "B"];

  /// 返回文件大小字符串
  static String getRollupSize(int size) {
    int idx = 3;
    int r1 = 0;
    String result = "";
    while (idx >= 0) {
      int s1 = size % 1024;
      size = size >> 10;
      if (size == 0 || idx == 0) {
        r1 = (r1 * 100) ~/ 1024;
        if (r1 > 0) {
          if (r1 >= 10)
            result = "$s1.$r1${RollupSize_Units[idx]}";
          else
            result = "$s1.0$r1${RollupSize_Units[idx]}";
        } else
          result = s1.toString() + RollupSize_Units[idx];
        break;
      }
      r1 = s1;
      idx--;
    }
    return result;
  }

  static Future<Color> getImageLightVibrantColor(String imagePath,
      {Color defaultColor: Colors.white30, String type: "network"}) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(type == "network"
            ? NetworkImage(imagePath)
            : Image.asset(imagePath));

    return paletteGenerator.lightVibrantColor?.color ?? defaultColor;
  }

  static Future<Color> getImageDominantColor(String imagePath,
      {Color defaultColor: Colors.blueAccent, String type: "network"}) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(type == "network"
            ? NetworkImage(imagePath)
            : AssetImage(imagePath));

    return paletteGenerator.dominantColor?.color ?? defaultColor;
  }

  static Future<Color> getImageDarkMutedColor(String imagePath,
      {Color defaultColor: Colors.blueAccent, String type: "network"}) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(type == "network"
            ? NetworkImage(imagePath)
            : Image.asset(imagePath));

    return paletteGenerator.darkMutedColor?.color ?? defaultColor;
  }

  static Future<Null> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static bool isEmail(String email) {
    RegExp exp =
        RegExp("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$");
    return exp.hasMatch(email);
  }
}
