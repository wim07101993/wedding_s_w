import 'package:wedding_s_w/features/song_requests/models/song_request.dart';
import 'package:wedding_s_w/features/song_requests/models/spotify_song_request.dart';
import 'package:wedding_s_w/shared/json_extensions.dart';

class FreeInputSongRequest implements SongRequest {
  const FreeInputSongRequest({
    required this.timestamp,
    required this.input,
  });

  FreeInputSongRequest.fromInput({
    required this.input,
  }) : timestamp = DateTime.now();

  factory FreeInputSongRequest.fromJson(Map<String, dynamic> json) {
    return FreeInputSongRequest(
      timestamp: json.get('timestamp'),
      input: json.get('input'),
    );
  }

  final String input;
  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic> toFirebase() {
    return {
      SongRequest.typeFieldName: typeName,
      SongRequest.timestampFieldName: timestamp,
      'input': input,
    };
  }

  @override
  T when<T>({
    required T Function(SpotifySong song) spotifySong,
    required T Function(FreeInputSongRequest song) freeInputSongRequest,
  }) {
    return freeInputSongRequest(this);
  }

  static const String typeName = 'FreeInputSongRequest';
}
