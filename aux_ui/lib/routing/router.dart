import 'package:aux_ui/routing/routing_constants.dart';
import 'package:aux_ui/screens/create_queue/host_invite.dart';
import 'package:aux_ui/screens/link_spotify.dart';
import 'package:aux_ui/screens/join_queue/join_queue.dart';
import 'package:aux_ui/screens/join_queue/join_queue_confirmation.dart';
import 'package:aux_ui/screens/nux_intro.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/screens/tester.dart';
import 'package:aux_ui/screens/main/main_queue.dart';
import 'package:aux_ui/screens/main/main_search.dart';
import 'package:flutter/material.dart';

final SpotifySession spotifySession = SpotifySession();

Route<dynamic> generateRoute(RouteSettings settings) {
  Object args = settings.arguments;
  // TODO: confirm where we replace the route and where we push/pop, decide where to have default null next/back
  switch (settings.name) {
  
    case MainQueueRoute:
      return MaterialPageRoute(builder: (context) => MainSearch(spotifySession: spotifySession));
      // return MaterialPageRoute(builder: (context) => MainQueue(sessionManager: spotifySession));
    
    case MainSearchRoute:
      return MaterialPageRoute(builder: (context) => MainSearch(spotifySession: spotifySession));

    case LinkSpotifyRoute:
      if (args.toString() == 'host') {
        return MaterialPageRoute(builder: (context) => LinkSpotify(nextPage: HostInviteRoute, sessionManager: spotifySession));
      }
      return MaterialPageRoute(builder: (context) => LinkSpotify(nextPage: JoinQueueRoute, sessionManager: spotifySession));
    
    case HostInviteRoute:
      String queueName = settings.arguments;
      return MaterialPageRoute(builder: (context) => HostInvite(
          queueName: queueName, 
          nextPage: MainQueueRoute,
          backPage: NuxIntroRoute,
        )
      );
    
    case JoinQueueRoute:
      return MaterialPageRoute(builder: (context) => GuestJoinQueue(nextPage: JoinQueueConfirmationRoute));

    case JoinQueueConfirmationRoute:
      return MaterialPageRoute(builder: (context) => JoinQueueConfirmation(
        nextPage: MainQueueRoute,
        backPage: JoinQueueRoute,
        )
      );    

    case NuxIntroRoute:
      return MaterialPageRoute(builder: (context) => NuxIntro());

    case TesterRoute:
      return MaterialPageRoute(builder: (context) => Tester());
    
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