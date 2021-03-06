import 'package:flutter/services.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:aux_ui/aux_lib/song.dart';

class SpotifySession {
  var _authToken;
  var _connected = false;
  String currentSongUri = "spotify:track:5OuJTtNve7FxUX82eEBupN";

  static final String _CLIENT_ID = DotEnv().env['CLIENT_ID'].toString();
  static final String _REDIRECT_URL = DotEnv().env['REDIRECT_URL'].toString();
  static final String _CLIENT_SECRET = DotEnv().env['CLIENT_SECRET'].toString();
  final Logger _logger = new Logger();

  void setStatus(String code, {String message = ""}) {
    var text = message.isEmpty ? "" : " : $message";
    _logger.i("$code$text");
  }

  Stream<PlayerState> getPlayerState() {
    return SpotifySdk.subscribePlayerState();
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: _CLIENT_ID, redirectUrl: _REDIRECT_URL);
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
          clientId: _CLIENT_ID, redirectUrl: _REDIRECT_URL);
      _authToken = authenticationToken;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> queue(String spotifyUri) async {
    try {
      await SpotifySdk.queue(spotifyUri: spotifyUri);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> play(String spotifyUri) async {
    try {
      await SpotifySdk.play(spotifyUri: spotifyUri);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus("not implemented");
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
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
}
