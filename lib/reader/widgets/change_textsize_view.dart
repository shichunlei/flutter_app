import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';

class ChangeTextSizeView extends StatelessWidget {
  ChangeTextSizeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Store.connect<ReaderSettingModel>(builder:
        (BuildContext context, ReaderSettingModel snapshot, Widget child) {
      return Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Text('字    号', style: TextStyles.textGreyC14),
        Gaps.hGap20,
        Text('A-', style: TextStyle(color: Colors.white, fontSize: 22)),
        Expanded(
            child: Slider(
                onChanged: (double value) => snapshot.changeTextSize(value),
                label: '${snapshot.textSize}',
                value: snapshot.textSize,
                divisions: 40,
                min: Dimens.minFontSize,
                max: Dimens.maxFontSize,
                activeColor: readerMainColor)),
        Text('A+', style: TextStyle(color: Colors.white, fontSize: 22))
      ]);
    });
  }
}
