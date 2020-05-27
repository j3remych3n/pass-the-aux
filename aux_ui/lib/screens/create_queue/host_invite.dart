import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/layout/nux_container.dart';
import 'package:aux_ui/widgets/buttons/rounded_action_button.dart';

class HostInvite extends SequentialWidget {
  final String queueName;
  const HostInvite({Key key, String nextPage, String backPage, this.queueName})
      : super(key: key, nextPage: nextPage, backPage: backPage);
  _HostInviteState createState() => _HostInviteState();
}

class _Caption extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const _Caption({Key key, this.text, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class _QRCode extends StatelessWidget {
  final String imageAssetLink;

  const _QRCode({Key key, this.imageAssetLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth *
            0.7, // TODO: un-hardcode, square won't work
        height: SizeConfig.screenWidth * 0.7,
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
}

class _BitlyLink extends StatelessWidget {
  final String url;

  const _BitlyLink({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                data: IconThemeData(
                    color: auxAccent), // TODO: pull up share methods
                child: Icon(Icons.share))));
  }
}

class _HostInviteState extends State<HostInvite> {
  Widget _namePromptText;
  Widget _inviteGeneration;
  String _bitlyURL;
  String _qrAssetLink;
  bool _initialized = false;

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
        const _Caption(
            text: "with a secret link",
            padding: EdgeInsets.only(left: 5, bottom: 12)),
        _BitlyLink(url: _bitlyURL),
        const _Caption(
            text: "with a QR code",
            padding: EdgeInsets.only(left: 5, bottom: 12, top: 24)),
        _QRCode(imageAssetLink: _qrAssetLink),
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: RoundedActionButton(
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
