import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/reg_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/buttons/link_spotify_button.dart';
import 'package:aux_ui/widgets/buttons/confirmation_nav_button.dart';

class HostReg extends StatefulWidget {
  _HostRegState createState() => _HostRegState();
}

class _HostRegState extends State<HostReg> {
  List<Widget> tops;
  List<Widget> bottoms;
  List<int> topFlexVals;
  bool initialized = false;
  int screenCounter = 0;
  String queueName;
  String bitlyURL = "bit.ly/2VqnC3B";
  String qrAssetLink = "assets/qr_example.png";

  Widget createTopText(String text) {
    return Align(
        alignment: Alignment.bottomLeft, child: Text(text, style: auxDisp3));
  }

  Widget createCaption(String text, EdgeInsets padding) {
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

  Widget createBitlyLink(String url) {
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

  Widget createQRCode(String imageAssetLink) {
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

  void nextScreen() {
    setState(() {
      if (screenCounter < 3) {
        screenCounter++;
      }
    });
  }

  void spotifyOAuth() {
    // TODO: implement
  }

  void generateBitly() {
     //TODO: replace with actual bitly generation
  }

  void generateQR() {
    // TODO replace with actual qr generation
  }

  void initializeWidgets() {
    if (initialized)
      return; // don't waste time reinitializing widgets on rebuild
    initialized = true;

    tops = [
      createTopText("let's set up your account"),
      createTopText("one more step and we're ready to roll"),
      createTopText("invite your friends"),
      createTopText("does this look right?"),
    ];

    // TODO: add spotify oauth

    Widget spotifyLink = Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.safeAreaVertical * 1.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                    height: SizeConfig.safeAreaVertical,
                    minWidth: double.infinity,
                    child:
                        LinkSpotifyButton(text: 'link your spotify premium *')),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        //TODO: not hard coded
                        child: Text(
                            '* aux hosts need a spotify premium account in order to play music on demand',
                            style: auxAsterisk))),
              ],
            )));

    Widget nameQueueTextField = Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.safeAreaVertical * 1.5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AuxTextField( //TODO: conf = screenCounter increment + gen bitly/qr, cancel = go back
                    icon: Icon(
                      Icons.short_text,
                      color: auxAccent,
                      size: 26.0,
                      semanticLabel: "aux queue name",
                    ),
                    label: 'name your aux queue',
                  )
                ])));

    Widget inviteGeneration = Align(
      alignment: Alignment.bottomCenter,
      child: Column(children: <Widget>[
        createCaption(
            "with a secret link", EdgeInsets.only(left: 5, bottom: 12)),
        createBitlyLink(bitlyURL),
        createCaption(
            "with a QR code", EdgeInsets.only(left: 5, bottom: 12, top: 24)),
        createQRCode(qrAssetLink),
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: ConfirmationNavButton(
                height: 40,
                width: SizeConfig.screenWidth * 3 / 5,
                onPress: () {
                  print(screenCounter);
                  nextScreen();
                },
                color: auxAccent,
                borderColor: auxAccent,
                text: "done",
                textStyle: auxPrimaryButton))
      ]),
    );

    Widget queueCreateConfirmation = Align(
      alignment: Alignment.bottomCenter,
      child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                top: 35), // TODO: change after putting in queue preview
            child: ConfirmationNavButton(
                height: 32,
                width: SizeConfig.screenWidth * 3 / 5,
                onPress: () {},
                color: auxAccent,
                borderColor: auxAccent,
                text: "join",
                textStyle: auxPrimaryButton)),
        Padding(
            padding: EdgeInsets.only(top: 35),
            child: ConfirmationNavButton(
                height: 32,
                width: SizeConfig.screenWidth * 3 / 5,
                onPress: () {},
                color: auxPrimary,
                borderColor: auxAccent,
                text: "this isn't it, take me back",
                textStyle: auxAccentButton))
      ]),
    );

    bottoms = [
      spotifyLink,
      nameQueueTextField,
      inviteGeneration,
      queueCreateConfirmation
    ];
    topFlexVals = [6, 6, 3, 6];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    initializeWidgets();

    return RegContainer(
        topFlex: topFlexVals[screenCounter],
        title: 'aux',
        topWidget: tops[screenCounter],
        bottomWidget: bottoms[screenCounter]);
  }
}
