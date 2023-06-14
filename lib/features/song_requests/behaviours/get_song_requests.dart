import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/song_requests/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';

class GetSongRequestsQuery {
  const GetSongRequestsQuery({
    required this.lastItemTime,
  });

  final DateTime? lastItemTime;
}

class GetSongRequests
    extends Behaviour<GetSongRequestsQuery, List<SongRequest>> {
  GetSongRequests({
    super.monitor,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<List<SongRequest>> action(
    GetSongRequestsQuery input,
    BehaviourTrack? track,
  ) async {
    const pageSize = 30;
    final lastItemTimestamp = input.lastItemTime;

    var query = firestore.songRequests.orderBy(
      SongRequest.timestampFieldName,
      descending: true,
    );
    if (lastItemTimestamp != null) {
      query = query.startAt([
        Timestamp.fromMillisecondsSinceEpoch(
          lastItemTimestamp.millisecondsSinceEpoch - 1,
        ),
      ]);
    }
    query = query.limit(pageSize);

    final items = await query.get();
    return items.docs.map((doc) => doc.data()).toList();
  }
}
