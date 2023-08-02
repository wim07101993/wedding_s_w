import 'package:behaviour/behaviour.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/src/dependency_management/feature.dart';
import 'package:shared/src/firebase/firebase_feature.dart';
import 'package:shared/src/firebase/remote_config_global_value.dart';
import 'package:shared/src/song_requests/behaviours/get_song_requests.dart';
import 'package:shared/src/song_requests/behaviours/request_song.dart';
import 'package:shared/src/song_requests/behaviours/search_songs.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:spotify/spotify.dart';

typedef SongRequestPagingController = PagingController<DateTime?, SongRequest>;

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
    getIt.registerLazySingleton(
      () {
        final controller = SongRequestPagingController(firstPageKey: null);
        controller.addPageRequestListener((lastEntryTimestamp) {
          getIt<GetSongRequests>()(
            GetSongRequestsQuery(lastItemTime: lastEntryTimestamp),
          ).thenWhen(
            (exception) => controller.error = exception,
            (value) => controller.appendPage(
              value,
              value.lastOrNull?.timestamp,
            ),
          );
        });
        return controller;
      },
      dispose: (controller) => controller.dispose(),
    );
  }

  @override
  String toString() => 'song request feature';
}
