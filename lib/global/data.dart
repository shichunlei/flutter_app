import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

import '../page_index.dart';

class ExpandStateBean {
  String title;
  IconData leading;
  List<SubExpandBean> children;

  ExpandStateBean({this.title, this.children, this.leading});

  static List<ExpandStateBean> expandStateList = [
    ExpandStateBean(
        leading: Icons.filter_1,
        title: 'Widgets Example',
        children: [
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
          SubExpandBean(
              'ValueListenableBuilder', ValueListenableBuilderWidget()),
        ]),
    ExpandStateBean(
        leading: Icons.filter_2,
        title: 'Layouts Example',
        children: [
          SubExpandBean('AppBar', AppBarWidget()),
          SubExpandBean('Dialog', DialogWidget()),
          SubExpandBean('Sliver 家族控件基本使用', SliverWidget()),
          SubExpandBean('Sliver NestedScrollView使用', SliverPage()),
          SubExpandBean('Sliver 高级用法', SliverDemo()),
          SubExpandBean(
              '拖拽排序 ReorderableListView', ReorderableListViewWidget()),
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
    ExpandStateBean(
        leading: Icons.filter_3,
        title: 'NavigationBar Example',
        children: [
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
    ExpandStateBean(
        leading: Icons.filter_4,
        title: 'Animation Example',
        children: [
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
    ExpandStateBean(
        leading: Icons.filter_5,
        title: 'Third Plugins Example',
        children: [
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
          // SubExpandBean('录音', SoundDemo()),
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
      // SubExpandBean('Flutter Sound', FlutterSoundPage()),
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
    ExpandStateBean(
        leading: Icons.filter_7,
        title: 'Projects Example',
        children: [
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
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613450026&di=b437fb833266185b71041924064bf9f4&imgtype=0&src=http%3A%2F%2Fimg.tupianzj.com%2Fuploads%2FBizhi%2Fmn1_1366.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613867578&di=135d97fcf172b3dfad616bd0bc4bd937&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2Fc%2F5847d25f3c545.jpg",
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613450029&di=ea64f2fe2964faa33933ba2de2288fc5&imgtype=0&src=http%3A%2F%2Fwww.wfuyu.com%2Fuploadfile%2Fcj%2F20141130%2Fcd70ec786aa669ee4d472073cf52c76a.jpg',
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613867558&di=a6ba548b68d33f4160456ef7a369f28a&imgtype=0&src=http%3A%2F%2Fim1.xpyle.cn%2Fcoll%2F202002%2FOT20200216165929594.jpg',
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613450028&di=0e37954f7cb7a904282c467a203ea0bd&imgtype=0&src=http%3A%2F%2Fwww.52qingyin.cn%2Fwp-content%2Fuploads%2F2013%2F09%2Fqingyoushuilian3.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2925061987,411404233&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4176017085,1014898947&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1151904050,4162194237&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=379622373,74041926&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3312451982,3816676872&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2313290898,4177083589&fm=26&gp=0.jpg",
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613450027&di=458499ec44ddb616a43a38ca49fa0aa3&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fc995d143ad4bd113cce8af145bafa40f4bfb05ea.jpg',
  'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2832342280,1019704477&fm=26&gp=0.jpg',
  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4024827225,1981202973&fm=26&gp=0.jpg',
  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2029082490,2363810538&fm=26&gp=0.jpg',
  'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2785384588,322545246&fm=26&gp=0.jpg',
  'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=384115025,2366469586&fm=26&gp=0.jpg',
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=556889999,3306363683&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4074334908,1434307869&fm=26&gp=0.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613450026&di=47516c55145db734d1c7f98bbca432ca&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ffaf2b2119313b07e8cce7a000dd7912397dd8c42.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3496053885,3190325716&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=322974403,2804872580&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2623563115,731719555&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1720211335,232769932&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3596808855,380159611&fm=26&gp=0.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613450026&di=62bca46fb7dd0daecb1e00ad5d05884a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F2%2F27%2F0308374988.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1459903101,4085466206&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1147935470,1225963007&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2306794792,159490749&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1623879114,795577895&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3509350334,2584391832&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3335334756,3364879534&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3649689340,3293497883&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4174052176,1211122446&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3351677703,1391797338&fm=26&gp=0.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601613819735&di=cf0ada3dc3cc52c95b80043176a8000b&imgtype=0&src=http%3A%2F%2Fimgservice.suning.cn%2Fuimg1%2Fb2c%2Fimage%2FBp7eHnnK8-1Bs-r233K9-Q.jpg",
];

var backgroundImage =
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=207405038,2990742581&fm=26&gp=0.jpg';

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
