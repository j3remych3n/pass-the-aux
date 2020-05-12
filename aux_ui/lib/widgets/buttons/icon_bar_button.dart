
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';

class IconBarButton extends StatefulWidget {
  final String text;
  final Widget icon;
  final Function onPressed;

  IconBarButton(
      {
        Key key, 
        @required this.text,
        @required this.icon,
        this.onPressed,
      }
    ): super(key: key);

  @override
  _IconBarButton createState() => _IconBarButton();
}

class _IconBarButton extends State<IconBarButton> {
  @override
  Widget build(BuildContext context) {
    return 
      FlatButton(
        onPressed: widget.onPressed,
        color: auxAccent,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: widget.icon,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                strutStyle: StrutStyle(
                  fontSize: 17, 
                  height: 1.2
                ), 
              ),
            ),
          ],
        )
      );
  }
}