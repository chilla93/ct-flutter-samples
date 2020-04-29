import 'package:flutter/material.dart';
import 'package:flutter_first/src/models/Shoe.Models.dart';

class ShoeItem extends StatelessWidget {
  final ShoeItemModel item;
  const ShoeItem({
    Key key,
    this.item
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Theme.of(context).cardColor,
                child: Ink.image(
                  image: AssetImage(this.item.imageSrc),
                  height: 90
                )
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(this.item.title, style: Theme.of(context).textTheme.title)
                  ),
                  Text(this.item.description, style: Theme.of(context).textTheme.body1)
                ],
              ),
            ), 
            flex: 9
          )
        ]
      ),
    );
  }
}