part of flutter_charts;

/// Position of the legend in chart.
/// - LegendPosition.auto places the legend either at the bottom when the height is
/// greater than the width, or at right when the width is greater than height.
/// - LegendPosition.bottom places the legend below the plot area.
/// - LegendPosition.left places the legend at the left to the plot area.
/// - LegendPosition.right places the legend at the right to the plot area.
/// - LegendPosition.top places the legend at the top of the plot area.
enum LegendPosition { auto, bottom, left, right, top }

/// Alignment of various elements in chart.
/// - ChartAlignment.near aligns to the near position.
/// - ChartAlignment.center aligns to the center position.
/// - ChartAlignment.far aligns to the far position.
enum ChartAlignment { near, center, far }

/// Mode to handle the legend items overflow.
/// - LegendItemOverflowMode.wrap will wrap and place the remaining legend item to next line.
/// - LegendItemOverflowMode.scroll will place all the legend items in single line and enables scrolling.
/// - LegendItemOverflowMode.none will simply hides the remaining legend items
enum LegendItemOverflowMode { wrap, scroll, none }

/// Orientation of legend items.
/// - LegendItemOrientation.auto will align the legend items based on the position.
/// - LegendItemOrientation.horizontal will align the legend items horizontally.
/// - LegendItemOrientation.vertical will align the legend item vertically.
enum LegendItemOrientation { auto, horizontal, vertical }

/// Supported shapes for legend item.
enum LegendIconType {
  seriesType,
  circle,
  rectangle,
  image,
  pentagon,
  verticalLine,
  horizontalLine,
  diamond,
  triangle,
  invertedTriangle
}

/// Position of data labels in Cartesian chart.
/// - ChartDataLabelAlignment.auto places the data label either top or bottom position
/// of a point based on the position.
/// - ChartDataLabelAlignment.outer places the data label at outside of a point.
/// - ChartDataLabelAlignment.top places the data label at the top position of a point.
/// - ChartDataLabelAlignment.bottom places the data label at the bottom position of a point.
/// - ChartDataLabelAlignment.middle places the data label at the center position of a point.
enum ChartDataLabelAlignment { auto, outer, top, bottom, middle }

/// Position of data labels in Circular chart.
/// - CircularLabelPosition.curve places the data label inside the point.
/// - CircularLabelPosition.line places the data label outside the point.
enum CircularLabelPosition { inside, outside }

enum PyramidMode { linear, surface }

enum SmartLabelMode { shift, hide, none }
