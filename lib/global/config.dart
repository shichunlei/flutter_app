import 'package:flutter/material.dart';
import 'package:flutter_app/global/custom_icon.dart';

class Config {
  static final bool DEBUG = true;

  /// 和天气APPKEY
  static final String HE_WEATHER_KEY =
      // '2d2a76fac8324146a1b17b68bda42c76';
      "d6cfdce8193445ba894d889e7ab2de5b";

  /// 豆瓣电影appkey
  static final String DOUBAN_MOVIE_KEY = "0b2bdeda43b5688921839c8ecb20399b";

  static final String HOLIDAYS_API_KEY =
      // 'd0e77032a65c58a0ea07eddf508c31da4dd16f2e';
      // 'e3d29a00c8e79f50211cfd05e47f92c7c5735a5e';
      // '28395347787004033c45afe35e659151463fbae4f8acd3c7c874b59edbe812aa';
      // '1adf4a3e7f5fe650030caf52535da3bd697c3150';
      // '7fb42d57b3f2f2f5e9dce6d5abc8802c2c3350d2';
      // '40c1b39db558e1ca5d926c255e8454e6fcf4f38c';
      // 'c9c76abee7787da52647b74276aac02b303ccf30';
      'afbba6c2a5506d4d663f0ee8fd25ada775b39885';

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

enum RefreshType { DEFAULT, LOAD_MORE, REFRESH }

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
