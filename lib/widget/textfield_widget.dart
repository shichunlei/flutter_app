import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidgetDemo extends StatefulWidget {
  @override
  createState() => TextFieldWidgetDemoState();
}

class TextFieldWidgetDemoState extends State<TextFieldWidgetDemo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  String _color = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField Widget"),
      ),
      body: SafeArea(
        /// 实现原理是利用form自带的onWillPop属性拦截Navagation.pop()
        child: Form(
          onWillPop: _onBackPressed,
          child: ListView(
            children: builderTextField(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          autovalidate: true,
          key: _formKey,
        ),
        top: false,
        bottom: false,
      ),
    );
  }

  List<Widget> builderTextField() {
    return <Widget>[
      TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.person),
          hintText: 'Enter your first and last name',
          labelText: 'Name',
        ),
      ),
      TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.calendar_today),
          hintText: 'Enter your date of birth',
          labelText: 'Dob',
        ),
        keyboardType: TextInputType.datetime,
      ),
      TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.phone),
          hintText: 'Enter a phone number',
          labelText: 'Phone',
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
      ),
      TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.email),
          hintText: 'Enter a email address',
          labelText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
      ),
      InputDecorator(
        decoration: const InputDecoration(
          icon: const Icon(Icons.color_lens),
          labelText: 'Color',
        ),
        isEmpty: _color == '',
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _color,
            isDense: true,
            onChanged: (newValue) {
              setState(() {
                _color = newValue;
              });
            },
            items: _colors
                .map(
                  (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                )
                .toList(),
          ),
        ),
      ),
      Container(
          padding: const EdgeInsets.only(left: 40.0, top: 20.0),
          child: RaisedButton(
            child: const Text('Submit'),
            onPressed: () {},
          )),
    ];
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      builder: (context) => AlertDialog(
            title: Text('Do you really want to exit the page?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
      context: context,
    );
  }
}
