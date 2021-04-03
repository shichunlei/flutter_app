part of flutter_charts;

/// Customizes the selection in chart.
abstract class ChartSelectionBehavior {
  void onTouchDown(double xPos, double yPos);

  void onDoubleTap(double xPos, double yPos);

  void onLongPress(double xPos, double yPos);

  void onCircularTouchDown(int pointIndex, int seriesIndex);

  void onCircularDoubleTap(int pointIndex, int seriesIndex);

  void onCircularLongPress(int pointIndex, int seriesIndex);

  Paint getSelectedItemFill(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> selectedSegments);

  Paint getUnselectedItemFill(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> unselectedSegments);

  Paint getSelectedItemBorder(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> selectedSegments);

  Paint getUnselectedItemBorder(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> unselectedSegments);

  Color getCircularSelectedItemFill(Color color, int seriesIndex,
      int pointIndex, List<_Region> selectedRegions);

  Color getCircularUnSelectedItemFill(Color color, int seriesIndex,
      int pointIndex, List<_Region> unselectedRegions);

  Color getCircularSelectedItemBorder(Color color, int seriesIndex,
      int pointIndex, List<_Region> selectedRegions);

  Color getCircularUnSelectedItemBorder(Color color, int seriesIndex,
      int pointIndex, List<_Region> unselectedRegions);
}
