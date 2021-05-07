part of flutter_charts;

/// Creates the segments for chart series.
abstract class ChartSegment {
  ///Gets the color of the series
  Paint getFillPaint();

  ///Gets the border color of the series
  Paint getStrokePaint();

  ///Calculates the rendering bounds of a segment
  void calculateSegmentPoints();

  ///Draws segment in series bounds.
  void onPaint(Canvas canvas);

  ///Color of the segment
  Color color;

  ///Border color of the segment
  Color strokeColor;

  ///Border width of the segment
  double strokeWidth;

  ///Fill paint of the segment
  Paint fillPaint;

  ///Stroke paint of the segment
  Paint strokePaint;

  ///Chart series
  XyDataSeries<dynamic, dynamic> series;

  ///Chart series
  XyDataSeries<dynamic, dynamic> oldSeries;

  ///Animation factor value
  double animationFactor;

  ///Rectangle of the segment
  RRect segmentRect;

  Paint _defaultFillColor;

  Paint _defaultStrokeColor;

  int currentSegmentIndex, _seriesIndex;

  _CartesianChartPoint<dynamic> _currentPoint;

  _CartesianChartPoint<dynamic> _point;

  _CartesianChartPoint<dynamic> _oldPoint;

  bool _oldSeriesVisible;

  Rect _oldRegion;
}
