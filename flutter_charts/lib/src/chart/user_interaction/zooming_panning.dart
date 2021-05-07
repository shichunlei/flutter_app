part of flutter_charts;

/// Customizes the zooming options.
class ZoomPanBehavior extends ZoomBehavior {
  ZoomPanBehavior(
      {this.enablePinching = false,
      this.enableDoubleTapZooming = false,
      this.enablePanning = false,
      this.enableSelectionZooming = false,
      this.zoomMode = ZoomMode.xy,
      this.maximumZoomLevel,
      this.selectionRectBorderWidth = 1,
      this.selectionRectBorderColor,
      this.selectionRectColor});

  ///Enables or disables the pinch zooming. Pinching can be performed by moving two
  ///fingers over the chart.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enablePinchZooming: true),
  ///        ));
  ///}
  ///```
  final bool enablePinching;

  ///Enables or disables the double tap zooming.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enableDoubleTapZooming: true),
  ///        ));
  ///}
  ///```
  final bool enableDoubleTapZooming;

  ///Enables or disables the panning. Panning can be performed on a zoomed axis.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
  ///        ));
  ///}
  ///```
  final bool enablePanning;

  ///Enables or disables the selection zooming. Selection zooming can be performed
  ///by dragging. The drawn rectangular region will be zoomed on touch.
  ///
  ///Defaults to false.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///        ));
  ///}
  ///```
  final bool enableSelectionZooming;

  ///By default, both the x and y-axes in the chart can be zoomed. It can be changed by
  ///setting value to this property.
  ///
  ///Defaults to ZoomMode.xy
  ///
  ///Also refer [ZoomMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true, zoomMode: ZoomMode.x),
  ///        ));
  ///}
  ///```
  final ZoomMode zoomMode;

  ///Maximum zoom level. Zooming will be stopped after reached this value.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true, maximumZoomLevel: 2),
  ///        ));
  ///}
  ///```
  final double maximumZoomLevel;

  ///Border width of the selection zooming rectangle.
  ///
  ///Defaults to 1
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true, selectionRectBorderWidth: 2),
  ///        ));
  ///}
  ///```
  final double selectionRectBorderWidth;

  ///Border color of the selection zooming rectangle.
  ///
  ///Defaults to Colors.grey
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true, selectionRectBorderColor: Colors.red),
  ///        ));
  ///}
  ///```
  final Color selectionRectBorderColor;

  ///Color of the selection zooming rectangle.
  ///
  ///Defaults to Color.fromRGBO(89, 244, 66, 0.2)
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true, selectionRectColor: Colors.yellow),
  ///        ));
  ///}
  ///```
  final Color selectionRectColor;
  SfCartesianChart _chart;
  List<_ZoomAxisRange> _zoomAxes;
  _ZoomRectPainter _painter;
  Offset _previousMovedPosition;
  bool _isPanning, _canPerformSelection, _isPinching;
  Rect _zoomingRect = const Rect.fromLTWH(0, 0, 0, 0);
  bool _delayRedraw = false;
  double _zoomFactor, _zoomPosition;

  /// To get chart instance
  void _setChart(SfCartesianChart sfChart) => _chart = sfChart;

  /// Below method for Double tap Zooming
  void _doubleTapZooming(double xPos, double yPos, double zoomFactor) {
    ZoomPanArgs zoomStartArgs;
    for (int axisIndex = 0;
        axisIndex < _chart._chartAxis._axisCollections.length;
        axisIndex++) {
      final dynamic axis = _chart._chartAxis._axisCollections[axisIndex];
      if (_chart.onZoomStart != null)
        _zoomEvent(_chart, axis, zoomStartArgs, _chart.onZoomStart);

      if ((axis._orientation == AxisOrientation.vertical &&
              zoomMode != ZoomMode.x) ||
          (axis._orientation == AxisOrientation.horizontal &&
              zoomMode != ZoomMode.y)) {
        final num cumulative = math.max(
            math.max(1 / _minMax(axis._zoomFactor, 0, 1), 1) + (0.25), 1);
        if (cumulative >= 1) {
          num origin = axis._orientation == AxisOrientation.horizontal
              ? xPos / _chart._chartAxis._axisClipRect.width
              : 1 - (yPos / _chart._chartAxis._axisClipRect.height);
          origin = origin > 1 ? 1 : origin < 0 ? 0 : origin;
          zoomFactor = (cumulative == 1) ? 1 : _minMax(1 / cumulative, 0, 1);
          _zoomPosition = (cumulative == 1)
              ? 0
              : axis._zoomPosition + ((axis._zoomFactor - zoomFactor) * origin);
          if (axis._zoomPosition != _zoomPosition ||
              axis._zoomFactor != zoomFactor) {
            zoomFactor = (_zoomPosition + zoomFactor) > 1
                ? (1 - _zoomPosition)
                : zoomFactor;
          }

          axis._zoomPosition = _zoomPosition;
          axis._zoomFactor = zoomFactor;
          axis._bounds = const Rect.fromLTWH(0, 0, 0, 0);
          axis._visibleLabels = <AxisLabel>[];
        }
        if (zoomFactor < (maximumZoomLevel ?? 0.1)) {
          axis._zoomFactor = maximumZoomLevel ?? 0.1;
          axis._zoomPosition = 0.0;
          zoomFactor = maximumZoomLevel ?? 0.1;
        }
      }

      if (_chart.onZoomEnd != null) {
        ZoomPanArgs zoomEndArgs;
        _zoomEvent(_chart, axis, zoomEndArgs, _chart.onZoomEnd);
      }
    }
    _createZoomState();
  }

  /// Below method is for panning the zoomed chart
  void _doPan(double xPos, double yPos) {
    num currentScale;
    num value;
    for (int axisIndex = 0;
        axisIndex < _chart._chartAxis._axisCollections.length;
        axisIndex++) {
      final dynamic axis = _chart._chartAxis._axisCollections[axisIndex];
      if ((axis._orientation == AxisOrientation.vertical &&
              zoomMode != ZoomMode.x) ||
          (axis._orientation == AxisOrientation.horizontal &&
              zoomMode != ZoomMode.y)) {
        double currentZoomPosition = axis._zoomPosition;
        currentScale = math.max(1 / _minMax(axis._zoomFactor, 0, 1), 1);
        if (axis._orientation == AxisOrientation.horizontal) {
          value = (_previousMovedPosition.dx - xPos) /
              _chart._chartAxis._axisClipRect.width /
              currentScale;
          currentZoomPosition = _minMax(
                  axis.isInversed
                      ? axis._zoomPosition - value
                      : axis._zoomPosition + value,
                  0,
                  1 - axis._zoomFactor)
              .toDouble();
          axis._zoomPosition = currentZoomPosition;
        } else {
          value = (_previousMovedPosition.dy - yPos) /
              _chart._chartAxis._axisClipRect.height /
              currentScale;
          currentZoomPosition = _minMax(
                  axis.isInversed
                      ? axis._zoomPosition + value
                      : axis._zoomPosition - value,
                  0,
                  1 - axis._zoomFactor)
              .toDouble();
          axis._zoomPosition = currentZoomPosition;
        }
      }
    }
    _createZoomState();
  }

  ///Below method for drawing selection  rectangle
  Path _rectPath;
  void _drawSelectionZoomRect(
      double currentX, double currentY, double startX, double startY) {
    final Rect clipRect = _chart._chartAxis._axisClipRect;
    final Offset startPosition = Offset(
        (startX < clipRect.left) ? clipRect.left : startX,
        (startY < clipRect.top) ? clipRect.top : startY);
    final Offset currentMousePosition = Offset(
        (currentX > clipRect.right)
            ? clipRect.right
            : ((currentX < clipRect.left) ? clipRect.left : currentX),
        (currentY > clipRect.bottom)
            ? clipRect.bottom
            : ((currentY < clipRect.top) ? clipRect.top : currentY));
    _rectPath = Path();
    if (zoomMode == ZoomMode.x) {
      _rectPath.moveTo(startPosition.dx, clipRect.top);
      _rectPath.lineTo(startPosition.dx, clipRect.bottom);
      _rectPath.lineTo(currentMousePosition.dx, clipRect.bottom);
      _rectPath.lineTo(currentMousePosition.dx, clipRect.top);
      _rectPath.close();
    } else if (zoomMode == ZoomMode.y) {
      _rectPath.moveTo(clipRect.left, startPosition.dy);
      _rectPath.lineTo(clipRect.left, currentMousePosition.dy);
      _rectPath.lineTo(clipRect.right, currentMousePosition.dy);
      _rectPath.lineTo(clipRect.right, startPosition.dy);
      _rectPath.close();
    } else {
      _rectPath.moveTo(startPosition.dx, startPosition.dy);
      _rectPath.lineTo(startPosition.dx, currentMousePosition.dy);
      _rectPath.lineTo(currentMousePosition.dx, currentMousePosition.dy);
      _rectPath.lineTo(currentMousePosition.dx, startPosition.dy);
      _rectPath.close();
    }
    _zoomingRect = _rectPath.getBounds();
    _chart._chartState.zoomRepaintNotifier.value++;
  }

  /// Below method for zooming selected portion
  void _doSelectionZooming(Rect zoomRect) {
    ZoomPanArgs zoomEndArgs;
    final Rect rect = _chart._chartAxis._axisClipRect;
    for (int axisIndex = 0;
        axisIndex < _chart._chartAxis._axisCollections.length;
        axisIndex++) {
      final ChartAxis axis = _chart._chartAxis._axisCollections[axisIndex];
      ZoomPanArgs zoomStartArgs;
      if (_chart.onZoomStart != null)
        _zoomEvent(_chart, axis, zoomStartArgs, _chart.onZoomStart);
      axis._previousZoomFactor = axis._zoomFactor;
      axis._previousZoomPosition = axis._zoomPosition;
      if (axis._orientation == AxisOrientation.horizontal) {
        if (zoomMode != ZoomMode.y) {
          axis._zoomPosition +=
              ((zoomRect.left - rect.left) / (rect.width)).abs() *
                  axis._zoomFactor;
          axis._zoomFactor *= zoomRect.width / rect.width;
          if (maximumZoomLevel != null) {
            axis._zoomFactor = axis._zoomFactor >= maximumZoomLevel
                ? axis._zoomFactor
                : maximumZoomLevel;
          }
        }
      } else {
        if (zoomMode != ZoomMode.x) {
          axis._zoomPosition += (1 -
                  ((zoomRect.height + (zoomRect.top - rect.top)) /
                          (rect.height))
                      .abs()) *
              axis._zoomFactor;
          axis._zoomFactor *= zoomRect.height / rect.height;
          if (maximumZoomLevel != null) {
            axis._zoomFactor = axis._zoomFactor >= maximumZoomLevel
                ? axis._zoomFactor
                : maximumZoomLevel;
          }
        }
      }
      if (_chart.onZoomEnd != null)
        _zoomEvent(_chart, axis, zoomEndArgs, _chart.onZoomEnd);
    }

    zoomRect = const Rect.fromLTRB(0, 0, 0, 0);
    _rectPath = Path();
    _createZoomState();
  }

//Below method is for pinch zooming
  void _performPinchZooming(
      List<PointerEvent> touchStartList, List<PointerEvent> touchMoveList) {
    num touch0StartX,
        touch0StartY,
        touch1StartX,
        touch1StartY,
        touch0EndX,
        touch0EndY,
        touch1EndX,
        touch1EndY;
    if (!(_zoomingRect.width > 0 && _zoomingRect.height > 0)) {
      _zoomAxes = _chart._chartState.zoomAxes;
      _calculateZoomAxesRange(_chart);
      _delayRedraw = true;
      final Rect offsetRect = _chart._chartAxis._axisClipRect;
      final Rect containerRect = _chart._chartState.containerRect;
      final Rect rect = Rect.fromLTWH(containerRect.left, containerRect.top,
          containerRect.width, containerRect.height);
      final Rect elementOffsetRect = rect;
      touch0StartX = touchStartList[0].position.dx - elementOffsetRect.left;
      touch0StartY = touchStartList[0].position.dy - elementOffsetRect.top;
      touch0EndX = touchMoveList[0].position.dx - elementOffsetRect.left;
      touch0EndY = touchMoveList[0].position.dy - elementOffsetRect.top;
      touch1StartX = touchStartList[1].position.dx - elementOffsetRect.left;
      touch1StartY = touchStartList[1].position.dy - elementOffsetRect.top;
      touch1EndX = touchMoveList[1].position.dx - elementOffsetRect.left;
      touch1EndY = touchMoveList[1].position.dy - elementOffsetRect.top;
      num scaleX, scaleY, clipX, clipY;
      Rect pinchRect;
      scaleX =
          (touch0EndX - touch1EndX).abs() / (touch0StartX - touch1StartX).abs();
      scaleY =
          (touch0EndY - touch1EndY).abs() / (touch0StartY - touch1StartY).abs();
      clipX = ((offsetRect.left - touch0EndX) / scaleX) + touch0StartX;
      clipY = ((offsetRect.top - touch0EndY) / scaleY) + touch0StartY;
      pinchRect = Rect.fromLTWH(
          clipX, clipY, offsetRect.width / scaleX, offsetRect.height / scaleY);
      _calculatePinchZoomFactor(_chart, pinchRect);
      if (_chart._chartAxis._axisCollections[0]._zoomFactor > 0.05 &&
          _chart._chartAxis._axisCollections[1]._zoomFactor > 0.05) {
        _chart._chartState.zoomProgress = true;
        _createZoomState();
      }
    }
  }

  void _createZoomState() {
    _chart._chartState.zoomedAxisStates = <ChartAxis>[];
    _chart._chartState.zoomedAxisStates
        .addAll(_chart._chartAxis._axisCollections);
    _chart._chartState._redraw();
  }

  /// Below method is for pinch zooming
  void _calculatePinchZoomFactor(SfCartesianChart chart, Rect pinchRect) {
    final ZoomMode mode = zoomMode;
    num selectionMin;
    num selectionMax;
    num rangeMin;
    num rangeMax;
    num value;
    num axisTrans;
    double currentZoomPosition;
    double currentZoomFactor;
    num currentFactor;
    num currentPosition;
    final Rect offsetRect = chart._chartAxis._axisClipRect;
    for (int axisIndex = 0;
        axisIndex < chart._chartAxis._axisCollections.length;
        axisIndex++) {
      final ChartAxis axis = chart._chartAxis._axisCollections[axisIndex];
      if ((axis._orientation == AxisOrientation.horizontal &&
              mode != ZoomMode.y) ||
          (axis._orientation == AxisOrientation.vertical &&
              mode != ZoomMode.x)) {
        if (axis._orientation == AxisOrientation.horizontal) {
          value = pinchRect.left - offsetRect.left;
          axisTrans = offsetRect.width / _zoomAxes[axisIndex].delta;
          rangeMin = value / axisTrans + _zoomAxes[axisIndex].min;
          value = pinchRect.left + pinchRect.width - offsetRect.left;
          rangeMax = value / axisTrans + _zoomAxes[axisIndex].min;
        } else {
          value = pinchRect.top - offsetRect.top;
          axisTrans = offsetRect.height / _zoomAxes[axisIndex].delta;
          rangeMin = (value * -1 + offsetRect.height) / axisTrans +
              _zoomAxes[axisIndex].min;
          value = pinchRect.top + pinchRect.height - offsetRect.top;
          rangeMax = (value * -1 + offsetRect.height) / axisTrans +
              _zoomAxes[axisIndex].min;
        }
        selectionMin = math.min(rangeMin, rangeMax);
        selectionMax = math.max(rangeMin, rangeMax);
        currentPosition = (selectionMin - _zoomAxes[axisIndex].actualMin) /
            _zoomAxes[axisIndex].actualDelta;
        currentFactor =
            (selectionMax - selectionMin) / _zoomAxes[axisIndex].actualDelta;
        currentZoomPosition = currentPosition < 0 ? 0 : currentPosition;
        currentZoomFactor = currentFactor > 1 ? 1 : currentFactor;
        onPinch(axis, currentZoomPosition, currentZoomFactor);
      }
    }
  }

  num _minMax(num value, num min, num max) =>
      value > max ? max : (value < min ? min : value);

  /// Below method is for storing calculated zoom range

  void _calculateZoomAxesRange(SfCartesianChart chart) {
    for (int index = 0;
        index < chart._chartAxis._axisCollections.length;
        index++) {
      final ChartAxis axis = chart._chartAxis._axisCollections[index];
      final _ZoomAxisRange range = _ZoomAxisRange();
      final _VisibleRange axisRange = axis._visibleRange;
      if (_zoomAxes != null &&
          _zoomAxes.isNotEmpty &&
          index <= _zoomAxes.length - 1) {
        if (!_delayRedraw) {
          _zoomAxes[index].min = axisRange.minimum;
          _zoomAxes[index].delta = axisRange.delta;
        }
      } else {
        _zoomAxes ??= <_ZoomAxisRange>[];
        range.actualMin = axis._actualRange.minimum;
        range.actualDelta = axis._actualRange.delta;
        range.min = axisRange.minimum;
        range.delta = axisRange.delta;
        _zoomAxes.add(range);
      }
    }
  }

  /// Increases the magnification of the plot area.
  void zoomIn() {
    bool needZoom;
    for (int index = 0;
        index < _chart._chartAxis._axisCollections.length;
        index++) {
      final dynamic axis = _chart._chartAxis._axisCollections[index];
      if (axis._zoomFactor <= 1.0 && axis._zoomFactor > 0.0) {
        if (axis._zoomFactor - 0.1 < 0) {
          needZoom = false;
          break;
        } else {
          axis._zoomFactor -= 0.1;
          axis._zoomPosition = 0.2;
          needZoom = true;
        }
      }
    }
    if (needZoom) {
      _chart._chartState._redraw();
    }
  }

  /// Decreases the magnification of the plot area.
  void zoomOut() {
    for (int index = 0;
        index < _chart._chartAxis._axisCollections.length;
        index++) {
      final dynamic axis = _chart._chartAxis._axisCollections[index];
      if (axis._zoomFactor < 1.0 && axis._zoomFactor > 0.0) {
        axis._zoomFactor += 0.1;
        axis._zoomPosition = 0.2;
        axis._zoomFactor = axis._zoomFactor > 1.0
            ? 1.0
            : (axis._zoomFactor < 0.0 ? 0.0 : axis._zoomFactor);
      }
    }
    _chart._chartState._redraw();
  }

  /// Changes the zoom level using zoom factor. Here, you can pass the zoom factor of
  /// an axis to magnify the plot area. The value ranges from 0 to 1.
  void zoomByFactor(double zoomFactor) {
    for (int index = 0;
        index < _chart._chartAxis._axisCollections.length;
        index++) {
      final dynamic axis = _chart._chartAxis._axisCollections[index];
      axis._zoomFactor = zoomFactor;
      _chart._chartState._redraw();
    }
  }

  /// Zooms the chart for a given rectangle value. Here, you can pass the rectangle with
  /// the left, right, top, and bottom values, using which the selection zooming will
  /// be performed.
  void zoomByRect(Rect rect) =>
      _chart.zoomPanBehavior._doSelectionZooming(rect);

  /// Change the zoom level of an appropriate axis. Here, you need to pass axis, zoom factor,
  /// zoom position of the zoom level that needs to be modified.
  void zoomToSingleAxis(
      ChartAxis axiss, double zoomPosition, double zoomFactor) {
    final dynamic axis = axiss;
    axis._zoomFactor = zoomFactor;
    axis._zoomPosition = zoomPosition;
    _chart._chartState._redraw();
  }

  /// Pans the plot area for given left, right, top, and bottom directions. To perform
  /// this action, the plot area needs to be in zoomed state.
  void panToDirection(String direction) {
    direction = direction.toLowerCase();
    for (int axisIndex = 0;
        axisIndex < _chart._chartAxis._axisCollections.length;
        axisIndex++) {
      final dynamic axis = _chart._chartAxis._axisCollections[axisIndex];
      if (axis._orientation == AxisOrientation.horizontal) {
        if (direction == 'left') {
          axis._zoomPosition =
              (axis._zoomPosition > 0 && axis._zoomPosition <= 0.9)
                  ? axis._zoomPosition - 0.1
                  : axis._zoomPosition;
          axis._zoomPosition =
              axis._zoomPosition < 0.0 ? 0.0 : axis._zoomPosition;
        }
        if (direction == 'right') {
          axis._zoomPosition =
              (axis._zoomPosition >= 0 && axis._zoomPosition < 1)
                  ? axis._zoomPosition + 0.1
                  : axis._zoomPosition;
          axis._zoomPosition =
              axis._zoomPosition > 1.0 ? 1.0 : axis._zoomPosition;
        }
      } else {
        if (direction == 'bottom') {
          axis._zoomPosition =
              (axis._zoomPosition > 0 && axis._zoomPosition <= 0.9)
                  ? axis._zoomPosition - 0.1
                  : axis._zoomPosition;
          axis._zoomPosition =
              axis._zoomPosition < 0.0 ? 0.0 : axis._zoomPosition;
        }
        if (direction == 'top') {
          axis._zoomPosition =
              (axis._zoomPosition >= 0 && axis._zoomPosition < 1)
                  ? axis._zoomPosition + 0.1
                  : axis._zoomPosition;
          axis._zoomPosition =
              axis._zoomPosition > 1.0 ? 1.0 : axis._zoomPosition;
        }
      }
    }
    _chart._chartState._redraw();
  }

  /// Returns the plot area back to its original position after zooming.
  void reset() {
    for (int index = 0;
        index < _chart._chartAxis._axisCollections.length;
        index++) {
      final dynamic axis = _chart._chartAxis._axisCollections[index];
      axis._zoomFactor = 1.0;
      axis._zoomPosition = 0.0;
    }
    _chart._chartState._redraw();
  }

  /// Performs panning action.
  @override
  void onPan(double xPos, double yPos) => _doPan(xPos, yPos);

  /// Performs the double-tap action.
  @override
  void onDoubleTap(double xPos, double yPos, double zoomFactor) =>
      _doubleTapZooming(xPos, yPos, zoomFactor);

  /// Draws selection zoomRect
  @override
  void onPaint(Canvas canvas) => _painter.drawRect(canvas);

  /// Performs selection zooming.
  @override
  void onDrawSelectionZoomRect(
          double currentX, double currentY, double startX, double startY) =>
      _drawSelectionZoomRect(currentX, currentY, startX, startY);

  /// Performs pinch start action.
  @override
  void onPinchStart(ChartAxis axis, double firstX, double firstY,
      double secondX, double secondY, double scaleFactor) {}

  /// Performs pinch end action.
  @override
  void onPinchEnd(ChartAxis axis, double firstX, double firstY, double secondX,
      double secondY, double scaleFactor) {}

  /// Performs pinch zooming.
  @override
  void onPinch(ChartAxis axis, double position, double scaleFactor) {
    axis._zoomFactor = scaleFactor;
    axis._zoomPosition = position;
  }
}

class _ZoomAxisRange {
  _ZoomAxisRange({this.actualMin, this.actualDelta, this.min, this.delta});
  num actualMin, actualDelta, min, delta;
}
