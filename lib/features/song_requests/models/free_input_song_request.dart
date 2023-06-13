import 'package:wedding_s_w/features/song_requests/models/song_request.dart';
import 'package:wedding_s_w/shared/json_extensions.dart';

class FreeInputSongRequest extends SongRequest {
  const FreeInputSongRequest({required this.input});

  factory FreeInputSongRequest.fromJson(Map<String, dynamic> json) {
    return FreeInputSongRequest(
      input: json.get('input'),
    );
  }

  final String input;

  @override
  Map<String, dynamic> toJson() => {'input': input};
}
