import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ContactPage extends StatefulWidget {
  final String name;
  final String phone;
  final String avatar;
  final String email;
  final String cell;
  final String address;
  final String area;
  final String birthday;

  ContactPage({
    Key key,
    this.name,
    this.phone,
    this.avatar,
    this.email,
    this.cell,
    this.address,
    this.area,
    this.birthday,
  }) : super(key: key);

  @override
  createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
        mini: true,
        elevation: 8.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
                title: widget.name,
                avatarImgUrl: widget.avatar,
                navigationBarHeight: Utils.navigationBarHeight,
                expandedHeight: _appBarHeight,
                coverImgUrl: backgroundImage),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                BuildRowView(),
                LineWidget(
                  height: 1.0,
                  color: Colors.black12,
                  lineType: LineType.horizontal,
                ),
                BuildPhoneView(
                  phone: widget.phone,
                  cell: widget.cell,
                ),
                BuildEmailView(email: widget.email),
                BuildAddressView(
                  address: widget.address,
                  area: widget.area,
                ),
                BuildOtherView(
                  birthday: "${formatDateByStr(widget.birthday, formats: [
                    yyyy,
                    '-',
                    mm,
                    '-',
                    dd
                  ])}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
