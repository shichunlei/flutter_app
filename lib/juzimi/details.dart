import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_html/flutter_html.dart';

import 'tag_list.dart';

class JuZiMiDetails extends StatefulWidget {
  final String type;
  final int id;

  JuZiMiDetails({Key key, @required this.type, @required this.id})
      : super(key: key);

  @override
  createState() => _JuZiMiDetailsState();
}

class _JuZiMiDetailsState extends State<JuZiMiDetails> {
  JuZiMi juzimi;

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getDetails(widget.id, widget.type);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: ImageLoadView(
              'http://www.cnjxn.com/storage/2019/08/26/pEDsWrvnNU01QVuBQqIqQqc3TaZ8gQZjEFoopOpD.jpeg'),
          centerTitle: true,
        ),
        body: LoaderContainer(
            contentView: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${juzimi?.title}',
                    style: TextStyles.textBoldDark26,
                  ),
                  Gaps.vGap5,
                  Text(
                    '发表时间${juzimi?.time}',
                    style: TextStyles.textGrey14,
                  ),
                  Gaps.vGap5,
                  Text(
                    '来源：${juzimi?.source}',
                    style: TextStyles.textGrey14,
                  ),
                  Gaps.vGap5,
                  Text(
                    '阅读量：${juzimi?.readCount}',
                    style: TextStyles.textGrey14,
                  ),
                  Gaps.vGap5,
                  Line(
                    lineHeight: 1,
                    color: Colors.grey,
                  ),
                  Gaps.vGap5,
                  Html(
                      data: juzimi?.details,
                      defaultTextStyle: TextStyle(fontSize: 16),
                      padding: EdgeInsets.all(8.0),
                      blockSpacing: 2.0,
                      useRichText: true,
                      linkStyle: const TextStyle(
                          color: Colors.redAccent,
                          decorationColor: Colors.redAccent,
                          decoration: TextDecoration.underline),
                      onLinkTap: (url) {
                        debugPrint("Opening $url...");
                      }),
                  juzimi != null && juzimi.tags.length > 0
                      ? Wrap(
                          children: juzimi.tags.map((tag) {
                            return ActionChip(
                              label: Text('${tag.tag}'),
                              onPressed: () => pushNewPage(
                                  context,
                                  JuZiMiTagListPage(
                                    id: tag.id,
                                  )),
                            );
                          }).toList(),
                          spacing: 5,
                        )
                      : Container(),
                  Line(
                    lineHeight: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    child: Text(
                      '${juzimi?.copyright}',
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  Line(
                    lineHeight: 1,
                    color: Colors.grey,
                  ),
                  Gaps.vGap5,
                  Text('用户还喜欢'),
                  Gaps.vGap5,
                  juzimi != null && juzimi.userLikeTags.length > 0
                      ? Wrap(
                          spacing: 5,
                          children: juzimi.userLikeTags.map((tag) {
                            return ActionChip(
                              label: Text('${tag.tag}'),
                              onPressed: () => pushNewPage(
                                  context,
                                  JuZiMiTagListPage(
                                    id: tag.id,
                                  )),
                            );
                          }).toList(),
                        )
                      : Container(),
                  Gaps.vGap5,
                  Text('热门推荐'),
                  Gaps.vGap10,
                  juzimi != null
                      ? ListView.separated(
                          itemBuilder: (_, index) {
                            return Material(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _status = LoaderState.Loading;
                                  });

                                  getDetails(juzimi?.recommends[index]?.id,
                                      juzimi?.recommends[index]?.type);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${juzimi?.recommends[index]?.title}',
                                        style: TextStyles.textBoldDark14,
                                      ),
                                      Gaps.vGap5,
                                      Text('${juzimi?.recommends[index]?.time}')
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Line(
                            margin: EdgeInsets.symmetric(
                              vertical: 3,
                            ),
                          ),
                          itemCount: juzimi.recommends.length,
                          padding: EdgeInsets.zero,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        )
                      : SizedBox(),
                ],
              ),
            ),
            loaderState: _status),
      ),
    );
  }

  void getDetails(int id, String type) async {
    juzimi = await ApiService.getJuZiMiDetails(id, type);

    setState(() {
      _status = LoaderState.Succeed;
    });
  }
}
