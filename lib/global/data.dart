import 'package:flutter/material.dart';

import '../page_index.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/widget/sliver.dart';

class Doodle {
  final String name;
  final String time;
  final String content;
  final String doodle;
  final Color iconBackground;
  final Icon icon;

  const Doodle(
      {this.name,
      this.time,
      this.content,
      this.doodle,
      this.icon,
      this.iconBackground});

  static const List<Doodle> doodles = [
    Doodle(
        name: "Al-Sufi (Azophi)",
        time: "903 - 986",
        content:
            "One of Al-Sufi's greatest works involved fact-checking the Greek astronomer Ptolemy's measurements of the brightness and size of stars. In the year 964 AD, Al-Sufi published his findings in a book titled Kitab al-Kawatib al-Thabita al-Musawwar, or The Book of Fixed Stars. In many cases, he confirmed Ptolemy’s discoveries, but he also improved upon his work by illustrating the constellations and correcting some of Ptolemy’s observations about the brightness of stars.",
        doodle:
            "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4016383514,3614601022&fm=26&gp=0.jpg",
        icon: Icon(Icons.star, color: Colors.white),
        iconBackground: Colors.cyan),
    Doodle(
        name: "Abu al-Wafa’ al-Buzjani",
        time: "940 - 998",
        content:
            " Abu al-Wafa' is an innovator whose contributions to science include one of the first known introductions to negative numbers, and the development of the first quadrant, a tool used by astronomers to examine the sky. His pioneering work in spherical trigonometry was hugely influential for both mathematics and astronomy.",
        doodle:
            "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3789620214,3216522198&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.exposure,
          color: Colors.white,
        ),
        iconBackground: Colors.redAccent),
    Doodle(
        name: "Al-Hasan Ibn al-Haytham",
        time: "c. 965 - c. 1040",
        content:
            "Ibn al-Haytham was the first to explain through experimentation that vision occurs when light bounces on an object and then is directed to one's eyes. He was also an early proponent of the concept that a hypothesis must be proved by experiments based on confirmable procedures or mathematical evidence—hence understanding the scientific method five centuries before Renaissance scientists.",
        doodle:
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2536545892,2258796484&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.visibility,
          color: Colors.black87,
          size: 32.0,
        ),
        iconBackground: Colors.yellow),
    Doodle(
        name: "Al-Bīrūnī",
        time: "973 - 1050",
        content:
            "Biruni is regarded as one of the greatest scholars of the Golden Age of Muslim civilisation and was well versed in physics, mathematics, astronomy, and natural sciences, and also distinguished himself as a historian, chronologist and linguist. He studied almost all fields of science and was compensated for his research and strenuous work. Royalty and powerful members of society sought out Al-Biruni to conduct research and study to uncover certain findings.",
        doodle:
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2942458885,2161231393&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.account_balance,
          color: Colors.black87,
        ),
        iconBackground: Colors.amber),
    Doodle(
        name: "Ibn Sina (Avicenna)",
        time: "980 - 1037",
        content:
            "Avicenna (Ibn Sīnā) was a Persian polymath who is regarded as one of the most significant physicians, astronomers, thinkers and writers of the Islamic Golden Age. He has been described as the father of early modern medicine. Of the 450 works he is known to have written, around 240 have survived, including 150 on philosophy and 40 on medicine.\nHis most famous works are The Book of Healing, a philosophical and scientific encyclopedia, and The Canon of Medicine, a medical encyclopedia which became a standard medical text at many medieval universities and remained in use as late as 1650. In 1973, Avicenna's Canon Of Medicine was reprinted in  York.\nBesides philosophy and medicine, Avicenna's corpus includes writings on astronomy, alchemy, geography and geology, psychology, Islamic theology, logic, mathematics, physics and works of poetry.",
        doodle:
            "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2844749082,2312759693&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.healing,
          color: Colors.white,
        ),
        iconBackground: Colors.green),
    Doodle(
        name: "Ibn Rushd (Averroes)",
        time: "1126 - 1198",
        content:
            "Averroes was an Andalusian philosopher and thinker who wrote about many subjects, including philosophy, theology, medicine, astronomy, physics, Islamic jurisprudence and law, and linguistics. His philosophical works include numerous commentaries on Aristotle, for which he was known in the West as The Commentator. He also served as a judge and a court physician for the Almohad Caliphate.",
        doodle:
            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3213237648,2312067813&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.blur_circular,
          color: Colors.white,
        ),
        iconBackground: Colors.indigo),
    Doodle(
        name: "Nasir al-Din Tusi",
        time: "1201 - 1274",
        content:
            "Tusi was a Persian polymath, architect, philosopher, physician, scientist, and theologian. He is often considered the creator of trigonometry as a mathematical discipline in its own right. Ibn Khaldun (1332–1406) considered Al-Tusi to be the greatest of the later Persian scholars.",
        doodle:
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1817632637,3443052285&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.category,
          color: Colors.white,
        ),
        iconBackground: Colors.pinkAccent),
    Doodle(
        name: "Ibn Battuta",
        time: "1304 - 1368",
        content:
            "Over a period of thirty years, Ibn Battuta visited most of the Islamic world and many non-Muslim lands, including North Africa, the Horn of Africa, West Africa, the Middle East, Central Asia, Southeast Asia, South Asia and China. Near the end of his life, he dictated an account of his journeys, titled A Gift to Those Who Contemplate the Wonders of Cities and the Marvels of Travelling (Tuḥfat an-Nuẓẓār fī Gharāʾib al-Amṣār wa ʿAjāʾib al-Asfār), usually simply referred to as The Travels (Rihla). This account of his journeys provides a picture of a medieval civilisation that is still widely consulted today.",
        doodle:
            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=357307289,3261904920&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.navigation,
          color: Colors.white,
          size: 32.0,
        ),
        iconBackground: Colors.deepPurpleAccent),
    Doodle(
        name: "Ibn Khaldun",
        time: "1332 - 1406",
        content:
            "He is widely considered as a forerunner of the modern disciplines of historiography, sociology, economics, and demography.\nHe is best known for his book, the Muqaddimah or Prolegomena ('Introduction'). The book influenced 17th-century Ottoman historians like Kâtip Çelebi, Ahmed Cevdet Pasha and Mustafa Naima, who used the theories in the book to analyse the growth and decline of the Ottoman Empire. Also, 19th-century European scholars acknowledged the significance of the book and considered Ibn Khaldun to be one of the greatest philosophers of the Middle Ages.",
        doodle:
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4196133035,4167956900&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.supervised_user_circle,
          color: Colors.white,
        ),
        iconBackground: Colors.teal),
    Doodle(
        name: "Piri Reis",
        time: "1465 - 1553",
        content:
            "He is primarily known today for his maps and charts collected in his Kitab-ı Bahriye (Book of Navigation), a book that contains detailed information on navigation, as well as very accurate charts (for their time) describing the important ports and cities of the Mediterranean Sea. He gained fame as a cartographer when a small part of his first world map (prepared in 1513) was discovered in 1929 at the Topkapı Palace in Istanbul. His world map is the oldest known Turkish atlas showing the  World, and one of the oldest maps of America still in existence anywhere (the oldest known map of America that is still in existence is the map drawn by Juan de la Cosa in 1500). Piri Reis' map is centered on the Sahara at the latitude of the Tropic of Cancer.",
        doodle:
            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1843767238,1936795003&fm=26&gp=0.jpg",
        icon: Icon(
          Icons.map,
          color: Colors.white,
          size: 32.0,
        ),
        iconBackground: Colors.blue),
  ];
}

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
          SubExpandBean('TextField', TextFieldWidget()),
          SubExpandBean('Slider', SliderWidget()),
          SubExpandBean('Range Slider', RangeSliderPage()),
          SubExpandBean('Chip', ChipWidget()),
          SubExpandBean('CheckSwitch', CheckSwitchWidget()),
          SubExpandBean('主题', ThemeSample()),
          SubExpandBean('ColorFiltered', ColorFilteredWidget()),
          SubExpandBean('ScrollNotification', ScrollNotificationDemo()),
        ]),
    ExpandStateBean(
        leading: Icons.filter_2,
        title: 'Layouts Example',
        children: [
          SubExpandBean('AppBar', AppBarWidget()),
          SubExpandBean('Dialog', DialogWidget()),
          SubExpandBean('Sliver1', SliverWidget()),
          SubExpandBean('Sliver2', SliverPage()),
          SubExpandBean('Table', TablePage()),
          SubExpandBean('日期时间选择', DateTimePicker()),
          SubExpandBean('BottomSheet', BottomSheetWidget()),
          SubExpandBean('滑动删除', DismissibleWidget()),
          SubExpandBean('毛玻璃', FrostingWidget()),
          SubExpandBean('Stepper', StepperWidget()),
          SubExpandBean('AspectRatio', AspectRatioSample()),
          SubExpandBean('ButtonBar', ButtonBarDemo()),
          SubExpandBean('InheritedWidget', InheritedWidgetTestContainer()),
        ]),
    ExpandStateBean(
        leading: Icons.filter_3,
        title: 'NavigationBar Example',
        children: [
          SubExpandBean('TabBar', TabBarHomePage()),
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
          SubExpandBean('AnimatedIcons', AnimatedIconsDemo()),
          SubExpandBean('AnimatedPadding', AnimatedPaddingDemo()),
          SubExpandBean('AnimatedSize', AnimatedSizeDemo()),
          SubExpandBean('AnimatedAlign', AnimatedAlignDemo()),
          SubExpandBean('AnimatedPositioned', AnimatedPositionedDemo()),
          SubExpandBean('Tween', TweenDemo()),
          SubExpandBean('自定义动画', CustomAnimationDemo()),
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
          SubExpandBean('城市选择控件', CityPickerPage()),
          SubExpandBean('iOS风格城市选择控件', IosCityPickersPage()),
          SubExpandBean('fullpage风格城市选择控件', FullpageCityPickersPage()),
          SubExpandBean('设备信息', DeviceInfoPage()),
          SubExpandBean('二维码（生成/扫描）', QrImageWidget()),
          SubExpandBean('图表示例', ChartsWidget()),
          SubExpandBean('本地读取json数据', LoadingJsonPage()),
          SubExpandBean('侧滑菜单示例', InnerDrawerSample()),
          SubExpandBean('路由过渡动画', RouteSample()),
          SubExpandBean('DropDown', DropDownSample()),
          SubExpandBean('Image Colors', ImageColors()),
          SubExpandBean('尺子', RulerSample()),
          SubExpandBean('Preview', PreviewSample()),
          SubExpandBean('高德地图定位', AMapLocationDemo()),
          SubExpandBean('SecondFloor', SecondFloorDemo()),
          SubExpandBean('视差图片效果', ParallaxImageDemo()),
          SubExpandBean('骨架屏示例', ShimmerDemo()),
        ]),
    ExpandStateBean(leading: Icons.filter_6, title: 'UI Challenges', children: [
      SubExpandBean('登录页面1', PasswordLoginPage()),
      SubExpandBean('登录页面2', LogonPage()),
      SubExpandBean('登录页面3', SlidingLoginPage()),
      SubExpandBean('登录页面4', SignUpPage()),
      SubExpandBean('登录页面5', BottomSheetLoginPage()),
      SubExpandBean('登录页面6', OnboardingPage()),
      SubExpandBean('视频背景登录页面', LoginVideoPage()),
      SubExpandBean('Music Player', FluteMusicPlayerPage()),
      SubExpandBean('Audio Player', AudioPlayersPage()),
      SubExpandBean('Flutter Sound', FlutterSoundPage()),
      SubExpandBean('CardFlip', CardFlipPage()),
      SubExpandBean('仿抖音首页动画', TikTokPage()),
      SubExpandBean('BackDrop', BackDropPage()),
    ]),
    ExpandStateBean(
        leading: Icons.filter_7,
        title: 'Projects Example',
        children: [
          SubExpandBean('仿追书神器', BookReaderHomePage()),
          SubExpandBean('仿好奇心日报', QDailySplashPage()),
          SubExpandBean('豆瓣电影', MovieHomePage()),
          SubExpandBean('百姓生活+', IndexPage()),
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
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2918882617,1624283714&fm=26&gp=0.jpg",
  'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1694196096,1956817301&fm=26&gp=0.jpg',
  'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3473128871,1574804327&fm=26&gp=0.jpg',
  'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=422401622,3669771322&fm=26&gp=0.jpg',
  'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2832342280,1019704477&fm=26&gp=0.jpg',
  'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1759214474,1595279735&fm=26&gp=0.jpg',
  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4024827225,1981202973&fm=26&gp=0.jpg',
  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2029082490,2363810538&fm=26&gp=0.jpg',
  'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2785384588,322545246&fm=26&gp=0.jpg',
  'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=384115025,2366469586&fm=26&gp=0.jpg',
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=556889999,3306363683&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4074334908,1434307869&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2662785624,2609285852&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3182788030,321513843&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2925061987,411404233&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4176017085,1014898947&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1151904050,4162194237&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=379622373,74041926&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3312451982,3816676872&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2313290898,4177083589&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1114909265,4252356893&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3496053885,3190325716&fm=26&gp=0.jpg",
  "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=322974403,2804872580&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2623563115,731719555&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1720211335,232769932&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3596808855,380159611&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3624286312,3700724023&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1459903101,4085466206&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1147935470,1225963007&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2306794792,159490749&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1623879114,795577895&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3509350334,2584391832&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3335334756,3364879534&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3649689340,3293497883&fm=26&gp=0.jpg",
  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4174052176,1211122446&fm=26&gp=0.jpg",
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3351677703,1391797338&fm=26&gp=0.jpg",
];

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class LinearSales {
  final int time;
  final int sales;

  LinearSales(this.time, this.sales);
}

/// Sample linear data type.
class LinearSaless {
  final int year;
  final int yearLower;
  final int yearUpper;
  final int sales;
  final int salesLower;
  final int salesUpper;
  final double radius;

  LinearSaless(this.year, this.yearLower, this.yearUpper, this.sales,
      this.salesLower, this.salesUpper, this.radius);
}

class ChartFlutterBean {
  static List<charts.Series<TimeSeriesSales, DateTime>> createSampleData0() {
    final data = [
      TimeSeriesSales(DateTime(2017, 9, 19), 15),
      TimeSeriesSales(DateTime(2017, 9, 26), 25),
      TimeSeriesSales(DateTime(2017, 10, 9), 20),
      TimeSeriesSales(DateTime(2017, 10, 10), 75),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      ),
    ];
  }

  //饼状图
  static List<charts.Series<LinearSales, int>> createSampleData1() {
    final data = [
      LinearSales(0, 100),
      LinearSales(1, 75),
      LinearSales(2, 25),
      LinearSales(3, 5),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];

    //点
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSaless, int>> createSampleData3() {
    final data = [
      LinearSaless(10, 7, 10, 25, 20, 25, 5.0),
      LinearSaless(13, 11, 13, 225, 205, 225, 5.0),
      LinearSaless(34, 34, 24, 150, 150, 130, 5.0),
      LinearSaless(37, 37, 57, 10, 10, 12, 6.5),
      LinearSaless(45, 35, 45, 260, 300, 260, 8.0),
      LinearSaless(56, 46, 56, 200, 170, 200, 7.0),
    ];

    final maxMeasure = 300;

    return [
      charts.Series<LinearSaless, int>(
        id: 'Sales',
        // Providing a color function is optional.
        colorFn: (LinearSaless sales, _) {
          // Bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSaless sales, _) => sales.year,
        domainLowerBoundFn: (LinearSaless sales, _) => sales.yearLower,
        domainUpperBoundFn: (LinearSaless sales, _) => sales.yearUpper,
        measureFn: (LinearSaless sales, _) => sales.sales,
        measureLowerBoundFn: (LinearSaless sales, _) => sales.salesLower,
        measureUpperBoundFn: (LinearSaless sales, _) => sales.salesUpper,
        // Providing a radius function is optional.
        radiusPxFn: (LinearSaless sales, _) => sales.radius,
        data: data,
      )
    ];
  }

  //条形图：
  static List<charts.Series<OrdinalSales, String>> createSampleData() {
    final desktopSalesDataA = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    final tableSalesDataA = [
      OrdinalSales('2014', 25),
      OrdinalSales('2015', 50),
      OrdinalSales('2016', 10),
      OrdinalSales('2017', 20),
    ];

    final mobileSalesDataA = [
      OrdinalSales('2014', 10),
      OrdinalSales('2015', 15),
      OrdinalSales('2016', 50),
      OrdinalSales('2017', 45),
    ];

    final desktopSalesDataB = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    final tableSalesDataB = [
      OrdinalSales('2014', 25),
      OrdinalSales('2015', 50),
      OrdinalSales('2016', 10),
      OrdinalSales('2017', 20),
    ];

    final mobileSalesDataB = [
      OrdinalSales('2014', 10),
      OrdinalSales('2015', 15),
      OrdinalSales('2016', 50),
      OrdinalSales('2017', 45),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Desktop A',
        seriesCategory: 'A',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesDataA,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Tablet A',
        seriesCategory: 'A',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesDataA,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile A',
        seriesCategory: 'A',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesDataA,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Desktop B',
        seriesCategory: 'B',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesDataB,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Tablet B',
        seriesCategory: 'B',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesDataB,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile B',
        seriesCategory: 'B',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesDataB,
      ),
    ];
  }

  List<charts.Series<OrdinalSales, String>> getData() {
    final desktopSalesData = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    final tabletSalesData = [
      OrdinalSales('2014', 25),
      OrdinalSales('2015', 50),
      OrdinalSales('2016', 10),
      OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      OrdinalSales('2014', 10),
      OrdinalSales('2015', 15),
      OrdinalSales('2016', 50),
      OrdinalSales('2017', 45),
    ];

    final otherSalesData = [
      OrdinalSales('2014', 20),
      OrdinalSales('2015', 35),
      OrdinalSales('2016', 15),
      OrdinalSales('2017', 10),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Other',
        insideLabelStyleAccessorFn: (T, int) {
          return charts.TextStyleSpec(color: charts.Color.transparent);
        },
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
      ),
    ];
  }
}

var backgroundImage =
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1444433231,507640515&fm=11&gp=0.jpg';

String weatherBg(String condCode) {
  String bgImage = '';
  switch (condCode) {
    case '100':
    case '200':
    case '201':
    case '202':
    case '203':
    case '204':
    case '205':
    case '206':
    case '207':
    case '208':
    case '209':
    case '210':
    case '211':
    case '212':
    case '213':
    case '999':
      bgImage = 'images/weather_backgrounds/back_100d.jpg';
      break;
    case '101':
    case '102':
    case '103':
      bgImage = 'images/weather_backgrounds/back_101d.jpg';
      break;
    case '104':
      bgImage = 'images/weather_backgrounds/back_104d.jpg';
      break;
    case '300':
    case '301':
    case '305':
    case '306':
    case '307':
    case '308':
    case '309':
    case '310':
    case '311':
    case '312':
    case '313':
    case '314':
    case '315':
    case '316':
    case '317':
    case '318':
    case '399':
      bgImage = 'images/weather_backgrounds/back_300d.jpg';
      break;
    case '302':
    case '303':
    case '304':
      bgImage = 'images/weather_backgrounds/back_302d.jpg';
      break;
    case '400':
    case '401':
    case '402':
    case '403':
    case '404':
    case '405':
    case '406':
    case '407':
    case '408':
    case '409':
    case '410':
    case '499':
      bgImage = 'images/weather_backgrounds/back_400d.jpg';
      break;
    case '500':
    case '501':
    case '509':
    case '510':
    case '514':
    case '515':
      bgImage = 'images/weather_backgrounds/back_500d.jpg';
      break;
    case '502':
    case '511':
    case '512':
    case '513':
      bgImage = 'images/weather_backgrounds/back_502d.jpg';
      break;
    case '503':
    case '504':
    case '507':
    case '508':
      bgImage = 'images/weather_backgrounds/back_503d.jpg';
      break;
    case '900':
      bgImage = 'images/weather_backgrounds/back_900d.jpg';
      break;
    case '901':
      bgImage = 'images/weather_backgrounds/back_901d.jpg';
      break;
    default:
      bgImage = 'images/weather_backgrounds/back_100d.jpg';
      break;
  }
  return bgImage;
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

List<Map<String, dynamic>> musicBase = [
  {
    'name': '无归',
    'artists': '叶里',
    'url': 'https://music.163.com/song/media/outer/url?id=404465743.mp3',
    "img1v1Url":
        "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    'like': false
  },
  {
    'name': '扉をあけて',
    'artists': 'ANZA',
    'url': 'https://music.163.com/song/media/outer/url?id=555959.mp3',
    "img1v1Url":
        "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    'like': false
  },
  {
    'name': 'Past The Stargazing Season',
    'artists': 'Mili',
    'url': 'https://music.163.com/song/media/outer/url?id=29401202.mp3',
    "img1v1Url":
        "https://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    'like': false
  }
];
