import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/layout/nux_container.dart';
import 'package:aux_ui/widgets/buttons/confirmation_nav_button.dart';

class HostInvite extends SequentialWidget {
  final String queueName;
  const HostInvite(
    {
      Key key, 
      String nextPage, 
      String backPage, 
      this.queueName}) : super(key: key, nextPage: nextPage, backPage: backPage);
  _HostInviteState createState() => _HostInviteState(queueName);
}

class _HostInviteState extends State<HostInvite> {
  Widget _namePromptText;
  Widget _inviteGeneration;
  String _bitlyURL;
  String _qrAssetLink;
  bool _initialized = false;
  final String queueName;

  _HostInviteState(this.queueName);

  void _createBitlyLink() {
    _bitlyURL = "bit.ly/2VqnC3B";
    // TODO: write actual generation with queueName
  }

  void _createQRCode() {
    _qrAssetLink = "assets/qr_example.png";
    // TODO: write actual generation; with queueName
  }

  @override
  void initState() {
    super.initState();
    _createBitlyLink();
    _createQRCode();
  }

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

  Widget _createBitlyLinkComponent(String url) {
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
                data: IconThemeData(color: auxAccent), // TODO: pull up share methods
                child: Icon(Icons.share))));
  }

  Widget _createQRCodeComponent(String imageAssetLink) {
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
        _createBitlyLinkComponent(_bitlyURL),
        _createCaption(
            "with a QR code", EdgeInsets.only(left: 5, bottom: 12, top: 24)),
        _createQRCodeComponent(_qrAssetLink),
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: ConfirmationNavButton(
                height: 40,
                width: SizeConfig.screenWidth * 3 / 5,
                onPressed: () => widget.nextReplace(context),
                color: auxAccent,
                borderColor: auxAccent,
                text: "done",
                textStyle: auxPrimaryButton))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _initializeWidgets();

    return NuxContainer(
        topFlex: 3,
        title: 'aux',
        topWidget: _namePromptText,
        bottomWidget: _inviteGeneration);
  }

}