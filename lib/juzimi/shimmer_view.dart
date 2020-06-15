import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class ShimmerView extends StatelessWidget {
  ShimmerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Container(
                height: 180,
                width: Utils.width,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 25,
                      width: Utils.width - 100,
                      color: Colors.white,
                    ),
                    Gaps.vGap5,
                    Container(
                      height: 50,
                      width: Utils.width,
                      color: Colors.white,
                    ),
                    Gaps.vGap5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            Gaps.hGap8,
                            Container(
                              height: 20,
                              width: 80,
                              color: Colors.white,
                            )
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Gaps.vGap5,
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 2,
    );
  }
}
