part of flutter_charts;

/// Data points grouping mode.
/// - CircularChartGroupMode.point, groups the points based on length.
/// - CircularChartGroupMode.value, groups the points based on the y value.
enum CircularChartGroupMode { point, value }

/// Data label position of range bar series.
/// - Position.left, places the data label to the left side.
/// - Position.right, places the data label to the right side.
enum Position { left, right }

/// Data labels intersect action.
/// - LabelIntersectAction.hide, hides the intersecting labels.
/// - LabelIntersectAction.none, will not perform any action on intersection.
enum LabelIntersectAction { hide, none }

/// Type of connector line.
/// - ConnectorType.curve, will render the data label connector line curvely.
/// - ConnectorType.line, will render the data label connector lien straightly.
enum ConnectorType { curve, line }

/// Corner style of range bar series.
/// - CornerStyle.bothFlat, will render both the corners flatly.
/// - CornerStyle.bothCurve, will render both the corners curvely.
/// - CornerStyle.startCurve, will render starting corner curvely.
/// - CornerStyle.endCurve, will render ending corner curvely.
enum CornerStyle { bothFlat, bothCurve, startCurve, endCurve }
