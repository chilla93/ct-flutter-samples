
import 'package:flutter/material.dart';

class SwipeBoxComponent extends StatelessWidget {
  SwipeBoxComponent({
    Key key,
    @required this.controller,
    @required this.listData
  }) : super(key: key);

  final PageController controller;
  final List<String> listData;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageView.builder(
      controller: controller,
      itemCount: this.listData.length,
      itemBuilder: (BuildContext context, int index){
        return _buildSwipeableView(theme, this.listData[index]);
      }
    );
  }

  Widget _buildSwipeableView(ThemeData theme, String title) {
    return Column(
      children: <Widget>[
        Spacer(flex: 5),
        Flexible(
          flex: 7,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(title, style: theme.textTheme.display1)
          ),
        )
      ]
    );
  }
}
