
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/buttons/icon_bar_button.dart';
import 'package:aux_ui/named_routing/routing_constants.dart';

class NuxIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      NuxContainer(
        title: 'aux', 
        topWidget: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Text("let's get started", style: auxDisp3),
          ),
        bottomWidget:  
          Align(
            alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  ButtonTheme(
                      minWidth: double.infinity,
                      child: IconBarButton(
                          text: 'host a new queue',
                          onPressed: () => Navigator.pushNamed(context, HostSpotifyLinkRoute),
                        ),
                    ),
                    Padding(padding: EdgeInsets.all(18)),
                    ButtonTheme(
                      minWidth: double.infinity,
                      child: IconBarButton(
                          text: 'join an existing queue',
                          onPressed: () => Navigator.pushNamed(context, GuestSignupRoute),
                        ),
                    ),
                ]
              )
          )
      );
  }
}