import 'package:flutter/material.dart';
import 'package:flutter_first/src/components/AppAvatar.dart';
import 'package:flutter_first/src/components/AppDrawerComponent.dart';

class _DrawerLink {
  final IconData icon;
  final String title;
  const _DrawerLink(this.icon, this.title);
}

class DrawerContentPartial extends StatefulWidget {
  static const EdgeInsets _paddingVerticalInsets = EdgeInsets.only(bottom: 8, top: 8);
  static const EdgeInsets _paddingHorizontalInsets = EdgeInsets.only(left: 16, right: 16);
  static EdgeInsets _paddingfullInsets = _paddingVerticalInsets.add(_paddingHorizontalInsets);
  static const Padding _verticalPadding = const Padding(padding: _paddingVerticalInsets);

  static const List<_DrawerLink> _links = [
    const _DrawerLink(Icons.perm_identity, "Profile"), 
    const _DrawerLink(Icons.home, "Home"), 
    const _DrawerLink(Icons.shopping_cart, "My Cart"), 
    const _DrawerLink(Icons.favorite_border, "Favourite"), 
  ];


  const DrawerContentPartial({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState()  => DrawerContentPartialState();



}

class DrawerContentPartialState extends State<DrawerContentPartial>{
  String selectedTitle;

  @override
  void initState() { 
    super.initState();
    selectedTitle = DrawerContentPartial._links.first.title;
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, layoutConstraints){
      
      return Container(
        // color: Colors.yellow,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: layoutConstraints.maxHeight),
            child: Padding(
              // padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
              padding: const EdgeInsets.fromLTRB(0, 100, 16, 0),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildHeader(context),
                      const Padding(padding: EdgeInsets.only(top: 64)),
                    ]
                    ..addAll(
                      DrawerContentPartial._links.map((link) => (
                        _buildActionItem(context, link.icon, link.title, isSelected: selectedTitle == link.title)
                      ))
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context){
    return Padding(
      padding: DrawerContentPartial._paddingHorizontalInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppAvatar(size: 80),
          DrawerContentPartial._verticalPadding,
          Text("Hi", style: Theme.of(context).primaryTextTheme.headline),
          DrawerContentPartial._verticalPadding,
          Text("Chilla Tenga", style: Theme.of(context).primaryTextTheme.headline.copyWith(fontWeight: FontWeight.w700)),
        ]
      ),
    );

  }

  Widget _buildActionItem(BuildContext context, IconData icon, String text, {bool isSelected = false}) {
    var _containerColor = Colors.transparent;
    Function() _onTapCallback  = () {
      setState(() => selectedTitle = text);
      // AppDrawerController.of(context).close();
    };
    final theme = Theme.of(context);
    var titleTextStyle = theme.primaryTextTheme.title;
    Color _iconColor;

    assert(theme != null);
    if(isSelected){
      _containerColor = theme.accentColor.withOpacity(0.2);
      _onTapCallback = null;
      titleTextStyle = titleTextStyle.copyWith(color: theme.accentColor);
      _iconColor = theme.accentColor;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Material(
        type: MaterialType.button,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.hardEdge,
        color: _containerColor,
        child: InkWell(
          onTap: _onTapCallback,
          child: Container(
            padding: DrawerContentPartial._paddingfullInsets,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Icon(
                    icon,
                    size: 32,
                    color: _iconColor,
                  ),
                ),
                Text(text, style: titleTextStyle)
              ],
            ),
          ),
        ),
      ),
    );
  }


}

