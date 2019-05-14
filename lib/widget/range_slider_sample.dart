import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/range_slider.dart';

class RangeSliderSample extends StatefulWidget {
  RangeSliderSample({Key key}) : super(key: key);

  @override
  createState() => _RangeSliderSampleState();
}

class _RangeSliderSampleState extends State<RangeSliderSample> {
  // List of RangeSliders to use, together with their parameters
  List<RangeSliderData> rangeSliders;

  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  @override
  void initState() {
    super.initState();
    rangeSliders = _rangeSliderDefinitions();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: new Scaffold(
        appBar: new AppBar(title: new Text('RangeSlider Demo')),
        body: new Container(
          padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          child: new Column(
            children: <Widget>[]
              ..add(
                //
                // Simple example
                //
                new RangeSlider(
                  min: 0.0,
                  max: 100.0,
                  lowerValue: _lowerValue,
                  upperValue: _upperValue,
                  divisions: 5,
                  showValueIndicator: true,
                  valueIndicatorMaxDecimals: 1,
                  onChanged: (double newLowerValue, double newUpperValue) {
                    setState(() {
                      _lowerValue = newLowerValue;
                      _upperValue = newUpperValue;
                    });
                  },
                  onChangeStart:
                      (double startLowerValue, double startUpperValue) {
                    print(
                        'Started with values: $startLowerValue and $startUpperValue');
                  },
                  onChangeEnd: (double newLowerValue, double newUpperValue) {
                    print(
                        'Ended with values: $newLowerValue and $newUpperValue');
                  },
                ),
              )
              // Add some space
              ..add(
                new SizedBox(height: 24.0),
              )
              //
              // Add a series of RangeSliders, built as regular Widgets
              // each one having some specific customizations
              //
              ..addAll(_buildRangeSliders())

              //
              // Add a disabled version
              //
              ..add(
                new RangeSlider(
                  min: 0.0,
                  max: 100.0,
                  lowerValue: 25.0,
                  upperValue: 50.0,
                  divisions: 5,
                  showValueIndicator: true,
                  valueIndicatorMaxDecimals: 1,
                  onChanged: null,
                ),
              )

              //
              // Add custom value formatter
              //
              ..add(
                new RangeSlider(
                  min: 0.0,
                  max: 100.0,
                  lowerValue: _lowerValueFormatter,
                  upperValue: _upperValueFormatter,
                  divisions: 10,
                  showValueIndicator: true,
                  valueIndicatorFormatter: (int index, double value) {
                    String twoDecimals = value.toStringAsFixed(2);
                    return '$twoDecimals mm';
                  },
                  onChanged: (double newLowerValue, double newUpperValue) {
                    setState(() {
                      _lowerValueFormatter = newLowerValue;
                      _upperValueFormatter = newUpperValue;
                    });
                  },
                ),
              ),
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------
  // Creates a list of RangeSliders, based on their
  // definition and SliderTheme customizations
  // -----------------------------------------------
  List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        // adapt the RangeSlider lowerValue and upperValue
        setState(() {
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
        });
      }));
      // Add an extra padding at the bottom of each RangeSlider
      children.add(new SizedBox(height: 8.0));
    }

    return children;
  }

  // -------------------------------------------------
  // Creates a list of RangeSlider definitions
  // -------------------------------------------------
  List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0.0, max: 100.0, lowerValue: 10.0, upperValue: 100.0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          overlayColor: Colors.red[100]),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: false,
          valueIndicatorMaxDecimals: 0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: true,
          valueIndicatorMaxDecimals: 0,
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.red[50],
          valueIndicatorColor: Colors.green),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          thumbColor: Colors.grey,
          valueIndicatorColor: Colors.grey),
    ];
  }
}

// ---------------------------------------------------
// Helper class aimed at simplifying the way to
// automate the creation of a series of RangeSliders,
// based on various parameters
//
// This class is to be used to demonstrate the appearance
// customization of the RangeSliders
// ---------------------------------------------------
class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = const Color(0xFF0175c2);
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0x8a0175c2);
  static const Color defaultThumbColor = const Color(0xFF0175c2);
  static const Color defaultValueIndicatorColor = const Color(0xFF0175c2);
  static const Color defaultOverlayColor = const Color(0x290175c2);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 1,
    this.forceValueIndicator: false,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  // Returns the values in text format, with the number
  // of decimals, limited to the valueIndicatedMaxDecimals
  //
  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);

  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  // Builds a RangeSlider and customizes the theme
  // based on parameters
  //
  Widget build(BuildContext context, RangeSliderCallback callback) {
    return new Container(
      width: double.infinity,
      child: new Row(
        children: <Widget>[
          new Container(
            constraints: new BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: new Text(lowerValueText),
          ),
          new Expanded(
            child: new SliderTheme(
              // Customization of the SliderTheme
              // based on individual definitions
              // (see rangeSliders in _RangeSliderSampleState)
              data: SliderTheme.of(context).copyWith(
                overlayColor: overlayColor,
                activeTickMarkColor: activeTickMarkColor,
                activeTrackColor: activeTrackColor,
                inactiveTrackColor: inactiveTrackColor,
                thumbColor: thumbColor,
                valueIndicatorColor: valueIndicatorColor,
                showValueIndicator: showValueIndicator
                    ? ShowValueIndicator.always
                    : ShowValueIndicator.onlyForDiscrete,
              ),
              child: new RangeSlider(
                min: min,
                max: max,
                lowerValue: lowerValue,
                upperValue: upperValue,
                divisions: divisions,
                showValueIndicator: showValueIndicator,
                valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                onChanged: (double lower, double upper) {
                  // call
                  callback(lower, upper);
                },
              ),
            ),
          ),
          new Container(
            constraints: new BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: new Text(upperValueText),
          ),
        ],
      ),
    );
  }
}
