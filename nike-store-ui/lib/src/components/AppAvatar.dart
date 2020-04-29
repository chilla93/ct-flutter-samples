import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final double size;
  const AppAvatar({
    Key key,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.size,
      width: this.size,
      child: Material(
        color: Colors.blue,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size/4)),
        // borderRadius: BorderRadius.circular(10),
        child: Ink.image(
          image: AssetImage("assets/images/headshot-woman-3.jpg"),
          fit: BoxFit.cover,
          child: InkWell(onTap: () => {}),
        ),
      ),
    );
  }
}