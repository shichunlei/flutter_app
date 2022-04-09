import 'package:flutter/material.dart';
import 'dart:math' as math;

/// https://github.com/FlutterDance/movie

class MoveCard extends StatelessWidget {
  /// 动画过程偏移量
  final double offset;

  /// 电影模型
  final MovieBean movie;

  MoveCard({
    Key key,
    @required this.movie,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
        offset: Offset(-32 * gauss * offset.sign, 0),
        child: Card(
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Column(children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  child: Image.network('${movie.poster}',
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      alignment: Alignment(-offset.abs(), 0),
                      fit: BoxFit.cover)),
              SizedBox(height: 8),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text('${movie.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: 8),
                        Text('上映日期: ${movie.date}', style: TextStyle(color: Colors.grey)),
                        Text('${movie.intro}',
                            maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        Row(children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xFF162A49)),
                                  textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))),
                              child: Text('立即购买'),
                              onPressed: () {}),
                          Spacer(),
                          Text('￥${movie.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(width: 16)
                        ])
                      ])))
            ])));
  }
}

class SlidingContainerPage extends StatefulWidget {
  @override
  createState() => _SlidingContainerPageState();
}

class _SlidingContainerPageState extends State<SlidingContainerPage> {
  PageController pageController;
  double pageOffset = 0;

  List<MovieBean> movies = [
    MovieBean(
        name: '长津湖',
        intro:
            '电影以抗美援朝战争第二次战役中的长津湖战役为背景，讲述了一段波澜壮阔的历史：71年前，中国人民志愿军赴朝作战，在极寒严酷环境下，东线作战部队凭着钢铁意志和英勇无畏的战斗精神一路追击，奋勇杀敌，扭转了战场态势，打出了军威国威。',
        poster: 'https://img9.doubanio.com/view/photo/l/public/p2681329386.webp',
        date: '2021-09-30',
        price: '49.99'),
    MovieBean(
        name: '我和我的父辈',
        intro:
            '继2019年《我和我的祖国》、2020年《我和我的家乡》，国庆三部曲之《我和我的父辈》接棒定档2021年国庆。由吴京、章子怡、徐峥、沈腾导演，“中国电影追梦人”再次集结，以革命、建设、改革开放和新时代为历史坐标, 通过“家与国”的视角描写几代父辈的奋斗经历，讲述中国人的血脉相连和精神传承，再现中国人努力拼搏的时代记忆。',
        poster: 'https://img2.doubanio.com/view/photo/l/public/p2683055011.webp',
        date: '2021-09-30',
        price: '29.99'),
    MovieBean(
        name: '怒火・重案',
        intro: '重案组布网围剿国际毒枭，突然杀出一组蒙面悍匪“黑吃黑”，更冷血屠杀众警察。重案组督察张崇邦（甄子丹 饰）亲睹战友被杀，深入追查发现，悍匪首领竟是昔日战友邱刚敖（谢霆锋 饰）。',
        poster: 'https://img1.doubanio.com/view/photo/l/public/p2673412189.webp',
        date: '2021-07-30',
        price: '19.99'),
    MovieBean(
        name: '沙丘・Dune',
        intro: '电影《沙丘》为观众呈现了一段神秘而感人至深的英雄之旅。天赋异禀的少年保罗・厄崔迪被命运指引，为了保卫自己的家族和人民，决心前往'
            '浩瀚宇宙间最危险的星球，开启一场惊心动魄的冒险。与此同时，各路势力为了抢夺这颗星球上一种能够释放人类最大潜力的珍贵资源而纷纷加入战场。最终，唯有那些能够战胜内心恐惧的人才能生存下去。',
        poster: 'https://img9.doubanio.com/view/photo/l/public/p2687443734.webp',
        date: '2021-09-03',
        price: '29.99'),
    MovieBean(
        name: '速度与激情 9',
        intro:
            '“唐老大” 多姆・托莱多（范・迪塞尔 饰）与莱蒂（米歇尔・罗德里格兹 饰）和他的儿子小布莱恩，过上了远离纷扰的平静生活。然而他们也知道，安宁之下总潜藏着危机。这一次，为了保护他所爱的人，唐老大不得不直面过去。他和伙伴们面临的是一场足以引起世界动荡的阴谋，以及一个前所未遇的一流杀手和高能车手。而这个名叫雅各布（约翰・塞纳 饰）的人，恰巧是多姆遗落在外的亲弟弟。',
        poster: 'https://img9.doubanio.com/view/photo/l/public/p2640611704.webp',
        date: '2021-05-21',
        price: '9.99')
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.84);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('正在热播', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600))),
        body: Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: PageView(
                    controller: pageController,
                    children: List.generate(movies.length, (index) {
                      return MoveCard(movie: movies[index], offset: pageOffset - index);
                    })))));
  }
}

class MovieBean {
  /// 名称
  final String name;

  /// 简介
  final String intro;

  /// 海报图片
  final String poster;

  /// 上映日期
  final String date;

  /// 票价
  final String price;

  const MovieBean({
    @required this.name,
    @required this.intro,
    @required this.poster,
    @required this.date,
    @required this.price,
  });
}
