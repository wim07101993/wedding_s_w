import 'package:spotify/spotify.dart';
import 'package:wedding_s_w/features/song_requests/models/free_input_song_request.dart';
import 'package:wedding_s_w/features/song_requests/models/spotify_song_request.dart';

abstract class SongRequest {
  factory SongRequest.fromSpotifyTrack(TrackSimple track) =
      SpotifySong.fromSpotifyTrack;

  factory SongRequest.freeInput({required String input}) =
      FreeInputSongRequest.fromInput;

  factory SongRequest.fromFirebase(Map<String, dynamic> json) {
    final type = json[typeFieldName];
    if (type == SpotifySong.typeName) {
      return SpotifySong.fromJson(json);
    } else if (type == FreeInputSongRequest.typeName) {
      return FreeInputSongRequest.fromJson(json);
    } else {
      throw Exception('unknown song request type $json');
    }
  }

  DateTime get timestamp;

  Map<String, dynamic> toFirebase();

  T when<T>({
    required T Function(SpotifySong song) spotifySong,
    required T Function(FreeInputSongRequest song) freeInputSongRequest,
  });

  static const String typeFieldName = 'type';
  static const String timestampFieldName = 'timestamp';
}
