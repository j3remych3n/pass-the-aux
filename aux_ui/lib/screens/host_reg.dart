
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/reg_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/buttons/link_spotify_button.dart';

class HostReg extends StatefulWidget {

  _HostRegState createState() => _HostRegState();
}

class _HostRegState extends State<HostReg> {
  Widget accountSetUpText = Align(
      alignment: Alignment.bottomLeft,
      child: Text("let's set up your account", style: auxDisp3)
  );

  Widget oneMoreStepText = Align(
      alignment: Alignment.bottomLeft,
      child: Text("one more step and we're ready to roll", style: auxDisp3)
  );

  @override
  Widget build(BuildContext context) {
    return
      RegContainer(
        title: 'aux',
        topWidget:
        Align(
            alignment: Alignment.bottomLeft,
            child: Text("let's set up your account", style: auxDisp3)
        ),
        bottomWidget:
        Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  height: SizeConfig.safeAreaVertical,
                  minWidth: double.infinity,
                  child: LinkSpotifyButton(text: 'link your spotify premium *'),
                ),
                Align(alignment: Alignment.topRight,
                    child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20), //TODO: not hard coded
                    child: Text('* aux hosts need a spotify premium account in order to play music on demand',
                        style: auxAsterisk)
                )),
              ],
            )
        ),
      );
  }
}