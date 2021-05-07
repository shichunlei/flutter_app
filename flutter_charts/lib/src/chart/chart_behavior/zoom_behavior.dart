part of flutter_charts;

/// Holds the zooming gestures.
abstract class ZoomBehavior {
  void onPan(double xPos, double yPos);

  void onDoubleTap(double xPos, double yPos, double zoomFactor);

  void onPaint(Canvas canvas);

  void onDrawSelectionZoomRect(
      double currentX, double currentY, double startX, double startY);

  void onPinchStart(ChartAxis axis, double firstX, double firstY,
      double secondX, double secondY, double scaleFactor);

  void onPinchEnd(ChartAxis axis, double firstX, double firstY, double secondX,
      double secondY, double scaleFactor);

  void onPinch(ChartAxis axis, double position, double scaleFactor);
}
