
import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/layout/nux_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/buttons/icon_bar_button.dart';
import 'package:aux_ui/named_routing/routing_constants.dart';

class GuestSignup extends SequentialWidget {
  const GuestSignup({Key key, String nextPage}) : super(key: key, nextPage: nextPage);
  _GuestSignupState createState() => _GuestSignupState();
}

class _GuestSignupState extends State<GuestSignup> {
  TextEditingController nicknameController;
  bool _textFieldInput;

  @override
  void initState() {
    _textFieldInput = false;
    nicknameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }

  void txtSubmitted(String str) {
    Navigator.pushNamed(context, JoinQueueRoute);
  }

  void txtFocused(bool focused) {
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
                    onSubmitted: txtSubmitted,
                    onFocusChange: txtFocused,
                  ),
                  Visibility(visible: !_textFieldInput, child: 
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('or', style: auxAccentButton)
                    ),
                  ),
                  Visibility(visible: true, child: 
                    ButtonTheme(
                      minWidth: double.infinity,
                      child: IconBarButton(
                          icon: Image.asset('assets/spotify_logo.png', height: 21, width: 21), 
                          text: 'sign up with spotify',
                          onPressed: () => widget.next(context),
                        ),
                    ),
                  ),
                ],
              )
            ),
      );
  }
}