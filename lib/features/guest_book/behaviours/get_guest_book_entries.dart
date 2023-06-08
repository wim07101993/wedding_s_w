import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/guest_book/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/shared/json_extensions.dart';

class GuestbookPageQuery {
  GuestbookPageQuery({required this.lastItemTime});

  final DateTime lastItemTime;
}

class GuestbookEntry {
  GuestbookEntry({
    required this.id,
    required this.timestamp,
    required this.message,
  });

  final String id;
  final DateTime timestamp;
  final String message;
}

class GetGuestBookEntries
    extends Behaviour<GuestbookPageQuery, List<GuestbookEntry>> {
  GetGuestBookEntries({
    super.monitor,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<List<GuestbookEntry>> action(
    GuestbookPageQuery input,
    BehaviourTrack? track,
  ) async {
    const pageSize = 10;
    final startAt = Timestamp.fromMicrosecondsSinceEpoch(
      input.lastItemTime.microsecondsSinceEpoch - 1,
    );
    final snapshot = await firestore.guestbookEntries
        .orderBy('timestamp', descending: true)
        .startAt([startAt])
        .limit(pageSize)
        .get();

    final entries =
        snapshot.docs.map(mapDocToGuestbookEntry).toList(growable: false);
    final validEntries =
        entries.whereType<GuestbookEntry>().toList(growable: false);

    return validEntries;
  }

  GuestbookEntry? mapDocToGuestbookEntry(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    final id = data.maybeGet<String>('id');
    final timestamp = data.maybeGet<DateTime>('timestamp');
    final message = data.maybeGet<String>('message');
    if (id == null || timestamp == null || message == null) {
      return null;
    }

    return GuestbookEntry(
      id: id,
      timestamp: timestamp,
      message: message,
    );
  }
}
