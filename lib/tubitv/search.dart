import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'details.dart';

class SearchListPage extends StatefulWidget {
  SearchListPage({Key key}) : super(key: key);

  @override
  createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  String key;

  List<TuBiTV> data = [];

  LoaderState state = LoaderState.NoAction;

  /// Should request these via the API.
  List<String> defaults = [
    "The Man",
    "Moby Dick",
    "Palm Swings",
    "Condo, The",
    "American Beach House",
    "Bikini Model Academy",
    "Blue My Mind",
    "Baby Fever",
    "All Out Dynfunktion!",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkTheme(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: TextEditingController(text: key),
              style: TextStyle(fontSize: 16, color: Colors.white),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: "Find movies, TV shows & more",
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              onSubmitted: (text) {
                this.key = text;
                setState(() {
                  state = LoaderState.Loading;
                });
                _searchAction(key: text);
              },
              onChanged: (text) {
                this.key = text;
                if (text.isEmpty) {
                  setState(() {});
                }
              },
            ),
          ),
        ),
        body: LoaderContainer(
            contentView: this.key == null || this.key.length == 0
                ? _buildDefaultList()
                : _buildResultList(),
            loaderState: state),
      ),
    );
  }

  _buildDefaultList() {
    return ListView.builder(
        itemCount: defaults.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                key = defaults[index];
                state = LoaderState.Loading;
              });
              _searchAction(key: defaults[index]);
            },
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  defaults[index],
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
          );
        },
        itemExtent: 50);
  }

  void _searchAction({String key}) async {
    Utils.hideKeyboard(context);
    data = await ApiService.getTubiTVSearchData(
        key: key,
        platform: Utils.isAndroid ? "android" : "iphone",
        deviceId: "11111");

    if (data.length == 0) {
      state = LoaderState.NoData;
    } else {
      state = LoaderState.Succeed;
    }

    setState(() {});
  }

  Widget _buildResultList() {
    return EasyRefresh.custom(
      slivers: <Widget>[
        SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return InkWell(
                child: Column(
                  children: <Widget>[
                    ImageLoadView(
                      '${data[index]?.posterarts?.first ?? ""}',
                      height: (Utils.width - 10) / 3 * 2 - 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: Text('${data[index]?.title}',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textWhite14),
                    )
                  ],
                ),
                onTap: () =>
                    pushNewPage(context, DetailsPage(id: data[index]?.id)),
              );
            }, childCount: data.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5))
      ],
    );
  }
}
