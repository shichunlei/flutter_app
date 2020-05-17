import 'package:flutter/material.dart';

/// 1.创建一个model，用于保存当前的计数值
class InheritedTestModel {
  final int count;

  const InheritedTestModel(this.count);
}

/// 2.创建一个InheritedWidget
class InheritedContext extends InheritedWidget {
  // 数据
  final InheritedTestModel inheritedTestModel;

  // 点击+号的方法
  final Function() increment;

  // 点击-号的方法
  final Function() reduce;

  InheritedContext({
    Key key,
    @required this.inheritedTestModel,
    @required this.increment,
    @required this.reduce,
    @required Widget child,
  }) : super(key: key, child: child);

  static InheritedContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: InheritedContext);
  }

  // 是否重建widget就取决于数据是否相同
  @override
  bool updateShouldNotify(InheritedContext oldWidget) {
    return inheritedTestModel != oldWidget.inheritedTestModel;
  }
}

/// 3.把 "+" ,“-”, "value" 3个widget隔离
class TestWidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inheritedContext = InheritedContext.of(context);

    final inheritedTestModel = inheritedContext.inheritedTestModel;

    print('TestWidgetA 中count的值:  ${inheritedTestModel.count}');
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: RaisedButton(
          textColor: Colors.black,
          child: Text('+'),
          onPressed: inheritedContext.increment),
    );
  }
}

class TestWidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inheritedContext = InheritedContext.of(context);

    final inheritedTestModel = inheritedContext.inheritedTestModel;

    print('TestWidgetB 中count的值:  ${inheritedTestModel.count}');

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: Text(
        '当前count:${inheritedTestModel.count}',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

class TestWidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inheritedContext = InheritedContext.of(context);

    final inheritedTestModel = inheritedContext.inheritedTestModel;

    print('TestWidgetC 中count的值:  ${inheritedTestModel.count}');

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: RaisedButton(
          textColor: Colors.black,
          child: Text('-'),
          onPressed: inheritedContext.reduce),
    );
  }
}

/// 4.组合
class InheritedWidgetTestContainer extends StatefulWidget {
  @override
  createState() => _InheritedWidgetTestContainerState();
}

class _InheritedWidgetTestContainerState
    extends State<InheritedWidgetTestContainer> {
  InheritedTestModel inheritedTestModel;

  _initData() {
    inheritedTestModel = InheritedTestModel(0);
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _incrementCount() {
    setState(() {
      inheritedTestModel = InheritedTestModel(inheritedTestModel.count + 1);
    });
  }

  _reduceCount() {
    setState(() {
      inheritedTestModel = InheritedTestModel(inheritedTestModel.count - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedContext(
        inheritedTestModel: inheritedTestModel,
        increment: _incrementCount,
        reduce: _reduceCount,
        child: Scaffold(
          appBar: AppBar(
            title: Text('InheritedWidget'),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: Text(
                  '我们常使用的\nTheme.of(context).textTheme\nMediaQuery.of(context).size等\n就是通过InheritedWidget实现的',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              TestWidgetA(),
              TestWidgetB(),
              TestWidgetC(),
            ],
          ),
        ));
  }
}
