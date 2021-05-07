part of flutter_charts;

class _PointInfo<D> {
  _PointInfo(this.x, this.y);
  dynamic x;
  num y;
  String text;
  Color fill;
  Color color;
  Color borderColor;
  D sortValue;
  num borderWidth;
  bool isExplode;
  bool isShadow;
  bool isEmpty = false;
  bool isVisible = true;
  bool isSelected = false;
  Position dataLabelPosition;
  ChartDataLabelPosition renderPosition;
  Rect labelRect;
  Size dataLabelSize = const Size(0, 0);
  bool saturationRegionOutside = false;
  num yRatio;
  num heightRatio;
  List<Offset> pathRegion;
  Rect region;
  Offset symbolLocation;
  num explodeDistance;
}
