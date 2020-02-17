import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';

class ChangeTextSpaceView extends StatelessWidget {
  ChangeTextSpaceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Store.connect<ReaderSettingModel>(builder:
        (BuildContext context, ReaderSettingModel snapshot, Widget child) {
      return Row(children: <Widget>[
        Text('行间距', style: TextStyles.textGreyC14),
        Gaps.hGap20,
        Expanded(
          child: Row(children: <Widget>[
            Button(
                onPressed: snapshot.spaceValue <= Dimens.minSpace
                    ? null
                    : () => snapshot.spaceMinus(),
                child: Text("-", style: TextStyle(fontSize: 18)),
                height: 30,
                halfRadius: true,
                width: 60,
                color: readerMainColor,
                disabledColor: readerMainDisColor),
            Text('${snapshot.spaceValue.toDouble().toStringAsFixed(1)}',
                style: TextStyles.textWhite14),
            Button(
                onPressed: snapshot.spaceValue >= Dimens.maxSpace
                    ? null
                    : () => snapshot.spaceAdd(),
                child: Text("+", style: TextStyle(fontSize: 18)),
                height: 30,
                halfRadius: true,
                width: 60,
                color: readerMainColor,
                disabledColor: readerMainDisColor),
          ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
        )
      ]);
    });
  }
}
