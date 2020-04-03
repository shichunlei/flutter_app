import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;

import 'package:flutter/services.dart';
import 'package:flutter_app/bean/music.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// 获取运行平台是Android还是IOS
  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => Platform.isIOS;

  /// 字符串转颜色
  ///
  /// [string] 字符串
  ///
  static Color strToColor(String string) {
    assert(string.length > 1);
    final int hash = string.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  /// 随机颜色
  ///
  static Color randomRGB() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }

  static Color randomARGB() {
    Random random = new Random();
    return Color.fromARGB(random.nextInt(180), random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
  }

  /// 生成随机串
  ///
  /// [len] 字符串长度
  ///
  static String randomString(int len) {
    String character = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < len; i++) {
      left = left + character[Random().nextInt(character.length)];
    }
    return left;
  }

  /// 屏幕宽
  ///
  static double get width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  /// RPX 用于屏幕适配（比例适配）
  ///
  static double get rpx {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width / 750;
  }

  /// 屏幕高
  ///
  static double get height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  /// 标题栏高度（包括状态栏）
  ///
  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  /// 状态栏高度
  ///
  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  /// 底部状态栏高度
  ///
  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 复制到剪粘板
  ///
  static copyToClipboard(String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  static const RollupSize_Units = ["GB", "MB", "KB", "B"];

  /// 返回文件大小字符串
  ///
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
            : AssetImage(imagePath));

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
            : AssetImage(imagePath));

    return paletteGenerator.darkMutedColor?.color ?? defaultColor;
  }

  static Future<Null> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// 校验邮箱
  ///
  static bool isEmail(String email) {
    if (email == null) return false;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(
      pattern,
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(email);
  }

  /// 校验金额
  ///
  static bool isAmount(String amount) {
    if (amount == null) return false;
    RegExp regex = RegExp(r'^\d+(\.\d+)?$');
    return regex.hasMatch(amount);
  }

  /// 校验密码
  ///
  bool validatePassword(String password) {
    if (password.length < 6 ||
        !password.contains(RegExp(r'[A-z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    return true;
  }

  /// 时间转字符串
  ///
  static String duration2String(Duration duration) {
    return duration?.toString()?.split('.')?.first ?? '0:00:00';
  }

  /// 16进制颜色值转换为10进制值
  ///
  /// [colorStr] 颜色值 #FFEE22
  /// [alpha] 透明度（16进制）
  ///
  static int getColorHexFromStr(String colorStr, {String alpha: "FF"}) {
    if (colorStr == null) {
      return 0;
    }
    colorStr = colorStr.replaceAll("#", "");
    if (colorStr.length == 6) {
      colorStr = alpha + colorStr;
    }
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  /// 隐藏键盘
  ///
  /// [context] 上下文
  ///
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 状态栏状态
  ///
  /// [enable] true为显示；false为隐藏
  ///
  static void statusBarEnable(bool enable) {
    SystemChrome.setEnabledSystemUIOverlays(
        enable ? SystemUiOverlay.values : []);
  }

  /// 是否是空字符串
  ///
  static bool isEmptyString(String str) {
    if (str == null || str.isEmpty) {
      return true;
    }
    return false;
  }

  /// 是否不是空字符串
  ///
  static bool isNotEmptyString(String str) {
    if (str != null && str.isNotEmpty) {
      return true;
    }
    return false;
  }

  /// 🔥格式化手机号为344
  ///
  static String formatMobile344(String mobile) {
    if (isEmptyString(mobile)) return '';
    mobile = mobile?.replaceAllMapped(new RegExp(r"(^\d{3}|\d{4}\B)"),
        (Match match) {
      return '${match.group(0)} ';
    });
    if (mobile != null && mobile.endsWith(' ')) {
      mobile = mobile.substring(0, mobile.length - 1);
    }
    return mobile;
  }

  static Future<void> readFont(String fontName, String path) async {
    var fontLoader = FontLoader(fontName);
    fontLoader.addFont(getCustomFont(path));
    await fontLoader.load();
  }

  static Future<ByteData> getCustomFont(String path) async {
    ByteData byteData = await rootBundle.load(path);
    return byteData;
  }

  /// 格式化歌词
  ///
  /// [lyricStr] 歌词
  ///
  static List<Lyric> formatLyric(String lyricStr) {
    if (lyricStr == null) {
      return [];
    }

    RegExp reg = RegExp(r"^\[\d{2}");

    /// 1. 首先根据\n 来切割字符串
    List<Lyric> result = lyricStr.split("\n").where(
      (r) {
        /// 2. 然后用正则挑选出所有带时间的行
        return reg.hasMatch(r);
      },
    ).map((s) {
      /// 3. 循环列表创建 Lyric 类，赋值当前文字和起始时间
      String time = s.substring(0, s.indexOf(']')); // => [00:00.10]
      String lyric = s.substring(s.indexOf(']') + 1);
      time = s.substring(1, time.length - 1); // => 00:00.10
      int hourSeparatorIndex = time.indexOf(":");
      int minuteSeparatorIndex = time.indexOf(".");
      return Lyric(
        lyric,
        startTime: Duration(
          minutes: int.parse(
            time.substring(0, hourSeparatorIndex),
          ),
          seconds: int.parse(
            time.substring(hourSeparatorIndex + 1, minuteSeparatorIndex),
          ),
          milliseconds: int.parse(
            time.substring(minuteSeparatorIndex + 1),
          ),
        ),
      );
    }).toList();

    /// 4. 最后再循环一次，把下一个的起始时间赋值到当前行的结束时间中
    for (int i = 0; i < result.length - 1; i++) {
      result[i].endTime = result[i + 1].startTime;
    }

    /// 5. 最后一句歌词没有结束时间（应该是音乐的最后时间）默认设为1:00:00.00
    result[result.length - 1].endTime = Duration(hours: 1);
    return result;
  }

  /// 查找歌词位置
  ///
  /// [curTime] 当前时间
  /// [lyrics] 歌词集合
  ///
  static int findLyricIndex(double curTime, List<Lyric> lyrics) {
    for (int i = 0; i < lyrics.length; i++) {
      if (curTime >= lyrics[i].startTime.inMilliseconds &&
          curTime <= lyrics[i].endTime.inMilliseconds) {
        return i;
      }
    }
    return 0;
  }
}
