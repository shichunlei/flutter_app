import 'package:flutter/material.dart';
import 'package:flutter_app/global/custom_icon.dart';

class Config {
  static final bool DEBUG = true;

  /// 高德地图APP_KEY
  static final String AMAP_KEY = "24d68b20bd23ec522658ddd98d3cd5b0";

  /// 和天气APP_KEY
  static final String HE_WEATHER_KEY =
      // '2d2a76fac8324146a1b17b68bda42c76';
      "d6cfdce8193445ba894d889e7ab2de5b";

  static final String READER_IMAGE_URL = 'http://statics.zhuishushenqi.com';
  static final String READER_CHAPTER_URL =
      'http://chapterup.zhuishushenqi.com/chapter/';

  /// 类型
  static const GenreList = [
    '剧情',
    '喜剧',
    '动作',
    '爱情',
    '科幻',
    '动画',
    '纪录片',
    '悬疑',
    '惊悚',
    '恐怖',
    '犯罪',
    '奇幻',
    '冒险',
    '灾难',
    '武侠',
    '音乐',
    '歌舞',
    '传记',
    '历史',
    '战争',
    '同性',
    '西部',
    '情色'
  ];

  /// 地区
  static const RegionList = [
    '中国大陆',
    '美国',
    '香港',
    '日本',
    '韩国',
    '台湾',
    '英国',
    '法国',
    '德国',
    '意大利',
    '西班牙',
    '印度',
    '泰国',
    '俄罗斯',
    '伊朗',
    '加拿大',
    '澳大利亚',
    '爱尔兰',
    '瑞典',
    '巴西',
    '丹麦'
  ];

  /// 特色
  static const FeatureList = [
    '经典',
    '青春',
    '治愈',
    '文艺',
    '女性',
    '小说改编',
    '超级英雄',
    '美食',
    '宗教',
    '励志',
    '魔幻',
    '黑帮',
    '感人'
  ];

  /// 年代
  static const YearList = [
    '2019',
    '2018',
    '2010年代',
    '2000年代',
    '90年代',
    '80年代',
    '70年代',
    '60年代',
    '更早'
  ];
}

/// 所有主题色列表
final List<Color> themeColors = [
  Colors.blue,
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.deepOrange,
  Colors.pink,
  Colors.purple,
  Colors.amber,
  Colors.teal,
  Colors.lightGreen,
  Colors.grey,
];

List<Map<String, dynamic>> orderTitles = [
  {'icon': Icons.all_inclusive, 'title': '全部'},
  {'icon': CustomIcon.no_payment, 'title': '待付款'},
  {'icon': CustomIcon.no_send, 'title': '待发货'},
  {'icon': CustomIcon.no_receive, 'title': '待收货'},
  {'icon': CustomIcon.comment, 'title': '待评价'}
];

/// 枚举: 支持的语言种类
enum SupportLocale {
  FOLLOW_SYSTEM,
  SIMPLIFIED_CHINESE,
  TRADITIONAL_CHINESE_TW,
  TRADITIONAL_CHINESE_HK,
  ENGLISH
}

/// SupportLocale -> locale
Map<SupportLocale, Locale> mapLocales = {
  SupportLocale.FOLLOW_SYSTEM: null,
  SupportLocale.SIMPLIFIED_CHINESE: Locale("zh", "CN"),
  SupportLocale.TRADITIONAL_CHINESE_TW: Locale("zh", "TW"),
  SupportLocale.TRADITIONAL_CHINESE_HK: Locale("zh", "HK"),
  SupportLocale.ENGLISH: Locale("en", "")
};

/// SupportLocale 对应的含义
Map<SupportLocale, String> get mapSupportLocale => {
      SupportLocale.FOLLOW_SYSTEM: "跟随系统",
      SupportLocale.SIMPLIFIED_CHINESE: "简体中文",
      SupportLocale.TRADITIONAL_CHINESE_TW: "繁體中文(臺灣)",
      SupportLocale.TRADITIONAL_CHINESE_HK: "繁體中文(香港)",
      SupportLocale.ENGLISH: "English"
    };
