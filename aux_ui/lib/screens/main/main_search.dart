import 'package:aux_ui/aux_lib/aux_controller.dart';
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
import 'dart:collection';

class MainSearch extends StatefulWidget {
  final SpotifySession spotifySession;
  final AuxController controller;
  const MainSearch({Key key, this.spotifySession, this.controller}) : super(key: key);
  _MainSearchState createState() => _MainSearchState();
}

class _SearchResults extends StatelessWidget {
  final List<Song> searchResults;
  final HashMap<int, Song> selected = HashMap();
  final AuxController controller;
  bool newSearch;

  _SearchResults(
    {
      Key key, 
      @required this.searchResults, 
      @required this.newSearch,
      @required this.controller,
    }
  ):super(key: key);

  void selectSong(int idx) {
    if(this.newSearch) {
      this.selected.clear();
      this.newSearch = false;
    }
    if(selected.containsKey(idx)) selected.remove(idx);
    else selected.putIfAbsent(idx, () => searchResults[idx]);
    print('selected indices: ${selected.keys.toString()}');
  }

  void addSong(int idx) async {
    this.selected.clear();
    selected.putIfAbsent(idx, () => searchResults[idx]);

//    await this.controller.addSong(selected[idx].id);
    // TODO: change this back
    await this.controller.getSongs(3, 3);
    print('added single song idex: ${selected.keys.toString()}');
  }

  @override
  build(BuildContext context) {
    return QueueContainer( // TODO: factor out into nested class
        title: 'results',
        child: SongList.tap(
            multiSelect: false,
            songs: this.searchResults, 
            onPressed: this.addSong,
        ),
    );
  }
}

class _YourPicks extends StatelessWidget {
  final List<So ng> yourPicks;
  final Function songOnPress;
  const _YourPicks({Key key, @required this.yourPicks, @required this.songOnPress}):super(key: key);

  @override
  build(BuildContext context) {
    return QueueContainer( // TODO: factor out into nested class
        title: 'your picks',
        child: SongList.tap(songs: this.yourPicks, onPressed: (int x){}),
    );
  }
}

class _SearchControls extends StatelessWidget {
  final Function picksBack;
  final Function picksDelete;
  final Function searchAdd;

  const _SearchControls(
    {
      Key key, 
      @required this.picksBack, 
      @required this.picksDelete,
      @required this.searchAdd,
    }
  ):super(key: key);

  @override
  build(BuildContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // picks & search: unselected
        RoundedActionButton.back(
          width: SizeConfig.blockSizeHorizontal * 50, 
          onPressed: (){},),

        // TODO: implement with issue #26
        // search results: selected
        // RoundedActionButton.back(text: 'cancel', onPressed: (){},),
        // RoundedActionButton(text: 'add ${20} songs', width: SizeConfig.blockSizeHorizontal * 40, onPressed: (){},),

        // picks: selected
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
  bool newSearch = true;

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
      this.newSearch = true;
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
        // Expanded(
        //   child: (this.searching) ? 
        //     _SearchResults(
        //       searchResults: this.searchResults, 
        //       newSearch: this.newSearch,
        //     ) :
        //     _YourPicks(yourPicks: this.yourPicks, songOnPress: (int x) {},)
        // ),
        Expanded(
          child: _SearchResults(
            searchResults: this.searchResults, 
            newSearch: this.newSearch,
            controller: widget.controller,
          ),
        ),
      ],
      footerHeight: SizeConfig.blockSizeVertical * 8,
      footer: _SearchControls(),
    );
  }
}