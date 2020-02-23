import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

class ItemDataView extends StatelessWidget {
  final CitiesBean city;

  ItemDataView({Key key,@required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                '${city?.cityName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              alignment: Alignment.center,
              height: 20,
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                '${city?.confirmedCount}',
                style: TextStyle(color: Color(0xFFEE836C)),
              ),
              alignment: Alignment.center,
              height: 20,
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                '${city?.deadCount}',
                style: TextStyle(color: Color(0xFF164F81)),
              ),
              alignment: Alignment.center,
              height: 20,
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                '${city?.curedCount}',
              ),
              alignment: Alignment.center,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
