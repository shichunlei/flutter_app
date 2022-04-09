import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';
import '../youdao/page/home.dart';

class ExpandStateBean {
  String title;
  IconData leading;
  List<SubExpandBean> children;

  ExpandStateBean({this.title, this.children, this.leading});

  static List<ExpandStateBean> expandStateList = [
    ExpandStateBean(leading: Icons.filter_1, title: 'Widgets Example', children: [
      SubExpandBean('Text', TextWidget()),
      SubExpandBean('Button', ButtonWidget()),
      SubExpandBean('ToggleButtons', ToggleButtonsWidget()),
      SubExpandBean('Image', ImageWidget()),
      SubExpandBean('Icon', IconWidget()),
      SubExpandBean('TextField', TextFieldWidgetDemo()),
      SubExpandBean('全局悬浮按钮', FloatingTouchDemoPage()),
      SubExpandBean('Slider', SliderWidget()),
      SubExpandBean('Range Slider', RangeSliderPage()),
      SubExpandBean('Chip', ChipWidget()),
      SubExpandBean('CheckSwitch', CheckSwitchWidget()),
      SubExpandBean('主题', ThemeSample()),
      SubExpandBean('动态加载外部字体', FontLoaderPage()),
      SubExpandBean('ColorFiltered', ColorFilteredWidget()),
      SubExpandBean('ScrollNotification', ScrollNotificationDemo()),
      SubExpandBean('ValueListenableBuilder', ValueListenableBuilderWidget()),
    ]),
    ExpandStateBean(leading: Icons.filter_2, title: 'Layouts Example', children: [
      SubExpandBean('AppBar', AppBarWidget()),
      SubExpandBean('Dialog', DialogWidget()),
      SubExpandBean('Sliver 家族控件基本使用', SliverWidget()),
      SubExpandBean('Sliver NestedScrollView使用', SliverPage()),
      SubExpandBean('Sliver 高级用法', SliverDemo()),
      SubExpandBean('拖拽排序 ReorderableListView', ReorderableListViewWidget()),
      SubExpandBean('Table', TablePage()),
      SubExpandBean('日期时间选择', DateTimePicker()),
      SubExpandBean('BottomSheet', BottomSheetWidget()),
      SubExpandBean('滑动删除', DismissibleWidget()),
      SubExpandBean('自定义滑动删除', SlideMenuItemDemoPage()),
      SubExpandBean('毛玻璃', FrostingWidget()),
      SubExpandBean('Stepper', StepperWidget()),
      SubExpandBean('AspectRatio', AspectRatioSample()),
      SubExpandBean('ButtonBar', ButtonBarDemo()),
      SubExpandBean('InheritedWidget', InheritedWidgetTestContainer()),
      SubExpandBean('GridPaper', GridPaperWidget()),
      SubExpandBean('Draggable', DraggableWidget()),
      SubExpandBean('Draggable', DraggableGridPage()),
      SubExpandBean('键盘监听', KeyboardStatePage()),
    ]),
    ExpandStateBean(leading: Icons.filter_3, title: 'NavigationBar Example', children: [
      SubExpandBean('TabBar', TabBarHomePage()),
      SubExpandBean('TabBarDemo', TabBarDemoPage()),
      SubExpandBean('BottomNavigationBar', BottomNavigationBarHomePage()),
      SubExpandBean('NavigationBarShifting', NavigationBarShifting()),
      SubExpandBean('NavigationBarFixed', NavigationBarFixed()),
      SubExpandBean('BubbleBottomBar', BubbleBottomBarPage()),
      SubExpandBean('不规则底部导航栏', BottomAppbarSample()),
      SubExpandBean('FancyBottomNavigationBar', FancyBottomNavigationBar()),
      SubExpandBean('CurvedNavigationBar', CurvedNavigationBarSample()),
      SubExpandBean('CupertinoTabBar', CupertinoTabBarSample()),
      SubExpandBean('BottomBarView', BottomBarViewDemo()),
      SubExpandBean('Titled Bottom Bar', TitledNavigationBarDemo()),
    ]),
    ExpandStateBean(leading: Icons.filter_4, title: 'Animation Example', children: [
      SubExpandBean('Curves', CurvesDemo()),
      SubExpandBean('AnimatedContainer', AnimatedContainerDemo()),
      SubExpandBean('AnimatedOpacity', AnimatedOpacityDemo()),
      SubExpandBean('AnimatedSwitcher', AnimatedSwitcherSample()),
      SubExpandBean('AnimatedCrossFade', AnimatedCrossFadeDemo()),
      SubExpandBean('AnimatedBuilder', AnimatedBuilderDemo()),
      SubExpandBean('TweenAnimationBuilder', TweenAnimationBuilderDemo()),
      SubExpandBean('AnimatedIcons', AnimatedIconsDemo()),
      SubExpandBean('AnimatedPadding', AnimatedPaddingDemo()),
      SubExpandBean('AnimatedSize', AnimatedSizeDemo()),
      SubExpandBean('AnimatedAlign', AnimatedAlignDemo()),
      SubExpandBean('AnimatedPositioned', AnimatedPositionedDemo()),
      SubExpandBean('AnimatedPhysicalModel', AnimatedPhysicalModelDemo()),
      SubExpandBean('AnimatedNumber', AnimatedNumberDemo()),
      SubExpandBean('Tween', TweenDemo()),
      SubExpandBean('自定义动画', CustomAnimationDemo()),
      SubExpandBean('路由过渡动画', RouteSample()),
      SubExpandBean('AnimatedWear', AnimatedWearDemo()),
    ]),
    ExpandStateBean(leading: Icons.filter_5, title: 'Third Plugins Example', children: [
      SubExpandBean('Wave', WavePage()),
      SubExpandBean('Swiper', SwiperSample()),
      SubExpandBean('LikeButton', LikeButtonPage()),
      SubExpandBean('时间流', TimeLinePage()),
      SubExpandBean('LoadImage', LoadImageWidget()),
      SubExpandBean('RoundedLetter', RoundedLetterWidget()),
      SubExpandBean('Flipper', FlipperWidget()),
      SubExpandBean('FlipView Sample', FlutterFlipViewSample()),
      SubExpandBean('FlipView Custom', FlipViewCustom()),
      SubExpandBean('ContactPicker', ContactPickerWidget()),
      SubExpandBean('瀑布流示例', StaggeredViewPage()),
      SubExpandBean('评分控件', StarRatingWidget()),
      SubExpandBean('Clippy', ClippyWidget()),
      SubExpandBean('设备信息', DeviceInfoPage()),
      SubExpandBean('本地读取json数据', LoadingJsonPage()),
      SubExpandBean('侧滑菜单示例', InnerDrawerSample()),
      SubExpandBean('DropDown', DropDownSample()),
      SubExpandBean('Image Colors', ImageColors()),
      SubExpandBean('尺子', RulerSample()),
      SubExpandBean('尺子2', HorizontalPickerDemo()),
      SubExpandBean('SecondFloor', SecondFloorDemo()),
      SubExpandBean('视差图片效果', ParallaxImageDemo()),
      SubExpandBean('骨架屏示例', ShimmerDemo()),
      SubExpandBean('DragSortView', DragSortPage()),
      SubExpandBean('群头像', NineGridPage()),
    ]),
    ExpandStateBean(leading: Icons.filter_6, title: 'Beautiful UI', children: [
      SubExpandBean('携程首页', CtripHomePage()),
      SubExpandBean('Boarding Pass Cards', TicketFoldPage()),
      SubExpandBean('登录页面1', PasswordLoginPage()),
      SubExpandBean('登录页面2', LogonPage()),
      SubExpandBean('登录页面3', SlidingLoginPage()),
      SubExpandBean('登录页面4', SignUpPage()),
      SubExpandBean('登录页面5', BottomSheetLoginPage()),
      SubExpandBean('登录页面6', OnboardingPage()),
      SubExpandBean('登录页面7', LoginScreen()),
      SubExpandBean('Flare登录页面', FlareLoginPage()),
      SubExpandBean('视频背景登录页面', LoginVideoPage()),
      SubExpandBean('验证码验证登录', CodeInputViewPage()),
      SubExpandBean('Music Player', MusicPlayerPage()),
      SubExpandBean('Audio Player', AudioPlayersPage()),
      SubExpandBean('滚动视差效果', SlidingContainerPage()),
      SubExpandBean('CardFlip', CardFlipPage()),
      SubExpandBean('仿抖音首页动画', TikTokPage()),
      SubExpandBean('BackDrop', BackDropPage()),
      SubExpandBean('CardScroll', CardScrollDemo()),
      SubExpandBean('GuillotineMenu', GuillotineMenuPage()),
      SubExpandBean('BottomMenu', BottomMenuPage()),
      SubExpandBean('BankScreen', BankScreen()),
      SubExpandBean('BottomDrag', BottomDragWidgetDemo()),
      SubExpandBean('LightDrawer', LightDrawerPage()),
      SubExpandBean('ScrollHeader', ScrollHeaderDemoPage()),
      SubExpandBean('QRCode', QRCodePage()),
      SubExpandBean('个人中心', PersonalCenterPage()),
      SubExpandBean('可折叠的view', FoldablePage()),
      SubExpandBean('Movies Concept', MoviesConceptPage()),
      SubExpandBean('签名画板', DrawingBoardPage()),
    ]),
    ExpandStateBean(leading: Icons.filter_7, title: 'Projects Example', children: [
      SubExpandBean('战疫情', SARSCoVIndexPage()),
      SubExpandBean('仿追书神器', BookReaderHomePage()),
      SubExpandBean('仿好奇心日报', QDailySplashPage()),
      // SubExpandBean('豆瓣电影', MovieHomePage()),
      SubExpandBean('tubi TV', TubiTVHomePage()),
      SubExpandBean('NBA Sports', NBAHomePage()),
      SubExpandBean('百姓生活+', OnBoardingPage()),
      SubExpandBean('我是个句子迷', SplashPage()),
      SubExpandBean('有道精品课', YouDaoHomePage()),
      SubExpandBean('每日一文', OneArticlePage()),
      SubExpandBean('元素周期表', ElementsPage()),
      SubExpandBean('Question', QuizPage()),
      SubExpandBean('仿朋友圈', WeChatFriendsCircle()),
      SubExpandBean('MVP Demo', MvpHomePage()),
      SubExpandBean('Flutter 第一个Demo', RandomWords()),
    ]),
  ];
}

class SubExpandBean {
  String title;
  Widget page;

  SubExpandBean(this.title, this.page);
}

List<String> bannerImages = [
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F9e%2F39%2Fda%2F9e39da817ab6dfc54807f8ecf1794e6a.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635840620&t=485dfacbad22e33f9b267e528a2f52f8",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic.jj20.com%2Fup%2Fallimg%2Fmn01%2F041919145642%2F1Z419145642-7.jpg&refer=http%3A%2F%2Fpic.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635840620&t=ca1d9676f593a32f52c935137183f0dd",
  'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpuui.qpic.cn%2Fvpic%2F0%2Fe0824cmoq76.png%2F0&refer=http%3A%2F%2Fpuui.qpic.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635840812&t=4ef2489f36e5b47655c3ae04f33adcc8',
  'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1011%2F06201G00G1%2F1F620100G1-5-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635840812&t=19eac9e61fee232d74fd1ae0da49612c',
  "https://t7.baidu.com/it/u=3676218341,3686214618&fm=193&f=GIF",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2925061987,411404233&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4176017085,1014898947&fm=26&gp=0.jpg",
  "https://t7.baidu.com/it/u=3930750564,2979238085&fm=193&f=GIF",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=379622373,74041926&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3312451982,3816676872&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2313290898,4177083589&fm=26&gp=0.jpg",
  'https://t7.baidu.com/it/u=3522949495,3570538969&fm=193&f=GIF',
  'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2832342280,1019704477&fm=26&gp=0.jpg',
  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4024827225,1981202973&fm=26&gp=0.jpg',
  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2029082490,2363810538&fm=26&gp=0.jpg',
  'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2785384588,322545246&fm=26&gp=0.jpg',
  'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=384115025,2366469586&fm=26&gp=0.jpg',
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=556889999,3306363683&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4074334908,1434307869&fm=26&gp=0.jpg",
  "https://t7.baidu.com/it/u=2253011977,2934623845&fm=193&f=GIF",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3496053885,3190325716&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=322974403,2804872580&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2623563115,731719555&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1720211335,232769932&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3596808855,380159611&fm=26&gp=0.jpg",
  "https://t7.baidu.com/it/u=3038817810,32670274&fm=193&f=GIF",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1459903101,4085466206&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1147935470,1225963007&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2306794792,159490749&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1623879114,795577895&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3509350334,2584391832&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3335334756,3364879534&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3649689340,3293497883&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4174052176,1211122446&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3351677703,1391797338&fm=26&gp=0.jpg",
  "https://t7.baidu.com/it/u=2878377037,2986969897&fm=193&f=GIF",
];

var backgroundImage = 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=207405038,2990742581&fm=26&gp=0.jpg';

var douBanDefaultImage =
    "https://img1.doubanio.com/f/movie/ca527386eb8c4e325611e22dfcb04cc116d6b423/pics/movie/celebrity-default-small.png";

WeatherType weatherBg(String condCode) {
  WeatherType weatherType;
  switch (condCode) {
    case '100': // 晴（日间）
    case '999': // 未知
      weatherType = WeatherType.sunny;
      break;
    case '150': // 晴（夜间）
      weatherType = WeatherType.sunnyNight;
      break;
    case '153': // 晴间多云（夜间）
      break;
    case '154': // 阴（夜间）
      break;
    case '101': // 多云
    case '102': // 少云
    case '103': // 晴间多云（日间）
      weatherType = WeatherType.cloudy;
      break;
    case '104': // 阴（日间）
      weatherType = WeatherType.overcast;
      break;
    case '309': // 毛毛雨/细雨
    case '305': // 小雨
    case '314': // 小到中雨
    case '399': // 雨
      weatherType = WeatherType.lightRainy;
      break;
    case '306': // 中雨
    case '315': // 中到大雨
    case '350': // 阵雨（夜间）
    case '300': // 阵雨（日间）
      weatherType = WeatherType.middleRainy;
      break;
    case '307': // 大雨
    case '316': // 大到暴雨
    case '317': // 暴雨到大暴雨
    case '318': // 大暴雨到特大暴雨
    case '310': // 暴雨
    case '311': // 大暴雨
    case '312': // 特大暴雨
    case '301': // 强阵雨（日间）
    case '351': // 强阵雨（夜间）
    case '308': // 极端降雨
    case '313': // 冻雨
      weatherType = WeatherType.heavyRainy;
      break;
    case '302': // 雷阵雨
    case '303': // 强雷阵雨
    case '304': // 雷阵雨伴有冰雹
      weatherType = WeatherType.thunder;
      break;
    case '400': // 小雪
    case '408': // 小到中雪
    case '499': // 雪
      weatherType = WeatherType.lightSnow;
      break;
    case '401': // 中雪
    case '409': // 中到大雪
    case '407': // 阵雪（日间）
    case '457': // 阵雪（夜间）
      weatherType = WeatherType.middleSnow;
      break;
    case '402': // 大雪
    case '410': // 大到暴雪
    case '403': // 暴雪
      weatherType = WeatherType.heavySnow;
      break;
    case '404': // 雨夹雪
    case '405': // 雨雪天气
    case '406': // 阵雨夹雪（日间）
    case '456': // 阵雨夹雪（夜间）

      break;
    case '500': // 薄雾
    case '501': // 雾
    case '509': // 浓雾
    case '510': // 强浓雾
    case '514': // 大雾
    case '515': // 特强浓雾
      weatherType = WeatherType.foggy;
      break;
    case '502': // 霾
    case '511': // 中度霾
    case '512': // 重度霾
    case '513': // 严重霾
      weatherType = WeatherType.hazy;
      break;
    case '503': // 扬沙
    case '504': // 浮尘
    case '507': // 沙尘暴
    case '508': // 强沙尘暴
      weatherType = WeatherType.dusty;
      break;
    case '900': // 冷

      break;
    case '901': // 热

      break;
    default:
      weatherType = WeatherType.sunny;
      break;
  }
  return weatherType;
}

const List<String> QDailyKeys = <String>[
  "好莱坞",
  "亚马逊",
  "阿里巴巴",
  "音乐节",
  "特斯拉",
  "腾讯",
  "苹果",
  "海淘",
  "百度",
  "Google",
  "小米",
  "时尚",
  "迪士尼",
  "万达",
  "星巴克",
  "人工智能",
  "无人机",
  "华为",
  "MUJI",
  "宜家"
];

List<String> guideList = [
  "images/qdaily/bg_whatsnew_bg_1.jpg",
  "images/qdaily/bg_whatsnew_bg_2.jpg",
  "images/qdaily/bg_whatsnew_bg_3.jpg"
];

List<Widget> loadingWidgets = [
  SpinKitThreeBounce(color: Utils.strToColor('ThreeBounce'), size: 30.0),
  SpinKitCircle(color: Utils.strToColor('Circle')),
  SpinKitChasingDots(color: Utils.strToColor('ChasingDots')),
  SpinKitRotatingCircle(color: Utils.strToColor('RotatingCircle')),
  SpinKitRotatingPlain(color: Utils.strToColor('RotatingPlain')),
  SpinKitPumpingHeart(color: Utils.strToColor('PumpingHeart')),
  SpinKitPulse(color: Utils.strToColor('Pulse')),
  SpinKitDoubleBounce(color: Colors.grey),
  SpinKitWave(color: Colors.blue, type: SpinKitWaveType.start),
  SpinKitWave(color: Colors.red, type: SpinKitWaveType.center),
  SpinKitWave(color: Colors.pink, type: SpinKitWaveType.end),
  SpinKitWanderingCubes(color: Colors.teal),
  SpinKitWanderingCubes(color: Colors.lightBlue, shape: BoxShape.circle),
  SpinKitFadingFour(color: Colors.lightBlueAccent),
  SpinKitFadingFour(color: Colors.lightGreen, shape: BoxShape.rectangle),
  SpinKitFadingCube(color: Colors.lightGreenAccent),
  SpinKitCubeGrid(size: 51.0, color: Colors.lime),
  SpinKitFoldingCube(color: Colors.limeAccent),
  SpinKitRing(color: Colors.teal),
  SpinKitDualRing(color: Colors.tealAccent),
  SpinKitRipple(color: Colors.pinkAccent),
  SpinKitFadingGrid(color: Colors.pinkAccent),
  SpinKitFadingGrid(color: Colors.purple, shape: BoxShape.rectangle),
  SpinKitHourGlass(color: Colors.purpleAccent),
  SpinKitSpinningCircle(color: Colors.deepOrange),
  SpinKitSpinningCircle(color: Colors.deepPurple, shape: BoxShape.rectangle),
  SpinKitFadingCircle(color: Colors.deepPurpleAccent),
  CupertinoActivityIndicator(),
  CircularProgressIndicator(backgroundColor: Colors.greenAccent),
];

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
enum SupportLocale { FOLLOW_SYSTEM, SIMPLIFIED_CHINESE, TRADITIONAL_CHINESE_TW, TRADITIONAL_CHINESE_HK, ENGLISH }

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
