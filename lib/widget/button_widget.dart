import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  @override
  createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  Widget _buttonType;

  /// add line
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _buttonType = buildRaisedButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// add line
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Button Widget"),
        actions: <Widget>[
          PopupMenuButton<Widget>(
            onSelected: (Widget value) {
              setState(() {
                _buttonType = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<Widget>>[
                  PopupMenuItem<Widget>(
                    value: buildRaisedButton(),
                    child: Text('RAISED BUTTON'),
                  ),
                  PopupMenuItem<Widget>(
                    value: buildFlatButton(),
                    child: Text('FLAT BUTTON'),
                  ),
                  PopupMenuItem<Widget>(
                    value: buildOutlineButton(),
                    child: Text('OUTLINE BUTTON'),
                  ),
                  PopupMenuItem<Widget>(
                    value: buildIconButton(),
                    child: Text('ICON BUTTON'),
                  ),
                  PopupMenuItem<Widget>(
                    value: buildActionButton(),
                    child: Text('ACTION BUTTON'),
                  ),
                  PopupMenuItem<Widget>(
                    value: buildDropdownButton(),
                    child: Text('DROPDOWN BUTTON'),
                  ),
                  PopupMenuItem<Widget>(
                    value: buildCupertinoButton(),
                    child: Text('CUPERTINO BUTTON'),
                  ),
                ],
          )
        ],
      ),
      body: Center(
        child: _buttonType,
      ),
    );
  }

  Widget buildRaisedButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: const Text('RAISED BUTTON',
                    semanticsLabel: 'RAISED BUTTON 1'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
                shape: const StadiumBorder(),
              ),
              RaisedButton(
                child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 1'),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('RAISED BUTTON',
                    semanticsLabel: 'RAISED BUTTON 2'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
              ),
              RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label:
                    const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 2'),
                onPressed: null,
                shape: const StadiumBorder(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFlatButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child:
                    const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 1'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
                shape: const StadiumBorder(),
              ),
              FlatButton(
                child: Text(
                  'DISABLED',
                  semanticsLabel: 'DISABLED BUTTON 3',
                ),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18.0),
                label:
                    const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 2'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
              ),
              FlatButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18.0),
                label:
                    const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 4'),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOutlineButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton(
                child: const Text('OUTLINE BUTTON',
                    semanticsLabel: 'OUTLINE BUTTON 1'),
                onPressed: () {
                  // Perform some action
                },
                shape: const StadiumBorder(),
              ),
              OutlineButton(
                child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 5'),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('OUTLINE BUTTON',
                    semanticsLabel: 'OUTLINE BUTTON 2'),
                onPressed: () {
                  // Perform some action
                },
              ),
              OutlineButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label:
                    const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 6'),
                onPressed: null,
                shape: const StadiumBorder(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool iconButtonToggle = false;

  Widget buildIconButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            IconButton(
                icon: const Icon(Icons.thumb_up, semanticLabel: 'Thumbs up'),
                onPressed: () {
                  setState(() => iconButtonToggle = !iconButtonToggle);
                },
                color:
                    iconButtonToggle ? Theme.of(context).primaryColor : null),
            const IconButton(
                icon: Icon(Icons.thumb_up, semanticLabel: 'Thumbs not up'),
                onPressed: null)
          ], mainAxisAlignment: MainAxisAlignment.center),
          SizedBox(
            height: 20,
          ),
          Row(
              children: <Widget>[CloseButton(), BackButton()],
              mainAxisAlignment: MainAxisAlignment.center)
        ],
      ),
    );
  }

  Widget buildActionButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Perform some action
          _displaySnackBar();
        },
        tooltip: 'floating action button',
      ),
    );
  }

  // https://en.wikipedia.org/wiki/Free_Four
  String dropdown1Value = 'Free';
  String dropdown2Value;
  String dropdown3Value = 'Four';

  Widget buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: const Text('Simple dropdown:'),
            trailing: DropdownButton<String>(
              value: dropdown1Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown1Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: const Text('Dropdown with a hint:'),
            trailing: DropdownButton<String>(
              value: dropdown2Value,
              hint: const Text('Choose'),
              onChanged: (String newValue) {
                setState(() {
                  dropdown2Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: const Text('Scrollable dropdown:'),
            trailing: DropdownButton<String>(
              value: dropdown3Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown3Value = newValue;
                });
              },
              items: <String>[
                'One',
                'Two',
                'Free',
                'Four',
                'Can',
                'I',
                'Have',
                'A',
                'Little',
                'Bit',
                'More',
                'Five',
                'Six',
                'Seven',
                'Eight',
                'Nine',
                'Ten'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCupertinoButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: const Alignment(0.0, -0.2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CupertinoButton(
                  child: const Text('Cupertino Button'), onPressed: () {}),
              const CupertinoButton(
                child: Text('Disabled'),
                onPressed: null,
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.all(12.0)),
        CupertinoButton(
            child: const Text('With Background'),
            color: CupertinoColors.activeBlue,
            onPressed: () {}),
        const Padding(padding: EdgeInsets.all(12.0)),
        const CupertinoButton(
          child: Text('Disabled'),
          color: CupertinoColors.activeBlue,
          onPressed: null,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ],
    );
  }

  void _displaySnackBar() {
    /// show snackbar
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        /// set content of snackbar
        content: Text(
          "Hello! I am SnackBar :)",
        ),

        /// set duration
        duration: Duration(seconds: 3),

        /// set the action
        action: SnackBarAction(
          label: "Hit Me (Action)",
          onPressed: () {
            /// When action button is pressed, show another snackbar
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                  "Hello! I am shown becoz you pressed Action :)",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
