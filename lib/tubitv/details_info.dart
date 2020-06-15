import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';

import '../page_index.dart';

class DetailsInfoView extends StatelessWidget {
  const DetailsInfoView({
    Key key,
    @required this.data,
  }) : super(key: key);

  final TuBiTV data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 179,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ImageLoadView(
                '${data?.posterarts?.first}',
                width: 125,
              ),
              Gaps.hGap8,
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('${data?.title ?? ""}',
                        style: TextStyles.textBoldWhile16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text("(${data?.year})",
                                      style: TextStyles.textWhite16),
                                  Text("${data?.durationStr ?? ''}",
                                      style: TextStyles.textWhite16),
                                ],
                              ),
                            ),
                            TagView(
                              tag: '${data?.ratings?.first?.value}',
                              padding: EdgeInsets.all(5.0),
                              textColor: Colors.white,
                            )
                          ],
                        ),
                        data != null
                            ? Wrap(
                                spacing: 5,
                                children: data.tags
                                    .map((_) => Chip(label: Text(_)))
                                    .toList(),
                              )
                            : SizedBox()
                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Button(
                    onPressed: () {},
                    child: Text('ADD TO QUEUE', style: TextStyle(fontSize: 18)),
                    color: Colors.white,
                    textColor: Color(0xff26262d),
                  ),
                  flex: 4),
              Gaps.hGap8,
              Expanded(
                  child: Button(
                    onPressed: () {},
                    child: Text('SHARE', style: TextStyle(fontSize: 18)),
                    buttonShape: ButtonShape.OUTLINE,
                    borderColor: Colors.white,
                  ),
                  flex: 2),
              Gaps.hGap8,
              Expanded(
                  child: Button(
                    onPressed: () {},
                    child: Text('...', style: TextStyle(fontSize: 16)),
                    buttonShape: ButtonShape.OUTLINE,
                    borderColor: Colors.white,
                  ),
                  flex: 1),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data?.description ?? "",
              style: TextStyle(color: Colors.white, fontSize: 20, height: 1.5)),
        ),
        Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('DIRECTOR', style: TextStyles.textBoldWhile16),
            ),
            Expanded(
              child: data == null
                  ? SizedBox()
                  : Wrap(
                      children: data.directors.map((text) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            text,
                            style: TextStyles.textWhite16,
                          ),
                        );
                      }).toList(),
                    ),
            )
          ],
        ),
        Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('STARRING', style: TextStyles.textBoldWhile16),
            ),
            Expanded(
              child: data == null
                  ? SizedBox()
                  : Wrap(
                      children: data.actors.map((text) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            text,
                            style: TextStyles.textWhite16,
                          ),
                        );
                      }).toList(),
                    ),
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
