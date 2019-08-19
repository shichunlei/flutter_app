import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';
import '../index.dart';

class TagPage extends StatefulWidget {
  final int tagId;
  final String title;

  TagPage({Key key, this.title, this.tagId}) : super(key: key);

  @override
  createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  LoaderState _status = LoaderState.Loading;

  List<ColumnBean> columns = [];

  List<BannerBean> banners = [];

  List<SubTagBean> subTags = [];

  List<CoursesBean> courses = [];

  int lastRank = 0;

  bool isLoadComplete = false;

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('${widget.title}')),
        body: _bodyView(context));
  }

  Widget _bodyView(BuildContext context) {
    return LoaderContainer(
      loaderState: _status,
      contentView: EasyRefresh(
        refreshFooter: BallPulseFooter(
            key: _footerKey, color: Colors.red, backgroundColor: Colors.white),
        loadMore: isLoadComplete ? null : () async => loadMore(),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Container(
                height: Utils.width * 36 / 118,
                child: Swiper(
                    itemBuilder: (context, index) =>
                        ImageLoadView(banners[index].img),
                    itemCount: banners.length,
                    autoplay: true,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    pagination: SwiperPagination(),
                    onTap: (index) => pushNewPage(
                        context,
                        WebViewPage(
                            url: banners[index].url,
                            title: '${banners[index].title}')))),
            Gaps.vGap5,
            Container(
              child: SizedBox.fromSize(
                  size: Size.fromHeight(90),
                  child: ListView.builder(
                      itemBuilder: (context, index) => ItemTag(
                          title: subTags[index].name,
                          image: subTags[index].icon,
                          onTap: () {}),
                      padding: EdgeInsets.only(top: 0),
                      itemCount: subTags.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal)),
              color: Colors.white,
            ),
            ListView.builder(
                itemBuilder: (context, index) =>
                    ItemColumn(columnBean: columns[index]),
                padding: EdgeInsets.only(top: 0),
                itemCount: columns.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false),
            Gaps.vGap3,
            Container(
                color: Colors.white,
                child: Text('全部课程',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                alignment: Alignment.center,
                padding: EdgeInsets.all(20)),
            ListView.builder(
                itemBuilder: (context, index) => ItemCourse(
                    course: courses[index],
                    onPressed: () => pushNewPage(
                        context,
                        WebViewPage(
                            url:
                                "https://ke.youdao.com/wap/course/detail/${courses[index].id}",
                            title: '${courses[index].courseTitle}'))),
                padding: EdgeInsets.only(top: 0),
                itemCount: courses.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false),
            Offstage(
              offstage: !isLoadComplete,
              child: LineViewLine(
                  child: Text('没有更多了', style: TextStyle(color: Colors.grey)),
                  horizontalPadding: 80.0,
                  verticalPadding: 40),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    YouDaoData _data = await ApiService.getYouDaoGroupDetails(widget.tagId);

    columns = _data.column;
    banners = _data.banner;
    subTags = _data.subTag;
    courses.addAll(_data.courses);

    if (_data.courses.length < 20) {
      /// 加载完啦！
      isLoadComplete = true;
    }

    lastRank = courses.last.rank;

    _status = LoaderState.Succeed;

    setState(() {});
  }

  Future<void> loadMore() async {
    int t = DateTime.now().millisecondsSinceEpoch;
    List<CoursesBean> data =
        await ApiService.getYouDaoGroupCourseList(widget.tagId, lastRank, t);

    courses.addAll(data);
    if (data.length < 10) {
      /// 加载完啦！
      isLoadComplete = true;
    }

    lastRank = data.last.rank;

    setState(() {});
  }
}
