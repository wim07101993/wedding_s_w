import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/song_requests/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';

class RequestSong extends Behaviour<SongRequest, void> {
  RequestSong({
    super.monitor,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<void> action(SongRequest input, BehaviourTrack? track) {
    return firestore.songRequests.add(input);
  }
}
