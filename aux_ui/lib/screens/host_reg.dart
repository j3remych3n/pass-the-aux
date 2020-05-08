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
  List<Widget> tops;
  List<Widget> bottoms;
  bool initialized = false;

  Widget createTopText(String text) {
    return Align(
        alignment: Alignment.bottomLeft, child: Text(text, style: auxDisp3));
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
                  child: LinkSpotifyButton(text: 'link your spotify premium *'),
                ),
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
                  AuxTextField(
                    icon: Icon(
                      Icons.short_text,
                      color: auxAccent,
                      size: 26.0,
                      semanticLabel: "aux queue name",
                    ),
                    label: 'name your aux queue',
                  )
                ])));

    Widget secretLinkGeneration =
        Card(child: Text("placeholder", style: auxBody2));

    bottoms = [spotifyLink, nameQueueTextField, secretLinkGeneration];
  }

  Widget createCaption(String text, EdgeInsets padding) {
    return Padding(
        padding: padding,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "with a secret link",
              style: auxAccentButton,
              textAlign: TextAlign.left,
            )));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    initializeWidgets();

    return RegContainer(
        topFlex: 3,
        title: 'aux',
        topWidget: Align(
            alignment: Alignment.bottomCenter,
            child: Text("let's set up your account", style: auxDisp3)),
        bottomWidget: Align(
          alignment: Alignment.bottomCenter,
          child: Column(children: <Widget>[
            createCaption(
                "with a secret link", EdgeInsets.only(left: 5, bottom: 12)),
            Card(
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
                    title: Text("placeholder", style: auxBody2),
                    trailing: IconTheme(
                        data: IconThemeData(color: auxAccent),
                        child: Icon(Icons.share)))),
            createCaption("with a QR code",
                EdgeInsets.only(left: 5, bottom: 12, top: 36)),
            Container(
                width: 100,
                height: 100,
                child: Card(
                child: Image.asset('assets/qr_example.png'),
                color: auxAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: auxAccent,
                        style: BorderStyle.solid,
                        width: 2 // TODO: scale by screen resolution
                        )))),
            FlatButton(color: auxAccent, shape: RoundedRectangleBorder(side: BorderSide(
                color: auxAccent,
                style: BorderStyle.solid
            ), borderRadius: BorderRadius.circular(50)),
                child: Text("done", style: auxAccentButton))
          ]),
        ));
  }
}
