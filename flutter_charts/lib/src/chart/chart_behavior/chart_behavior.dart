part of flutter_charts;

/// Holds the gestures for chart.
abstract class ChartBehavior {
  void onTouchDown(double xPos, double yPos);

  void onTouchUp(double xPos, double yPos);

  void onDoubleTap(double xPos, double yPos);

  void onTouchMove(double xPos, double yPos);

  void onLongPress(double xPos, double yPos);

  void onPaint(Canvas canvas);
}
