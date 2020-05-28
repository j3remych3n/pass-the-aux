import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/routing/router.dart';
import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/widgets/queue_main_display/playback_controls.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/main_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';
import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:aux_ui/widgets/buttons/rounded_action_button.dart';

class MainSearch extends StatefulWidget {
  final SpotifySession spotifySession;
  const MainSearch({Key key, this.spotifySession}) : super(key: key);
  _MainSearchState createState() => _MainSearchState();
}

class _SearchResults extends StatelessWidget {
  final List<Song> searchResults;
  final Function songOnPress;
  const _SearchResults({Key key, @required this.searchResults, @required this.songOnPress}):super(key: key);

  @override
  build(BuildContext) {
    return QueueContainer( // TODO: factor out into nested class
        title: 'results',
        child: SongList(songs: this.searchResults, songOnPress: (int x){}),
    );
  }
}

class _YourPicks extends StatelessWidget {
  final List<Song> yourPicks;
  final Function songOnPress;
  const _YourPicks({Key key, @required this.yourPicks, @required this.songOnPress}):super(key: key);

  @override
  build(BuildContext) {
    return QueueContainer( // TODO: factor out into nested class
        title: 'your picks',
        child: SongList(songs: this.yourPicks, songOnPress: (int x){}),
    );
  }
}

class _SearchControls extends StatelessWidget {
  @override
  build(BuildContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // RoundedActionButton.back(width: SizeConfig.blockSizeHorizontal * 50, onPressed: (){},),

        RoundedActionButton.back(text: 'cancel', onPressed: (){},),
        RoundedActionButton(text: 'add ${20} songs', width: SizeConfig.blockSizeHorizontal * 40, onPressed: (){},),

        // RoundedActionButton.back(text: 'cancel', onPressed: (){},),
        // RoundedActionButton.delete(width: SizeConfig.blockSizeHorizontal * 28, onPressed: (){},),
      ],
    );
  }
}

class _MainSearchState extends State<MainSearch> {
  List<Song> searchResults;
  List<Song> yourPicks;
  List<int> selected;
  TextEditingController searchController;
  bool searching = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    this.searchResults = new List();
    this.yourPicks = new List();
    this.selected = new List();
  }

  void _search(String query) async {
    setState(() {
      this.searching = true;
    });
    widget.spotifySession.search(query).then((results) =>
      setState(() {
          this.searchResults = results;
        }
      )
    );
  }

  void confirm(int x) async {
    setState(() {
      this.searching = false;
    });
  }

  void _throttledSearch(String query) async {
    _search(query);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MainContainer(
      title: 'add a song', 
      body: [
        AuxTextField( // TODO: add clear input blutton at far right end
          icon: Icon(Icons.search, color:auxAccent, size: 26.0, semanticLabel: "Search for a song"),
          label: 'search for a song',
          controller: this.searchController,
          showActions: false,
          onChanged: this._throttledSearch, // short search? https://stackoverflow.com/questions/54765307/textfield-on-change-call-api-how-to-throttle-this
          onSubmitted: this._search, // TODO: full search
        ),
        Expanded(
          child: (this.searching) ? 
            _SearchResults(searchResults: this.searchResults, songOnPress: (int x) {},) : 
            _YourPicks(yourPicks: this.yourPicks, songOnPress: (int x) {},)
          ),
      ],
      // footer: SearchControls(onConfirm: (){}, onCancel: (){}, selected: this.selected),
        // footer: PlaybackControls(isHost: true),
      footerHeight: SizeConfig.blockSizeVertical * 8,
      footer: _SearchControls(),
    );
  }
}