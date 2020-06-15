// * 使用Dismissible组件实现右滑删除
// * 它是根据Key来删除ListView中的某一项的
// * 请注意ListView.builder中itemBuilder: (context, index)传进的index
// * 它不是list中的下标，而是这个组件在当前屏幕上所占的位置

import 'package:flutter/material.dart';

class DismissibleWidget extends StatefulWidget {
  DismissibleWidget({Key key}) : super(key: key);

  @override
  createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget> {
  List<String> items = new List<String>.generate(30, (i) => "Item ${(i + 1)}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('侧滑删除'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),

            /// 组件消失后回调
            onDismissed: (direction) {
              var _snackStr;
              if (direction == DismissDirection.endToStart) {
                // 从右向左  也就是删除
                _snackStr = '删除了${items[index]}';
              } else if (direction == DismissDirection.startToEnd) {
                _snackStr = '收藏了${items[index]}';
              }

              /// 展示 SnackBar
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(_snackStr),
                duration: Duration(milliseconds: 400),
              ));

              /// 删除后刷新列表，以达到真正的删除
              setState(() {
                items.removeAt(index);
              });
            },

            ///组件大小改变的时长
            resizeDuration: const Duration(milliseconds: 300),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.fiber_manual_record,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.amber,
                  ),
                  title: Text('$item'),
                  subtitle: Text('Pull to refresh.\nSwipe to dismiss.'),
                  onTap: () {},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[200],
                ),
              ],
            ),

            /// 滑动时组件下一层显示的内容，没有设置secondaryBackground时，从右往左或者从左往右滑动都显示该内容，设置了secondaryBackground后，从左往右滑动显示该内容，从右往左滑动显示secondaryBackground的内容
            background: Container(
              color: Colors.orange,
              child: const ListTile(
                leading: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ),
              ),
            ),

            /// secondaryBackground不能单独设置，只能在已经设置了background后才能设置，从右往左滑动时显示
            secondaryBackground: Container(
              color: Colors.red,
              child: const ListTile(
                trailing: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),

            /// 使应用程序有机会是否决定dismiss。如果返回的future<bool>为true，则该小部件将被dismiss，否则它将被移回其原始位置。如果返回的future<bool>为false或空，则不会运行[onResize]和[onDismissed]回调。
            confirmDismiss: (direction) async {
              var _confirmContent;

              var _alertDialog;

              if (direction == DismissDirection.endToStart) {
                // 从右向左  也就是删除
                _confirmContent = '确认删除${items[index]}？';
                _alertDialog = _createDialog(
                  _confirmContent,
                  () {
                    // 展示 SnackBar
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('确认删除${items[index]}'),
                      duration: Duration(milliseconds: 400),
                    ));
                    Navigator.of(context).pop(true);
                  },
                  () {
                    // 展示 SnackBar
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('不删除${items[index]}'),
                      duration: Duration(milliseconds: 400),
                    ));
                    Navigator.of(context).pop(false);
                  },
                );
              } else if (direction == DismissDirection.startToEnd) {
                _confirmContent = '确认收藏${items[index]}？';
                _alertDialog = _createDialog(
                  _confirmContent,
                  () {
                    // 展示 SnackBar
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('确认收藏${items[index]}'),
                      duration: Duration(milliseconds: 400),
                    ));
                    Navigator.of(context).pop(true);
                  },
                  () {
                    // 展示 SnackBar
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('不收藏${items[index]}'),
                      duration: Duration(milliseconds: 400),
                    ));
                    Navigator.of(context).pop(false);
                  },
                );
              }

              var isDismiss = await showDialog(
                  context: context,
                  builder: (context) {
                    return _alertDialog;
                  });
              return isDismiss;
            },
          );
        },
        itemCount: items.length,
      ),
    );
  }

  Widget _createDialog(
      String _confirmContent, Function sureFunction, Function cancelFunction) {
    return AlertDialog(
      title: Text('Confirm'),
      content: Text(_confirmContent),
      actions: <Widget>[
        FlatButton(onPressed: sureFunction, child: Text('sure')),
        FlatButton(onPressed: cancelFunction, child: Text('cancel')),
      ],
    );
  }
}
