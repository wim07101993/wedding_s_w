import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/song_requests/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';

class GetSongRequests extends Behaviour<int, List<SongRequest>> {
  GetSongRequests({
    super.monitor,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<List<SongRequest>> action(int input, BehaviourTrack? track) async {
    final items = await firestore.songRequests.limit(30).get();
    return items.docs.map((doc) => doc.data()).toList();
  }
}
