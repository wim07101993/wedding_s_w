import 'package:spotify/spotify.dart';
import 'package:wedding_s_w/features/song_requests/models/free_input_song_request.dart';
import 'package:wedding_s_w/features/song_requests/models/spotify_song_request.dart';

abstract class SongRequest {
  const SongRequest();

  factory SongRequest.fromSpotifyTrack(TrackSimple track) =
      SpotifySong.fromSpotifyTrack;

  factory SongRequest.freeInput({required String input}) = FreeInputSongRequest;

  factory SongRequest.fromFirebase(Map<String, dynamic> json) {
    if (_songRequestIs<SpotifySong>(json)) {
      return SpotifySong.fromJson(json);
    } else if (_songRequestIs<FreeInputSongRequest>(json)) {
      return FreeInputSongRequest.fromJson(json);
    } else {
      throw Exception('unknown song request type $json');
    }
  }

  Map<String, dynamic> toJson();

  Map<String, dynamic> toFirebase() {
    final json = toJson();
    return {
      'type': runtimeType.toString(),
      ...json,
    };
  }

  static bool _songRequestIs<T>(Map<String, dynamic> json) {
    return json['type'] == T.toString();
  }
}
