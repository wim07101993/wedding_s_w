import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wedding_s_w/features/guest_book/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';

class GuestbookPageQuery {
  const GuestbookPageQuery({
    required this.lastItemTime,
  });

  final DateTime? lastItemTime;
}

class GetGuestBookEntries
    extends Behaviour<GuestbookPageQuery, List<GuestbookEntry>> {
  GetGuestBookEntries({
    super.monitor,
    required this.firestore,
    required this.storage,
  });

  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  @override
  String get tag => 'get guestbook entries';

  @override
  Future<List<GuestbookEntry>> action(
    GuestbookPageQuery input,
    BehaviourTrack? track,
  ) async {
    const pageSize = 5;
    final lastItemTimestamp = input.lastItemTime;

    var query =
        firestore.guestbookEntries.orderBy('timestamp', descending: true);
    if (lastItemTimestamp != null) {
      query = query.startAt([
        Timestamp.fromMillisecondsSinceEpoch(
          lastItemTimestamp.millisecondsSinceEpoch - 1,
        ),
      ]);
    }
    query = query.limit(pageSize);

    final snapshot = await query.get();
    final entriesFuture = await Future.wait(
      snapshot.docs.map((doc) => firebaseDocToGuestbookEntry(doc, storage)),
    );
    final list =
        entriesFuture.whereType<GuestbookEntry>().toList(growable: false);
    return list;
  }
}
