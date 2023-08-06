import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/src/dependency_management/feature.dart';
import 'package:shared/src/firebase/firebase_feature.dart';
import 'package:shared/src/firebase/remote_config_global_value.dart';
import 'package:shared/src/song_requests/behaviours/get_song_requests.dart';
import 'package:shared/src/song_requests/behaviours/request_song.dart';
import 'package:shared/src/song_requests/behaviours/search_songs.dart';
import 'package:shared/src/song_requests/firebase_firestore_extensions.dart';
import 'package:shared/src/song_requests/models/free_input_song_request.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/src/song_requests/models/spotify_song_request.dart';
import 'package:spotify/spotify.dart';

typedef SongRequestController = ValueNotifier<List<SongRequest>>;

class SharedSongRequestsFeature extends FeatureWithSubscriptions {
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
      () => SongRequestController(const []),
      dispose: (controller) => controller.dispose(),
    );
  }

  @override
  Future<void> install(GetIt getIt) async {
    await super.install(getIt);
    subscriptions.add(
      getIt<FirebaseFirestore>().songRequests.snapshots().listen((snapshot) {
        updateSongRequests(
          snapshot,
          getIt<SongRequestController>(),
        );
      }),
    );
  }

  @override
  String toString() => 'song request feature';
}

void updateSongRequests(
  QuerySnapshot<SongRequest> snapshot,
  SongRequestController songRequests,
) {
  final addedItems = snapshot.docChanges
      .where((change) => change.type == DocumentChangeType.added)
      .map((change) => change.doc.data())
      .whereType<SongRequest>()
      .toList(growable: false);

  final currentItems = songRequests.value;
  if (currentItems.isEmpty) {
    songRequests.value = addedItems
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return;
  }

  final removedItems = snapshot.docChanges
      .where((change) => change.type == DocumentChangeType.removed)
      .map((change) => change.doc.data())
      .whereType<SongRequest>()
      .toList(growable: false);

  final currentSpotifyItems = currentItems.whereType<SpotifySong>();
  final currentFreeInputItems = currentItems.whereType<FreeInputSongRequest>();

  final spotifyItemsToAdd = addedItems.whereType<SpotifySong>().where(
        (song) => currentSpotifyItems
            .every((existing) => song.spotifyId != existing.spotifyId),
      );
  final freeInputItemsToAdd =
      addedItems.whereType<FreeInputSongRequest>().where(
            (song) => currentFreeInputItems
                .every((existing) => song.input != existing.input),
          );

  final removedSpotifyItems =
      removedItems.whereType<SpotifySong>().toList(growable: false);
  final removedFreeInputItems =
      removedItems.whereType<FreeInputSongRequest>().toList(growable: false);

  songRequests.value = [
    ...spotifyItemsToAdd,
    ...freeInputItemsToAdd,
    ...currentItems.where((request) {
      if (request is SpotifySong) {
        return removedSpotifyItems
            .every((toRemove) => toRemove.spotifyId != request.spotifyId);
      } else if (request is FreeInputSongRequest) {
        return removedFreeInputItems
            .every((toRemove) => toRemove.input != request.input);
      }
      return false;
    }),
  ]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
}
