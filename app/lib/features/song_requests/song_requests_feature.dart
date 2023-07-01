import 'package:get_it/get_it.dart';
import 'package:spotify/spotify.dart';
import 'package:wedding_s_w/features/song_requests/behaviours/get_song_requests.dart';
import 'package:wedding_s_w/features/song_requests/behaviours/request_song.dart';
import 'package:wedding_s_w/features/song_requests/behaviours/search_songs.dart';
import 'package:wedding_s_w/shared/dependency_management/feature.dart';
import 'package:wedding_s_w/shared/firebase/firebase_feature.dart';
import 'package:wedding_s_w/shared/firebase/remote_config_global_value.dart';

class SongRequestsFeature extends Feature {
  const SongRequestsFeature();

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
}
