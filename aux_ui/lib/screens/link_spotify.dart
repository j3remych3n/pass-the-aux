import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/layout/nux_container.dart';
import 'package:aux_ui/widgets/buttons/icon_bar_button.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/aux_lib/aux_controller.dart';
import 'package:aux_ui/routing/routing_constants.dart';

class LinkSpotify extends SequentialWidget {
  final SpotifySession sessionManager;

  const LinkSpotify({Key key, String nextPage, this.sessionManager})
      : super(key: key, nextPage: nextPage);

  _LinkSpotifyState createState() => _LinkSpotifyState();
}

class _LinkSpotifyState extends State<LinkSpotify> {
  login() async {
    bool authConnected = await widget.sessionManager.login();

    if (authConnected) {
      // TODO - actually get spotify username for "auth"
      var webController = AuxController('');
      webController.login();

      if (widget.nextPage == HostInviteRoute)
        await webController.createSession();

      widget.next(context, arguments: webController);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return NuxContainer(
        topFlex: 6,
        title: 'aux',
        topWidget: const Align(
            alignment: Alignment.bottomLeft,
            child: Text("let's set up your account", style: auxDisp3)),
        bottomWidget: Align(
            alignment: Alignment.center,
            child: Padding(
                padding:
                    EdgeInsets.only(bottom: SizeConfig.safeAreaVertical * 1.5),
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
                          onPressed: login,
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
                ))));
  }
}
