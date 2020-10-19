import 'package:flutter/material.dart';

class DraggableGridPage extends StatefulWidget {
  @override
  createState() => DraggableGridPageState();
}

class DraggableGridPageState extends State<DraggableGridPage> {
  var mList = [
    '要闻',
    '推荐',
    '关注流',
    '24小时',
    '娱乐',
    '北京',
    '财经',
    '生活',
    '科技',
    '军事',
  ];
  var recList = [
    '体育',
    '汽车',
    '健康',
    '国际',
    '千里眼',
    '跑步',
    '时尚',
    '文化',
    '房产',
    '历史',
    '星座',
    '旅游',
    '教育',
    '美食',
    '母婴',
    '纪录片',
    '电竞',
    '励志',
    '独家',
    '明星',
    '电影',
    '政务',
    '数码',
    '游戏',
    '机器人',
    'NBA',
    '装修',
    '电视剧'
  ];
  var tempList = [];
  var isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dragable GridView')),
        body: ListView(children: <Widget>[
          _comTitleWid(false),
          _comGridView(mList),
          _comTitleWid(true),
          _comGridView(recList)
        ]));
  }

  _comTitleWid(isRec) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
        child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Text(isRec ? '更多栏目' : '我的栏目', style: TextStyle(fontSize: 16.0)),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(isRec ? '点击添加栏目' : '点击进入栏目',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey))),
              flex: 1),
          _titleRightWid(isRec)
        ]));
  }

  _titleRightWid(isRec) {
    if (isRec)
      return Container();
    else
      return GestureDetector(
          child: Container(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 14.0),
                  child: Text(!isEdit ? '编辑' : '完成',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.red))),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)))),
          onTap: () {
            setState(() => isEdit = !isEdit);
          });
  }

  _comGridView(list) {
    return Padding(
        padding: EdgeInsets.only(left: 14.0, right: 14.0),
        child: GridView.builder(
            physics: ScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 2.6),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: _itemDragableWidget(list, index),
                  onTap: () {
                    if (list == recList) {
                      final temp = list[index];
                      recList.remove(temp);
                      list.remove(temp);
                      mList.add(temp);
                      setState(() {});
                    } else if (isEdit) {
                      final temp = list[index];
                      mList.remove(temp);
                      list.remove(temp);
                      recList.add(temp);
                      setState(() {});
                    }
                  });
            }));
  }

  _itemClipWid(list, index, isFeedBack) {
    return Material(
        color: Colors.transparent,
        child: Container(
            width: (MediaQuery.of(context).size.width - 40) / 4,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: isFeedBack ? 8.0 : 4.0),
                child: Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    (isEdit && list == mList)
                        ? Icon(Icons.clear, size: 12.0, color: Colors.grey)
                        : Container(),
                    (list == recList)
                        ? Icon(Icons.add, size: 12.0, color: Colors.grey)
                        : Container(),
                    Text(list[index],
                        style: TextStyle(
                            color: isFeedBack ? Colors.red : Colors.black))
                  ]),
                )),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isFeedBack ? Colors.red : Colors.black54,
                    width: 0.5),
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(50.0)))));
  }

  _itemDragableWidget(list, index) {
    return Draggable(
        data: index,
        childWhenDragging: Container(),
        dragAnchor: DragAnchor.child,
        feedback: _itemClipWid(list, index, true),
        child: DragTarget(onWillAccept: (data) {
          print("Draggable onWillAccept data --> $data");
          _tempState(list);
          return list == mList && data != null;
        }, onAccept: (data) {
          print("Draggable onAccept data --> $data");
          if (list == mList &&
              tempList != null &&
              tempList.length == 2 &&
              tempList[0] == tempList[1]) {
            final temp = list[data];
            list.remove(temp);
            list.insert(index, temp);
            setState(() {});
          }
        }, onLeave: (data) {
          print("Draggable onLeave data --> $data");
        }, builder: (context, candidateData, rejectedData) {
          return _itemClipWid(list, index, false);
        }));
  }

  _tempState(list) {
    if (tempList != null) {
      if (tempList.length == 2) {
        tempList = [];
        tempList.add((list == mList) ? 0 : 1);
      } else if (tempList.length == 1) {
        tempList.add((list == mList) ? 0 : 1);
      } else {
        tempList.add((list == mList) ? 0 : 1);
      }
    } else {
      tempList = [];
      tempList.add((list == mList) ? 0 : 1);
    }
  }
}
