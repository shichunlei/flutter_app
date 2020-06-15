import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

import '../../page_index.dart';
import 'item_country_view.dart';

class ItemContinentDataView extends StatelessWidget {
  final Continent continent;

  ItemContinentDataView({Key key, this.continent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Container(
                  child: Text('${continent?.continentName}'),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Text('${continent?.currentConfirmedCount}'),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Text('${continent?.confirmedCount}'),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Text('${continent?.deadCount}'),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Text('${continent?.curedCount}'),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          color: Color(0xFFF7D7F7),
          height: 35,
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) =>
              ItemCountryDataView(country: continent?.country[index]),
          separatorBuilder: (BuildContext context, int index) => Gaps.vGap(1),
          itemCount: continent.country.length,
          shrinkWrap: true,
          primary: false,
        ),
      ],
    );
  }
}
