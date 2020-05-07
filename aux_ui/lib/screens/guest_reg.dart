
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/reg_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/buttons/link_spotify_button.dart';

class GuestReg extends StatefulWidget {

  _GuestRegState createState() => _GuestRegState();
}

class _GuestRegState extends State<GuestReg> {
  @override
  Widget build(BuildContext context) {
    return 
      RegContainer(
        title: 'aux', 
        topWidget: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Text("first,\nlet's get a name!", style: auxDisp3)
          ),
        bottomWidget:  
          Align(
            alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  AuxTextField(
                    icon: Icon(
                      Icons.short_text, 
                      color:auxAccent,
                      size: 26.0,
                      semanticLabel: "Short text for user nickname",
                    ),
                    label: 'enter a nickname',
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('or', style: auxAccentButton)
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: LinkSpotifyButton(),
                  )
                ],
              )
            ),
      );
  }
}