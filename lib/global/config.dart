import 'package:flutter/material.dart';

class Config {
  static final bool DEBUG = true;

  static final String HE_WEATHER_KEY =
      // '2d2a76fac8324146a1b17b68bda42c76';
      "d6cfdce8193445ba894d889e7ab2de5b";

  static final String DOUBAN_MOVIE_KEY = "0b2bdeda43b5688921839c8ecb20399b";

  static final String COIN_MARKET_CAP_KEY =
      // '36e73e36-c202-4f0e-8f17-0190aa8a0705';
      // '00ca39a2-10a7-4617-8eef-897fa860bd8b';
      // 'e74a4062-7219-4143-89d9-6737066c65e0';
      // '36e73e36-c202-4f0e-8f17-0190aa8a0705';
      // '4f555a16-64b4-4ec2-87b7-cbf0a7179c71';
      // '27d1830b-1b35-46a4-810f-5d035a8cfb8e';
      // '90058ea6-90d3-400c-a31e-821ea817f70e';
      'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c';

  static const String DOUBAN_WEB_URL = 'https://movie.douban.com/';

  static const String MOVIE_BASE_URL = "https://api.douban.com/v2/movie";

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
