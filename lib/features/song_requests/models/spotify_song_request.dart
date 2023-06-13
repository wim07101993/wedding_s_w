import 'package:spotify/spotify.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';
import 'package:wedding_s_w/shared/json_extensions.dart';
import 'package:wedding_s_w/shared/string_extensions.dart';

class SpotifySong extends SongRequest {
  const SpotifySong({
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
            track is Track ? track.album?.images?.first.url.nullIfEmpty : null;

  factory SpotifySong.fromJson(Map<String, dynamic> json) {
    return SpotifySong(
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
  Map<String, dynamic> toJson() {
    return {
      'spotifyId': spotifyId,
      'title': title,
      'artists': artists,
      'albumName': albumName,
      'albumCoverUrl': albumCoverUrl,
    };
  }
}
