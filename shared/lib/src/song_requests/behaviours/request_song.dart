import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared/src/song_requests/firebase_firestore_extensions.dart';
import 'package:shared/src/song_requests/models/free_input_song_request.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/src/song_requests/models/spotify_song_request.dart';

class RequestSong extends Behaviour<SongRequest, void> {
  RequestSong({
    super.monitor,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  String get tag => 'request song';

  @override
  Future<void> action(SongRequest input, BehaviourTrack? track) async {
    final existingQuery = input.when<Query<SongRequest>>(
      spotifySong: (song) => firestore.songRequests
          .where(SpotifySong.idFieldName, isEqualTo: song.spotifyId),
      freeInputSongRequest: (song) => firestore.songRequests.where(
        FreeInputSongRequest.inputToLowerFieldName,
        isEqualTo: song.inputToLower,
      ),
    );

    final existing = await existingQuery.limit(1).get();
    if (existing.size > 0) {
      throw const SongAlreadyRequestedException();
    }
    await firestore.songRequests.add(input);
  }
}

class SongAlreadyRequestedException implements Exception {
  const SongAlreadyRequestedException();
}
