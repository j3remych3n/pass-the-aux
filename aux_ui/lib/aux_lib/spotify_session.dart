import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify/spotify.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:aux_ui/aux_lib/song.dart';

class SpotifySession {
  var _authToken;
  var _connected = false;

  static final String _CLIENT_ID = DotEnv().env['CLIENT_ID'].toString();
  static final String _REDIRECT_URL = DotEnv().env['REDIRECT_URL'].toString();
  static final String _CLIENT_SECRET = DotEnv().env['CLIENT_SECRET'].toString();
  final Logger _logger = new Logger();
  SpotifyApi _webApi = new SpotifyApi(new SpotifyApiCredentials(_CLIENT_ID, _CLIENT_SECRET));

  void setStatus(String code, {String message = ""}) {
    var text = message.isEmpty ? "" : " : $message";
    _logger.i("$code$text");
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: _CLIENT_ID,
          redirectUrl: _REDIRECT_URL);
      _connected = result;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> authenticate() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: _CLIENT_ID,
          redirectUrl: _REDIRECT_URL);
      _authToken = authenticationToken;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> queue(String spotifyUri) async {
    try {
      await SpotifySdk.queue(
          spotifyUri: spotifyUri);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<bool> login() async {
    await connectToSpotifyRemote();
    await authenticate();
    setStatus("token is", message: _authToken);
    setStatus("connected is", message: _connected.toString());
    return _connected;
  }


  Future<List<Song>> search(
    String query, 
    { List<SearchType> types = const [SearchType.track], 
      int limit = 20, 
      String market = 'US'}) async {
        
      var results = await _webApi.search
        .get(query, types);

      
        
      /*var search = await spotify.search
      .get('metallica')
      .first(2)
      .catchError((err) => print((err as SpotifyException).message));
  if (search == null) {
    return;
  }
  search.forEach((pages) {
    pages.items.forEach((item) {
      if (item is PlaylistSimple) {
        print('Playlist: \n'
            'id: ${item.id}\n'
            'name: ${item.name}:\n'
            'collaborative: ${item.collaborative}\n'
            'href: ${item.href}\n'
            'trackslink: ${item.tracksLink.href}\n'
            'owner: ${item.owner}\n'
            'public: ${item.owner}\n'
            'snapshotId: ${item.snapshotId}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            'images: ${item.images.length}\n'
            '-------------------------------');
      }
      if (item is Artist) {
        print('Artist: \n'
            'id: ${item.id}\n'
            'name: ${item.name}\n'
            'href: ${item.href}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            '-------------------------------');
      }
      if (item is TrackSimple) {
        print('Track:\n'
            'id: ${item.id}\n'
            'name: ${item.name}\n'
            'href: ${item.href}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            'isPlayable: ${item.isPlayable}\n'
            'artists: ${item.artists.length}\n'
            'availableMarkets: ${item.availableMarkets.length}\n'
            'discNumber: ${item.discNumber}\n'
            'trackNumber: ${item.trackNumber}\n'
            'explicit: ${item.explicit}\n'
            '-------------------------------');
      }
      if (item is AlbumSimple) {
        print('Album:\n'
            'id: ${item.id}\n'
            'name: ${item.name}\n'
            'href: ${item.href}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            'albumType: ${item.albumType}\n'
            'artists: ${item.artists.length}\n'
            'availableMarkets: ${item.availableMarkets.length}\n'
            'images: ${item.images.length}\n'
            '-------------------------------');
      } 
    });
  });*/
  }
}