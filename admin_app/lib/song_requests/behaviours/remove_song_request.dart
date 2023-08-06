import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared/song_requests.dart';

class RemoveSongRequest extends Behaviour<SongRequest, void> {
  RemoveSongRequest({
    super.monitor,
    required this.firestore,
    required this.songRequestPagingController,
  });

  final FirebaseFirestore firestore;
  final SongRequestPagingController songRequestPagingController;

  @override
  Future<void> action(SongRequest input, BehaviourTrack? track) async {
    final query = input.when<Query<SongRequest>>(
      spotifySong: (song) => firestore.songRequests
          .where(SpotifySong.idFieldName, isEqualTo: song.spotifyId),
      freeInputSongRequest: (song) => firestore.songRequests.where(
        FreeInputSongRequest.inputToLowerFieldName,
        isEqualTo: song.inputToLower,
      ),
    );

    final snapshot = await query.get();
    await Future.wait(snapshot.docs.map((doc) => doc.reference.delete()));

    songRequestPagingController.itemList =
        songRequestPagingController.itemList?.toList()?..remove(input);
  }
}
