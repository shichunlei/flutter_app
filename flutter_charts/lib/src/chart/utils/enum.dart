part of flutter_charts;

/// Orientation of an axis
/// - AxisOrientation.vertical, renders the axis vertically.
/// - AxisOrientation.horizontal, renders the axis horizontally.
enum AxisOrientation { vertical, horizontal }

/// Padding for axis ranges.
/// - ChartRangePadding.auto, will apply None as padding for horizontal numeric axis, while the
/// vertical numeric axis takes Normal as padding calculation.
/// - ChartRangePadding.none, will not add any padding to the min and max values.
/// - ChartRangePadding.normal, will apply padding to the axis based on the default range calculation.
/// - ChartRangePadding.additional, will add an interval to the minimum and maximum of the axis.
/// - ChartRangePadding.round, will round the minimum and maximum values to the nearest possible value,
/// which is divisible by an interval.
enum ChartRangePadding { auto, none, normal, additional, round }

/// Placement of category axis labels.
/// - LabelPlacement.betweenTicks, places the axis label between the ticks.
/// - LabelPlacement.onTicks, places the axis label on the ticks.
enum LabelPlacement { betweenTicks, onTicks }

/// Action while the axis label intersects.
/// - AxisLabelIntersectAction.none, will not perform any action on intersecting labels.
/// - AxisLabelIntersectAction.hide, hides the intersecting labels.
/// - AxisLabelIntersectAction.wrap, wraps and places the intersecting labels in the next line.
/// - AxisLabelIntersectAction.multipleRows, places the axis labels in multiple rows.
/// - AxisLabelIntersectAction.rotate45, rotates all the axis labels to 45°.
/// - AxisLabelIntersectAction.rotate90, rotates all the axis labels to 90°.
enum AxisLabelIntersectAction {
  none,
  hide,
  wrap,
  multipleRows,
  rotate45,
  rotate90
}

/// Interval type of the DateTime axis.
/// - DateTimeIntervalType.auto, will calculate interval based on the data points.
/// - DateTimeIntervalType.years, will consider interval as years.
/// - DateTimeIntervalType.months, will consider interval as months.
/// - DateTimeIntervalType.days, will consider interval as days.
/// - DateTimeIntervalType.hours, will consider interval as hours.
/// - DateTimeIntervalType.minutes, will consider interval as minutes.
/// - DateTimeIntervalType.seconds, will consider interval as seconds.
enum DateTimeIntervalType { auto, years, months, days, hours, minutes, seconds }

/// Position of the axis labels.
/// - ChartDataLabelPosition.inside places the axis label inside the plot area
/// - ChartDataLabelPosition.outside places the axis label outside the plot area.
enum ChartDataLabelPosition { inside, outside }

/// Data marker supports the below shapes.
/// If the shape is DataMarkerType.image, specify the image path in the imageUrl property of markerSettings.
enum DataMarkerType {
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

/// Spline supports the following types.
/// If SplineType.cardinal type is specified, then specify the tension using cardinalSplineTension property.
enum SplineType { natural, monotonic, cardinal, clamped }

/// Placement of edge labels in the axis.
/// - EdgeLabelPlacement.none, places the edge labels in its own position.
/// - EdgeLabelPlacement.hides, hide the edge labels.
/// - EdgeLabelPlacement.shift, shift the edge labels inside the plot area bounds.
enum EdgeLabelPlacement { none, hide, shift }

/// Mode of empty data points.
/// - EmptyPointMode.gap, will consider as gap for the empty points.
/// - EmptyPointMode.zero, will consider as 0 value for the empty points.
/// - EmptyPointMode.drop, will drops to a minimum of the axis.
/// - EmptyPointMode.average, will consider the average value of its previous and next data points.
enum EmptyPointMode { gap, zero, drop, average }

/// Sorting order of data points.
/// - SortingOrder.ascending, arranges the points in ascending order.
/// - SortingOrder.descending, arranges the points in descending order.
/// - SortingOrder.none renders the points without sorting.
enum SortingOrder { ascending, descending, none }

/// Position of the ticks in the axis.
/// - TickPosition.inside, places the ticks inside the plot area.
/// - TickPosition.outside, places the ticks outside the plot area.
enum TickPosition { inside, outside }

/// Mode of activating a particular user interactive feature.
/// - ActivationMode.singleTap, activates the appropriate feature on single tap.
/// - ActivationMode.doubleTap, activates on double tap.
/// - ActivationMode.longPress, activates on longPress.
/// - ActivationMode.none will not activate any feature.
enum ActivationMode { singleTap, doubleTap, longPress, none }

/// Trackball tooltip's display mode.
/// - TrackballDisplayMode.floatAllPoints, displays separate tooltip for the points of different series.
/// - TrackballDisplayMode.groupAllPoints, groups the tooltip text of the points of different series.
/// - TrackballDisplayMode.nearestPoint, displays the tooltip of nearest point.
/// - TrackballDisplayMode.none, will not show the tooltip.
enum TrackballDisplayMode { none, floatAllPoints, groupAllPoints, nearestPoint }

/// Crosshair line type.
/// - CrosshairLineType.both, displays both horizotal and vertical lines.
/// - CrosshairLineType.horizontal, displays horizontal line.
/// - CrosshairLineType.vertical, displays vertical line.
/// - and CrosshairLineType.none, will not display crosshair line.
enum CrosshairLineType { both, horizontal, vertical, none }

/// Trackball line type.
/// - TrackballLineType.vertical, displays vertical trackball line.
/// - TrackballLineType.horizontal, displays horizontal trackball line.
/// - TrackballLineType.none, will not display trackball line.
enum TrackballLineType { vertical, horizontal, none }

/// Zooming mode.
/// - ZoomMode.x, zooms in horizontal direction.
/// - ZoomMode.y, zooms in vertical direction.
/// - ZoomMode.xy, zooms in both horizontal and vertical direction.
enum ZoomMode { x, y, xy }

/// Data point selection type.
/// - SelectionType.point, selects the individual point.
/// - SelectionType.series, selects the entire series.
/// - SelectionType.cluster, selects the cluster of data points.
enum SelectionType { point, series, cluster }

/// Coordinate unit for placing annotations.
/// - CoordinateUnit.point, places the annotation concerning to the points.
/// - CoordinateUnit.logicalPixel, places the annotation concerning to the pixel value.
enum CoordinateUnit { point, logicalPixel }

/// Region of annotation for positioning it.
/// - AnnotationRegion.chart, places the annotation anywhere in the chart area.
/// - AnnotationRegion.plotArea, places the annotation anywhere in the plot area.
enum AnnotationRegion { chart, plotArea }

/// Border mode of area series.
/// - AreaBorderMode.all, renders border for all the sides of area.
/// - AreaBorderMode.top, renders border only for top side.
/// - AreaBorderMode.excludeBottom, renders border except bottom side.
enum AreaBorderMode { all, top, excludeBottom }

/// Types of text rendering positions
enum TextAnchor { start, middle, end }
