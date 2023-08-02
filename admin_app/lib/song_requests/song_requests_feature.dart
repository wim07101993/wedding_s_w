import 'package:admin_app/song_requests/behaviours/remove_song_request.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/song_requests.dart';

class SongRequestsFeature extends SharedSongRequestsFeature {
  const SongRequestsFeature();

  @override
  void registerTypes(GetIt getIt) {
    super.registerTypes(getIt);
    getIt.registerFactory(
      () => RemoveSongRequest(
        monitor: getIt(),
        firestore: getIt(),
        songRequestPagingController: getIt(),
      ),
    );
  }
}
