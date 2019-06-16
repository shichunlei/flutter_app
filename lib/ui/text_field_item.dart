import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../page_index.dart';

class TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final KeyboardActionsConfig config;
  final FocusNode nextFocusNode;
  final int maxLines;
  final int maxLength;

  const TextFieldItem(
      {Key key,
      this.controller,
      @required this.title,
      this.keyboardType: TextInputType.text,
      this.hintText: "",
      this.focusNode,
      this.nextFocusNode,
      this.config,
      this.maxLines: 1,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (config != null && Utils.isIOS) {
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, config);
    }
    return Container(
        height: maxLines == 1 ? 55.0 : maxLines * 55.0 * 0.75,
        margin: const EdgeInsets.only(left: 16.0, right: 16),
        width: double.infinity,
        child: Row(
            crossAxisAlignment: maxLines == 1
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(title, style: TextStyles.textDark14)),
              Expanded(
                  child: TextField(
                      maxLength: maxLength,
                      style: TextStyles.textDark14,
                      maxLines: maxLines,
                      focusNode: focusNode,
                      keyboardType: keyboardType,
                      inputFormatters: (keyboardType == TextInputType.number ||
                              keyboardType == TextInputType.phone)
                          ? [WhitelistingTextInputFormatter(RegExp("[0-9]"))]
                          : keyboardType ==
                                  TextInputType.numberWithOptions(decimal: true)
                              ? [UsNumberTextInputFormatter()]
                              : [BlacklistingTextInputFormatter(RegExp(""))],
                      controller: controller,
                      onEditingComplete: nextFocusNode == null
                          ? null
                          : () => FocusScope.of(context)
                              .requestFocus(nextFocusNode),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16.0),
                          hintText: hintText,
                          counterText: "",
                          border: InputBorder.none,
                          hintStyle: TextStyles.textGrayC14)))
            ]));
  }
}

/// 只允许输入小数
class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
        value != defaultDouble.toString() &&
        strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
