import 'dart:math';

import 'package:flutter/material.dart';

class DetailsBannerPartial extends StatelessWidget {
  const DetailsBannerPartial({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Stack(
      overflow: Overflow.clip,              
      children: <Widget>[
        _buildBackground(context),
        _buildDetailsContainer(context),
        _buildIconButton(context)
      ],
    );
  }

  Positioned _buildIconButton(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Material(
        elevation: 20,
        shadowColor: Theme.of(context).accentColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Theme.of(context).accentColor,
        clipBehavior: Clip.hardEdge,
        type: MaterialType.canvas,
        child: IconButton(
          padding: EdgeInsets.all(16),
          iconSize: 32,
          icon: Icon(Icons.shopping_basket),
          onPressed: () => {},
        ),
      ),
    );
  }

  Container _buildDetailsContainer(BuildContext context) {
    return Container(
      // color: Colors.blue,
      padding: EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            // angle: -pi/10,
            // angle: 0,
            transform: Matrix4.rotationZ(-pi/10)..setTranslationRaw(-15, 0, 0),
            alignment: Alignment.center,
            // transform: Matrix4.translationValues(50,0,0),
            // transform: Matrix4.zero()..setIdentity(),
            child: Container(
              padding: EdgeInsets.only(bottom: 80),
              // color: Colors.blue,
              child: FractionallySizedBox(widthFactor: 0.9, child: Image.asset("assets/images/shoes/nike-shoe-cropped.png")),
            ),
          ),
          // Container(height: 100, width: 100, color: Colors.blue)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text("Nike Joyride Flyknit", style: Theme.of(context).textTheme.headline)
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text("Men's Running Shoe", style: Theme.of(context).textTheme.subhead),
              ),
            ]
          )
        ]
      ),
    );
  }

  Positioned _buildBackground(BuildContext context) {
    return Positioned.fill(
      child: Transform.translate(
        offset: Offset(50,0),
        child: Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(40)
            ),
          ),
        ),
      ),
    );
  }
}