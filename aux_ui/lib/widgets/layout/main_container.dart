import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class MainContainer extends StatelessWidget  {

  final Widget header;
  final List<Widget> children;

  const MainContainer(
    {
      Key key,
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
          children: this.children,
        )
      ),
    );
  }
}