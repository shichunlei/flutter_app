import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';
import '../index.dart';

class YouDaoHomePage extends StatefulWidget {
  YouDaoHomePage({Key key}) : super(key: key);

  @override
  createState() => _YouDaoHomePageState();
}

class _YouDaoHomePageState extends State<YouDaoHomePage> {
  List<TagRecommendCoursesBean> _tagRecommendCourses = [];
  List<BannerBean> banners = [];
  List<CoursesBean> popularCourse = [];
  List<DiscoverBean> discover = [];

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('有道精品课')),
        body: _bodyView());
  }

  Widget _bodyView() {
    return LoaderContainer(
      loaderState: _status,
      contentView: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          AspectRatio(
              aspectRatio: 118 / 36,
              child: Swiper(
                  itemBuilder: (context, index) =>
                      ImageLoadView(banners[index]?.img),
                  itemCount: banners?.length,
                  autoplay: true,
                  onTap: (index) => pushNewPage(
                      context,
                      WebViewPage(
                          url: banners[index]?.url,
                          title: '${banners[index]?.title}')))),
          Gaps.vGap3,
          SectionView(
            '热门课程',
            hiddenMore: true,
            child: ListView.builder(
                itemBuilder: (context, index) => ItemCourse(
                    course: popularCourse[index],
                    onPressed: () => pushNewPage(
                        context,
                        WebViewPage(
                            url:
                                "https://ke.youdao.com/wap/course/detail/${popularCourse[index].id}",
                            title: '${popularCourse[index]?.courseTitle}'))),
                padding: EdgeInsets.only(top: 0),
                itemCount: popularCourse.length > 4 ? 4 : popularCourse?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false),
          ),
          Gaps.vGap3,
//          SectionView(
//            '发现好课',
//            hiddenMore: true,
//            child: SizedBox.fromSize(
//                size: Size.fromHeight(Utils.width * 348 / 720),
//                child: ListView.builder(
//                    itemBuilder: (context, index) => ItemGoodCourse(
//                        discover: discover[index],
//                        onPressed: () => pushNewPage(
//                            context,
//                            WebViewPage(
//                                url: "${discover[index]?.url}",
//                                title: '${discover[index]?.title}'))),
//                    padding: EdgeInsets.only(top: 0),
//                    itemCount: discover?.length,
//                    physics: BouncingScrollPhysics(),
//                    scrollDirection: Axis.horizontal)),
//          ),
          ListView.builder(
              itemBuilder: (context, index) =>
                  ItemTagRecommendCourse(bean: _tagRecommendCourses[index]),
              padding: EdgeInsets.only(top: 0),
              itemCount: _tagRecommendCourses?.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false)
        ],
      ),
    );
  }

  void getHomeData() async {
    int t = DateTime.now().millisecondsSinceEpoch;
    await ApiService.getYouDaoHomeHead(t).then((data) async {
      YouDaoData _data = data;
      banners = data.head;
      popularCourse = data.popularCourse;
      _tagRecommendCourses.addAll(data?.tagRecommendCourses);
      discover = data.discover;

      if (_data?.popup != null) {
        showDialog<Null>(
            context: context,
            builder: (BuildContext context) =>
                AdDialog(image: _data?.popup?.img));
      }

      await ApiService.getYouDaoHomeTags(data?.tagRecommends, t).then((data) {
        _tagRecommendCourses.addAll(data.tagRecommendCourses);

        _status = LoaderState.Succeed;

        if (mounted) setState(() {});
      });
    });
  }
}
