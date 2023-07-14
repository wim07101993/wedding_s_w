import 'dart:typed_data';

import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared/guest_book/behaviours/get_guestbook_entry_picture.dart';
import 'package:shared/guest_book/firebase_firestore_extensions.dart';
import 'package:shared/guest_book/models/guest_book_entry.dart';
import 'package:shared/json_extensions.dart';

class GuestbookPageQuery {
  const GuestbookPageQuery({
    required this.lastItemTime,
  });

  final DateTime? lastItemTime;
}

class _GuestbookEntry extends ChangeNotifier implements GuestbookEntry {
  _GuestbookEntry({
    required this.id,
    required this.timestamp,
    required this.message,
  });

  Uint8List? _picture;

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final String message;
  @override
  Uint8List? get picture => _picture;
  set picture(Uint8List? value) {
    _picture = value;
    notifyListeners();
  }
}

class GetGuestBookEntries
    extends Behaviour<GuestbookPageQuery, List<GuestbookEntry>> {
  GetGuestBookEntries({
    super.monitor,
    required this.firestore,
    required this.getGuestbookEntryPicture,
  });

  final FirebaseFirestore firestore;
  final GetGuestbookEntryPicture getGuestbookEntryPicture;

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
    final entries = snapshot.docs
        .map((doc) => mapDocToGuestbookEntry(doc, getGuestbookEntryPicture))
        .toList(growable: false);
    final validEntries =
        entries.whereType<GuestbookEntry>().toList(growable: false);

    return validEntries;
  }
}

GuestbookEntry? mapDocToGuestbookEntry(
  DocumentSnapshot<Map<String, dynamic>> doc,
  GetGuestbookEntryPicture getGuestbookEntryPicture,
) {
  final data = doc.data();
  if (data == null) {
    return null;
  }

  final id = data.maybeGet<String>('id');
  final timestamp = data.maybeGet<DateTime>('timestamp');
  final message = data.maybeGet<String>('message');
  if (id == null || timestamp == null || message == null) {
    return null;
  }

  final entry = _GuestbookEntry(
    id: id,
    timestamp: timestamp,
    message: message,
  );

  getGuestbookEntryPicture(id)
      .thenWhenSuccess((picture) => entry.picture = picture);

  return entry;
}
