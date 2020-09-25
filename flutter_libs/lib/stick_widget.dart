import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// https://github.com/CarGuo/gsy_flutter_demo/blob/master/lib/widget/stick/stick_widget.dart
class StickWidget extends MultiChildRenderObjectWidget {
  /// 顺序添加 stickHeader 和 stickContent
  StickWidget({
    @required stickHeader,
    @required stickContent,
  }) : super(
          /// 如果反过来，会有意想不到的效果哦
          children: [stickContent, stickHeader],
        );

  @override
  StickRender createRenderObject(BuildContext context) {
    /// 传入 ScrollableState
    return StickRender(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(BuildContext context, StickRender renderObject) {
    renderObject..scrollable = Scrollable.of(context);
  }
}

class StickRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, StickParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, StickParentData> {
  StickRender({@required ScrollableState scrollable}) {
    this._scrollable = scrollable;
  }

  ScrollableState _scrollable;

  set scrollable(ScrollableState scrollableState) {
    if (_scrollable == scrollableState) {
      return;
    }
    final ScrollableState preScroll = _scrollable;
    _scrollable = scrollableState;
    if (attached) {
      /// 这里触发更新
      preScroll.position?.removeListener(markNeedsLayout);
      scrollableState.position?.addListener(markNeedsLayout);
    }
    markNeedsLayout();
  }

  double getScrollAbleDy() {
    RenderObject renderObject = _scrollable.context.findRenderObject();
    if (!renderObject.attached) {
      return 0;
    }
    try {
      return localToGlobal(Offset.zero, ancestor: renderObject).dy;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  @override
  void attach(_) {
    /// 设置监听
    _scrollable.position?.addListener(markNeedsLayout);
    super.attach(_);
  }

  @override
  void detach() {
    _scrollable.position?.removeListener(markNeedsLayout);
    super.detach();
  }

  /// 设置为 isRepaintBoundary 或者性能会好一些。
  /// @override
  /// bool get isRepaintBoundary => true;

  @override
  double computeMinIntrinsicHeight(double width) =>
      (lastChild.getMinIntrinsicHeight(width) +
          firstChild.getMinIntrinsicHeight(width));

  @override
  double computeMaxIntrinsicHeight(double width) =>
      (lastChild.getMaxIntrinsicHeight(width) +
          firstChild.getMaxIntrinsicHeight(width));

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) =>
      defaultComputeDistanceToHighestActualBaseline(baseline);

  /// 设置绘制默认
  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  /// 设置我们的 StickParentData
  @override
  void setupParentData(RenderObject child) {
    super.setupParentData(child);
    if (child.parentData is! StickParentData) {
      child.parentData = StickParentData();
    }
  }

  @override
  void performLayout() {
    var header = lastChild;
    var content = firstChild;

    /// 取消最小宽高
    var loosenConstraints = constraints.loosen();
    content.layout(loosenConstraints, parentUsesSize: true);
    header.layout(loosenConstraints, parentUsesSize: true);

    /// 获取各自的高度用户计算
    var contentHeight = content.size.height;
    var headerHeight = header.size.height;

    /// 对于当前布局，用内容作为宽高
    var width = content.size.width;
    var height = headerHeight + contentHeight;
    size = Size(width, height);

    /// 内容的初始化位置
    (content.parentData as StickParentData).offset = Offset(0, headerHeight);

    /// 计算出 header 需要的整体偏移量，用于反方向
    var headerOffset = height - headerHeight;

    /// 判断当前 item 在 ScrollAble 里的偏移
    var scrollAbleDy = getScrollAbleDy();

    /// 是滑动的多还是偏移量
    var realHeaderOffset = math.min(-scrollAbleDy, headerOffset);
    (header.parentData as StickParentData).offset =
        Offset(0, math.max(0, realHeaderOffset));
  }

  @override
  bool hitTestChildren(HitTestResult result, {Offset position}) =>
      defaultHitTestChildren(result, position: position);
}

class StickParentData extends ContainerBoxParentData<RenderBox> {}
