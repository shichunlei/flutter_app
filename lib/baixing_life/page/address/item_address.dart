import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/store/index.dart';

import '../../../page_index.dart';
import '../../index.dart';

class ItemAddress extends StatefulWidget {
  final Address address;

  ItemAddress({Key key, @required this.address}) : super(key: key);

  @override
  createState() => _ItemAddressState();
}

class _ItemAddressState extends State<ItemAddress>
    with SingleTickerProviderStateMixin {
  bool _isCheck = false;

  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 初始化动画控制
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Stack(children: <Widget>[
          Container(
              padding: EdgeInsets.all(16),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Row(children: <Widget>[
                            Text('${widget.address.name}',
                                style: TextStyles.textBoldDark16),
                            Gaps.hGap10,
                            Text('${widget.address.phone}',
                                style: TextStyles.textDark14),
                            Offstage(
                                offstage: !widget.address.isDefault,
                                child: Row(children: <Widget>[
                                  Gaps.hGap8,
                                  Chip(
                                      backgroundColor: Colors.red,
                                      label: Text('默认',
                                          style: TextStyles.textWhite12))
                                ])),
                            Offstage(
                                offstage: widget.address?.tag?.isEmpty,
                                child: Row(children: <Widget>[
                                  Gaps.hGap8,
                                  Chip(
                                      backgroundColor: Colors.deepPurple,
                                      label: Text('${widget.address.tag}',
                                          style: TextStyles.textWhite12))
                                ]))
                          ]),
                          Gaps.vGap8,
                          Text(
                              '${widget.address.province}${widget.address.city}${widget.address.county}${widget.address.address}',
                              style: TextStyles.textDark14,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis)
                        ])),
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                            padding: EdgeInsets.all(2),
                            width: 20.0,
                            height: 20.0,
                            child: Icon(Icons.more_horiz)),
                        onTap: () {
                          /// 开始执行动画
                          _controller.forward(from: 0.0);
                          setState(() => _isCheck = true);
                        })
                  ])),
          Positioned.fill(
              child: Offstage(
                  offstage: !_isCheck,
                  child: AnimatedBuilder(
                      animation: _animation,
                      builder: (_, child) => _buildMarkView())))
        ]));
  }

  Widget _buildMarkView() {
    return MenuReveal(
        revealPercent: _animation.value,
        child: InkWell(
            onTap: () {
              _controller.reverse(from: 1.1);
              _isCheck = false;
            },
            child: Container(
                color: Color(0x4D000000),
                child: Theme(
                    // 修改button默认的最小宽度与padding
                    data: Theme.of(context).copyWith(
                        buttonTheme: ButtonThemeData(
                            minWidth: 56.0,
                            height: 36.0,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            // 距顶部距离为0
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                              color: Colors.white,
                              onPressed: () {
                                _controller.reverse(from: 1.1);
                                _isCheck = false;

                                pushNewPage(
                                    context,
                                    CreateEditAddressPage(
                                        title: '${S.of(context).eidt_address}',
                                        id: widget.address.id));
                              },
                              child: Text('${S.of(context).edit}',
                                  style: TextStyles.textBlue14)),
                          FlatButton(
                              color: Colors.white,
                              onPressed: () {
                                _controller.reverse(from: 1.1);
                                _isCheck = false;

                                _showDeleteBottomSheet(widget.address?.id);
                              },
                              child: Text('${S.of(context).delete}',
                                  style: TextStyles.textRed14)),
                          FlatButton(
                              color: Colors.white,
                              onPressed: () {
                                _controller.reverse(from: 1.1);
                                _isCheck = false;

                                if (!widget.address.isDefault) {
                                  Store.value<AddressModel>(context,
                                          listen: false)
                                      .updateAddressDefault(
                                          context, widget.address?.id, true);
                                }
                              },
                              child:
                                  Text('设为默认', style: TextStyles.textGrey14)),
                          Gaps.hGap8
                        ])))));
  }

  _showDeleteBottomSheet(int id) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Material(
              color: Colors.white,
              child: SafeArea(
                  child: Container(
                      height: 161.2,
                      child: Column(children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            height: 52.0,
                            child: Text("是否确认删除，防止错误操作",
                                style: TextStyles.textDark16)),
                        Gaps.line,
                        Container(
                            height: 54.0,
                            width: double.infinity,
                            child: FlatButton(
                                textColor: Colors.red,
                                child:
                                    Text("确认删除", style: TextStyles.textRed16),
                                onPressed: () => Store.value<AddressModel>(
                                        context,
                                        listen: false)
                                    .deleteAddress(context, id))),
                        Gaps.line,
                        Container(
                            height: 54.0,
                            width: double.infinity,
                            child: FlatButton(
                                textColor: Colors.grey,
                                child: Text("${S.of(context).cancel}",
                                    style: TextStyles.textGrey16),
                                onPressed: () => Navigator.of(context).pop()))
                      ]))));
        });
  }
}
