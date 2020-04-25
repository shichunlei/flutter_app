import 'package:flutter/material.dart';
import '../index.dart';
import '../../page_index.dart';

class ItemCourse extends StatelessWidget {
  final CoursesBean course;
  final VoidCallback onPressed;

  ItemCourse({Key key, this.course, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 3),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${course.courseTitle}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                Gaps.vGap3,
                Text(
                    '${course.courseTime} | ${course.lessonNum.toInt() == course.lessonNum ? course.lessonNum.toInt() : course.lessonNum}课时',
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
                Row(
                    children: <Widget>[
                      Container(
                          width: 180,
                          child: GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(top: 0),
                              itemCount: course.teacherList.length > 3
                                  ? 3
                                  : course.teacherList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 0.8),
                              itemBuilder: (context, index) => Container(
                                  width: 45,
                                  child: Column(
                                      children: <Widget>[
                                        ImageLoadView(
                                            '${course.teacherList[index].imgUrl}',
                                            width: 45,
                                            height: 45,
                                            shape: BoxShape.circle),
                                        Text(
                                            '${course.teacherList[index].name}',
                                            maxLines: 1)
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.end)))),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Offstage(
                                      offstage:
                                          course.courseOriginalPrice == 0 ||
                                              course.courseSalePrice ==
                                                  course.courseOriginalPrice,
                                      child: Text(
                                          '￥${course.courseOriginalPrice}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.lineThrough))),
                                  Text(
                                      course.courseSalePrice == 0
                                          ? '免费'
                                          : '￥${course.courseSalePrice}',
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                ]),
                            Text('已有${course.courseSaleNum}人购买',
                                style: TextStyle(color: Colors.grey))
                          ])
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end)
              ],
            )),
        onTap: onPressed);
  }
}
