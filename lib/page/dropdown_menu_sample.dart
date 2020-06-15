import 'package:flutter/material.dart';
import 'package:flutter_app/bean/condition.dart';
import 'package:flutter_app/movie/ui/filter_listview.dart';

import '../page_index.dart';

class DropDownSample extends StatefulWidget {
  DropDownSample({Key key}) : super(key: key);

  @override
  createState() => _DropDownSampleState();
}

class _DropDownSampleState extends State<DropDownSample> {
  List<String> _dropDownHeaderItemStrings = ['全城', '品牌', '价格低', '筛选'];

  Condition _selectBrandSortCondition;
  Condition _selectDistanceSortCondition;
  DropdownMenuController _dropdownMenuController = DropdownMenuController();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _selectBrandSortCondition = brandSortConditions?.first;

    _selectDistanceSortCondition = distanceSortConditions?.first;
  }

  @override
  void dispose() {
    _dropdownMenuController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0, title: Text('仿美团电影下拉筛选菜单')),
      backgroundColor: Colors.white,
      endDrawer: Container(
          margin: EdgeInsets.only(left: Utils.width / 4, top: 0),
          color: Colors.white),
      body: Stack(key: _stackKey, children: <Widget>[
        Column(children: <Widget>[
          // 下拉菜单头部
          DropDownHeader(
            // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
            items: [
              DropDownHeaderItem(_dropDownHeaderItemStrings?.first),
              DropDownHeaderItem(_dropDownHeaderItemStrings[1]),
              DropDownHeaderItem(_dropDownHeaderItemStrings[2]),
              DropDownHeaderItem(_dropDownHeaderItemStrings[3],
                  iconData: Icons.filter_frames, iconSize: 18),
            ],
            // DropDownHeader对应第一父级Stack的key
            stackKey: _stackKey,
            // controller用于控制menu的显示或隐藏
            controller: _dropdownMenuController,
            // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
            onItemTap: (index) {
              if (index == 3) {
                _scaffoldKey.currentState.openEndDrawer();
                _dropdownMenuController.hide();
              }
            },
            // 头部的高度
            height: 60,
            // 头部背景颜色
            //color: Theme.of(context).primaryColor,
            // 头部边框宽度
            //borderWidth: 1,
            // 头部边框颜色
            //borderColor: Color(0xFFeeede6),
            // 分割线高度
            //dividerHeight: 20,
            // 分割线颜色
            //dividerColor: Color(0xFFeeede6),
            // 文字样式
            //style: TextStyle(color: Color(0xFF666666), fontSize: 13),
            // 下拉时文字样式
            dropDownStyle: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
            // 图标大小
            //iconSize: 20,
            // 图标颜色
            //iconColor: Color(0xFFafada7),
            // 下拉时图标颜色
            //iconDropDownColor: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: ListView.separated(
                itemCount: 100,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(height: 1.0),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(leading: Text('test$index'), onTap: () {});
                }),
          ),
        ]),
        // 下拉菜单
        DropDownMenu(
            // controller用于控制menu的显示或隐藏
            controller: _dropdownMenuController,
            // 下拉菜单显示或隐藏动画时长
            animationMilliseconds: 500,
            // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
            menus: [
              DropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: _buildQuanChengWidget((selectValue) {
                    _dropDownHeaderItemStrings.first = selectValue;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
              DropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: FilterListView(
                      items: brandSortConditions,
                      itemOnTap: (value) {
                        _selectBrandSortCondition = value;
                        _dropDownHeaderItemStrings[1] =
                            _selectBrandSortCondition.title == '全部'
                                ? '品牌'
                                : _selectBrandSortCondition.title;
                        _dropdownMenuController.hide();
                        setState(() {});
                      })),
              DropdownMenuBuilder(
                  dropDownHeight: 60.0 * distanceSortConditions.length,
                  dropDownWidget: FilterListView(
                      items: distanceSortConditions,
                      itemOnTap: (value) {
                        _dropDownHeaderItemStrings[2] =
                            _selectDistanceSortCondition.title;
                        _selectDistanceSortCondition = value;
                        _dropdownMenuController.hide();
                        setState(() {});
                      })),
            ]),
      ]),
    );
  }

  int _selectTempFirstLevelIndex = 0;
  int _selectFirstLevelIndex = 0;

  int _selectSecondLevelIndex = -1;

  _buildQuanChengWidget(void itemOnTap(String selectValue)) {
//    List firstLevels = List<int>.filled(15, 0);
    List firstLevels = List<String>.generate(15, (int index) {
      if (index == 0) {
        return '全部';
      }
      return '$index区';
    });

    List secondLevels = List<String>.generate(15, (int index) {
      if (index == 0) {
        return '全部';
      }
      return '$_selectTempFirstLevelIndex$index街道办';
    });

    return Row(children: <Widget>[
      Expanded(
        child: ListView(
          children: firstLevels.map((item) {
            int index = firstLevels.indexOf(item);
            return GestureDetector(
              onTap: () {
                _selectTempFirstLevelIndex = index;

                if (_selectTempFirstLevelIndex == 0) {
                  itemOnTap('全城');
                  return;
                }
                setState(() {});
              },
              child: Container(
                  height: 60,
                  color: _selectTempFirstLevelIndex == index
                      ? Colors.grey[200]
                      : Colors.white,
                  alignment: Alignment.center,
                  child: _selectTempFirstLevelIndex == index
                      ? Text(
                          '$item',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Text('$item')),
            );
          }).toList(),
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.grey[200],
          child: _selectTempFirstLevelIndex == 0
              ? Container()
              : ListView(
                  children: secondLevels.map((item) {
                    int index = secondLevels.indexOf(item);
                    return GestureDetector(
                        onTap: () {
                          _selectSecondLevelIndex = index;
                          _selectFirstLevelIndex = _selectTempFirstLevelIndex;
                          if (_selectSecondLevelIndex == 0) {
                            itemOnTap(firstLevels[_selectFirstLevelIndex]);
                          } else {
                            itemOnTap(item);
                          }
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: _selectFirstLevelIndex ==
                                      _selectTempFirstLevelIndex &&
                                  _selectSecondLevelIndex == index
                              ? Text('$item',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor))
                              : Text('$item'),
                        ));
                  }).toList(),
                ),
        ),
      )
    ]);
  }
}
