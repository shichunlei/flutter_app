import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

class ItemCityDataView extends StatelessWidget {
  final CitiesBean city;

  ItemCityDataView({Key key, this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(flex: 7,
            child: Container(
              child: Text(
                '${city?.cityName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              alignment: Alignment.center,
            ),
          ),
          Expanded(flex: 6,
            child: Container(
              child: Text('${city?.currentConfirmedCount}'),
              alignment: Alignment.center,
            ),
          ),
          Expanded(flex: 6,
            child: Container(
              child: Text('${city?.confirmedCount}'),
              alignment: Alignment.center,
            ),
          ),
          Expanded(flex: 5,
            child: Container(
              child: Text('${city?.deadCount}'),
              alignment: Alignment.center,
            ),
          ),
          Expanded(flex: 5,
            child: Container(
              child: Text('${city?.curedCount}'),
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
