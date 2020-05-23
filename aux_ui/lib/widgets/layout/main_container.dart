import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class MainContainer extends StatelessWidget  {

  final String title;
  final Widget header;
  final List<Widget> children;

  const MainContainer(
    {
      Key key,
      this.title,
      this.header,
      this.children,
    }
  ) : super(key: key);

  @override
  build(BuildContext context) {
    SizeConfig().init(context);
    
    return Material(
      child: Container(
        constraints: BoxConstraints.loose(
          Size.fromHeight(
            SizeConfig.safeAreaVertical
          )
        ),
        padding: SizeConfig.notchPadding,
        color: auxPrimary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ConstrainedBox(
              constraints: ,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(this.title, style: auxDisp2)
              )
            )
            
          ]
        )
      ),
    );
  }
}