import 'package:flutter/material.dart';
import 'package:skype_clone/utils/universal_variables.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsets marging;
  final bool mini;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  CustomTile(
      {@required this.title,
      @required this.leading,
      this.onTap,
      this.icon,
      this.marging = const EdgeInsets.all(0),
      this.mini = true,
      this.onLongPress,
      @required this.subtitle,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mini ? 10 : 0),
        margin: marging,
        child: Row(
          children: <Widget>[
            leading,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: mini ? 10 : 15),
                padding: EdgeInsets.symmetric(vertical: mini ? 3 : 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: UniversalVariables.separatorColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        title,
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            icon ?? Container(),
                            subtitle,
                          ],
                        ),
                      ],
                    ),
                    trailing ?? Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
