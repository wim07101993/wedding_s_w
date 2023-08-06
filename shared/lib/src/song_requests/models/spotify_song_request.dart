import 'package:shared/json_extensions.dart';
import 'package:shared/src/song_requests/models/free_input_song_request.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/string_extensions.dart';
import 'package:spotify/spotify.dart';

class SpotifySong implements SongRequest {
  const SpotifySong({
    required this.timestamp,
    required this.spotifyId,
    required this.title,
    required this.artists,
    required this.albumName,
    required this.albumCoverUrl,
  });

  SpotifySong.fromSpotifyTrack(TrackSimple track)
      : spotifyId = track.id,
        title = track.name.nullIfEmpty,
        artists = track.artists
                ?.map((artist) => artist.name)
                .whereType<String>()
                .toList(growable: false) ??
            const [],
        albumName = track is Track ? track.album?.name.nullIfEmpty : null,
        albumCoverUrl =
            track is Track ? track.album?.images?.first.url.nullIfEmpty : null,
        timestamp = DateTime.now();

  factory SpotifySong.fromJson(Map<String, dynamic> json) {
    return SpotifySong(
      timestamp: json.get('timestamp'),
      spotifyId: json.get('spotifyId'),
      title: json.get('title'),
      artists: json.getList('artists'),
      albumName: json.get('albumName'),
      albumCoverUrl: json.get('albumCoverUrl'),
    );
  }

  final String? spotifyId;
  final String? title;
  final List<String> artists;
  final String? albumName;
  final String? albumCoverUrl;
  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic> toFirebase() {
    return {
      SongRequest.typeFieldName: typeName,
      SongRequest.timestampFieldName: timestamp,
      idFieldName: spotifyId,
      'title': title,
      'artists': artists,
      'albumName': albumName,
      'albumCoverUrl': albumCoverUrl,
    };
  }

  @override
  T when<T>({
    required T Function(SpotifySong song) spotifySong,
    required T Function(FreeInputSongRequest song) freeInputSongRequest,
  }) {
    return spotifySong(this);
  }

  static const String typeName = 'SpotifySongRequest';
  static const String idFieldName = 'spotifyId';
}
