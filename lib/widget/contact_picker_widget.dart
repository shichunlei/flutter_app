import 'package:easy_contact_picker/easy_contact_picker.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class ContactPickerWidget extends StatefulWidget {
  @override
  createState() => _ContactPickerWidgetState();
}

class _ContactPickerWidgetState extends State<ContactPickerWidget> {
  List<Contact> _list = [];

  final EasyContactPicker _contactPicker = EasyContactPicker();

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(centerTitle: true, title: Text('ContactPicker')),
        body: LoaderContainer(
            contentView: ListView.separated(
              itemBuilder: (_, index) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_list[index].fullName}'),
                      Gaps.vGap5,
                      Text('${_list[index].phoneNumber}'),
                    ],
                  ),
                );
              },
              itemCount: _list.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Gaps.vGap(1.0),
            ),
            loaderState: state));
  }

  void loadContacts() async {
    if (await PermissionsUtil.requestContactsPermission()) {
      _list = await _contactPicker.selectContacts();

      if (mounted)
        setState(() {
          state = LoaderState.Succeed;
        });
    }
  }
}
