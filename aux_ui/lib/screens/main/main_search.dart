import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/main_container.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';
import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:flutter/foundation.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class MainSearch extends StatefulWidget {
  final SpotifySession spotifySession;
  const MainSearch({Key key, this.spotifySession}) : super(key: key);
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  List<Song> searchResults;
  TextEditingController searchController;
  int counter = 0;


  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    this.searchResults = new List();
  }

  void _search(String query) async {
    widget.spotifySession.search(query).then((results) =>
      setState(() {
          this.searchResults = results;
        }
      )
    );
  }

  void _throttledSearch(String query) async {
    await _search(query);
  }

  void avoidKeyboard(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MainContainer(title: 'add a song', 
      body: [
        AuxTextField( // TODO: add clear input blutton at far right end
          icon: Icon(Icons.search, color:auxAccent, size: 26.0, semanticLabel: "Search for a song"),
          label: 'search for a song',
          controller: this.searchController,
          showActions: false,
          onChanged: this._search, // short search? https://stackoverflow.com/questions/54765307/textfield-on-change-call-api-how-to-throttle-this
          onSubmitted: this._search, // TODO: full search
        ),
        KeyboardAvoider(
          child: QueueContainer(
            title: 'results',
            child: SongList(songs: this.searchResults, onPress: (){}),
            constraints: null,
            height: 500.0,
        ),
        )
      ]
    );
  }
}