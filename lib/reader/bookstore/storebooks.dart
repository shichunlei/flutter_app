import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';
import '../index.dart';

class StoreBooksPage extends StatefulWidget {
  final String major;
  final String gender;
  final List<Books> banners;
  final bool hiddenHeader;

  StoreBooksPage(
      {Key key, this.major, this.gender, this.banners, this.hiddenHeader: true})
      : super(key: key);

  @override
  createState() => _StoreBooksPageState();
}

class _StoreBooksPageState extends State<StoreBooksPage>
    with AutomaticKeepAliveClientMixin {
  List<Books> _books = [];

  LoaderState _status = LoaderState.Loading;

  @override
  bool get wantKeepAlive => true;

  bool isLoadComplete = false;

  int page = 0;
  int limit = 20;

  @override
  void initState() {
    super.initState();

    getBooksData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        loaderState: _status,
        contentView: EasyRefresh(
            onLoad: isLoadComplete ? null : () async => getBooksData(),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Offstage(
                    offstage: widget.hiddenHeader,
                    child: Row(children: <Widget>[
                      Expanded(
                          child: IconText(
                              text: '分类',
                              icon: Icon(Icons.dashboard,
                                  color: Colors.blueAccent),
                              onPressed: () {})),
                      Expanded(
                        child: IconText(
                            text: '排行',
                            icon: Icon(Icons.equalizer, color: Colors.green),
                            onPressed: () =>
                                pushNewPage(context, RankingsPage())),
                      ),
                      Expanded(
                        child: IconText(
                            text: '书单',
                            icon: Icon(Icons.insert_drive_file,
                                color: Colors.pinkAccent),
                            onPressed: () =>
                                pushNewPage(context, BookListPage())),
                      ),
                      Expanded(
                        child: IconText(
                            text: '漫画',
                            icon: Icon(Icons.photo, color: Colors.purple),
                            onPressed: () =>
                                pushNewPage(context, PicturePage())),
                      )
                    ])),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Swiper(
                        autoplay: widget.banners.length > 1,
                        itemBuilder: (_, index) =>
                            ImageLoadView(widget.banners[index].cover),
                        itemCount: widget.banners.length,
                        onTap: (index) => pushNewPage(
                            context,
                            BookDetailsPage(
                                id: widget.banners[index]?.id,
                                imageUrl: widget.banners[index]?.cover)),
                        pagination: SwiperCustomPagination(
                            builder: (BuildContext context,
                                    SwiperPluginConfig config) =>
                                Container(
                                    alignment: Alignment.bottomCenter,
                                    child: DotsIndicator(
                                        dotsCount: widget.banners.length,
                                        position: config.activeIndex,
                                        reversed: false,
                                        decorator: DotsDecorator(
                                            activeColor: readerMainColor,
                                            size: const Size.square(5.0),
                                            activeSize: const Size(10.0, 5.0),
                                            activeShape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        2.5))))))),
                    height: (Utils.width - 20) / 69 * 28 + 20),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemCount: _books.length,
                    itemBuilder: (_, int position) => ItemBook(
                        book: _books[position],
                        onPressed: () => pushNewPage(
                            context,
                            BookDetailsPage(
                                id: _books[position].id,
                                imageUrl: _books[position].cover))),
                    separatorBuilder: (BuildContext context, int index) =>
                        Gaps.vGap3)
              ]),
            )));
  }

  void getBooksData() async {
    List<Books> _list = await ApiService.getBookByCategories(
        widget.gender, widget.major,
        start: page * limit, limit: limit);

    if (_list.length < limit) {
      isLoadComplete = true;
    } else {
      page++;
    }

    _books.addAll(_list);
    _status = LoaderState.Succeed;
    if (mounted) {
      setState(() {});
    }
  }
}
