import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/buttons/confirmation_nav_button.dart';

class HostConfirmation extends StatefulWidget {
  _HostConfirmationState createState() => _HostConfirmationState();
}

class _HostConfirmationState extends State<HostConfirmation> {
  bool _initialized = false;
  Widget _confirmationText;
  Widget _queueCreateConfirmation;

  void _initializeWidgets() {
    if (_initialized)
      return; // don't waste time reinitializing widgets on rebuild
    _initialized = true;

    _confirmationText = Align(
        alignment: Alignment.bottomLeft,
        child: Text("does this look right?", style: auxDisp3));

    _queueCreateConfirmation = Align(
      alignment: Alignment.bottomCenter,
      child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                top: 35), // TODO: change after putting in queue preview
            child: ConfirmationNavButton(
                height: 32,
                width: SizeConfig.screenWidth * 3 / 5,
                onPressed: () {},
                color: auxAccent,
                borderColor: auxAccent,
                text: "join",
                textStyle: auxPrimaryButton)),
        Padding(
            padding: EdgeInsets.only(top: 35),
            child: ConfirmationNavButton(
                height: 32,
                width: SizeConfig.screenWidth * 3 / 5,
                onPressed: () {},
                color: auxPrimary,
                borderColor: auxAccent,
                text: "this isn't it, take me back",
                textStyle: auxAccentButton))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _initializeWidgets();

    return NuxContainer(
        topFlex: 6,
        title: 'aux',
        topWidget: _confirmationText,
        bottomWidget: _queueCreateConfirmation);
  }

}