import 'package:aux_ui/named_routing/routing_constants.dart';
import 'package:aux_ui/screens/create_queue/host_invite.dart';
import 'package:aux_ui/screens/link_spotify.dart';
import 'package:aux_ui/screens/join_queue/join_queue.dart';
import 'package:aux_ui/screens/join_queue/join_queue_confirmation.dart';
import 'package:aux_ui/screens/nux_intro.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  Object args = settings.arguments;
  // TODO: confirm where we replace the route and where we push/pop, decide where to have default null next/back
  switch (settings.name) {
    case AuxHomeRoute:
      return MaterialPageRoute(builder: (context) => NuxIntro());
    
    case LinkSpotifyRoute:
      if (args.toString() == 'host') {
        return MaterialPageRoute(builder: (context) => LinkSpotify(nextPage: HostInviteRoute));
      }
      return MaterialPageRoute(builder: (context) => LinkSpotify(nextPage: JoinQueueRoute));
    
    case HostInviteRoute:
      String queueName = settings.arguments;
      return MaterialPageRoute(builder: (context) => HostInvite(
        queueName: queueName, 
        nextPage: AuxHomeRoute,
        backPage: AuxHomeRoute,
        )
      );
    
    case JoinQueueRoute:
      return MaterialPageRoute(builder: (context) => GuestJoinQueue(nextPage: JoinQueueConfirmationRoute));

    case JoinQueueConfirmationRoute:
      return MaterialPageRoute(builder: (context) => JoinQueueConfirmation(backPage: JoinQueueRoute));    

    case NuxIntroRoute:
      return MaterialPageRoute(builder: (context) => NuxIntro());
    
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