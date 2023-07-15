import 'package:behaviour/behaviour.dart';
import 'package:shared/song_requests/models/spotify_song_request.dart';
import 'package:spotify/spotify.dart';

class SearchSongs extends Behaviour<String, List<SpotifySong>> {
  SearchSongs({
    super.monitor,
    required this.spotify,
  });

  final SpotifyApi spotify;

  @override
  Future<List<SpotifySong>> action(String searchString, BehaviourTrack? track) {
    return spotify.search.get(searchString).first(10).then(
          (pages) => pages
              .tracks()
              .map((track) => SpotifySong.fromSpotifyTrack(track))
              .toList(growable: false),
        );
  }
}

extension _PageExtensions on List<Page> {
  Iterable<TrackSimple> tracks() sync* {
    for (final page in this) {
      final items = page.items?.toList(growable: false);
      if (items == null) {
        continue;
      }

      for (final item in items) {
        if (item is TrackSimple) {
          yield item;
        }
      }
    }
  }
}
