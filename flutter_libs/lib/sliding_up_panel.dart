import 'package:flutter/material.dart';

/// https://github.com/akshathjain/sliding_up_panel/blob/master/lib/src/panel.dart

enum SlidingDirection { UP, DOWN }

enum PanelState { OPEN, CLOSED }

class SlidingUpPanel extends StatefulWidget {
  /// The Widget that slides into view. When the
  /// panel is collapsed and if [collapsed] is null,
  /// then top portion of this Widget will be displayed;
  /// otherwise, [collapsed] will be displayed overtop
  /// of this Widget.
  final Widget panel;

  /// The Widget displayed overtop the [panel] when collapsed.
  /// This fades out as the panel is opened.
  final Widget collapsed;

  /// The Widget that lies underneath the sliding panel.
  /// This Widget automatically sizes itself
  /// to fill the screen.
  final Widget body;

  /// The height of the sliding panel when fully collapsed.
  final double minHeight;

  /// The height of the sliding panel when fully open.
  final double maxHeight;

  /// A border to draw around the sliding panel sheet.
  final Border border;

  /// If non-null, the corners of the sliding panel sheet are rounded by this [BorderRadiusGeometry].
  final BorderRadiusGeometry borderRadius;

  /// A list of shadows cast behind the sliding panel sheet.
  final List<BoxShadow> boxShadow;

  /// The color to fill the background of the sliding panel sheet.
  final Color color;

  /// The amount to inset the children of the sliding panel sheet.
  final EdgeInsetsGeometry padding;

  /// Empty space surrounding the sliding panel sheet.
  final EdgeInsetsGeometry margin;

  /// Set to false to not to render the sheet the [panel] sits upon.
  /// This means that only the [body], [collapsed], and the [panel]
  /// Widgets will be rendered.
  /// Set this to false if you want to achieve a floating effect or
  /// want more customization over how the sliding panel
  /// looks like.
  final bool renderPanelSheet;

  /// Set to false to disable the panel from snapping open or closed.
  final bool panelSnapping;

  /// If non-null, this can be used to control the state of the panel.
  final PanelController controller;

  /// If non-null, shows a darkening shadow over the [body] as the panel slides open.
  final bool backdropEnabled;

  /// Shows a darkening shadow of this [Color] over the [body] as the panel slides open.
  final Color backdropColor;

  /// The opacity of the backdrop when the panel is fully open.
  /// This value can range from 0.0 to 1.0 where 0.0 is completely transparent
  /// and 1.0 is completely opaque.
  final double backdropOpacity;

  /// Flag that indicates whether or not tapping the
  /// backdrop closes the panel. Defaults to true.
  final bool backdropTapClosesPanel;

  /// If non-null, this callback
  /// is called as the panel slides around with the
  /// current position of the panel. The position is a double
  /// between 0.0 and 1.0 where 0.0 is fully collapsed and 1.0 is fully open.
  final void Function(double position) onPanelSlide;

  /// If non-null, this callback is called when the
  /// panel is fully opened
  final VoidCallback onPanelOpened;

  /// If non-null, this callback is called when the panel
  /// is fully collapsed.
  final VoidCallback onPanelClosed;

  /// If non-null and true, the SlidingUpPanel exhibits a
  /// parallax effect as the panel slides up. Essentially,
  /// the body slides up as the panel slides up.
  final bool parallaxEnabled;

  /// Allows for specifying the extent of the parallax effect in terms
  /// of the percentage the panel has slid up/down. Recommended values are
  /// within 0.0 and 1.0 where 0.0 is no parallax and 1.0 mimics a
  /// one-to-one scrolling effect. Defaults to a 10% parallax.
  final double parallaxOffset;

  /// Allows toggling of the draggability of the SlidingUpPanel.
  /// Set this to false to prevent the user from being able to drag
  /// the panel up and down. Defaults to true.
  final bool isDraggable;

  /// Either SlideDirection.UP or SlideDirection.DOWN. Indicates which way
  /// the panel should slide. Defaults to UP. If set to DOWN, the panel attaches
  /// itself to the top of the screen and is fully opened when the user swipes
  /// down on the panel.
  final SlidingDirection slideDirection;

  /// The default state of the panel; either PanelState.OPEN or PanelState.CLOSED.
  /// This value defaults to PanelState.CLOSED which indicates that the panel is
  /// in the closed position and must be opened. PanelState.OPEN indicates that
  /// by default the Panel is open and must be swiped closed by the user.
  final PanelState defaultPanelState;

  SlidingUpPanel(
      {Key key,
      @required this.panel,
      this.body,
      this.collapsed,
      this.minHeight = 100.0,
      this.maxHeight = 500.0,
      this.border,
      this.borderRadius,
      this.boxShadow = const <BoxShadow>[
        BoxShadow(
          blurRadius: 8.0,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        )
      ],
      this.color = Colors.white,
      this.padding,
      this.margin,
      this.renderPanelSheet = true,
      this.panelSnapping = true,
      this.controller,
      this.backdropEnabled = false,
      this.backdropColor = Colors.black,
      this.backdropOpacity = 0.5,
      this.backdropTapClosesPanel = true,
      this.onPanelSlide,
      this.onPanelOpened,
      this.onPanelClosed,
      this.parallaxEnabled = false,
      this.parallaxOffset = 0.1,
      this.isDraggable = true,
      this.slideDirection = SlidingDirection.UP,
      this.defaultPanelState = PanelState.CLOSED})
      : assert(0 <= backdropOpacity && backdropOpacity <= 1.0),
        super(key: key);

  @override
  createState() => _SlidingUpPanelState();
}

class _SlidingUpPanelState extends State<SlidingUpPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _ac;

  bool _isPanelVisible = true;

  @override
  void initState() {
    super.initState();

    _ac = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        value: widget.defaultPanelState == PanelState.CLOSED
            ? 0.0
            : 1.0 //set the default panel state (i.e. set initial value of _ac)
        )
      ..addListener(() {
        setState(() {});

        if (widget.onPanelSlide != null) widget.onPanelSlide(_ac.value);

        if (widget.onPanelOpened != null && _ac.value == 1.0)
          widget.onPanelOpened();

        if (widget.onPanelClosed != null && _ac.value == 0.0)
          widget.onPanelClosed();
      });

    widget.controller?._addListeners(
      _close,
      _open,
      _hide,
      _show,
      _setPanelPosition,
      _animatePanelToPosition,
      _getPanelPosition,
      _isPanelAnimating,
      _isPanelOpen,
      _isPanelClosed,
      _isPanelShown,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.slideDirection == SlidingDirection.UP
          ? Alignment.bottomCenter
          : Alignment.topCenter,
      children: <Widget>[
        //make the back widget take up the entire back side
        widget.body != null
            ? Positioned(
                top: widget.parallaxEnabled ? _getParallax() : 0.0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: widget.body,
                ),
              )
            : Container(),

        //the backdrop to overlay on the body
        !widget.backdropEnabled
            ? Container()
            : GestureDetector(
                onTap: widget.backdropTapClosesPanel ? _close : null,
                child: Opacity(
                  opacity: _ac.value * widget.backdropOpacity,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

                    //set color to null so that touch events pass through
                    //to the body when the panel is closed, otherwise,
                    //if a color exists, then touch events won't go through
                    color: _ac.value == 0.0 ? null : widget.backdropColor,
                  ),
                ),
              ),

        //the actual sliding part
        !_isPanelVisible
            ? Container()
            : GestureDetector(
                onVerticalDragUpdate: widget.isDraggable ? _onDrag : null,
                onVerticalDragEnd: widget.isDraggable ? _onDragEnd : null,
                child: Container(
                  height: _ac.value * (widget.maxHeight - widget.minHeight) +
                      widget.minHeight,
                  margin: widget.margin,
                  padding: widget.padding,
                  decoration: widget.renderPanelSheet
                      ? BoxDecoration(
                          border: widget.border,
                          borderRadius: widget.borderRadius,
                          boxShadow: widget.boxShadow,
                          color: widget.color,
                        )
                      : null,
                  child: Stack(
                    children: <Widget>[
                      //open panel
                      Positioned(
                          top: widget.slideDirection == SlidingDirection.UP
                              ? 0.0
                              : null,
                          bottom: widget.slideDirection == SlidingDirection.DOWN
                              ? 0.0
                              : null,
                          width: MediaQuery.of(context).size.width -
                              (widget.margin != null
                                  ? widget.margin.horizontal
                                  : 0) -
                              (widget.padding != null
                                  ? widget.padding.horizontal
                                  : 0),
                          child: Container(
                            height: widget.maxHeight,
                            child: widget.panel,
                          )),

                      // collapsed panel
                      Positioned(
                        top: widget.slideDirection == SlidingDirection.UP
                            ? 0.0
                            : null,
                        bottom: widget.slideDirection == SlidingDirection.DOWN
                            ? 0.0
                            : null,
                        width: MediaQuery.of(context).size.width -
                            (widget.margin != null
                                ? widget.margin.horizontal
                                : 0) -
                            (widget.padding != null
                                ? widget.padding.horizontal
                                : 0),
                        child: Container(
                          height: widget.minHeight,
                          child: Opacity(
                            opacity: 1.0 - _ac.value,

                            // if the panel is open ignore pointers (touch events) on the collapsed
                            // child so that way touch events go through to whatever is underneath
                            child: IgnorePointer(
                              ignoring: _isPanelOpen(),
                              child: widget.collapsed ?? Container(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  double _getParallax() {
    if (widget.slideDirection == SlidingDirection.UP)
      return -_ac.value *
          (widget.maxHeight - widget.minHeight) *
          widget.parallaxOffset;
    else
      return _ac.value *
          (widget.maxHeight - widget.minHeight) *
          widget.parallaxOffset;
  }

  void _onDrag(DragUpdateDetails details) {
    if (widget.slideDirection == SlidingDirection.UP)
      _ac.value -= details.primaryDelta / (widget.maxHeight - widget.minHeight);
    else
      _ac.value += details.primaryDelta / (widget.maxHeight - widget.minHeight);
  }

  void _onDragEnd(DragEndDetails details) {
    double minFlingVelocity = 365.0;

    //let the current animation finish before starting a new one
    if (_ac.isAnimating) return;

    //check if the velocity is sufficient to constitute fling
    if (details.velocity.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      double visualVelocity = -details.velocity.pixelsPerSecond.dy /
          (widget.maxHeight - widget.minHeight);

      if (widget.slideDirection == SlidingDirection.DOWN)
        visualVelocity = -visualVelocity;

      if (widget.panelSnapping) {
        _ac.fling(velocity: visualVelocity);
      } else {
        // actual scroll physics will be implemented in a future release
        _ac.animateTo(
          _ac.value + visualVelocity * 0.16,
          duration: Duration(milliseconds: 410),
          curve: Curves.decelerate,
        );
      }

      return;
    }

    // check if the controller is already halfway there
    if (widget.panelSnapping) {
      if (_ac.value > 0.5)
        _open();
      else
        _close();
    }
  }

  //---------------------------------
  //PanelController related functions
  //---------------------------------

  //close the panel
  void _close() {
    _ac.fling(velocity: -1.0);
  }

  //open the panel
  void _open() {
    _ac.fling(velocity: 1.0);
  }

  //hide the panel (completely offscreen)
  void _hide() {
    _ac.fling(velocity: -1.0).then((x) {
      setState(() {
        _isPanelVisible = false;
      });
    });
  }

  //show the panel (in collapsed mode)
  void _show() {
    _ac.fling(velocity: -1.0).then((x) {
      setState(() {
        _isPanelVisible = true;
      });
    });
  }

  //set the panel position to value - must
  //be between 0.0 and 1.0
  void _setPanelPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    _ac.value = value;
  }

  //set the panel position to value - must
  //be between 0.0 and 1.0
  void _animatePanelToPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    _ac.animateTo(value);
  }

  //get the current panel position
  //returns the % offset from collapsed state
  //as a decimal between 0.0 and 1.0
  double _getPanelPosition() {
    return _ac.value;
  }

  //returns whether or not
  //the panel is still animating
  bool _isPanelAnimating() {
    return _ac.isAnimating;
  }

  //returns whether or not the
  //panel is open
  bool _isPanelOpen() {
    return _ac.value == 1.0;
  }

  //returns whether or not the
  //panel is closed
  bool _isPanelClosed() {
    return _ac.value == 0.0;
  }

  //returns whether or not the
  //panel is shown/hidden
  bool _isPanelShown() {
    return _isPanelVisible;
  }
}

class PanelController {
  VoidCallback _closeListener;
  VoidCallback _openListener;
  VoidCallback _hideListener;
  VoidCallback _showListener;
  Function(double value) _setPanelPositionListener;
  Function(double value) _setAnimatePanelToPositionListener;
  double Function() _getPanelPositionListener;
  bool Function() _isPanelAnimatingListener;
  bool Function() _isPanelOpenListener;
  bool Function() _isPanelClosedListener;
  bool Function() _isPanelShownListener;

  void _addListeners(
    VoidCallback closeListener,
    VoidCallback openListener,
    VoidCallback hideListener,
    VoidCallback showListener,
    Function(double value) setPanelPositionListener,
    Function(double value) setAnimatePanelToPositionListener,
    double Function() getPanelPositionListener,
    bool Function() isPanelAnimatingListener,
    bool Function() isPanelOpenListener,
    bool Function() isPanelClosedListener,
    bool Function() isPanelShownListener,
  ) {
    this._closeListener = closeListener;
    this._openListener = openListener;
    this._hideListener = hideListener;
    this._showListener = showListener;
    this._setPanelPositionListener = setPanelPositionListener;
    this._setAnimatePanelToPositionListener = setAnimatePanelToPositionListener;
    this._getPanelPositionListener = getPanelPositionListener;
    this._isPanelAnimatingListener = isPanelAnimatingListener;
    this._isPanelOpenListener = isPanelOpenListener;
    this._isPanelClosedListener = isPanelClosedListener;
    this._isPanelShownListener = isPanelShownListener;
  }

  /// Closes the sliding panel to its collapsed state (i.e. to the  minHeight)
  void close() {
    _closeListener();
  }

  /// Opens the sliding panel fully
  /// (i.e. to the maxHeight)
  void open() {
    _openListener();
  }

  /// Hides the sliding panel (i.e. is invisible)
  void hide() {
    _hideListener();
  }

  /// Shows the sliding panel in its collapsed state
  /// (i.e. "un-hide" the sliding panel)
  void show() {
    _showListener();
  }

  /// Sets the panel position (without animation).
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  void setPanelPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    _setPanelPositionListener(value);
  }

  /// Animates the panel position to the value.
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open
  void animatePanelToPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    _setAnimatePanelToPositionListener(value);
  }

  /// Gets the current panel position.
  /// Returns the % offset from collapsed state
  /// to the open state
  /// as a decimal between 0.0 and 1.0
  /// where 0.0 is fully collapsed and
  /// 1.0 is full open.
  double getPanelPosition() {
    return _getPanelPositionListener();
  }

  /// Returns whether or not the panel is
  /// currently animating.
  bool isPanelAnimating() {
    return _isPanelAnimatingListener();
  }

  /// Returns whether or not the
  /// panel is open.
  bool isPanelOpen() {
    return _isPanelOpenListener();
  }

  /// Returns whether or not the
  /// panel is closed.
  bool isPanelClosed() {
    return _isPanelClosedListener();
  }

  /// Returns whether or not the
  /// panel is shown/hidden.
  bool isPanelShown() {
    return _isPanelShownListener();
  }
}
