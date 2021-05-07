part of flutter_charts;

class _SelectionRenderer {
  _SelectionRenderer();
  int pointIndex;
  int seriesIndex;
  int cartesianSeriesIndex;
  int cartesianPointIndex;
  bool isSelection;
  ChartSegment selectedSegment, currentSegment;
  final List<ChartSegment> defaultselectedSegments = <ChartSegment>[];
  final List<ChartSegment> defaultunselectedSegments = <ChartSegment>[];
  List<_ChartPoint<dynamic>> selectedDataPoints = <_ChartPoint<dynamic>>[];
  List<_ChartPoint<dynamic>> unselectedDataPoints = <_ChartPoint<dynamic>>[];
  List<_Region> selectedRegions = <_Region>[];
  List<_Region> unselectedRegions = <_Region>[];
  _ChartPoint<dynamic> currentDataPoint;
  bool isSelected = false;
  dynamic chart;
  dynamic series;
  dynamic fillColor, fillOpacity, strokeColor, strokeOpacity, strokeWidth;
  _Region currentRegion, selectedRegion;
  _ChartPoint<dynamic> selectedDataPoint;
  SelectionArgs selectionArgs;
  List<ChartSegment> selectedSegments;
  List<ChartSegment> unselectedSegments;

  void selectionIndex(int pointIndex, int seriesIndex,
      [SelectionType selectionType, bool multiSelect]) {
    bool isSamePointSelect = false;
    if (chart.onSelectionChanged != null) {
      chart.onSelectionChanged(
          getSelectionEventArgs(series, seriesIndex, pointIndex));
    }
    if (chart is SfCartesianChart) {
      /// Unselecting the last selected segment
      if (selectedSegments.length == 1)
        changeColorAndPopUnselectedSegments(unselectedSegments);

      /// Executes when multiselectoption is enabled

      if (multiSelect != null && multiSelect) {
        if (selectedSegments.isNotEmpty) {
          /// To identify the tapped segment
          currentSegment = series.segments[pointIndex];
          if (currentSegment.currentSegmentIndex == pointIndex &&
              currentSegment._seriesIndex == seriesIndex) {
            selectedSegment = series.segments[pointIndex];
          }

          /// Executes when tapped again in one of the selected segments
          if (multiSelect) {
            for (int j = selectedSegments.length - 1; j >= 0; j--) {
              series = chart
                  ._chartSeries.visibleSeries[selectedSegments[j]._seriesIndex];
              final ChartSegment currentSegment =
                  series.segments[selectedSegments[j].currentSegmentIndex];

              /// Applying default settings when last selected segment becames unselected
              if ((selectedSegment.segmentRect ==
                      selectedSegments[j].segmentRect) &&
                  (selectedSegments.length == 1)) {
                final Paint fillPaint =
                    getDefaultFillColor(null, null, currentSegment);
                final Paint strokePaint =
                    getDefaultStrokeColor(null, null, currentSegment);
                currentSegment.fillPaint = fillPaint;
                currentSegment.strokePaint = strokePaint;

                if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                    selectedSegments[j]._seriesIndex == seriesIndex)
                  isSamePointSelect = true;
                selectedSegments.remove(selectedSegments[j]);
              }

              /// Applying unselected color for unselected segments in multiselect option
              else if (selectedSegment.segmentRect ==
                  selectedSegments[j].segmentRect) {
                final Paint fillPaint = getFillColor(false, currentSegment);
                currentSegment.fillPaint = fillPaint;
                final Paint strokePaint = getStrokeColor(false, currentSegment);
                currentSegment.strokePaint = strokePaint;
                if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                    selectedSegments[j]._seriesIndex == seriesIndex)
                  isSamePointSelect = true;
                unselectedSegments.add(selectedSegments[j]);
                selectedSegments.remove(selectedSegments[j]);
              }
            }
          }
        }
      } else
        isSamePointSelect = changeColorAndPopSelectedSegments(
            selectedSegments, isSamePointSelect);

      /// To check that the selection setting is enable or not
      if (!isSamePointSelect) {
        for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
          final CartesianSeries<dynamic, dynamic> series =
              chart._chartSeries.visibleSeries[i];
          for (int i = 0; i < series.segments.length; i++) {
            currentSegment = series.segments[i];
            currentSegment.currentSegmentIndex == pointIndex &&
                    currentSegment._seriesIndex == seriesIndex
                ? selectedSegments.add(series.segments[i])
                : unselectedSegments.add(series.segments[i]);
          }

          /// Giving color to unselected segments
          _unselectedSegmentsColors(unselectedSegments);

          /// Giving Color to selected segments
          _selectedSegmentsColors(selectedSegments);
        }
      }
      chart._chartState.seriesRepaintNotifier.value++;
    } else {
      _Region currentRegion;

      /// Unselecting the last selected segment
      if (selectedDataPoints.length == 1)
        _changeColorAndPopUnselectedDataPoints(
            unselectedDataPoints, unselectedRegions);

      isSamePointSelect = _changeColorAndPopSelectedDataPoints(
          selectedDataPoints, selectedRegions, isSamePointSelect);

      if (!isSamePointSelect) {
        isSelected = true;
        for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
          final CircularSeries<dynamic, dynamic> series =
              chart._chartSeries.visibleSeries[i];
          if (isSelected) {
            for (int j = 0; j < series._pointRegions.length; j++) {
              currentRegion = series._pointRegions[j];
              if (currentRegion.pointIndex == null || pointIndex == null) {
                break;
              }
              if (currentRegion.pointIndex == pointIndex &&
                  currentRegion.seriesIndex == seriesIndex) {
                selectedDataPoints.add(series._renderPoints[j]);
                selectedRegions.add(series._pointRegions[j]);
                series._renderPoints[j].isSelected = true;
              } else {
                unselectedDataPoints.add(series._renderPoints[j]);
                unselectedRegions.add(series._pointRegions[j]);
                series._renderPoints[j].isSelected = false;
              }
            }

            /// Giving color to unselected segments
            _unselectedDataPointColors(
                unselectedDataPoints, series.selectionSettings);

            /// Giving Color to selected segments
            _selectedDataPointColors(
                selectedDataPoints, series.selectionSettings);
          }
        }
      }
      chart._chartState.seriesRepaintNotifier.value++;
    }
  }

  /// selection for selected datapoint index
  void selectedDataPointIndex(
      CartesianSeries<dynamic, dynamic> series, List<int> selectedData) {
    for (int data = 0; data < selectedData.length; data++) {
      final int selectedItem = selectedData[data];
      if (chart.onSelectionChanged != null) {
        // chart.onSelectionChanged(getSelectionEventArgs(
        //     series, selectedItem.seriesIndex, selectedItem.pointIndex));
      }
      for (int j = 0; j < series.segments.length; j++) {
        currentSegment = series.segments[j];
        currentSegment.currentSegmentIndex == selectedItem
            ? selectedSegments.add(series.segments[j])
            : unselectedSegments.add(series.segments[j]);
      }
    }
    _selectedSegmentsColors(selectedSegments);
    _unselectedSegmentsColors(unselectedSegments);
  }

  void _selectedDataPointColors(List<_ChartPoint<dynamic>> selectedDataPoints,
      dynamic selectionSettings) {
    for (int i = 0; i < selectedDataPoints.length; i++) {
      final Paint fillPaint = getFillColor(true, null, selectedDataPoints[i]);
      final Paint strokePaint =
          getStrokeColor(true, null, selectedDataPoints[i]);
      selectedDataPoints[i].fill =
          selectionSettings.getCircularSelectedItemFill(
              fillPaint.color,
              selectedRegions[i].seriesIndex,
              selectedRegions[i].pointIndex,
              selectedRegions);
      selectedDataPoints[i].strokeColor =
          selectionSettings.getCircularSelectedItemBorder(
              strokePaint.color,
              selectedRegions[i].seriesIndex,
              selectedRegions[i].pointIndex,
              selectedRegions);
      selectedDataPoints[i].strokeWidth = strokePaint.strokeWidth;
    }
  }

  void _unselectedDataPointColors(
      List<_ChartPoint<dynamic>> unselectedDataPoints,
      dynamic selectionSettings) {
    for (int i = 0; i < unselectedDataPoints.length; i++) {
      final Paint fillPaint =
          getFillColor(false, null, unselectedDataPoints[i]);
      final Paint strokePaint =
          getStrokeColor(false, null, unselectedDataPoints[i]);
      unselectedDataPoints[i].fill =
          selectionSettings.getCircularUnSelectedItemFill(
              fillPaint.color,
              unselectedRegions[i].seriesIndex,
              unselectedRegions[i].pointIndex,
              unselectedRegions);
      unselectedDataPoints[i].strokeColor =
          selectionSettings.getCircularUnSelectedItemBorder(
              strokePaint.color,
              unselectedRegions[i].seriesIndex,
              unselectedRegions[i].pointIndex,
              unselectedRegions);
      unselectedDataPoints[i].strokeWidth = strokePaint.strokeWidth;
    }
  }

  ///Paint method for default fill color settings
  Paint getDefaultFillColor(
      [List<_ChartPoint<dynamic>> points, int point, ChartSegment segment]) {
    final Paint selectedFillPaint = Paint();
    if (series is CartesianSeries) {
      series._seriesType == 'line' ||
              series._seriesType == 'spline' ||
              series._seriesType == 'stepline' ||
              series._seriesType == 'fastline' ||
              series._seriesType == 'stackedline'
          ? selectedFillPaint.color = segment._defaultStrokeColor.color
          : selectedFillPaint.color = segment._defaultFillColor.color;
      if (segment._defaultFillColor.shader != null) {
        selectedFillPaint.shader = segment._defaultFillColor.shader;
      }
    } else {
      selectedFillPaint.color = points[point].color.withOpacity(series.opacity);
      points[point].isSelected = false;
    }
    selectedFillPaint.style = PaintingStyle.fill;
    return selectedFillPaint;
  }

  ///Paint method for default stroke color settings
  Paint getDefaultStrokeColor(
      [List<_ChartPoint<dynamic>> points, int point, ChartSegment segment]) {
    final Paint selectedStrokePaint = Paint();
    if (series is CartesianSeries) {
      selectedStrokePaint.color = segment._defaultStrokeColor.color;
      selectedStrokePaint.strokeWidth = segment._defaultStrokeColor.strokeWidth;
    } else {
      if (series.borderColor != null)
        selectedStrokePaint.color = series.borderColor;
      if (series.borderWidth != null)
        selectedStrokePaint.strokeWidth = series.borderWidth;
    }
    selectedStrokePaint.style = PaintingStyle.stroke;
    return selectedStrokePaint;
  }

  /// Paint method with selected fill color values
  Paint getFillColor(bool isSelection,
      [ChartSegment segment, _ChartPoint<dynamic> point]) {
    final dynamic chartEventSelection = chart.onSelectionChanged;
    if (isSelection) {
      if (series is CartesianSeries) {
        fillColor = chartEventSelection != null &&
                selectionArgs != null &&
                selectionArgs.selectedColor != null
            ? selectionArgs.selectedColor
            : series.selectionSettings.selectedColor == null
                ? segment._defaultFillColor.color
                : series.selectionSettings.selectedColor;
      } else {
        fillColor = chartEventSelection != null &&
                selectionArgs != null &&
                selectionArgs.selectedColor != null
            ? selectionArgs.selectedColor
            : series.selectionSettings.selectedColor == null
                ? point.color
                : series.selectionSettings.selectedColor;
      }
      fillOpacity = chartEventSelection != null &&
              selectionArgs != null &&
              selectionArgs.selectedColor != null
          ? selectionArgs.selectedColor.opacity
          : series.selectionSettings.selectedOpacity == null
              ? series.opacity
              : series.selectionSettings.selectedOpacity;
    } else {
      if (series is CartesianSeries) {
        fillColor = chartEventSelection != null &&
                selectionArgs != null &&
                selectionArgs.unselectedColor != null
            ? selectionArgs.unselectedColor
            : series.selectionSettings.unselectedColor == null
                ? segment._defaultFillColor.color
                : series.selectionSettings.unselectedColor;
      } else {
        fillColor = chartEventSelection != null &&
                selectionArgs != null &&
                selectionArgs.unselectedColor != null
            ? selectionArgs.unselectedColor
            : series.selectionSettings.unselectedColor == null
                ? point.color
                : series.selectionSettings.unselectedColor;
      }
      fillOpacity = chartEventSelection != null &&
              selectionArgs != null &&
              selectionArgs.unselectedColor != null
          ? selectionArgs.unselectedColor.opacity
          : series.selectionSettings.unselectedOpacity == null
              ? series.opacity
              : series.selectionSettings.unselectedOpacity;
    }
    final Paint selectedFillPaint = Paint();
    selectedFillPaint.color = fillColor.withOpacity(fillOpacity);
    selectedFillPaint.style = PaintingStyle.fill;
    return selectedFillPaint;
  }

  /// Paint method with selected stroke color values
  Paint getStrokeColor(bool isSelection,
      [ChartSegment segment, _ChartPoint<dynamic> point]) {
    final dynamic chartEventSelection = chart.onSelectionChanged;
    if (isSelection) {
      if (series is CartesianSeries) {
        series._seriesType == 'line' ||
                series._seriesType == 'spline' ||
                series._seriesType == 'stepline' ||
                series._seriesType == 'fastline' ||
                series._seriesType == 'stackedline'
            ? strokeColor = chartEventSelection != null
                ? selectionArgs.selectedColor
                : series.selectionSettings.selectedColor == null
                    ? segment._defaultFillColor.color
                    : series.selectionSettings.selectedColor
            : strokeColor = chartEventSelection != null &&
                    selectionArgs != null &&
                    selectionArgs.selectedBorderColor != null
                ? selectionArgs.selectedBorderColor
                : series.selectionSettings.selectedBorderColor == null
                    ? series.borderColor
                    : series.selectionSettings.selectedBorderColor;
      } else {
        strokeColor = chartEventSelection != null &&
                selectionArgs != null &&
                selectionArgs.selectedBorderColor != null
            ? selectionArgs.selectedBorderColor
            : series.selectionSettings.selectedBorderColor == null
                ? series.borderColor
                : series.selectionSettings.selectedBorderColor;
      }

      strokeOpacity = chartEventSelection != null &&
              selectionArgs != null &&
              selectionArgs.selectedBorderColor != null
          ? selectionArgs.selectedBorderColor.opacity
          : series.selectionSettings.selectedOpacity == null
              ? series.opacity
              : series.selectionSettings.selectedOpacity;

      strokeWidth = chartEventSelection != null &&
              selectionArgs != null &&
              selectionArgs.selectedBorderWidth != null
          ? selectionArgs.selectedBorderWidth
          : series.selectionSettings.selectedBorderWidth == null
              ? series.borderWidth
              : series.selectionSettings.selectedBorderWidth;
    } else {
      if (series is CartesianSeries) {
        segment is LineSegment ||
                segment is SplineSegment ||
                segment is StepLineSegment ||
                segment is FastLineSegment ||
                segment is StackedLineSegment
            ? strokeColor = chartEventSelection != null && selectionArgs != null
                ? selectionArgs.unselectedColor
                : series.selectionSettings.unselectedColor == null
                    ? segment._defaultFillColor.color
                    : series.selectionSettings.unselectedColor
            : strokeColor = chartEventSelection != null &&
                    selectionArgs != null &&
                    selectionArgs.unselectedBorderColor != null
                ? selectionArgs.unselectedBorderColor
                : series.selectionSettings.unselectedBorderColor == null
                    ? series.borderColor
                    : series.selectionSettings.unselectedBorderColor;
      } else {
        strokeColor = chartEventSelection != null &&
                selectionArgs != null &&
                selectionArgs.unselectedBorderColor != null
            ? selectionArgs.unselectedBorderColor
            : series.selectionSettings.unselectedBorderColor == null
                ? series.borderColor
                : series.selectionSettings.unselectedBorderColor;
      }
      strokeOpacity = chartEventSelection != null &&
              selectionArgs != null &&
              selectionArgs.unselectedColor != null
          ? selectionArgs.unselectedColor.opacity
          : series.selectionSettings.unselectedOpacity == null
              ? series.opacity
              : series.selectionSettings.unselectedOpacity;
      strokeWidth = chartEventSelection != null &&
              selectionArgs != null &&
              selectionArgs.unselectedBorderWidth != null
          ? selectionArgs.unselectedBorderWidth
          : series.selectionSettings.unselectedBorderWidth == null
              ? series.borderWidth
              : series.selectionSettings.unselectedBorderWidth;
    }
    final Paint selectedStrokePaint = Paint();
    selectedStrokePaint.color = strokeColor;
    selectedStrokePaint.strokeWidth = strokeWidth;
    selectedStrokePaint.color.withOpacity(series.opacity);
    selectedStrokePaint.style = PaintingStyle.stroke;
    return selectedStrokePaint;
  }

  /// change color and removing unselected segments from list
  void _changeColorAndPopUnselectedDataPoints(
      List<_ChartPoint<dynamic>> unselectedDataPoints,
      List<_Region> unselectedRegions) {
    int k = unselectedDataPoints.length - 1;
    while (unselectedDataPoints.isNotEmpty) {
      series =
          chart._chartSeries.visibleSeries[unselectedRegions[k].seriesIndex];
      final _ChartPoint<dynamic> currentDataPoint =
          series._renderPoints[unselectedRegions[k].pointIndex];
      final Paint fillPaint = getDefaultFillColor(
          series._renderPoints, unselectedRegions[k].pointIndex);
      currentDataPoint.fill =
          fillPaint.color.withOpacity(fillPaint.color.opacity);
      final Paint strokePaint = getDefaultStrokeColor(
          series._renderPoints, unselectedRegions[k].pointIndex);
      currentDataPoint.strokeColor =
          strokePaint.color.withOpacity(strokePaint.color.opacity);
      currentDataPoint.strokeWidth = strokePaint.strokeWidth;
      unselectedDataPoints.remove(unselectedDataPoints[k]);
      unselectedRegions.remove(unselectedRegions[k]);
      k--;
    }
  }

  /// change color and remove selected segments from list
  bool _changeColorAndPopSelectedDataPoints(
      List<_ChartPoint<dynamic>> selectedDataPoints,
      List<_Region> selectedRegions,
      bool isSamePointSelect) {
    int j = selectedDataPoints.length - 1;
    while (selectedDataPoints.isNotEmpty) {
      series = chart._chartSeries.visibleSeries[selectedRegions[j].seriesIndex];
      final _ChartPoint<dynamic> currentDataPoint =
          series._renderPoints[selectedRegions[j].pointIndex];
      final Paint fillPaint = getDefaultFillColor(
          series._renderPoints, selectedRegions[j].pointIndex);
      currentDataPoint.fill =
          fillPaint.color.withOpacity(fillPaint.color.opacity);
      final Paint strokePaint = getDefaultStrokeColor(
          series._renderPoints, selectedRegions[j].pointIndex);
      currentDataPoint.strokeColor =
          strokePaint.color.withOpacity(strokePaint.color.opacity);
      currentDataPoint.strokeWidth = strokePaint.strokeWidth;
      if (selectedRegions[j].pointIndex == pointIndex &&
          selectedRegions[j].seriesIndex == seriesIndex)
        isSamePointSelect = true;
      selectedDataPoints.remove(selectedDataPoints[j]);
      selectedRegions.remove(selectedRegions[j]);
      j--;
    }
    return isSamePointSelect;
  }

  /// Give selected color for selected segments
  void _selectedSegmentsColors(List<ChartSegment> selectedSegments) {
    for (int i = 0; i < selectedSegments.length; i++) {
      series =
          chart._chartSeries.visibleSeries[selectedSegments[i]._seriesIndex];
      if (series._seriesType != 'area' &&
          series._seriesType != 'fastline' &&
          series._seriesType != 'stackedarea') {
        final ChartSegment currentSegment =
            series.segments[selectedSegments[i].currentSegmentIndex];
        final Paint fillPaint = getFillColor(true, currentSegment);
        currentSegment.fillPaint = series.selectionSettings.getSelectedItemFill(
            fillPaint,
            selectedSegments[i]._seriesIndex,
            selectedSegments[i].currentSegmentIndex,
            selectedSegments);
        final Paint strokePaint = getStrokeColor(true, currentSegment);
        currentSegment.strokePaint = series.selectionSettings
            .getSelectedItemBorder(
                strokePaint,
                selectedSegments[i]._seriesIndex,
                selectedSegments[i].currentSegmentIndex,
                selectedSegments);
      } else {
        final ChartSegment currentSegment = series.segments[0];
        final Paint fillPaint = getFillColor(true, currentSegment);
        currentSegment.fillPaint = series.selectionSettings.getSelectedItemFill(
            fillPaint,
            selectedSegments[i]._seriesIndex,
            selectedSegments[i].currentSegmentIndex,
            selectedSegments);
        final Paint strokePaint = getStrokeColor(true, currentSegment);
        currentSegment.strokePaint = series.selectionSettings
            .getSelectedItemBorder(
                strokePaint,
                selectedSegments[i]._seriesIndex,
                selectedSegments[i].currentSegmentIndex,
                selectedSegments);
      }
    }
  }

  /// Give unselected color for unselected segments
  void _unselectedSegmentsColors(List<ChartSegment> unselectedSegments) {
    for (int i = 0; i < unselectedSegments.length; i++) {
      series =
          chart._chartSeries.visibleSeries[unselectedSegments[i]._seriesIndex];
      if (series._seriesType != 'area' &&
          series._seriesType != 'fastline' &&
          series._seriesType != 'stackedarea') {
        final ChartSegment currentSegment =
            series.segments[unselectedSegments[i].currentSegmentIndex];
        final Paint fillPaint = getFillColor(false, currentSegment);
        currentSegment.fillPaint = series.selectionSettings
            .getUnselectedItemFill(
                fillPaint,
                unselectedSegments[i]._seriesIndex,
                unselectedSegments[i].currentSegmentIndex,
                unselectedSegments);
        final Paint strokePaint = getStrokeColor(false, currentSegment);
        currentSegment.strokePaint = series.selectionSettings
            .getUnselectedItemBorder(
                strokePaint,
                unselectedSegments[i]._seriesIndex,
                unselectedSegments[i].currentSegmentIndex,
                unselectedSegments);
      } else {
        final ChartSegment currentSegment = series.segments[0];
        final Paint fillPaint = getFillColor(false, currentSegment);
        currentSegment.fillPaint = series.selectionSettings
            .getUnselectedItemFill(
                fillPaint,
                unselectedSegments[i]._seriesIndex,
                unselectedSegments[i].currentSegmentIndex,
                unselectedSegments);
        final Paint strokePaint = getStrokeColor(false, currentSegment);
        currentSegment.strokePaint = series.selectionSettings
            .getUnselectedItemBorder(
                strokePaint,
                unselectedSegments[i]._seriesIndex,
                unselectedSegments[i].currentSegmentIndex,
                unselectedSegments);
      }
    }
  }

  /// change color and removing unselected segments from list
  void changeColorAndPopUnselectedSegments(
      List<ChartSegment> unselectedSegments) {
    int k = unselectedSegments.length - 1;
    while (unselectedSegments.isNotEmpty) {
      series =
          chart._chartSeries.visibleSeries[unselectedSegments[k]._seriesIndex];
      if (series._seriesType != 'area' &&
          series._seriesType != 'fastline' &&
          series._seriesType != 'stackedarea') {
        final ChartSegment currentSegment =
            series.segments[unselectedSegments[k].currentSegmentIndex];
        final Paint fillPaint = getDefaultFillColor(null, null, currentSegment);
        currentSegment.fillPaint = fillPaint;
        final Paint strokePaint =
            getDefaultStrokeColor(null, null, currentSegment);
        currentSegment.strokePaint = strokePaint;
        unselectedSegments.remove(unselectedSegments[k]);
        k--;
      } else {
        final ChartSegment currentSegment = series.segments[0];
        final Paint fillPaint = getDefaultFillColor(null, null, currentSegment);
        currentSegment.fillPaint = fillPaint;
        final Paint strokePaint =
            getDefaultStrokeColor(null, null, currentSegment);
        currentSegment.strokePaint = strokePaint;
        unselectedSegments.remove(unselectedSegments[0]);
        k--;
      }
    }
  }

  /// change color and remove selected segments from list
  bool changeColorAndPopSelectedSegments(
      List<ChartSegment> selectedSegments, bool isSamePointSelect) {
    int j = selectedSegments.length - 1;
    while (selectedSegments.isNotEmpty) {
      series =
          chart._chartSeries.visibleSeries[selectedSegments[j]._seriesIndex];
      if (series._seriesType != 'area' &&
          series._seriesType != 'fastline' &&
          series._seriesType != 'stackedarea') {
        final ChartSegment currentSegment =
            series.segments[selectedSegments[j].currentSegmentIndex];
        final Paint fillPaint = getDefaultFillColor(null, null, currentSegment);
        currentSegment.fillPaint = fillPaint;
        final Paint strokePaint =
            getDefaultStrokeColor(null, null, currentSegment);
        currentSegment.strokePaint = strokePaint;
        if (series._seriesType == 'line' ||
            series._seriesType == 'spline' ||
            series._seriesType == 'stepline' ||
            series._seriesType == 'stackedline') {
          if (selectedSegments[j].currentSegmentIndex == cartesianPointIndex &&
              selectedSegments[j]._seriesIndex == cartesianSeriesIndex)
            isSamePointSelect = true;
        } else {
          if (selectedSegments[j].currentSegmentIndex == pointIndex &&
              selectedSegments[j]._seriesIndex == seriesIndex)
            isSamePointSelect = true;
        }
        selectedSegments.remove(selectedSegments[j]);
        j--;
      } else {
        final ChartSegment currentSegment = series.segments[0];
        final Paint fillPaint = getDefaultFillColor(null, null, currentSegment);
        currentSegment.fillPaint = fillPaint;
        final Paint strokePaint =
            getDefaultStrokeColor(null, null, currentSegment);
        currentSegment.strokePaint = strokePaint;
        if (selectedSegments[0]._seriesIndex == seriesIndex)
          isSamePointSelect = true;
        selectedSegments.remove(selectedSegments[0]);
        j--;
      }
    }
    return isSamePointSelect;
  }

  ChartSegment getTappedSegment() {
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      final CartesianSeries<dynamic, dynamic> series =
          chart._chartSeries.visibleSeries[i];
      for (int k = 0; k < series.segments.length; k++) {
        if (series._seriesType != 'area' &&
            series._seriesType != 'fastline' &&
            series._seriesType != 'stackedarea') {
          currentSegment = series.segments[k];
          if (series._seriesType == 'line' ||
              series._seriesType == 'spline' ||
              series._seriesType == 'stepline' ||
              series._seriesType == 'stackedline') {
            if (currentSegment.currentSegmentIndex == cartesianPointIndex &&
                currentSegment._seriesIndex == cartesianSeriesIndex) {
              selectedSegment = series.segments[k];
            }
          } else {
            if (currentSegment.currentSegmentIndex == pointIndex &&
                currentSegment._seriesIndex == seriesIndex) {
              selectedSegment = series.segments[k];
            }
          }
        } else {
          currentSegment = series.segments[0];
          if (currentSegment._seriesIndex == seriesIndex) {
            selectedSegment = series.segments[0];
            break;
          }
        }
      }
    }
    return selectedSegment;
  }

  bool checkPosition() {
    outerLoop:
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      final CartesianSeries<dynamic, dynamic> series =
          chart._chartSeries.visibleSeries[i];
      for (int k = 0; k < series.segments.length; k++) {
        currentSegment = series.segments[k];
        if (currentSegment.currentSegmentIndex == pointIndex &&
            currentSegment._seriesIndex == seriesIndex) {
          isSelected = true;
          break outerLoop;
        } else
          isSelected = false;
      }
    }
    return isSelected;
  }

  /// To ensure selection for cartesian chart type
  bool isCartesianSelection(
      SfCartesianChart chartAssign,
      CartesianSeries<dynamic, dynamic> seriesAssign,
      int pointIndex,
      int seriesIndex) {
    chart = chartAssign;
    series = seriesAssign;

    if (chart.onSelectionChanged != null) {
      chart.onSelectionChanged(
          getSelectionEventArgs(series, seriesIndex, pointIndex));
    }

    /// For point mode
    if (chart.selectionType == SelectionType.point) {
      bool isSamePointSelect = false;

      /// Unselecting the last selected segment
      if (selectedSegments.length == 1)
        changeColorAndPopUnselectedSegments(unselectedSegments);

      /// Executes when multiselectoption is enabled
      bool multiSelect = false;
      if (chart.enableMultiSelection) {
        if (selectedSegments.isNotEmpty) {
          for (int i = chart._chartSeries.visibleSeries.length - 1;
              i >= 0;
              i--) {
            final CartesianSeries<dynamic, dynamic> series =
                chart._chartSeries.visibleSeries[i];

            /// To identify the tapped segment
            for (int k = 0; k < series.segments.length; k++) {
              currentSegment = series.segments[k];
              if (currentSegment.currentSegmentIndex == pointIndex &&
                  currentSegment._seriesIndex == seriesIndex) {
                selectedSegment = series.segments[k];
                break;
              }
            }
          }

          /// To identify that tapped segment in any one of the selected segment
          if (selectedSegment != null) {
            for (int k = 0; k < selectedSegments.length; k++) {
              if (selectedSegment._currentPoint ==
                  selectedSegments[k]._currentPoint) {
                multiSelect = true;
                break;
              }
            }
          }

          /// Executes when tapped again in one of the selected segments
          if (multiSelect) {
            for (int j = selectedSegments.length - 1; j >= 0; j--) {
              series = chart
                  ._chartSeries.visibleSeries[selectedSegments[j]._seriesIndex];
              final ChartSegment currentSegment =
                  series.segments[selectedSegments[j].currentSegmentIndex];

              /// Applying default settings when last selected segment becames unselected
              if ((selectedSegment._currentPoint ==
                      selectedSegments[j]._currentPoint) &&
                  (selectedSegments.length == 1)) {
                final Paint fillPaint =
                    getDefaultFillColor(null, null, currentSegment);
                final Paint strokePaint =
                    getDefaultStrokeColor(null, null, currentSegment);
                currentSegment.fillPaint = fillPaint;
                currentSegment.strokePaint = strokePaint;

                if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                    selectedSegments[j]._seriesIndex == seriesIndex)
                  isSamePointSelect = true;
                selectedSegments.remove(selectedSegments[j]);
              }

              /// Applying unselected color for unselected segments in multiselect option
              else if (selectedSegment._currentPoint ==
                  selectedSegments[j]._currentPoint) {
                final Paint fillPaint = getFillColor(false, currentSegment);
                currentSegment.fillPaint = fillPaint;
                final Paint strokePaint = getStrokeColor(false, currentSegment);
                currentSegment.strokePaint = strokePaint;

                if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                    selectedSegments[j]._seriesIndex == seriesIndex)
                  isSamePointSelect = true;
                unselectedSegments.add(selectedSegments[j]);
                selectedSegments.remove(selectedSegments[j]);
              }
            }
          }
        }
      } else
        isSamePointSelect = changeColorAndPopSelectedSegments(
            selectedSegments, isSamePointSelect);

      /// To check that the selection setting is enable or not
      if (series.selectionSettings.enable) {
        if (!isSamePointSelect) {
          series._seriesType == 'column' ||
                  series._seriesType == 'bar' ||
                  series._seriesType == 'scatter' ||
                  series._seriesType == 'bubble' ||
                  series._seriesType == 'stackedcolumn' ||
                  series._seriesType == 'stackedbar' ||
                  series._seriesType == 'rangecolumn'
              ? isSelected = checkPosition()
              : isSelected = true;
          for (int i = chart._chartSeries.visibleSeries.length - 1;
              i >= 0;
              i--) {
            final CartesianSeries<dynamic, dynamic> series1 =
                chart._chartSeries.visibleSeries[i];
            if (isSelected) {
              for (int j = 0; j < series1.segments.length; j++) {
                currentSegment = series1.segments[j];
                if (currentSegment.currentSegmentIndex == null ||
                    pointIndex == null) {
                  break;
                }
                currentSegment.currentSegmentIndex == pointIndex &&
                        currentSegment._seriesIndex == seriesIndex
                    ? selectedSegments.add(series1.segments[j])
                    : unselectedSegments.add(series1.segments[j]);
              }

              /// Giving color to unselected segments
              _unselectedSegmentsColors(unselectedSegments);

              /// Giving Color to selected segments
              _selectedSegmentsColors(selectedSegments);
            }
          }
        }
      }
    }

    ///For Series Mode
    else if (chart.selectionType == SelectionType.series) {
      bool isSamePointSelect = false;

      for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
        final CartesianSeries<dynamic, dynamic> series =
            chart._chartSeries.visibleSeries[i];
        for (int k = 0; k < series.segments.length; k++) {
          currentSegment = series.segments[k];
          final ChartSegment compareSegment = series.segments[k];
          if (currentSegment.segmentRect != compareSegment.segmentRect)
            isSelected = false;
        }
      }

      /// Executes only when final selected segment became unselected
      if (selectedSegments.length == series.segments.length)
        changeColorAndPopUnselectedSegments(unselectedSegments);

      /// Executes when multiselect option is enabled
      bool multiSelect = false;
      if (chart.enableMultiSelection) {
        if (selectedSegments.isNotEmpty) {
          selectedSegment = getTappedSegment();

          /// To identify that tapped again in any one of the selected segments
          if (selectedSegment != null) {
            for (int k = 0; k < selectedSegments.length; k++) {
              if (seriesIndex == selectedSegments[k]._seriesIndex) {
                multiSelect = true;
                break;
              }
            }
          }

          /// Executes when tapped again in one of the selected segments
          if (multiSelect) {
            ChartSegment currentSegment;
            for (int j = selectedSegments.length - 1; j >= 0; j--) {
              series = chart
                  ._chartSeries.visibleSeries[selectedSegments[j]._seriesIndex];

              if (series._seriesType != 'area' &&
                  series._seriesType != 'fastline' &&
                  series._seriesType != 'stackedarea')
                currentSegment =
                    series.segments[selectedSegments[j].currentSegmentIndex];
              else
                currentSegment = series.segments[0];

              /// Applying series fill when all last selected segment becames unselected
              if (series._seriesType != 'area' &&
                  series._seriesType != 'fastline' &&
                  series._seriesType != 'stackedarea') {
                if ((selectedSegment._seriesIndex ==
                        selectedSegments[j]._seriesIndex) &&
                    (selectedSegments.length <= series.segments.length)) {
                  final Paint fillPaint =
                      getDefaultFillColor(null, null, currentSegment);
                  final Paint strokePaint =
                      getDefaultStrokeColor(null, null, currentSegment);
                  currentSegment.fillPaint = fillPaint;
                  currentSegment.strokePaint = strokePaint;
                  if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                      selectedSegments[j]._seriesIndex == seriesIndex)
                    isSamePointSelect = true;
                  selectedSegments.remove(selectedSegments[j]);
                }

                /// Applying unselected color for unselected segments in multiselect option
                else if (selectedSegment._seriesIndex ==
                    selectedSegments[j]._seriesIndex) {
                  final Paint fillPaint = getFillColor(false, currentSegment);
                  final Paint strokePaint =
                      getStrokeColor(false, currentSegment);
                  currentSegment.fillPaint = fillPaint;
                  currentSegment.strokePaint = strokePaint;
                  if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                      selectedSegments[j]._seriesIndex == seriesIndex)
                    isSamePointSelect = true;
                  unselectedSegments.add(selectedSegments[j]);
                  selectedSegments.remove(selectedSegments[j]);
                }
              } else {
                if ((selectedSegment._seriesIndex ==
                        selectedSegments[j]._seriesIndex) &&
                    (selectedSegments.length <= series.segments.length)) {
                  final Paint fillPaint =
                      getDefaultFillColor(null, null, currentSegment);
                  final Paint strokePaint =
                      getDefaultStrokeColor(null, null, currentSegment);
                  currentSegment.fillPaint = fillPaint;
                  currentSegment.strokePaint = strokePaint;
                  if (selectedSegments[j]._seriesIndex == seriesIndex)
                    isSamePointSelect = true;
                  selectedSegments.remove(selectedSegments[j]);
                }

                /// Applying unselected color for unselected segments in multiselect option
                else if (selectedSegment._seriesIndex ==
                    selectedSegments[j]._seriesIndex) {
                  final Paint fillPaint = getFillColor(false, currentSegment);
                  final Paint strokePaint =
                      getStrokeColor(false, currentSegment);
                  currentSegment.fillPaint = fillPaint;
                  currentSegment.strokePaint = strokePaint;
                  if (selectedSegments[j]._seriesIndex == seriesIndex)
                    isSamePointSelect = true;
                  unselectedSegments.add(selectedSegments[j]);
                  selectedSegments.remove(selectedSegments[j]);
                }
              }
            }
          }
        }
      }

      ///Executes when multiselect is not enable
      else
        isSamePointSelect = changeColorAndPopSelectedSegments(
            selectedSegments, isSamePointSelect);

      /// To identify the Tapped segment
      if (series.selectionSettings.enable) {
        if (!isSamePointSelect) {
          series._seriesType == 'column' ||
                  series._seriesType == 'bar' ||
                  series._seriesType == 'scatter' ||
                  series._seriesType == 'bubble' ||
                  series._seriesType == 'stackedcolumn' ||
                  series._seriesType == 'stackedbar' ||
                  series._seriesType == 'rangecolumn'
              ? isSelected = checkPosition()
              : isSelected = true;
          selectedSegment = getTappedSegment();
          if (isSelected) {
            /// To Push the Selected and Unselected segment
            for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
              final CartesianSeries<dynamic, dynamic> series =
                  chart._chartSeries.visibleSeries[i];
              if (series._seriesType != 'area' &&
                  series._seriesType != 'fastline' &&
                  series._seriesType != 'stackedarea') {
                if (seriesIndex != null) {
                  for (int k = 0; k < series.segments.length; k++) {
                    currentSegment = series.segments[k];
                    currentSegment._seriesIndex == seriesIndex
                        ? selectedSegments.add(series.segments[k])
                        : unselectedSegments.add(series.segments[k]);
                  }
                }
              } else {
                currentSegment = series.segments[0];
                currentSegment._seriesIndex == seriesIndex
                    ? selectedSegments.add(series.segments[0])
                    : unselectedSegments.add(series.segments[0]);
              }

              /// Give Color to the Unselected segment
              _unselectedSegmentsColors(unselectedSegments);

              /// Give Color to the Selected segment
              _selectedSegmentsColors(selectedSegments);
            }
          }
        }
      }
    }

    /// For Cluster Mode
    else if (chart.selectionType == SelectionType.cluster) {
      bool isSamePointSelect = false;

      /// Executes only when last selected segment became unselected
      if (selectedSegments.length == chart._chartSeries.visibleSeries.length)
        changeColorAndPopUnselectedSegments(unselectedSegments);

      /// Executes when multiselect option is enabled
      bool multiSelect = false;
      if (chart.enableMultiSelection) {
        if (selectedSegments.isNotEmpty) {
          selectedSegment = getTappedSegment();

          /// To identify that tapped again in any one of the selected segment
          if (selectedSegment != null) {
            for (int k = 0; k < selectedSegments.length; k++) {
              if (selectedSegment.currentSegmentIndex ==
                  selectedSegments[k].currentSegmentIndex) {
                multiSelect = true;
                break;
              }
            }
          }

          /// Executes when tapped again in one of the selected segment
          if (multiSelect) {
            for (int j = selectedSegments.length - 1; j >= 0; j--) {
              series = chart
                  ._chartSeries.visibleSeries[selectedSegments[j]._seriesIndex];
              final ChartSegment currentSegment =
                  series.segments[selectedSegments[j].currentSegmentIndex];

              /// Applying default settings when last selected segment becames unselected
              if ((selectedSegment.currentSegmentIndex ==
                      selectedSegments[j].currentSegmentIndex) &&
                  (selectedSegments.length <=
                      chart._chartSeries.visibleSeries.length)) {
                final Paint fillPaint =
                    getDefaultFillColor(null, null, currentSegment);
                final Paint strokePaint =
                    getDefaultStrokeColor(null, null, currentSegment);
                currentSegment.fillPaint = fillPaint;
                currentSegment.strokePaint = strokePaint;

                if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                    selectedSegments[j]._seriesIndex == seriesIndex)
                  isSamePointSelect = true;

                selectedSegments.remove(selectedSegments[j]);
              }

              /// Applying unselected color for unselected segment in multiselect option
              else if (selectedSegment.currentSegmentIndex ==
                  selectedSegments[j].currentSegmentIndex) {
                final Paint fillPaint = getFillColor(false, currentSegment);
                final Paint strokePaint = getStrokeColor(false, currentSegment);
                currentSegment.fillPaint = fillPaint;
                currentSegment.strokePaint = strokePaint;

                if (selectedSegments[j].currentSegmentIndex == pointIndex &&
                    selectedSegments[j]._seriesIndex == seriesIndex)
                  isSamePointSelect = true;

                unselectedSegments.add(selectedSegments[j]);
                selectedSegments.remove(selectedSegments[j]);
              }
            }
          }
        }
      }

      ///Executes when multiselect is not enable
      else
        isSamePointSelect = changeColorAndPopSelectedSegments(
            selectedSegments, isSamePointSelect);

      /// To identify the Tapped segment
      if (series.selectionSettings.enable) {
        if (!isSamePointSelect) {
          final bool isSegmentSeries = series._seriesType == 'column' ||
              series._seriesType == 'bar' ||
              series._seriesType == 'scatter' ||
              series._seriesType == 'bubble' ||
              series._seriesType == 'stackedcolumn' ||
              series._seriesType == 'stackedbar' ||
              series._seriesType == 'rangecolumn';
          selectedSegment = getTappedSegment();
          isSegmentSeries ? isSelected = checkPosition() : isSelected = true;
          if (isSelected) {
            /// To Push the Selected and Unselected segments
            for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
              final CartesianSeries<dynamic, dynamic> series =
                  chart._chartSeries.visibleSeries[i];
              if (series.selectionSettings.enable) {
                if (currentSegment.currentSegmentIndex == null ||
                    pointIndex == null) {
                  break;
                }
                for (int k = 0; k < series.segments.length; k++) {
                  currentSegment = series.segments[k];

                  if (isSegmentSeries) {
                    currentSegment._currentPoint.xValue ==
                            selectedSegment._currentPoint.xValue
                        ? selectedSegments.add(series.segments[k])
                        : unselectedSegments.add(series.segments[k]);
                  } else {
                    currentSegment.currentSegmentIndex ==
                            selectedSegment.currentSegmentIndex
                        ? selectedSegments.add(series.segments[k])
                        : unselectedSegments.add(series.segments[k]);
                  }
                }
              }
            }

            /// Giving color to unselected segments
            _unselectedSegmentsColors(unselectedSegments);

            /// Giving Color to selected segments
            _selectedSegmentsColors(selectedSegments);
          }
        }
      }
    }
    return isSelected;
  }

// To get point index and series index
  void getPointAndSeriesIndex(SfCartesianChart chart, Offset position,
      CartesianSeries<dynamic, dynamic> series) {
    ChartSegment currentSegment, selectedSegment;
    for (int k = 0; k < series.segments.length; k++) {
      currentSegment = series.segments[k];
      if (currentSegment.segmentRect.contains(position)) {
        selectedSegment = series.segments[k];
      }
    }
    if (selectedSegment == null) {
      series.selectionSettings._selectionRenderer.pointIndex = null;
      series.selectionSettings._selectionRenderer.seriesIndex = null;
    } else {
      series.selectionSettings._selectionRenderer.pointIndex =
          selectedSegment.currentSegmentIndex;
      series.selectionSettings._selectionRenderer.seriesIndex =
          selectedSegment._seriesIndex;
    }
  }

// To check that touch point is lies in segment
  bool isLineIntersect(
      _CartesianChartPoint<dynamic> segmentStartPoint,
      _CartesianChartPoint<dynamic> segmentEndPoint,
      _CartesianChartPoint<dynamic> touchStartPoint,
      _CartesianChartPoint<dynamic> touchEndPoint) {
    final int topPos =
        getPointDirection(segmentStartPoint, segmentEndPoint, touchStartPoint);
    final int botPos =
        getPointDirection(segmentStartPoint, segmentEndPoint, touchEndPoint);
    final int leftPos =
        getPointDirection(touchStartPoint, touchEndPoint, segmentStartPoint);
    final int rightPos =
        getPointDirection(touchStartPoint, touchEndPoint, segmentEndPoint);

    return topPos != botPos && leftPos != rightPos;
  }

  /// To get the segment points direction
  static int getPointDirection(
      _CartesianChartPoint<dynamic> point1,
      _CartesianChartPoint<dynamic> point2,
      _CartesianChartPoint<dynamic> point3) {
    final int value = (((point2.y - point1.y) * (point3.x - point2.x)) -
            ((point2.x - point1.x) * (point3.y - point2.y)))
        .toInt();

    if (value == 0) {
      return 0;
    }

    return (value > 0) ? 1 : 2;
  }

  /// To identify that series contains a given point
  bool _isSeriesContainsPoint(dynamic series, Offset position) {
    dynamic dataPointIndex;
    ChartSegment startSegment;
    ChartSegment endSegment;
    final List<dynamic> nearestDataPoints = _getNearestChartPoints(
        position.dx, position.dy, series._xAxis, series._yAxis, series);
    if (nearestDataPoints == null) {
      return false;
    }
    for (dynamic dataPoint in nearestDataPoints) {
      dataPointIndex = series._dataPoints.indexOf(dataPoint);
    }

    if (dataPointIndex != null) {
      if (dataPointIndex == 0)
        startSegment = series.segments[dataPointIndex];
      else if (dataPointIndex == series._dataPoints.length - 1)
        startSegment = series.segments[dataPointIndex - 1];
      else {
        startSegment = series.segments[dataPointIndex - 1];
        endSegment = series.segments[dataPointIndex];
      }

      startSegment != null
          ? cartesianSeriesIndex = startSegment._seriesIndex
          : cartesianSeriesIndex = endSegment._seriesIndex;

      startSegment != null
          ? cartesianPointIndex = startSegment.currentSegmentIndex
          : cartesianPointIndex = endSegment.currentSegmentIndex;

      if (startSegment != null) {
        if (_isSegmentIntersect(startSegment, position.dx, position.dy)) {
          return true;
        }
      }

      if (endSegment != null)
        return _isSegmentIntersect(endSegment, position.dx, position.dy);
    }
    return false;
  }

  /// To identify the cartesian point index
  int getCartesianPointIndex(Offset position) {
    final List<dynamic> firstNearestDataPoints = <dynamic>[];
    dynamic previousIndex, nextIndex;
    dynamic dataPointIndex,
        previousDataPointIndex,
        nextDataPointIndex,
        nearestDataPointIndex;
    final List<dynamic> nearestDataPoints = _getNearestChartPoints(
        position.dx, position.dy, series._xAxis, series._yAxis, series);

    for (dynamic dataPoint in nearestDataPoints) {
      dataPointIndex = series._dataPoints.indexOf(dataPoint);
      previousIndex = series._dataPoints.indexOf(dataPoint) - 1;
      previousIndex < 0
          ? previousDataPointIndex = dataPointIndex
          : previousDataPointIndex = previousIndex;
      nextIndex = series._dataPoints.indexOf(dataPoint) + 1;
      nextIndex > series._dataPoints.length - 1
          ? nextDataPointIndex = dataPointIndex
          : nextDataPointIndex = nextIndex;
    }

    firstNearestDataPoints.add(series._dataPoints[previousDataPointIndex]);
    firstNearestDataPoints.add(series._dataPoints[nextDataPointIndex]);
    final List<dynamic> firstNearestPoints = _getNearestChartPoints(
        position.dx,
        position.dy,
        series._xAxis,
        series._yAxis,
        series,
        firstNearestDataPoints);

    for (dynamic dataPoint in firstNearestPoints) {
      if (dataPointIndex < series._dataPoints.indexOf(dataPoint))
        nearestDataPointIndex = dataPointIndex;
      else if (dataPointIndex == series._dataPoints.indexOf(dataPoint)) {
        series._dataPoints.indexOf(dataPoint) - 1 < 0
            ? nearestDataPointIndex = series._dataPoints.indexOf(dataPoint)
            : nearestDataPointIndex = series._dataPoints.indexOf(dataPoint) - 1;
      } else
        nearestDataPointIndex = series._dataPoints.indexOf(dataPoint);
    }
    series.selectionSettings._selectionRenderer.cartesianPointIndex =
        nearestDataPointIndex;
    return nearestDataPointIndex;
  }

  /// To know the segment is intersect with touch point
  bool _isSegmentIntersect(
      ChartSegment segment, double touchX1, double touchY1) {
    dynamic currentSegment;
    if (segment is LineSegment ||
        segment is SplineSegment ||
        segment is StepLineSegment ||
        segment is StackedLineSegment) {
      currentSegment = segment;
    }
    final dynamic x1 = currentSegment.x1;
    final dynamic y1 = currentSegment.y1;
    final dynamic x2 = currentSegment.x2;
    final dynamic y2 = currentSegment.y2;

    final dynamic leftPoint =
        _CartesianChartPoint<dynamic>(touchX1 - 20, touchY1 - 20);
    final dynamic rightPoint =
        _CartesianChartPoint<dynamic>(touchX1 + 20, touchY1 + 20);
    final dynamic topPoint =
        _CartesianChartPoint<dynamic>(touchX1 + 20, touchY1 - 20);
    final dynamic bottomPoint =
        _CartesianChartPoint<dynamic>(touchX1 - 20, touchY1 + 20);

    final _CartesianChartPoint<dynamic> startSegment =
        _CartesianChartPoint<dynamic>(x1, y1);
    final _CartesianChartPoint<dynamic> endSegment =
        _CartesianChartPoint<dynamic>(x2, y2);

    if (isLineIntersect(startSegment, endSegment, leftPoint, rightPoint) ||
        isLineIntersect(startSegment, endSegment, topPoint, bottomPoint)) {
      return true;
    }

    if (series is StepLineSeries) {
      final dynamic x3 = currentSegment.x3;
      final dynamic y3 = currentSegment.y3;
      final dynamic x2 = currentSegment.x2;
      final dynamic y2 = currentSegment.y2;
      final _CartesianChartPoint<dynamic> endSegment =
          _CartesianChartPoint<dynamic>(x2, y2);
      final _CartesianChartPoint<dynamic> midSegment =
          _CartesianChartPoint<dynamic>(x3, y3);
      if (isLineIntersect(endSegment, midSegment, leftPoint, rightPoint) ||
          isLineIntersect(endSegment, midSegment, topPoint, bottomPoint)) {
        return true;
      }
    }
    return false;
  }

  void getSeriesIndex(SfCartesianChart chart, Offset position,
      CartesianSeries<dynamic, dynamic> series) {
    Rect currentSegment;
    int seriesIndex;
    _CartesianChartPoint<dynamic> point;
    _ChartLocation currentPoint;
    final num markerHeight = series.markerSettings.height,
        markerWidth = series.markerSettings.width;
    outerLoop:
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      final CartesianSeries<dynamic, dynamic> series =
          chart._chartSeries.visibleSeries[i];
      for (int j = 0; j < series._dataPoints.length; j++) {
        point = series._dataPoints[j];
        currentPoint = _calculatePoint(
            point.xValue,
            point.yValue,
            series._xAxis,
            series._yAxis,
            chart._requireInvertedAxis,
            series,
            chart._chartAxis._axisClipRect);
        point.region = Rect.fromLTWH(currentPoint.x - markerWidth,
            currentPoint.y - markerHeight, 2 * markerWidth, 2 * markerHeight);
        currentSegment = point.region;
        if (currentSegment.contains(position)) {
          seriesIndex = i;
          break outerLoop;
        }
      }
    }
    series.selectionSettings._selectionRenderer.seriesIndex = seriesIndex;
  }

  /// To ensure selection for circular chart type
  bool isCircularSelection(
      SfCircularChart circularChart,
      CircularSeries<dynamic, dynamic> circularSeries,
      int pointIndex,
      int seriesIndex) {
    chart = circularChart;
    if (chart.onSelectionChanged != null) {
      chart.onSelectionChanged(
          getSelectionEventArgs(series, seriesIndex, pointIndex));
    }
    bool isSamePointSelect = false;
    chart._chartState.initialRender = false;

    /// Unselecting the last selected segment
    if (selectedDataPoints.length == 1) {
      _changeColorAndPopUnselectedDataPoints(
          unselectedDataPoints, unselectedRegions);
    }
    bool multiSelect = false;
    if (chart.enableMultiSelection) {
      if (selectedDataPoints.isNotEmpty) {
        for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
          final CircularSeries<dynamic, dynamic> series =
              chart._chartSeries.visibleSeries[i];

          /// To identify the tapped Region
          for (int k = 0; k < series._pointRegions.length; k++) {
            currentRegion = series._pointRegions[k];
            if (currentRegion.pointIndex == pointIndex &&
                currentRegion.seriesIndex == seriesIndex) {
              selectedRegion = series._pointRegions[k];
              selectedDataPoint =
                  series._renderPoints[selectedRegion.pointIndex];
              break;
            }
          }
        }

        /// To identify that tapped segment in any one of the selected regions
        if (selectedRegion != null) {
          for (int k = 0; k < selectedRegions.length; k++) {
            if (selectedDataPoint == selectedDataPoints[k]) {
              multiSelect = true;
              break;
            }
          }
        }

        /// Executes when tapped again in one of the selected segments
        if (multiSelect) {
          for (int j = selectedDataPoints.length - 1; j >= 0; j--) {
            series = chart
                ._chartSeries.visibleSeries[selectedRegions[j].seriesIndex];
            currentRegion = series._pointRegions[selectedRegions[j].pointIndex];
            currentDataPoint =
                series._renderPoints[selectedRegions[j].pointIndex];

            /// Applying default settings when last selected segment becames unselected
            if ((selectedDataPoint == selectedDataPoints[j]) &&
                (selectedDataPoints.length == 1)) {
              final Paint fillPaint = getDefaultFillColor(
                  series._renderPoints, selectedRegions[j].pointIndex);
              final Paint strokePaint = getDefaultStrokeColor(
                  series._renderPoints, selectedRegions[j].pointIndex);
              currentDataPoint.fill = fillPaint.color;
              currentDataPoint.strokeColor = strokePaint.color;

              if (selectedRegions[j].pointIndex == pointIndex &&
                  selectedRegions[j].seriesIndex == seriesIndex)
                isSamePointSelect = true;
              selectedDataPoints.remove(selectedDataPoints[j]);
              selectedRegions.remove(selectedRegions[j]);
            }

            /// Applying unselected color for unselected segments in multiselect option
            else if (selectedDataPoint == selectedDataPoints[j]) {
              final Paint fillPaint =
                  getFillColor(false, null, currentDataPoint);
              currentDataPoint.fill =
                  fillPaint.color.withOpacity(fillPaint.color.opacity);
              final Paint strokePaint =
                  getStrokeColor(false, null, currentDataPoint);
              currentDataPoint.strokeColor =
                  strokePaint.color.withOpacity(strokePaint.color.opacity);
              currentDataPoint.strokeWidth = strokePaint.strokeWidth;
              if (selectedRegions[j].pointIndex == pointIndex &&
                  selectedRegions[j].seriesIndex == seriesIndex)
                isSamePointSelect = true;
              unselectedDataPoints.add(selectedDataPoints[j]);
              selectedDataPoints[j].isSelected = false;
              selectedDataPoints.remove(selectedDataPoints[j]);
              unselectedRegions.add(selectedRegions[j]);
              selectedRegions.remove(selectedRegions[j]);
            }
          }
        }
      }
    } else
      isSamePointSelect = _changeColorAndPopSelectedDataPoints(
          selectedDataPoints, selectedRegions, isSamePointSelect);

    if (series.selectionSettings.enable) {
      if (!isSamePointSelect) {
        isSelected = true;
        for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
          final CircularSeries<dynamic, dynamic> series =
              chart._chartSeries.visibleSeries[i];
          if (isSelected) {
            for (int j = 0; j < series._renderPoints.length; j++) {
              currentRegion = series._pointRegions[j];
              if (currentRegion.pointIndex == null || pointIndex == null) {
                break;
              }

              if (currentRegion.pointIndex == pointIndex &&
                  currentRegion.seriesIndex == seriesIndex) {
                selectedDataPoints.add(series._renderPoints[j]);
                selectedRegions.add(series._pointRegions[j]);
                series._renderPoints[j].isSelected = true;
              } else {
                unselectedDataPoints.add(series._renderPoints[j]);
                unselectedRegions.add(series._pointRegions[j]);
                series._renderPoints[j].isSelected = false;
              }
            }

            /// Giving color to unselected segments
            _unselectedDataPointColors(
                unselectedDataPoints, series.selectionSettings);

            /// Giving Color to selected segments
            _selectedDataPointColors(
                selectedDataPoints, series.selectionSettings);
          }
        }
      }
    }
    return isSelected;
  }

  /// To do selection for cartesian type chart.
  void performSelection(Offset position) {
    bool select = false;
    bool isSelect = false;
    int cartesianPointIndex;
    if (series._seriesType == 'line' ||
        series._seriesType == 'spline' ||
        series._seriesType == 'stepline' ||
        series._seriesType == 'stackedline') {
      isSelect = series.selectionSettings.enable
          ? _isSeriesContainsPoint(series, position)
          : false;
      if (isSelect) {
        cartesianPointIndex = getCartesianPointIndex(position);
        select = series.selectionSettings._selectionRenderer
            .isCartesianSelection(
                chart, series, cartesianPointIndex, cartesianSeriesIndex);
      }
    } else {
      chart._chartState.renderDatalabelRegions = <Rect>[];
      if (series._seriesType == 'area' ||
          series._seriesType == 'stackedarea' ||
          series._seriesType == 'fastline')
        getSeriesIndex(chart, position, series);
      else
        getPointAndSeriesIndex(chart, position, series);
      select = series.selectionSettings._selectionRenderer
          .isCartesianSelection(chart, series, pointIndex, seriesIndex);
    }

    if (select)
      ValueNotifier<int>(chart._chartState.seriesRepaintNotifier.value++);
  }

  void _checkWithSelectionState(
      ChartSegment currentSegment, SfCartesianChart chart) {
    bool isSelected = false;
    final List<ChartSegment> newSelectedSegments = <ChartSegment>[];
    final List<ChartSegment> newUnSelectedSegments = <ChartSegment>[];
    if (selectedSegments.isNotEmpty) {
      for (int i = 0; i < selectedSegments.length; i++) {
        if (selectedSegments[i]._seriesIndex == currentSegment._seriesIndex &&
            selectedSegments[i].currentSegmentIndex ==
                currentSegment.currentSegmentIndex) {
          newSelectedSegments.add(currentSegment);
          isSelected = true;
          break;
        }
      }
      _selectedSegmentsColors(selectedSegments);
    }

    if (!isSelected && unselectedSegments.isNotEmpty) {
      for (int i = 0; i < unselectedSegments.length; i++) {
        if (unselectedSegments[i]._seriesIndex == currentSegment._seriesIndex &&
            unselectedSegments[i].currentSegmentIndex ==
                currentSegment.currentSegmentIndex) {
          newUnSelectedSegments.add(currentSegment);
          isSelected = true;
          break;
        }
      }
      _unselectedSegmentsColors(unselectedSegments);
    }
  }

  /// To do user interaction selection for circular chart type.
  void performCircularSelection(int pointIndex, int seriesIndex) {
    bool select = false;
    series.selectionSettings._selectionRenderer.seriesIndex = seriesIndex;
    series.selectionSettings._selectionRenderer.pointIndex = pointIndex;
    select = series.selectionSettings._selectionRenderer
        .isCircularSelection(chart, series, pointIndex, seriesIndex);
    if (select)
      ValueNotifier<int>(chart._chartState.seriesRepaintNotifier.value++);
  }

  SelectionArgs getSelectionEventArgs(
      dynamic series, num seriesIndex, num pointIndex) {
    if (series != null) {
      selectionArgs = SelectionArgs();
      selectionArgs.series = series;
      selectionArgs.selectedBorderColor =
          series.selectionSettings.selectedBorderColor;
      selectionArgs.selectedBorderWidth =
          series.selectionSettings.selectedBorderWidth;
      selectionArgs.selectedColor = series.selectionSettings.selectedColor;
      selectionArgs.unselectedBorderColor =
          series.selectionSettings.unselectedBorderColor;
      selectionArgs.unselectedBorderWidth =
          series.selectionSettings.unselectedBorderWidth;
      selectionArgs.unselectedColor = series.selectionSettings.unselectedColor;
      selectionArgs.seriesIndex = seriesIndex;
      selectionArgs.pointIndex = pointIndex;
    }
    return selectionArgs;
  }
}
