import 'package:flutter/material.dart';
import 'package:flutter_app/youdao/index.dart';

import '../page_index.dart';
import 'provider_widget.dart';
import 'text_model.dart';

class TextPage extends StatefulWidget {
  TextPage({Key key}) : super(key: key);

  @override
  createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  TextModel model;

  @override
  void initState() {
    super.initState();

    model = TextModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.setContext(context);

    return Scaffold(
        appBar: AppBar(title: Text("测试 ProviderWidget")),
        body: ProviderWidget<TextModel>(
            model: model,
            showLoading: true,
            showEmpty: true,
            onModelReady: (model) {
              model.initData();
            },
            builder: (BuildContext context, TextModel model, Widget child) {
              return ListView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    AspectRatio(
                        aspectRatio: 118 / 36,
                        child: Swiper(
                            itemBuilder: (context, index) =>
                                ImageLoadView(model.banners[index]?.img),
                            itemCount: model.banners?.length,
                            autoplay: true,
                            onTap: (index) => pushNewPage(
                                context,
                                WebViewPage(
                                    url: model.banners[index]?.url,
                                    title: '${model.banners[index]?.title}')))),
                    Gaps.vGap3,
                    SectionView('热门课程',
                        hiddenMore: true,
                        child: ListView.builder(
                            itemBuilder: (context, index) => ItemCourse(
                                course: model.popularCourse[index],
                                onPressed: () => pushNewPage(
                                    context,
                                    WebViewPage(
                                        url:
                                        "https://ke.youdao.com/wap/course/detail/${model.popularCourse[index].id}",
                                        title:
                                        '${model.popularCourse[index]?.courseTitle}'))),
                            padding: EdgeInsets.only(top: 0),
                            itemCount: model.popularCourse.length > 4
                                ? 4
                                : model.popularCourse?.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false)),
                    Gaps.vGap3,
                    ListView.builder(
                        itemBuilder: (context, index) => ItemTagRecommendCourse(
                            bean: model.tagRecommendCourses[index]),
                        padding: EdgeInsets.only(top: 0),
                        itemCount: model.tagRecommendCourses?.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false)
                  ]);
            }));
  }
}
