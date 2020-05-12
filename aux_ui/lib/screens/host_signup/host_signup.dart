import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/screens/host_signup/host_confirmation.dart';
import 'package:aux_ui/screens/host_signup/host_invite.dart';
import 'package:aux_ui/screens/host_signup/host_name_queue.dart';
import 'package:aux_ui/screens/host_signup/host_spotify_link.dart';


class HostSignup extends StatefulWidget {
  _HostSignupState createState() => _HostSignupState();
}

class _HostSignupState extends State<HostSignup> {
  Widget _spotifyLink;
  Widget _namePrompt;
  Widget _invite;
  Widget _confirmation;
  bool _initialized;

  void initializeWidgets() {
    if (_initialized)
      return; // don't waste time reinitializing widgets on rebuild
    _initialized = true;

    _spotifyLink = HostSpotifyLink();
    _namePrompt = HostNameQueue();
    _invite = HostInvite();
    _confirmation = HostConfirmation();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    initializeWidgets();

    return null;
  }
}
