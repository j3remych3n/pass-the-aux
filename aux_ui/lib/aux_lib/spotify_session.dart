import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class SpotifySession {
  var _authToken;
  var _connected = false;

  final String CLIENT_ID = DotEnv().env['CLIENT_ID'].toString();
  final String REDIRECT_URL = DotEnv().env['REDIRECT_URL'].toString();
  final Logger _logger = Logger();

  void setStatus(String code, {String message = ""}) {
    var text = message.isEmpty ? "" : " : $message";
    _logger.i("$code$text");
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: CLIENT_ID,
          redirectUrl: REDIRECT_URL);
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
          clientId: DotEnv().env['CLIENT_ID'].toString(),
          redirectUrl: DotEnv().env['REDIRECT_URL']).toString();
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
}