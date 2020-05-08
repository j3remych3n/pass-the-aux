
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/buttons/icon_bar_button.dart';

class GuestNux extends StatefulWidget {
  _GuestNuxState createState() => _GuestNuxState();
}

class _GuestNuxState extends State<GuestNux> {
  TextEditingController nicknameController;
  bool _textFieldInput = false;

  @override
  void initState() {
    nicknameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }

  void submitted(String str) {
    print('submitted ' + str);
  }

  void focused(bool focused) {
    print('textbox focused? ' + focused.toString());
    setState(() {
      _textFieldInput = focused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      NuxContainer(
        title: 'aux', 
        topWidget: 
          Align(
            alignment: Alignment.bottomLeft,
            // child: Text("first,\nlet's get a name!", style: auxDisp3),
            child: Text("first,\nlet's get a name!", style: auxDisp3),
          ),
        bottomWidget:  
          Align(
            alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  AuxTextField(
                    label: 'enter a nickname',
                    controller: nicknameController,
                    onSubmitted: submitted,
                    onFocusChange: focused,
                  ),
                  Visibility(visible: !_textFieldInput, child: 
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('or', style: auxAccentButton)
                    ),
                  ),
                  Visibility(visible: !_textFieldInput, child: 
                    ButtonTheme(
                      minWidth: double.infinity,
                      child: IconBarButton(
                          icon: Image.asset('assets/spotify_logo.png', height: 21, width: 21), 
                          text: 'sign up with spotify'
                        ),
                    ),
                  ),
                ],
              )
            ),
      );
  }
}