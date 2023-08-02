import 'package:get_it/get_it.dart';
import 'package:shared/src/dependency_management/feature.dart';
import 'package:shared/src/firebase/firebase_feature.dart';
import 'package:shared/src/firebase/remote_config_global_value.dart';
import 'package:shared/src/song_requests/behaviours/get_song_requests.dart';
import 'package:shared/src/song_requests/behaviours/request_song.dart';
import 'package:shared/src/song_requests/behaviours/search_songs.dart';
import 'package:spotify/spotify.dart';

class SharedSongRequestsFeature extends Feature {
  const SharedSongRequestsFeature();

  @override
  List<Type> get dependencies => const [FirebaseFeature];

  @override
  void registerTypes(GetIt getIt) {
    getIt.registerLazySingleton(() {
      final config = getIt<RemoteConfigGlobalValue>().value.spotify;
      return SpotifyApi(
        SpotifyApiCredentials(config.clientId, config.clientSecret),
      );
    });

    getIt.registerFactory(
      () => SearchSongs(monitor: getIt(), spotify: getIt()),
    );
    getIt.registerFactory(
      () => RequestSong(monitor: getIt(), firestore: getIt()),
    );
    getIt.registerFactory(
      () => GetSongRequests(monitor: getIt(), firestore: getIt()),
    );
  }

  @override
  String toString() => 'song request feature';
}
