import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

class ItemCountryDataView extends StatelessWidget {
  final CountryBean country;

  ItemCountryDataView({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              child: Text(
                '${country?.countryName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Text('${country?.currentConfirmedCount}'),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Text('${country?.confirmedCount}'),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Text('${country?.deadCount}'),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Text('${country?.curedCount}'),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
      color: Color(0xFFD7D7D7),
      height: 35,
    );
  }
}
