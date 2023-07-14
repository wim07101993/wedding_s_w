import 'package:shared/json_extensions.dart';
import 'package:shared/song_requests/models/song_request.dart';
import 'package:shared/song_requests/models/spotify_song_request.dart';

class FreeInputSongRequest implements SongRequest {
  const FreeInputSongRequest({
    required this.timestamp,
    required this.input,
    required this.inputToLower,
  });

  FreeInputSongRequest.fromInput({
    required this.input,
  })  : timestamp = DateTime.now(),
        inputToLower = input.toLowerCase();

  factory FreeInputSongRequest.fromJson(Map<String, dynamic> json) {
    return FreeInputSongRequest(
      timestamp: json.get(SongRequest.timestampFieldName),
      input: json.get(inputFieldName),
      inputToLower: json.get(inputToLowerFieldName),
    );
  }

  final String input;
  final String inputToLower;
  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic> toFirebase() {
    return {
      SongRequest.typeFieldName: typeName,
      SongRequest.timestampFieldName: timestamp,
      inputFieldName: input,
      inputToLowerFieldName: inputToLower
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
  static const String inputFieldName = 'input';
  static const String inputToLowerFieldName = 'inputToLower';
}
