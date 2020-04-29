import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';

const double _kWidth = 414.0;
// const double _kEdgeDragWidth = 20.0;
const double _kMinFlingVelocity = 365.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

class AppDrawerContainer extends StatefulWidget {
  final Widget child;
  final Widget drawerContentChild;

  const AppDrawerContainer({Key key, this.drawerContentChild, @required this.child}) : super(key: key);
  final double _drawerWidthFactor = 0.5;

  @override
  State<StatefulWidget> createState() {
    return AppDrawerContainerState();
  }
}

class AppDrawerContainerState extends State<AppDrawerContainer>{
  bool _disableContent;

  @override
  void initState() {
    super.initState();
    _disableContent = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AppDrawerContent(
        widthFactor: widget._drawerWidthFactor,
        child: widget.drawerContentChild,
      ),
      // AppDrawerController(
      //   drawerCallback: (open) {
      //     setState(() {
      //       // print(open);
      //       _disableContent = open;
      //     });
      //   },
      //   widthFactor: widget._drawerWidthFactor,
      //   child: Builder(
      //     builder: (aContext) => (
      //       GestureDetector(
      //         onTap: () {
      //           if(_disableContent) 
      //             AppDrawerController.of(aContext).close();
      //         },
      //         child: AbsorbPointer(
      //           absorbing: _disableContent, 
      //           child: RepaintBoundary(child: widget.child)
      //         ),
      //       )
      //     )
      //   )
      // )
    ]);
  }
}

class AppDrawerContent extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  const AppDrawerContent({Key key, @required this.child, this.widthFactor}) :
    assert(widthFactor >= 0 && widthFactor <= 1), 
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned.fill(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: widthFactor,
              child: Container(
                child: child,
              ),
            ),
          ),
        )
      ),
    );
  }
}

class AppDrawerController extends StatefulWidget {
  final DrawerCallback drawerCallback;
  final double widthFactor;
  final Widget child;
  final Widget drawerContentChild;

  AppDrawerController({Key key, this.drawerCallback, this.widthFactor = 1, this.drawerContentChild, @required this.child}) : 
    assert(widthFactor >= 0 && widthFactor <= 1), 
    super(key: key);

  static _AppDrawerControllerState of(BuildContext context) {
    assert(context != null);
    final state = context.findAncestorStateOfType<_AppDrawerControllerState>();
    if (state != null) {
      return state;
    }

    throw ErrorDescription(
        "Could not find associated state of app drawer container");
  }



  @override
  _AppDrawerControllerState createState() => _AppDrawerControllerState();
}

class _AppDrawerControllerState extends State<AppDrawerController>
    with SingleTickerProviderStateMixin<AppDrawerController> {
  AnimationController _controller;
  final double _drawerOpenScale = 0.2;
  final double _drawerOpenRotation = -math.pi / 16;
  final double _drawerBorderRadius = 48;
  final _defaultDrawerKey = GlobalKey();
  bool _disableContent;
  

  double get _width {
    final s  = _defaultDrawerKey.currentContext.findRenderObject() as RenderBox;
    if(s != null){
      return s.size.width * widget.widthFactor;
    }
    return _kWidth * widget.widthFactor;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: _kBaseSettleDuration);
    _disableContent = false;
    // _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void toggle() {
    // print("toggling container");
    if (_controller.isDismissed) {
      open();
    } else {
      close();
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (_, BoxConstraints layoutConstraints) {
        // print("layout constraints maxWidth ${layoutConstraints.maxWidth}");
        return Stack(
          children: <Widget>[
            AppDrawerContent(
              widthFactor: widget.widthFactor,
              child: widget.drawerContentChild,
            ),
            GestureDetector(
              onHorizontalDragDown: _handleDragDown,
              onHorizontalDragUpdate: _move,
              onHorizontalDragEnd: _settle,
              onHorizontalDragCancel: _handleDragCancel,
              dragStartBehavior: DragStartBehavior.start,
              child: AnimatedBuilder(
                animation: _controller,
                child: widget.child,
                builder: (_, Widget child) {
                  final radius = _controller.value * _drawerBorderRadius;
                  final rotation = _controller.value * _drawerOpenRotation;
                  final scale = 1 - (_controller.value * _drawerOpenScale);

                  final xTranslation =
                      _controller.value * (layoutConstraints.maxWidth * widget.widthFactor);
                  final yTranslation = ((layoutConstraints.maxHeight *
                          _controller.value *
                          _drawerOpenScale) /
                      2);
                  return Transform(
                    alignment: Alignment.topLeft,
                    transform: Matrix4.identity()
                      ..scale(scale)
                      ..setTranslationRaw(xTranslation, yTranslation, 0)
                      ..rotateZ(rotation),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: RepaintBoundary(
                        child: Container(
                          key: _defaultDrawerKey,
                          child: Builder(
                            builder: (aContext) => (
                              GestureDetector(
                                onTap: () {
                                  if(_disableContent) 
                                    AppDrawerController.of(aContext).close();
                                },
                                child: AbsorbPointer(
                                  absorbing: _disableContent, 
                                  child: RepaintBoundary(child: widget.child)
                                ),
                              )
                            )
                          )
                        )
                      )
                    )
                  );
                },
              ),
            )
          ]
        );
      },
    );
  }

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
  }

  bool _previouslyOpened = false;

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta / _width;

    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        delta = -delta;
        break;
      default:
        break;
    }

     _controller.value += delta;

    final bool opened = _controller.value > 0.5;
    if (opened != _previouslyOpened && widget.drawerCallback != null)
      widget.drawerCallback(opened);
    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
        if (_controller.isDismissed)
      return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;

      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          visualVelocity = -visualVelocity;
          break;
        default:
          break;
      }
      _controller.fling(velocity: visualVelocity);
    } 
    else if (_controller.value < 0.5) {
      close();
    } 
    else {
      open();
    }
  }

  void _handleDragCancel() {
    if (_controller.isDismissed || _controller.isAnimating)
      return;
    if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  /// Starts an animation to open the drawer.
  ///
  /// Typically called by [ScaffoldState.openDrawer].
  void open() {
    _controller.fling(velocity: 1.0);
    if (widget.drawerCallback != null)
      widget.drawerCallback(true);
      setState(() {
        _disableContent = true;
      });
  }

  /// Starts an animation to close the drawer.
  void close() {
    _controller.fling(velocity: -1.0);
    if (widget.drawerCallback != null)
      widget.drawerCallback(false);
      _disableContent = false;
  }
}

