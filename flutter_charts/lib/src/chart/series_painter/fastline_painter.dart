part of flutter_charts;

class _FastLineChartPainter extends CustomPainter {
  _FastLineChartPainter({
    this.chart,
    this.series,
    this.isRepaint,
    this.animationController,
    this.seriesAnimation,
    this.chartElementAnimation,
    ValueNotifier<num> notifier,
  }) : super(repaint: notifier);

  final SfCartesianChart chart;
  final bool isRepaint;
  final AnimationController animationController;
  final Animation<double> seriesAnimation;
  final Animation<double> chartElementAnimation;
  final XyDataSeries<dynamic, dynamic> series;
  Path path;
  Paint pathPaint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    Rect clipRect;
    double animationFactor;
    if (series._visible) {
      animationFactor = seriesAnimation != null ? seriesAnimation.value : 1;

      /// Clip rect will be added for series.
      final Rect axisClipRect = _calculatePlotOffset(
          chart._chartAxis._axisClipRect,
          Offset(series._xAxis.plotOffset, series._yAxis.plotOffset));
      canvas.clipRect(axisClipRect);
      if (series.animationDuration > 0) {
        _performLinearAnimation(series, canvas, animationFactor);
      }

      /// Draw fast line series
      series._draw(canvas);
      clipRect = _calculatePlotOffset(
          Rect.fromLTRB(
              chart._chartAxis._axisClipRect.left - series.markerSettings.width,
              chart._chartAxis._axisClipRect.top - series.markerSettings.height,
              chart._chartAxis._axisClipRect.right +
                  series.markerSettings.width,
              chart._chartAxis._axisClipRect.bottom +
                  series.markerSettings.height),
          Offset(series._xAxis.plotOffset, series._yAxis.plotOffset));
    }
    canvas.restore();
    if (series._visible && (animationFactor > chart._seriesDurationFactor)) {
      canvas.clipRect(clipRect);

      /// Draw marker and other elements for fastline series
      _renderSeriesElements(canvas, series, chartElementAnimation);
    }
  }

  @override
  bool shouldRepaint(_FastLineChartPainter oldDelegate) => isRepaint;
}
