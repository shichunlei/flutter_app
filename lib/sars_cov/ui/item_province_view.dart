import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

import '../../page_index.dart';
import 'item_city_view.dart';

class ItemProvinceDataView extends StatefulWidget {
  const ItemProvinceDataView({
    Key key,
    @required this.province,
  }) : super(key: key);

  final Province province;

  @override
  createState() => _ItemProvinceDataViewState();
}

class _ItemProvinceDataViewState extends State<ItemProvinceDataView> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: InkWell(
                  onTap: () {
                    isShow = !isShow;
                    setState(() {});
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: Container(
                          child: Text('${widget.province?.provinceShortName}'),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Text('${widget.province?.currentConfirmedCount}'),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Text('${widget.province?.confirmedCount}'),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Text('${widget.province?.deadCount}'),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Text('${widget.province?.curedCount}'),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          color: Color(0xFFF7D7F7),
          height: 35,
        ),
        Container(
          height: 0.5,
          color: Colors.grey,
        ),
        AnimatedContainer(
          height: isShow ? widget.province.cities.length * 36.0 : 0.0,
          child: ListView.separated(
            itemBuilder: (_, index) =>
                ItemCityDataView(city: widget.province?.cities[index]),
            separatorBuilder: (BuildContext context, int index) => Gaps.vGap(1),
            itemCount: widget.province.cities.length,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
          ),
          duration: Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
