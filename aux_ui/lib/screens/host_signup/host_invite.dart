import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/buttons/confirmation_nav_button.dart';

class HostInvite extends StatefulWidget {
  _HostInviteState createState() => _HostInviteState();
}

class _HostInviteState extends State<HostInvite> {
  Widget _namePromptText;
  Widget _inviteGeneration;
  String _bitlyURL = "bit.ly/2VqnC3B";
  String _qrAssetLink = "assets/qr_example.png";
  bool _initialized = false;

  Widget _createCaption(String text, EdgeInsets padding) {
    return Padding(
        padding: padding,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: auxAccentButton,
              textAlign: TextAlign.left,
            )));
  }

  Widget _createBitlyLink(String url) {
    return Card(
        color: Colors.transparent,
        borderOnForeground: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: auxAccent,
                style: BorderStyle.solid,
                width: 2 // TODO: scale by screen resolution
            )),
        child: ListTile(
            dense: true,
            title: Text(url, style: auxBody2),
            trailing: IconTheme(
                data: IconThemeData(color: auxAccent),
                child: Icon(Icons.share))));
  }

  Widget _createQRCode(String imageAssetLink) {
    return Container(
        width:
        SizeConfig.screenWidth - 83, // TODO: un-hardcode, square won't work
        height: SizeConfig.screenWidth - 83,
        child: Card(
            child: Image.asset(imageAssetLink),
            color: auxAccent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: auxAccent,
                    style: BorderStyle.solid,
                    width: 2 // TODO: scale by screen resolution
                ))));
  }

  void _initializeWidgets() {
    if (_initialized)
      return; // don't waste time reinitializing widgets on rebuild
    _initialized = true;

    _namePromptText = Align(
        alignment: Alignment.bottomLeft,
        child: Text("invite your friends", style: auxDisp3));

    _inviteGeneration = Align(
      alignment: Alignment.bottomCenter,
      child: Column(children: <Widget>[
        _createCaption(
            "with a secret link", EdgeInsets.only(left: 5, bottom: 12)),
        _createBitlyLink(_bitlyURL),
        _createCaption(
            "with a QR code", EdgeInsets.only(left: 5, bottom: 12, top: 24)),
        _createQRCode(_qrAssetLink),
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: ConfirmationNavButton(
                height: 40,
                width: SizeConfig.screenWidth * 3 / 5,
                onPressed: () {
                  // TODO: implement
                },
                color: auxAccent,
                borderColor: auxAccent,
                text: "done",
                textStyle: auxPrimaryButton))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initializeWidgets();
    return NuxContainer(
        topFlex: 3,
        title: 'aux',
        topWidget: _namePromptText,
        bottomWidget: _inviteGeneration);
  }

}