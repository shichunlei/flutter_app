import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DragBean
class DragBean {
  DragBean({this.index, this.selected = false, this.path});

  int index;
  bool selected;
  String path;
}

/// on drag listener.
/// if return true, delete drag index child image. default return false.
typedef OnDragListener = bool Function(MotionEvent event, double itemWidth);

/// Object used to report movement events.
class MotionEvent {
  static const int actionDown = 0;
  static const int actionUp = 1;
  static const int actionMove = 2;

  /// action.
  int action;

  /// drag index.
  int dragIndex;

  /// the global x coordinate system in logical pixels.
  double globalX;

  /// the global y coordinate system in logical pixels.
  double globalY;
}

/// Drag sort view.
/// Similar to the dynamic nine grid of weiBo / weChat publishing.
/// It supports pressing the zoom effect, dragging and sorting, and dragging to the specified location to delete.
class DragSortView extends StatefulWidget {
  /// create DragSortView.
  /// It is recommended to use a thumbnail picture，because the original picture is too large, it may cause repeated loading and cause flashing.
  /// 建议使用略微缩图，因为原图太大可能会引起重复加载导致闪动.
  DragSortView(
    this.data, {
    Key key,
    this.width,
    this.space = 5,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    @required this.itemBuilder,
    @required this.initBuilder,
    this.onDragListener,
  })  : assert(data != null),
        assert(itemBuilder != null),
        assert(initBuilder != null),
        super(key: key);

  /// picture data.
  final List<DragBean> data;

  /// View width.
  final double width;

  /// The number of logical pixels between each child.
  final double space;

  /// View padding.
  final EdgeInsets padding;

  /// View margin.
  final EdgeInsets margin;

  /// Called to build children for the view.
  final IndexedWidgetBuilder itemBuilder;

  /// Called to build init children for the view.
  final WidgetBuilder initBuilder;

  /// On drag listener.
  final OnDragListener onDragListener;

  @override
  createState() => DragSortViewState();
}

class DragSortViewState extends State<DragSortView>
    with TickerProviderStateMixin {
  /// child transposition anim.
  AnimationController _controller;

  /// child zoom anim.
  AnimationController _zoomController;

  /// child float anim.
  AnimationController _floatController;

  /// child positions.
  List<Rect> _positions = List();

  /// cache data.
  List<DragBean> _cacheData = List();

  /// drag child index.
  int _dragIndex = -1;

  /// drag child bean.
  DragBean _dragBean;

  /// MotionEvent
  MotionEvent _motionEvent;

  /// overlay entry.
  static OverlayEntry _overlayEntry;

  /// child count.
  int _itemCount = 0;

  /// child width.
  double _itemWidth = 0;

  Offset _downGlobalPos;
  double _downLeft;
  double _downTop;
  double _floatLeft = 0;
  double _floatTop = 0;
  double _fromTop = 0;
  double _fromLeft = 0;
  double _toTop = 0;
  double _toLeft = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _zoomController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _floatController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    _zoomController.addListener(() {
      _updateOverlay();
    });
    _floatController.addListener(() {
      _floatLeft =
          _toLeft + (_fromLeft - _toLeft) * (1 - _floatController.value);
      _floatTop = _toTop + (_fromTop - _toTop) * (1 - _floatController.value);
      _updateOverlay();
    });
    _floatController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _clearAll();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _zoomController?.dispose();
    _floatController?.dispose();
    _removeOverlay();
    super.dispose();
  }

  /// init child size and positions.
  void _init(BuildContext context, EdgeInsets padding, EdgeInsets margin) {
    double space = widget.space;
    double width = widget.width ??
        (MediaQuery.of(context).size.width - margin.left - margin.right);
    width = width - padding.left - padding.right;
    _itemWidth = (width - space * 2) / 3;
    _positions.clear();
    for (int i = 0; i < 9; i++) {
      double left = (space + _itemWidth) * (i % 3);
      double top = (space + _itemWidth) * (i ~/ 3);
      _positions.add(Rect.fromLTWH(left, top, _itemWidth, _itemWidth));
    }
  }

  /// get widget global coordinate system in logical pixels.
  Offset _getWidgetLocalToGlobal(BuildContext context) {
    RenderBox box = context.findRenderObject();
    return box == null ? Offset.zero : box.localToGlobal(Offset.zero);
  }

  /// get drag index.
  int _getDragIndex(Offset offset) {
    for (int i = 0; i < _itemCount; i++) {
      if (_positions[i].contains(offset)) {
        return i;
      }
    }
    return -1;
  }

  /// init child index.
  void _initIndex() {
    for (int i = 0; i < _itemCount; i++) {
      widget.data[i].index = i;
    }
    _cacheData.clear();
    _cacheData.addAll(widget.data);
  }

  /// add overlay.
  void _addOverlay(BuildContext context, Widget overlay) {
    OverlayState overlayState = Overlay.of(context);
    double space = widget.space;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext context) {
        return Positioned(
            left: _floatLeft - space * _zoomController.value,
            top: _floatTop - space * _zoomController.value,
            child: Material(
                child: Container(
                    width: _itemWidth + space * _zoomController.value * 2,
                    height: _itemWidth + space * _zoomController.value * 2,
                    color: Colors.redAccent,
                    child: overlay)));
      });
      overlayState.insert(_overlayEntry);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }
    _zoomController.reset();
    _zoomController.forward();
  }

  /// update overlay.
  void _updateOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.markNeedsBuild();
    }
  }

  /// remove overlay.
  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  /// get next child index.
  int _getNextIndex(Rect curRect, Rect origin) {
    if (_itemCount == 1) return 0;
    bool outside = true;
    for (int i = 0; i < _itemCount; i++) {
      Rect rect = _positions[i];
      bool overlaps = rect.overlaps(curRect);
      if (overlaps) {
        outside = false;
        Rect over = rect.intersect(curRect);
        Rect ori = origin.intersect(curRect);
        if (_getRectArea(over) > _itemWidth * _itemWidth / 2 ||
            _getRectArea(over) > _getRectArea(ori)) {
          return i;
        }
      }
    }
    int index = -1;
    if (outside) {
      if (curRect.bottom < 0) {
        index = _checkIndexTop(curRect);
      } else if (curRect.top > _itemWidth) {
        index = _checkIndexBottom(curRect);
      }
    }
    return index;
  }

  /// get area.
  double _getRectArea(Rect rect) {
    return rect.width * rect.height;
  }

  /// check top index.
  int _checkIndexTop(Rect other) {
    int index = -1;
    double area;
    for (int i = 0; (i < 3 && i < _itemCount); i++) {
      Rect rect = _positions[i];
      Rect over = rect.intersect(other);
      double _area = _getRectArea(over);
      if (area == null || _area <= area) {
        area = _area;
        index = i;
      }
    }
    return index;
  }

  /// check bottom index.
  int _checkIndexBottom(Rect other) {
    int tagIndex = -1;
    double area;
    for (int i = 0; (i < 3 && i < _itemCount); i++) {
      Rect _rect = _positions[i];
      Rect over = _rect.intersect(other);
      double _area = _getRectArea(over);
      if (area == null || _area <= area) {
        area = _area;
        tagIndex = i;
      }
    }
    if (tagIndex != -1) {
      for (int i = _itemCount - 1; i >= 0; i--) {
        if (((i + 1) / 3).ceil() >= (((_dragIndex + 1) / 3).ceil()) &&
            (i % 3 == tagIndex)) {
          return i;
        }
      }
    }
    return -1;
  }

  /// clear all.
  void _clearAll() {
    _removeOverlay();
    _cacheData.clear();
    int count = math.min(9, widget.data.length);
    for (int i = 0; i < count; i++) {
      widget.data[i].index = i;
      widget.data[i].selected = false;
    }
    setState(() {});
  }

  /// trigger drag event.
  bool _triggerDragEvent(int action) {
    if (widget.onDragListener != null && _dragIndex != -1) {
      if (_motionEvent == null) _motionEvent = MotionEvent();
      _motionEvent.dragIndex = _dragIndex;
      _motionEvent.action = action;
      _motionEvent.globalX = _floatLeft;
      _motionEvent.globalY = _floatTop;
      return widget.onDragListener(_motionEvent, _itemWidth);
    }
    return false;
  }

  /// build child.
  Widget _buildChild(BuildContext context) {
    List<Widget> children = List();
    if (_cacheData.isEmpty) {
      for (int i = 0; i < _itemCount; i++) {
        children.add(Positioned.fromRect(
            rect: _positions[i], child: widget.itemBuilder(context, i)));
      }
    } else {
      for (int i = 0; i < _itemCount; i++) {
        int curIndex = widget.data[i].index;
        int lastIndex = _cacheData[i].index;
        double left = _positions[curIndex].left +
            (_positions[lastIndex].left - _positions[curIndex].left) *
                _controller.value;
        double top = _positions[curIndex].top +
            (_positions[lastIndex].top - _positions[curIndex].top) *
                _controller.value;
        children.add(Positioned(
            left: left,
            top: top,
            width: _itemWidth,
            height: _itemWidth,
            child: Offstage(
                offstage: widget.data[i].selected == true,
                child: widget.itemBuilder(context, i))));
      }
    }

    if (_itemCount < 9) {
      children.add(Positioned.fromRect(
        rect: _positions[_itemCount],
        child: widget.initBuilder(context),
      ));
    }
    return Stack(children: children);
  }

  @override
  Widget build(BuildContext context) {
    _itemCount = math.min(9, widget.data.length);
    EdgeInsets padding = widget.padding;
    EdgeInsets margin = widget.margin;
    if (_itemWidth == 0) {
      _init(context, padding, margin);
    }

    int column = (_itemCount > 3 ? 3 : _itemCount + 1);
    int row = ((_itemCount + (_itemCount < 9 ? 1 : 0)) / 3).ceil();
    double realWidth = _itemWidth * column +
        widget.space * (column - 1) +
        padding.left +
        padding.right;
    double realHeight = _itemWidth * row +
        widget.space * (row - 1) +
        padding.top +
        padding.bottom;
    double left = margin.left + padding.left;
    double top = margin.top + padding.top;

    return GestureDetector(
        onLongPressStart: (LongPressStartDetails details) {
          Offset offset = _getWidgetLocalToGlobal(context);
          _dragIndex = _getDragIndex(details.localPosition);
          if (_dragIndex == -1) return;
          _initIndex();
          widget.data[_dragIndex].selected = true;
          _dragBean = widget.data[_dragIndex];
          _downGlobalPos = details.globalPosition;
          _downLeft = left + _positions[_dragIndex].left;
          _downTop = top + _positions[_dragIndex].top;
          _toLeft = offset.dx + left + _positions[_dragIndex].left;
          _toTop = offset.dy + top + _positions[_dragIndex].top;
          _floatLeft = _toLeft;
          _floatTop = _toTop;
          Widget overlay = widget.itemBuilder(context, _dragIndex);
          _addOverlay(context, overlay);
          _triggerDragEvent(MotionEvent.actionDown);
          setState(() {});
        },
        onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
          if (_dragIndex == -1) return;
          _floatLeft =
              _toLeft + (details.globalPosition.dx - _downGlobalPos.dx);
          _floatTop = _toTop + (details.globalPosition.dy - _downGlobalPos.dy);

          double left =
              _downLeft + (details.globalPosition.dx - _downGlobalPos.dx);
          double top =
              _downTop + (details.globalPosition.dy - _downGlobalPos.dy);
          Rect cRect = Rect.fromLTWH(left, top, _itemWidth, _itemWidth);
          int index = _getNextIndex(cRect, _positions[_dragIndex]);
          if (index != -1 && _dragIndex != index) {
            _initIndex();
            _dragIndex = index;
            widget.data.remove(_dragBean);
            widget.data.insert(_dragIndex, _dragBean);
            _controller.reset();
            _controller.forward();
          }
          _updateOverlay();
          _triggerDragEvent(MotionEvent.actionMove);
        },
        onLongPressEnd: (LongPressEndDetails details) {
          if (_dragIndex == -1) return;
          _fromLeft = _toLeft + (details.globalPosition.dx - _downGlobalPos.dx);
          _fromTop = _toTop + (details.globalPosition.dy - _downGlobalPos.dy);
          Offset offset = _getWidgetLocalToGlobal(context);
          _toLeft = offset.dx + left + _positions[_dragIndex].left;
          _toTop = offset.dy + top + _positions[_dragIndex].top;
        },
        onLongPressUp: () {
          _dragBean = null;
          bool isCatch = _triggerDragEvent(MotionEvent.actionUp);
          if (isCatch) {
            widget.data.removeAt(_dragIndex);
            _clearAll();
          } else {
            _floatController.reset();
            _floatController.forward();
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
            width: realWidth,
            height: realHeight,
            margin: margin,
            padding: padding,
            child: _buildChild(context)));
  }
}
