import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageBoxComponent extends StatelessWidget {
  ImageBoxComponent({
    Key key,
    @required this.controller,
    @required this.imageList
  }) :
  super(key: key);

  final PageController controller;
  final List<String> imageList;
  
  @override
  Widget build(BuildContext context) {
    final images = imageList.map<AssetImage>((i) => AssetImage(i)).toList();
    return FutureBuilder<dynamic>(
      future: Future.wait(images.map((image) => precacheImage(image, context)), eagerError: true),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return  ImageBoxTransitionComponent(imageList: images, controller: controller);
        }

        return Center(
          child: CupertinoActivityIndicator()
        );
      }
    );
  }
}

class ImageBoxTransitionComponent extends StatefulWidget {
  ImageBoxTransitionComponent({Key key, @required this.imageList, @required this.controller}) 
  :
  this._opacityTween = Tween(begin: 0.4, end: 1),
  this._reverseOpacityTween = Tween(begin: 1, end: 0.4),
  this.imageListCount = imageList.length,
  super(key: key);

  final PageController controller;
  final List<AssetImage> imageList;
  final int imageListCount;
  final Tween<double> _opacityTween;
  final Tween<double> _reverseOpacityTween;

  @override
  _ImageBoxTransitionComponentState createState() => _ImageBoxTransitionComponentState();
}

class _ImageBoxTransitionComponentState extends State<ImageBoxTransitionComponent> with SingleTickerProviderStateMixin {

  double get _pageValue {
    assert(widget.controller != null);
    if(widget.controller.hasClients){
      return widget.controller.page ?? widget.controller.initialPage.toDouble();
    }
    return 0;
  }

  double get _pageTransitionValue {
    if(_pageValue < 0){
      return 0;
    }
    return (_pageValue - _pageValue.floor()).abs();
  }


  int _currentPage;

  int get _nextPage {
    final val = _currentPage + 1;
    if(val == widget.imageListCount){
      return _currentPage;
    }

    return val;
  }

  AnimationController animationController;


 @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this
    );
    widget.controller.addListener(_handleChange);
    _currentPage = _pageValue.floor();
  }

  @override
  void didUpdateWidget(ImageBoxTransitionComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleChange);
      widget.controller.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    animationController.value = _pageTransitionValue;
    if(_pageValue < 0){
      return;
    }

    if(_pageValue.floor() != _currentPage){
      setState(() {
        _currentPage = _pageValue.floor();
        // The listenable's state is our build state, and it changed already.
      });

    }

  }

  Widget _image(AssetImage image){
    // print("creating image, creating image, creating image" + DateTime.now().toString());

    return RepaintBoundary(
      child: Container(
        child: Image(
          image: image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      )
    );
  }

  
  @override
  Widget build(BuildContext context) {
    // final curve = CurveTween(curve: Curves.slowMiddle);
    final curve = CurveTween(curve: Curves.slowMiddle);
    return Container(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: animationController,
            child: _image(widget.imageList[_nextPage]),
            builder: (BuildContext context, Widget child) {
                return FadeTransition(
                  opacity: animationController.drive(widget._opacityTween.chain(curve)),
                  child: child
                );
            },
          ),
          AnimatedBuilder(
            animation: animationController,
            child: _image(widget.imageList[_currentPage]),
            builder: (BuildContext context, Widget child) {
                return FadeTransition(
                  opacity: animationController.drive(widget._reverseOpacityTween.chain(curve)),
                  child: child
                );
            },
          ),
        ]
      )
    );
  }
}

