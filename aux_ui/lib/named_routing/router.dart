import 'package:aux_ui/named_routing/routing_constants.dart';
import 'package:aux_ui/screens/host_signup/host_confirmation.dart';
import 'package:aux_ui/screens/host_signup/host_invite.dart';
import 'package:aux_ui/screens/host_signup/host_name_queue.dart';
import 'package:aux_ui/screens/host_signup/host_spotify_link.dart';
import 'package:aux_ui/screens/nux_intro.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // TODO: confirm where we replace the route and where we push/pop, decide where to have default null next/back
  switch (settings.name) {
    case AuxHomeRoute:
      return MaterialPageRoute(builder: (context) => NuxIntro());
    case HostSpotifyLinkRoute:
      return MaterialPageRoute(builder: (context) => HostSpotifyLink());
    case HostNameQueueRoute:
      String nextPage = HostInviteRoute;
      return MaterialPageRoute(builder: (context) => HostNameQueue(nextPage: nextPage));
    case HostInviteRoute:
      String queueName = settings.arguments;
      String nextPage = HostConfirmationRoute;
      return MaterialPageRoute(builder: (context) => HostInvite(queueName: queueName, nextPage: nextPage));
    case HostConfirmationRoute:
      String backPage = HostNameQueueRoute; // TODO: is this the right flow?
      return MaterialPageRoute(builder: (context) => HostConfirmation(backPage: backPage));
    default:
      return MaterialPageRoute(builder: (context) => NuxIntro());
  }
}

/*
* Routing options:
* - manage entirely in this file, all pages separate and arguments passed here
* - build containers with container routes in this file
*   - interactions for subpages managed by passing next page to be generated
* - nested navigators
*   - potentially pretty complex, see bottom tabs example, a lot to manage
* - fake nesting
*   - per stack overflow post, looks like everything is actually flat but the nesting is faked
*   - need to add way to pass arguments in that case
* */