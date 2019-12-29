import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class MovieRangePage extends StatefulWidget {
  final int year;

  MovieRangePage({Key key, this.year}) : super(key: key);

  @override
  createState() => _MovieRangePageState();
}

class _MovieRangePageState extends State<MovieRangePage> {
  RangesData data;
  CoverBean cover;
  List<RangesBean> ranges = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getRangeData(widget.year);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        contentView: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ImageLoadView(
                        '${cover?.backgroundImg}',
                        width: Utils.width,
                        height: Utils.width / 3 * 4,
                      ),
                      ImageLoadView(
                        '${cover?.titleImg}',
                        height: 200.0,
                        width: 200.0,
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  '${cover?.title}',
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.5),
                itemBuilder: (_, index) => ItemRange(
                    year: widget.year.toString(),
                    info: ranges[index]?.info,
                    onPressed: () => pushNewPage(
                        context,
                        MovieRangeDetailPage(
                          year: widget.year.toString(),
                          cardColor: Color(Utils.getColorHexFromStr(
                              ranges[index]?.info?.primaryColorLight,
                              alpha: "af")),
                          topImage: ranges[index]?.info?.mobileBackgroundImg,
                          movies: ranges[index]?.subjects,
                          title: ranges[index]?.info?.title,
                          movie: ranges[index]?.info?.subject,
                        ))),
                itemCount: ranges.length,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ],
          ),
        ),
        loaderState: state,
      ),
    );
  }

  void getRangeData(int year) async {
    data = await ApiService.getMovieRanges(year);

    if (data != null) {
      cover = data.cover;
      ranges.addAll(data.ranges);
      state = LoaderState.Succeed;
    } else {
      state = LoaderState.Failed;
    }
    if (mounted) setState(() {});
  }
}
