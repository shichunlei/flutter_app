//Event Arguments
part of flutter_charts;

/// Holds the onTooltipRender event arguments.
class TooltipArgs {
  String text;
  String header;
  double locationX;
  double locationY;
  dynamic seriesIndex;
  List<dynamic> dataPoints;
  num pointIndex;
}

/// Holds the onActualRangeChanged event arguments.
class ActualRangeChangedArgs {
  String axisName;
  ChartAxis axis;
  dynamic actualMin;
  dynamic actualMax;
  dynamic actualInterval;
  dynamic visibleMin;
  dynamic visibleMax;
  dynamic visibleInterval;
  AxisOrientation orientation;
}

/// Holds the onAxisLabelRender event arguments.
class AxisLabelRenderArgs {
  String text;
  num value;
  String axisName;
  AxisOrientation orientation;
  ChartAxis axis;
  ChartTextStyle textStyle = ChartTextStyle();
}

/// Holds the onDataLabelRender event arguments.
class DataLabelRenderArgs {
  String text;
  ChartTextStyle textStyle = ChartTextStyle();
  dynamic series;
  dynamic dataPoints;
  num pointIndex;
}

/// Holds the onLegendItemRender event arguments.
class LegendRenderArgs {
  String text;
  LegendIconType legendIconType;
  int seriesIndex;
  //Applicable for circular chart alone
  int pointIndex;
  Color color;
}

/// Holds the onTrackballPositionChanging event arguments.
class TrackballArgs {
  _ChartPointInfo chartPointInfo = _ChartPointInfo();
}

/// Holds the onCrosshairPositionChanging event arguments.
class CrosshairRenderArgs {
  ChartAxis axis;
  String text;
  Color lineColor;
  dynamic value;
  String axisName;
  AxisOrientation orientation;
}

/// Holds the zooming event arguments.
class ZoomPanArgs {
  ChartAxis axis;
  double currentZoomPosition;
  double currentZoomFactor;
  double previousZoomPosition;
  double previousZoomFactor;
}

/// Holds the onPointTapped event arguments.
class PointTapArgs {
  int seriesIndex;
  int pointIndex;
  List<dynamic> dataPoints;
}

/// Holds the onAxisLabelTapped event arguments.
class AxisLabelTapArgs {
  ChartAxis axis;
  String text;
  num value;
  String axisName;
}

/// Holds the onLegendTapped event arguments.
class LegendTapArgs {
  dynamic series;
  int seriesIndex;
  //Applicable for circular chart alone
  int pointIndex;
}

/// Holds the onSelectionChanged event arguments.
class SelectionArgs {
  dynamic series;
  Color selectedColor;
  Color unselectedColor;
  Color selectedBorderColor;
  double selectedBorderWidth;
  Color unselectedBorderColor;
  double unselectedBorderWidth;
  int seriesIndex;
  int pointIndex;
}
