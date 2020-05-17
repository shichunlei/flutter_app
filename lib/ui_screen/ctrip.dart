import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../page_index.dart';

class CtripHomePage extends StatefulWidget {
  const CtripHomePage({Key key}) : super(key: key);

  @override
  createState() => _CtripHomePageState();
}

class _CtripHomePageState extends State<CtripHomePage> {
  ScrollController controller = ScrollController();

  double navAlpha = 0;
  double headerHeight = 210;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      var offset = controller.offset;
      if (offset <= 0) {
        if (navAlpha != 0) setState(() => navAlpha = 0);
      } else if (offset < headerHeight && offset > 0) {
        navAlpha = 1 - (headerHeight - offset) / headerHeight;
        setState(() {});
      } else {
        setState(() => navAlpha = 1);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: controller,
            child: Column(children: [
              /// Banner
              Container(
                  height: headerHeight,
                  child: Swiper(
                      itemCount: bannerList.length,
                      autoplay: true,
                      pagination: SwiperCustomPagination(builder:
                          (BuildContext context, SwiperPluginConfig config) {
                        return Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.only(bottom: 20, right: 5),
                            child: DotsIndicator(
                                dotsCount: bannerList.length,
                                position: config.activeIndex,
                                reversed: false,
                                decorator: DotsDecorator(
                                    size: const Size.square(5.0),
                                    activeSize: const Size(15.0, 5.0),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)))));
                      }),
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                              onTap: () => pushNewPage(context,
                                  WebViewPage(url: bannerList[index]['url'])),
                              child:
                                  ImageLoadView(bannerList[index]['icon'])))),

              /// localNavList
              Transform.translate(
                  offset: Offset(0, -20),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white.withAlpha(220),
                      margin: EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child: Container(
                          height: 75,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) => _buildItem(
                                  context,
                                  localNavList[index]['url'],
                                  localNavList[index]['icon'],
                                  localNavList[index]['title']),
                              itemCount: localNavList.length)))),

              /// gridNav
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Container(
                    child: Column(children: [
                      /// hotel
                      Container(
                          height: 72,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xfffa5956),
                            Color(0xffF78550)
                          ])),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://pic.c-ctrip.com/platform/h5/home/grid-nav-items-hotel.png'))),
                                    child: Row(children: <Widget>[
                                      _buildGridItemView(context, '酒店',
                                          'https://m.ctrip.com/webapp/hotel/',
                                          alignment: Alignment.centerLeft),
                                      Container(
                                          width: 1,
                                          color: Colors.white,
                                          height: double.infinity),
                                      _buildGridItemView(context, '民宿·客栈',
                                          'https://m.ctrip.com/webapp/inn/index')
                                    ]))),
                            Container(
                                width: 1,
                                color: Colors.white,
                                height: double.infinity),
                            _buildGridItemView(context, '特价·爆款',
                                'https://m.ctrip.com/webapp/hotel/hotsale')
                          ])),

                      /// flight
                      Container(
                          margin: EdgeInsets.only(top: 1),
                          height: 72,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xff4b8fed),
                            Color(0xff53bced)
                          ])),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://pic.c-ctrip.com/platform/h5/home/grid-nav-items-flight.png'))),
                                    child: Row(children: <Widget>[
                                      _buildGridItemView(context, '机票',
                                          'https://m.ctrip.com/html5/flight/swift/index',
                                          alignment: Alignment.centerLeft),
                                      Container(
                                          width: 1,
                                          color: Colors.white,
                                          height: double.infinity),
                                      _buildGridItemView(context, '火车票',
                                          'https://m.ctrip.com/webapp/train/?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F#/index?VNK=4e431539'),
                                    ]))),
                            Container(
                                width: 1,
                                color: Colors.white,
                                height: double.infinity),
                            Expanded(
                              child: Row(children: <Widget>[
                                _buildGridItemView(context, '汽车·船票',
                                    'https://m.ctrip.com/html5/Trains/bus/'),
                                Container(
                                    width: 1,
                                    color: Colors.white,
                                    height: double.infinity),
                                _buildGridItemView(context, '专车·租车',
                                    'https://m.ctrip.com/webapp/car/index?s=ctrip&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F'),
                              ]),
                            )
                          ])),

                      /// travel
                      Container(
                          margin: EdgeInsets.only(top: 1),
                          height: 72,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xff34c2aa),
                            Color(0xff6cd557)
                          ])),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://pic.c-ctrip.com/platform/h5/home/grid-nav-items-travel.png'))),
                                    child: Row(children: <Widget>[
                                      _buildGridItemView(context, '旅游',
                                          'https://m.ctrip.com/webapp/vacations/tour/vacations',
                                          alignment: Alignment.centerLeft),
                                      Container(
                                          width: 1,
                                          color: Colors.white,
                                          height: double.infinity),
                                      _buildGridItemView(context, '高铁游',
                                          'https://m.ctrip.com/webapp/train/crh/plan/crhList.html?secondwakeup=true&dpclickjump=true&allianceid=4897&sid=155952&ouid=index&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F'),
                                    ]))),
                            Container(
                                width: 1,
                                color: Colors.white,
                                height: double.infinity),
                            Expanded(
                              child: Row(children: <Widget>[
                                _buildGridItemView(context, '游轮游',
                                    'https://m.ctrip.com/webapp/cruise/index'),
                                Container(
                                    width: 1,
                                    color: Colors.white,
                                    height: double.infinity),
                                _buildGridItemView(context, '定制游',
                                    'https://m.ctrip.com/webapp/dingzhi')
                              ]),
                            )
                          ]))
                    ]),
                  )),

              /// subNavList
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (_, index) => _buildItem(
                      context,
                      subNavList[index]['url'],
                      subNavList[index]['icon'],
                      subNavList[index]['title']),
                  itemCount: subNavList.length,
                  padding: EdgeInsets.all(14),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false),

              /// salesBox
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black12))),
                  child: Row(children: <Widget>[
                    ImageLoadView(
                        'https://www.devio.org/io/flutter_app/img/sales_box_huodong.png',
                        width: 79,
                        fit: BoxFit.fill,
                        height: 15),
                    Material(
                        child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffff4e63),
                                  Color(0xffff6cc9)
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 30,
                                    child: Text('获取更多福利 >',
                                        style: TextStyle(color: Colors.white)),
                                    alignment: Alignment.center),
                                onTap: () => pushNewPage(
                                    context,
                                    WebViewPage(
                                        url:
                                            "https://contents.ctrip.com/activitysetupapp/mkt/index/moreact?popup=close&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F&secondwakeup=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F")))))
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  height: 45),
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(children: <Widget>[
                    GestureDetector(
                        child: ImageLoadView(
                            'https://cdn.lishaoy.net/ctrip/yyfl.jpg',
                            height: (Utils.width - 28) / 2 * 431 / 621,
                            width: (Utils.width - 28) / 2),
                        onTap: () => pushNewPage(
                            context,
                            WebViewPage(
                                url:
                                    "https://m.ctrip.com/webapp/membercenter/medical?pushcode=sy_rm1020"))),
                    GestureDetector(
                        child: ImageLoadView(
                            'https://cdn.lishaoy.net/ctrip/bydlb.jpg',
                            height: (Utils.width - 28) / 2 * 431 / 621,
                            width: (Utils.width - 28) / 2),
                        onTap: () => pushNewPage(
                            context,
                            WebViewPage(
                                url:
                                    "https://contents.ctrip.com/activitysetupapp/mkt/index/2020qyhbmfl?popup=close&pushcode=nn2025")))
                  ])),
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(children: <Widget>[
                    GestureDetector(
                        child: ImageLoadView(
                            'https://cdn.lishaoy.net/ctrip/lxypth.png',
                            height: (Utils.width - 28) / 2 * 266 / 620,
                            width: (Utils.width - 28) / 2),
                        onTap: () => pushNewPage(
                            context,
                            WebViewPage(
                                url: "https://m.ctrip.com/webapp/mall/index"))),
                    GestureDetector(
                        child: ImageLoadView(
                            'https://cdn.lishaoy.net/ctrip/yqzx.jpg',
                            height: (Utils.width - 28) / 2 * 266 / 620,
                            width: (Utils.width - 28) / 2),
                        onTap: () => pushNewPage(
                            context,
                            WebViewPage(
                                url:
                                    "https://smarket.ctrip.com/webapp/promocode/add?source=5")))
                  ])),
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(children: <Widget>[
                    GestureDetector(
                        child: ImageLoadView(
                            'https://cdn.lishaoy.net/ctrip/yqbzzc.jpg',
                            height: (Utils.width - 28) / 2 * 266 / 620,
                            width: (Utils.width - 28) / 2),
                        onTap: () => pushNewPage(
                            context,
                            WebViewPage(
                                url:
                                    "https://contents.ctrip.com/activitysetupapp/mkt/index/end"))),
                    GestureDetector(
                        child: ImageLoadView(
                            'https://cdn.lishaoy.net/ctrip/jxtjmp.jpg',
                            height: (Utils.width - 28) / 2 * 266 / 620,
                            width: (Utils.width - 28) / 2),
                        onTap: () => pushNewPage(
                            context,
                            WebViewPage(
                                url:
                                    "https://m.ctrip.com/webapp/ticket/index")))
                  ]))
            ]),
          ),

          /// appBar
          Container(
              height: Utils.navigationBarHeight,
              child: Scaffold(
                  backgroundColor: Color.fromRGBO(255, 255, 255, navAlpha),
                  appBar: AppBar(
                      brightness: Brightness.light,
                      automaticallyImplyLeading: false,
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      title: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.grey[200]),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(50.0),
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(children: <Widget>[
                                    Icon(Icons.search, color: Colors.grey),
                                    Gaps.hGap5,
                                    Expanded(
                                        child: Text('目的地 | 酒店 | 景点 | 航班号',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16))),
                                    Icon(Icons.keyboard_voice,
                                        color: Colors.grey)
                                  ])))))))
        ]));
  }
}

Widget _buildItem(BuildContext context, String url, String icon, String title) {
  return Material(
      type: MaterialType.transparency,
      child: InkWell(
          onTap: () => pushNewPage(context, WebViewPage(url: url)),
          child: Container(
              width: (Utils.width - 28.0) / 5,
              child: Column(children: [
                ImageLoadView(icon, width: 40, height: 40),
                Text(title, style: TextStyle(fontSize: 12))
              ], mainAxisAlignment: MainAxisAlignment.center))));
}

Widget _buildGridItemView(BuildContext context, String title, String url,
    {AlignmentGeometry alignment: Alignment.center}) {
  return Expanded(
      child: Material(
          type: MaterialType.transparency,
          child: InkWell(
              onTap: () => pushNewPage(context, WebViewPage(url: url)),
              child: Container(
                  padding: alignment == Alignment.center
                      ? null
                      : EdgeInsets.symmetric(horizontal: 10),
                  alignment: alignment,
                  child: Text(title, style: TextStyle(color: Colors.white))))));
}

const List<Map<String, String>> bannerList = [
  {
    "icon": "https://dimg04.c-ctrip.com/images/zg0q1f000001gi7o2E129.jpg",
    "url":
        "https://contents.ctrip.com/activitysetupapp/mkt/index/huzhoumenp?ctm_ref=vdc_ctm_2931"
  },
  {
    "icon": "https://dimg04.c-ctrip.com/images/zg0r1f000001g93pa8043.jpg",
    "url":
        "https://m.ctrip.com/tangram/NjEzMA==?ctm_ref=vactang_page_6130&isHideNavBar=YES"
  },
  {
    "icon": "https://dimg04.c-ctrip.com/images/zg0n1e000001fh5i4F9D7.jpg",
    "url":
        "https://contents.ctrip.com/activitysetupapp/mkt/index/kaiyuanjingqu?popup=close?pushcode=yy2"
  },
  {
    "icon": "https://dimg04.c-ctrip.com/images/zg0p1e000001f50p101A5.jpg",
    "url":
        "https://contents.ctrip.com/activitysetupapp/mkt/index/hdsh?ctm_ref=vdc_ctm_2678"
  },
  {
    "icon": "https://dimg04.c-ctrip.com/images/zg0s1f000001grj7n1CFA.jpg",
    "url":
        "https://m.ctrip.com/tangram/NjE5MQ==?ctm_ref=vactang_page_6191&isHideNavBar=YES"
  },
  {
    "icon": "https://dimg04.c-ctrip.com/images/zg0q1f000001gi7o2E129.jpg",
    "url":
        "https://contents.ctrip.com/activitysetupapp/mkt/index/huzhoumenp?ctm_ref=vdc_ctm_2931"
  },
  {
    "icon": "https://dimg04.c-ctrip.com/images/zg0r1f000001g93pa8043.jpg",
    "url":
        "https://m.ctrip.com/tangram/NjEzMA==?ctm_ref=vactang_page_6130&isHideNavBar=YES"
  }
];

const List<Map<String, String>> localNavList = [
  {
    "icon": "https://cdn.lishaoy.net/ctrip/lbsguide.png",
    "title": "攻略·景点",
    "url":
        "https://m.ctrip.com/webapp/you/place/2.html?ishideheader=true&secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/piao.png",
    "title": "门票·玩乐",
    "url":
        "https://dp.ctrip.com/webapp/ticket/tickethttps://m.ctrip.com/webapp/ticket/ticket?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/food.png",
    "title": "美食林",
    "url":
        "https://m.ctrip.com/webapp/you/foods/address.html?new=1&ishideheader=true&secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/around.png",
    "title": "周边游",
    "url":
        "https://m.ctrip.com/webapp/vacations/tour/around?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/onedaytravel.png",
    "title": "一日游",
    "url":
        "https://m.ctrip.com/webapp/activity/daytour?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  }
];

const subNavList = [
  {
    "icon": "https://cdn.lishaoy.net/ctrip/freetravel.png",
    "title": "自由行",
    "url":
        "https://m.ctrip.com/webapp/vacations/idiytour/diyindex?navBarStyle=white&secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/wifi.png",
    "title": "WiFi电话卡",
    "url":
        "https://m.ctrip.com/webapp/activity/wifi?from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/visa.png",
    "title": "保险·签证",
    "url":
        "https://m.ctrip.com/visa/extend/entry?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/globalshop.png",
    "title": "换钞·购物",
    "url":
        "https://m.ctrip.com/webapp/fshome/crnweb/home.html?bid=2&cid=3&pid=3&ctm_ref=M_ps_1home_gg_mh&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/hpgsguild.png",
    "title": "当地向导",
    "url":
        "https://m.ctrip.com/webapp/vacations/pguider/homepage?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/flight.png",
    "title": "特价机票",
    "url":
        "https://m.ctrip.com/webapp/flightactivity/muse/index.html?secondwakeup=true&dpclickjump=true&from=https://m.ctrip.com/html5/&dCityCode=SHA&dCityName=%E4%B8%8A%E6%B5%B7&dCityType=1",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/card.png",
    "title": "礼品卡",
    "url":
        "https://m.ctrip.com/webapp/lipin/money?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/creditCard.png",
    "title": "申卡·借钱",
    "url":
        "https://jr.ctrip.com/m/finweb/page/financeCenter?lbtoken=_bav3D9S76biJnHr9UWccJmWTMJ6hmj18h83PeskjFXM34GK8j9k8T7nbFZyvtJZGgxWUmGLA8zYEPihDAj3wQtPFJFrgZL7kiY6HpnV8Z7XqQx25m4rAbLiEp&from=financeCenter&clientSource=CTRIP",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/yiriyou1.png",
    "title": "境外玩乐",
    "url": "https://dp.ctrip.com/webapp/activity/overseasindex",
  },
  {
    "icon": "https://cdn.lishaoy.net/ctrip/more.png",
    "title": "更多",
    "url":
        "https://m.ctrip.com/webapp/more/?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
  }
];
