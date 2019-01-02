import 'package:flutter/material.dart';
import 'package:flutter_app/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginStatePage();
}

class LoginStatePage extends State<LoginPage> {
  // TODO: Add text editing controllers (101)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bulderFormWidget(),
    );
  }

  Widget bulderFormWidget() {
    return Form(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          Column(
            children: <Widget>[
              CircleAvatar(
                child: Image.asset(
                  'images/flutter_logo.png',
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Flutter',
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
          // TODO: Wrap Username with AccentColorOverride (103)
          // TODO: Remove filled: true values (103)
          // TODO: Wrap Password with AccentColorOverride (103)
          // TODO: Add TextField widgets (101)
          /// [Name]
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: "usernae",
            ),
            controller: _usernameController,
          ),

          /// spacer
          SizedBox(
            height: 12.0,
          ),

          /// [Password]
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'Password',
            ),
            controller: _passwordController,

            /// 将用户的输入自动替换为星号，一般用于密码文本框。
            obscureText: true,
          ),
          // TODO: Add button bar (101)
          ButtonBar(
            children: <Widget>[
              // TODO: Add buttons (101)
              FlatButton(
                onPressed: () {
                  // TODO: Clear the text fields (101)
                  _usernameController.clear();
                  _passwordController.clear();
                },
                child: Text(
                  "Cancel",
                ),
              ),

              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => route == null,
                  );
                },
                child: Text(
                  "NEXT",
                ),
                // TODO: Add an elevation to NEXT (103)
                elevation: 8.0, // New code
                // TODO: Add a beveled rectangular border to NEXT (103)
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
