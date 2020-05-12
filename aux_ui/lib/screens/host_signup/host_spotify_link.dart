import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/buttons/icon_bar_button.dart';

class HostSpotifyLink extends StatefulWidget {
  _HostSpotifyLinkState createState() => _HostSpotifyLinkState();
}

class _HostSpotifyLinkState extends State<HostSpotifyLink> {
  bool _initialized = false;
  Widget _accountSetupText;
  Widget _spotifyLink;

  void _initializeWidgets() {
    if (_initialized)
      return; // don't waste time reinitializing widgets on rebuild
    _initialized = true;

    _accountSetupText = Align(
        alignment: Alignment.bottomLeft,
        child: Text("let's set up your account", style: auxDisp3));

    _spotifyLink = Align(
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
                    IconBarButton(
                        icon: Image.asset(
                            'assets/spotify_logo.png', height: 21, width: 21),
                        text: 'link your spotify premium *'
                    )
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

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _initializeWidgets();

    return NuxContainer(
        topFlex: 6,
        title: 'aux',
        topWidget: _accountSetupText,
        bottomWidget: _spotifyLink);
  }
}