
import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/buttons/icon_bar_button.dart';
// import 'package:aux_ui/widgets/nux_overlay.dart';

class GuestJoinQueue extends SequentialWidget {
  const GuestJoinQueue({Key key, String nextPage}) : super(key: key, nextPage: nextPage);
  _GuestJoinQueueState createState() => _GuestJoinQueueState();
}

class _GuestJoinQueueState extends State<GuestJoinQueue> {
  TextEditingController formController;
  AuxTextField secretLinkInput;
  bool _textfieldInput = false;

  final String secretLinkLabel = 'enter a secret code / link';

  @override
  void initState() {
    formController = TextEditingController();
    
    secretLinkInput = AuxTextField(
      label: secretLinkLabel,
      controller: formController,
      onFocusChange: txtFocused,
    );

    super.initState();
  }

  void closeOverlay(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  void txtSubmitted(String str) {
    print('submitted ' + str);
  }

  void txtFocused(bool focused) {
    print('textbox focused? ' + focused.toString());
    setState(() {
      _textfieldInput = focused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      NuxContainer(
        title: 'aux', 
        topFlex: 3,
        topWidget: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Text("join\nan aux queue", style: auxDisp3),
          ),
        bottomWidget:  
          Align(
            alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  secretLinkInput,
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('or', style: auxAccentButton)
                  ),
                ],
              )
            ),
      );
  }
}