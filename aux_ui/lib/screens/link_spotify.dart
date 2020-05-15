import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/buttons/icon_bar_button.dart';
import 'package:aux_ui/named_routing/routing_constants.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/models/crossfade_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/player_context.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:logger/logger.dart';
import 'dart:async';


class LinkSpotify extends SequentialWidget {
  const LinkSpotify({Key key, String nextPage})
      : super(key: key, nextPage: nextPage);

  _LinkSpotifyState createState() => _LinkSpotifyState();
}

class _LinkSpotifyState extends State<LinkSpotify> {
  bool _initialized = false;
  Widget _accountSetupText;
  Widget _spotifyLink;
  final Logger _logger = Logger();

  Future<void> connectToSpotifyRemote() async {
    print("HERE!!!!");
    print(DotEnv().env['CLIENT_ID']);
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: DotEnv().env['CLIENT_ID'],
          redirectUrl: DotEnv().env['REDIRECT_URL']);
      print("===RESULT===");
      print(result);
      print("===RESULT===");
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> getAuthenticationToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: DotEnv().env['CLIENT_ID'],
          redirectUrl: DotEnv().env['REDIRECT_URL']);
      setStatus("Got a token: $authenticationToken");
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  void setStatus(String code, {String message = ""}) {
    var text = message.isEmpty ? "" : " : $message";
    _logger.i("$code$text");
  }

  void login() {
    connectToSpotifyRemote();
    getAuthenticationToken();
    //widget.next(context); //TODO: only next if successful login
  }

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
                    child: IconBarButton(
                      icon: Image.asset('assets/spotify_logo.png',
                          height: 21, width: 21),
                      text: 'link your spotify premium *',
                      onPressed: () => login(),
                    )),
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

    return StreamBuilder(
      stream: SpotifySdk.subscribeConnectionStatus(),
        builder: (context, snapshot) {
        bool _connected = false;
        if (snapshot.data != null) {
          _connected = snapshot.data.connected;
        }
      return NuxContainer(
          topFlex: 6,
          title: 'aux',
          topWidget: _accountSetupText,
          bottomWidget: _spotifyLink);
    });
  }
}
