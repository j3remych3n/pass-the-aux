import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class MainContainer extends StatelessWidget  {

  final String title;
  final Widget headerWidget;
  final Widget bottomWidget;
  final List<Widget> body;

  const MainContainer(
    {
      Key key,
      this.title,
      this.headerWidget,
      this.body,
      this.bottomWidget,
    }
  ) : super(key: key);



  @override
  build(BuildContext context) {
    // SizeConfig().init(context);
    return Material(
      child: Container(
        constraints: BoxConstraints.loose(
          Size.fromHeight(
            SizeConfig.safeAreaVertical
          )
        ),
        padding: SizeConfig.notchPadding,
        color: auxPrimary,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: SizeConfig.safeAreaHorizontal, 
            maxHeight: SizeConfig.safeAreaVertical,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 5, 
                  bottom: SizeConfig.blockSizeVertical * 1,
                  left: SizeConfig.blockSizeHorizontal * 4,
                  right: SizeConfig.blockSizeHorizontal * 4,
                  ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(this.title, style: auxDisp2)
                )
              ), 
              SizedBox(
                width: SizeConfig.safeAreaHorizontal,
                height: SizeConfig.blockSizeVertical,
                child: this.headerWidget,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 80,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 2,
                    right: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  child: Column(
                    children: this.body
                    .map((child) => 
                      Padding(
                        child: child, 
                        padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical*0.65,
                          bottom: SizeConfig.blockSizeVertical*0.65
                        )
                      )
                    ).toList()
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}