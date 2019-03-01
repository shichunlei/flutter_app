import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';

class ContactPickerWidget extends StatefulWidget {
  @override
  _ContactPickerWidgetState createState() => _ContactPickerWidgetState();
}

class _ContactPickerWidgetState extends State<ContactPickerWidget> {
  final ContactPicker _contactPicker = ContactPicker();
  Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ContactPicker'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              child: Text("CLICK ME"),
              onPressed: () async {
                Contact contact = await _contactPicker.selectContact();
                setState(() {
                  _contact = contact;
                });
              },
            ),
            Text(
              _contact == null ? 'No contact selected.' : _contact.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
