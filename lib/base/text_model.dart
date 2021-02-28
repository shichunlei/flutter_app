import 'package:flutter_app/bean/index.dart';
import 'package:flutter_app/service/other_repository.dart';

import 'base_object_model.dart';

class TextModel extends BaseObjectModel<YouDaoData> {
  List<TagRecommendCoursesBean> tagRecommendCourses = [];
  List<BannerBean> banners = [];
  List<CoursesBean> popularCourse = [];
  List<DiscoverBean> discover = [];

  @override
  Future<YouDaoData> loadData() async {
    int t = DateTime.now().millisecondsSinceEpoch;

    return await OtherRepository.getYouDaoHomeHead(t);
  }

  @override
  onCompleted(YouDaoData data) {
    banners = data.head;
    popularCourse = data.popularCourse;
    tagRecommendCourses.addAll(data?.tagRecommendCourses);
    discover = data.discover;
  }
}
