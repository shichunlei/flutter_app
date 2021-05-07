part of flutter_charts;

class _ChartTheme {
  _ChartTheme();
  Color axisLabelColor;
  Color axisTitleColor;
  Color axisLineColor;
  Color majorGridLineColor;
  Color minorGridLineColor;
  Color majorTickLineColor;
  Color minorTickLineColor;
  Color chartTitleColor;
  Color titleBackgroundColor;
  Color legendLabelColor;
  Color legendTitleColor;
  Color legendBackGroundColor;
  Color plotAreaBackgroundColor;
  Color crosshairLineColor;
  Color crosshairFillColor;
  Color crosshairLabelColor;
  Color tooltipFillColor;
  Color tooltipLabelColor;
  Color tooltipHeaderLineColor;
  Color selectionRectFillColor;
  Color selectionRectStrokeColor;
  Color selectionTooltipConnectorLineColor;
  Brightness brightness;

  void initializeChartTheme(ThemeData theme) {
    switch (theme.brightness) {
      case Brightness.light:
        {
          axisLabelColor = const Color.fromRGBO(104, 104, 104, 1);
          axisTitleColor = const Color.fromRGBO(66, 66, 66, 1);
          axisLineColor = const Color.fromRGBO(181, 181, 181, 1);
          majorGridLineColor = const Color.fromRGBO(219, 219, 219, 1);
          minorGridLineColor = const Color.fromRGBO(234, 234, 234, 1);
          majorTickLineColor = const Color.fromRGBO(181, 181, 181, 1);
          minorTickLineColor = const Color.fromRGBO(214, 214, 214, 1);
          chartTitleColor = const Color.fromRGBO(66, 66, 66, 1);
          titleBackgroundColor = Colors.transparent;
          legendLabelColor = const Color.fromRGBO(53, 53, 53, 1);
          legendBackGroundColor = const Color.fromRGBO(255, 255, 255, 1);
          legendTitleColor = const Color.fromRGBO(66, 66, 66, 1);
          plotAreaBackgroundColor = Colors.transparent;
          crosshairLineColor = const Color.fromRGBO(79, 79, 79, 1);
          crosshairFillColor = const Color.fromRGBO(79, 79, 79, 1);
          crosshairLabelColor = const Color.fromRGBO(229, 229, 229, 1);
          tooltipFillColor = const Color.fromRGBO(0, 8, 22, 0.75);
          tooltipLabelColor = const Color.fromRGBO(255, 255, 255, 1);
          tooltipHeaderLineColor = const Color.fromRGBO(255, 255, 255, 1);
          selectionRectFillColor = const Color.fromRGBO(41, 171, 226, 0.1);
          selectionRectStrokeColor = const Color.fromRGBO(41, 171, 226, 1);
          selectionTooltipConnectorLineColor =
              const Color.fromRGBO(79, 79, 79, 1);
          brightness = Brightness.light;
          break;
        }
      case Brightness.dark:
        {
          axisLabelColor = const Color.fromRGBO(242, 242, 242, 1);
          axisTitleColor = const Color.fromRGBO(255, 255, 255, 1);
          axisLineColor = const Color.fromRGBO(255, 255, 255, 1);
          majorGridLineColor = const Color.fromRGBO(70, 74, 86, 1);
          minorGridLineColor = const Color.fromRGBO(70, 74, 86, 1);
          majorTickLineColor = const Color.fromRGBO(191, 191, 191, 1);
          minorTickLineColor = const Color.fromRGBO(150, 150, 150, 1);
          chartTitleColor = const Color.fromRGBO(255, 255, 255, 1);
          titleBackgroundColor = Colors.transparent;
          legendLabelColor = const Color.fromRGBO(255, 255, 255, 1);
          legendBackGroundColor = const Color.fromRGBO(0, 0, 0, 1);
          legendTitleColor = const Color.fromRGBO(255, 255, 255, 1);
          plotAreaBackgroundColor = Colors.transparent;
          crosshairLineColor = const Color.fromRGBO(255, 255, 255, 1);
          crosshairFillColor = const Color.fromRGBO(255, 255, 255, 1);
          crosshairLabelColor = const Color.fromRGBO(0, 0, 0, 1);
          tooltipFillColor = const Color.fromRGBO(255, 255, 255, 1);
          tooltipLabelColor = const Color.fromRGBO(0, 0, 0, 1);
          tooltipHeaderLineColor = const Color.fromRGBO(150, 150, 150, 1);
          selectionRectFillColor = const Color.fromRGBO(255, 217, 57, 0.3);
          selectionRectStrokeColor = const Color.fromRGBO(255, 255, 255, 1);
          selectionTooltipConnectorLineColor =
              const Color.fromRGBO(150, 150, 150, 1);
          brightness = Brightness.dark;
          break;
        }
      default:
        {
          axisLabelColor = const Color.fromRGBO(104, 104, 104, 1);
          axisTitleColor = const Color.fromRGBO(66, 66, 66, 1);
          axisLineColor = const Color.fromRGBO(181, 181, 181, 1);
          majorGridLineColor = const Color.fromRGBO(219, 219, 219, 1);
          minorGridLineColor = const Color.fromRGBO(234, 234, 234, 1);
          majorTickLineColor = const Color.fromRGBO(181, 181, 181, 1);
          minorTickLineColor = const Color.fromRGBO(214, 214, 214, 1);
          chartTitleColor = const Color.fromRGBO(66, 66, 66, 1);
          titleBackgroundColor = Colors.transparent;
          legendLabelColor = const Color.fromRGBO(53, 53, 53, 1);
          legendBackGroundColor = const Color.fromRGBO(255, 255, 255, 1);
          legendTitleColor = const Color.fromRGBO(66, 66, 66, 1);
          plotAreaBackgroundColor = Colors.transparent;
          crosshairLineColor = const Color.fromRGBO(79, 79, 79, 1);
          crosshairFillColor = const Color.fromRGBO(79, 79, 79, 1);
          crosshairLabelColor = const Color.fromRGBO(229, 229, 229, 1);
          tooltipFillColor = const Color.fromRGBO(0, 8, 22, 0.75);
          tooltipLabelColor = const Color.fromRGBO(255, 255, 255, 1);
          tooltipHeaderLineColor = const Color.fromRGBO(255, 255, 255, 1);
          selectionRectFillColor = const Color.fromRGBO(41, 171, 226, 0.1);
          selectionRectStrokeColor = const Color.fromRGBO(41, 171, 226, 1);
          selectionTooltipConnectorLineColor =
              const Color.fromRGBO(79, 79, 79, 1);
          brightness = Brightness.light;
          break;
        }
    }
  }
}
