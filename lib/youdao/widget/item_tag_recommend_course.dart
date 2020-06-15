import 'package:flutter/material.dart';
import '../index.dart';

import '../../page_index.dart';

class ItemTagRecommendCourse extends StatelessWidget {
  final TagRecommendCoursesBean bean;

  ItemTagRecommendCourse({Key key, this.bean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SectionView(
                '${bean.tag.name}',
                onPressed: () => pushNewPage(
                    context, TagPage(title: bean.tag.name, tagId: bean.tag.id)),
                child: InkWell(
                    child: ImageLoadView('${bean.headImg}',
                        height: Utils.width * 320 / 678),
                    onTap: () => pushNewPage(
                        context,
                        WebViewPage(
                            url:
                                "https://ke.youdao.com/wap/course/detail/${bean.headCourseId}",
                            title: ''))),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ItemCourse(
                        course: bean.courses[index],
                        onPressed: () => pushNewPage(
                            context,
                            WebViewPage(
                                url:
                                    "https://ke.youdao.com/wap/course/detail/${bean.courses[index].id}",
                                title: '${bean.courses[index].courseTitle}')));
                  },
                  itemCount: bean.courses.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false)
            ],
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false));
  }
}
