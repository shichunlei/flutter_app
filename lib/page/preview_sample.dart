import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/preview.dart';

class PreviewSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Column(
        children: <Widget>[
          PreView(
            header: PreViewHeader(
              label: "label",
              value: "value",
            ),
            body: PreViewBody(
              children: [
                PreViewItem(
                  label: "sdsfsd",
                  value: "sdfsdfasd",
                ),
                PreViewItem(
                  label: "sdsfsd",
                  value: "sdfsdfasd",
                ),
                PreViewItem(
                  label: "sdsfsd",
                  value: "sdfsdfasd",
                ),
                PreViewItem(
                  label: "sdsfsd",
                  value: "sdfsdfasd",
                ),
              ],
            ),
            footer: PreViewFooter(
              children: [
                PreViewButton(
                  text: "sdsfs",
                ),
                PreViewButton(
                  text: "dsfsf",
                  primary: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
