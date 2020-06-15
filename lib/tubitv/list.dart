import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import 'details.dart';

class CategoryListPage extends StatefulWidget {
  final String category;
  final String title;
  final String topImage;

  CategoryListPage({Key key, this.category, this.title, this.topImage})
      : super(key: key);

  @override
  createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  int page = 1;
  int limit = 12;

  List<TuBiTV> list = [];

  bool isLoadComplete = false;

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getCategoryList(widget.category, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkTheme(
      child: Scaffold(
        body: LoaderContainer(
          contentView: EasyRefresh.custom(
            header: MaterialHeader(),
            footer: BallPulseFooter(),
            onRefresh: () async {
              page = 1;
              getCategoryList(widget.category, RefreshType.REFRESH);
            },
            onLoad: isLoadComplete
                ? null
                : () async {
                    page++;
                    getCategoryList(widget.category, RefreshType.LOAD_MORE);
                  },
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: Utils.width * 0.6,
                flexibleSpace: FlexibleSpaceBar(
                  background: AspectRatio(
                    aspectRatio: 0.6,
                    child: ImageLoadView(
                      '${widget.topImage}',
                    ),
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 5)),
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return InkWell(
                      child: Column(
                        children: <Widget>[
                          ImageLoadView(
                            '${list[index]?.posterarts?.first ?? ""}',
                            height: (Utils.width - 10) / 3 * 2 - 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Text('${list[index]?.title}',
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textWhite14),
                          )
                        ],
                      ),
                      onTap: () => pushNewPage(
                          context,
                          DetailsPage(
                            id: list[index]?.id,
                          )),
                    );
                  }, childCount: list.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5))
            ],
          ),
          loaderState: state,
        ),
      ),
    );
  }

  void getCategoryList(String category, RefreshType type) async {
    List<TuBiTV> _list = await ApiService.getTubiTVByCategory(
        category: category, page: page, limit: limit);

    if (type == RefreshType.REFRESH || type == RefreshType.DEFAULT) {
      isLoadComplete = false;
      list.clear();
    }

    if (_list.length < limit) {
      isLoadComplete = true;
      Toast.show(context, '就这些，没有更多了');
    }

    if (_list.length > 0) {
      list.addAll(_list);
    }

    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }
}
