import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class BookStorePage extends StatefulWidget {
  BookStorePage({Key key}) : super(key: key);

  @override
  createState() => _BookStorePageState();
}

class _BookStorePageState extends State<BookStorePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Tab> tabs = [
    Tab(text: '推荐'),
    Tab(text: '男生'),
    Tab(text: '女生'),
    Tab(text: '出版')
  ];

  List<Books> banners = [];

  List<Books> maleBanners = [];

  List<Books> femaleBanners = [];

  List<Books> pressBanners = [];

  @override
  void initState() {
    super.initState();

    banners.add(Books(
        id: "5c74f4ff66579954e8efd4f2",
        cover:
            "http://plf-bucket.zhuishushenqi.com/management/images/20191016/028722b4ac2144e48d427db909b35875.jpg"));
    banners.add(Books(
        id: "59f8138d39d6e7d64d33d47a",
        cover:
            "http://plf-bucket.zhuishushenqi.com/management/images/20190820/e3a9f890cceb4a78892879384f166cd0.jpg"));
    banners.add(Books(
        id: "5ce1762bbeaa7fc65a989a57",
        cover:
            "http://plf-bucket.zhuishushenqi.com/management/images/20190820/c4fed54241b64dba8f1bfc7f7d5f5df1.jpg"));
    banners.add(Books(
        id: "5ad587778a326462d63c7db7",
        cover:
            "http://plf-bucket.zhuishushenqi.com/management/images/20190820/0f76924d79b041a8bf7c8121df6fe140.jpg"));

    maleBanners.add(Books(
        id: "565eb60d4e47b55a5ded7127",
        cover:
            'http://plf-bucket.zhuishushenqi.com/management/images/20191016/6a01d6a91a2843c79eac6645de03ee32.jpg'));
    maleBanners.add(Books(
        id: "5d52108e6762b24fd63128fb",
        cover:
            'http://plf-bucket.zhuishushenqi.com/management/images/20190819/f3a1e08ed70742e8aa191a2c3ab91682.jpg'));
    maleBanners.add(Books(
        id: "5a51fa450c9b1e4f62c4a947",
        cover:
            'http://plf-bucket.zhuishushenqi.com/management/images/20190816/4521cd23997c491993425f096972469e.jpg'));

    femaleBanners.add(Books(
        id: "5a6afc6e26dfa479c0f4c97d",
        cover:
            'http://plf-bucket.zhuishushenqi.com/management/images/20191016/028722b4ac2144e48d427db909b35875.jpg'));
    femaleBanners.add(Books(
        id: "5b20edb74a9e1d40912b84d6",
        cover:
            'http://plf-bucket.zhuishushenqi.com/management/images/20190827/91e3e77c67ea4f8ba51e412ca962f7e4.jpg'));
    femaleBanners.add(Books(
        id: "58513103052645e06d613e9f",
        cover:
            'http://plf-bucket.zhuishushenqi.com/management/images/20190816/e21b5828535642aaa7b3cd9c9896dc59.jpg'));
    femaleBanners.add(Books(
        id: "592a6ec76c47852176c89f48",
        cover:
            'http://plf-bucket.zhuishushenqi.com/management/images/20191016/e978d7592ba44df5a07f94b291501909.jpg'));

    pressBanners.add(Books(
        id: "59cdf6a3135b5c9843c2cc25",
        cover:
            "http://plf-bucket.zhuishushenqi.com/management/images/20190718/3f95918726994398bda126b882828850.jpg"));
    pressBanners.add(Books(
        id: "5760c6333bb2dc793c8e81d6",
        cover:
            "http://plf-bucket.zhuishushenqi.com/management/images/20191016/583be49f98de4918a47ecab618b0dac6.jpg"));

    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
                tabs: tabs,
                controller: _controller,
                indicatorColor: readerMainColor,
                labelColor: readerMainColor,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontSize: 16))),
        body: Column(
          children: <Widget>[
            buildSearchBar(context),
            Expanded(
              child: TabBarView(controller: _controller, children: [
                StoreBooksPage(
                    gender: 'male',
                    major: '仙侠',
                    hiddenHeader: false,
                    banners: banners),
                StoreBooksPage(
                    gender: 'male', major: '玄幻', banners: maleBanners),
                StoreBooksPage(
                    gender: 'female', major: '现代言情', banners: femaleBanners),
                StoreBooksPage(
                    gender: 'press', major: '出版小说', banners: pressBanners)
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Row(children: <Widget>[
          Expanded(
              child: InkWell(
                  onTap: () => pushNewPage(context, SearchPage()),
                  child: Container(
                      height: 35,
                      margin: EdgeInsets.only(
                          left: 10, top: 8, bottom: 8, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFFF5F5F5)),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(Icons.search, size: 18),
                          Text("   搜索本地及网络书籍", style: TextStyles.textGreyC14)
                        ],
                      )))),
          IconButton(
              icon: Icon(Icons.widgets, color: readerMainColor),
              onPressed: () {})
        ]));
  }
}
