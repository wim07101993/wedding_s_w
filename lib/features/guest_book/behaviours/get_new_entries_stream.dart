import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guestbook_entry_picture.dart';
import 'package:wedding_s_w/features/guest_book/firebase_firestore_extensions.dart';

class GetNewEntriesStream
    extends BehaviourWithoutInput<Stream<GuestbookEntry>> {
  GetNewEntriesStream({
    super.monitor,
    required this.firestore,
    required this.getGuestbookEntryPicture,
  });

  final FirebaseFirestore firestore;
  final GetGuestbookEntryPicture getGuestbookEntryPicture;

  @override
  Future<Stream<GuestbookEntry>> action(BehaviourTrack? track) {
    return Future.sync(
      () => firestore.guestbookEntries
          .snapshots()
          .expand((snapshot) {
            return snapshot.docChanges
                .where((change) => change.type == DocumentChangeType.added)
                .map((change) => change.doc);
          })
          .map((doc) => mapDocToGuestbookEntry(doc, getGuestbookEntryPicture))
          .where((entry) => entry != null)
          .cast<GuestbookEntry>(),
    );
  }
}
