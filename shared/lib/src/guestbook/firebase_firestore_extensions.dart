import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/json_extensions.dart';
import 'package:shared/src/guestbook/models/guestbook_entry.dart';

const _timestampKey = 'timestamp';
const _messageKey = 'message';
const _pictureUri = 'pictureUri';

extension GuestbookFirebaseFirestoreExtensions on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> get guestbookEntries =>
      collection('guestbook');

  DocumentReference<Map<String, dynamic>> guestbookEntry(String id) {
    return guestbookEntries.doc(id);
  }
}

Future<GuestbookEntry?> firebaseDocToGuestbookEntry(
  DocumentSnapshot<Map<String, dynamic>> doc,
  FirebaseStorage storage,
) async {
  final data = doc.data();
  if (data == null) {
    return null;
  }

  final timestamp = data.maybeGet<DateTime>(_timestampKey);
  final message = data.maybeGet<String>(_messageKey);
  final pictureUri = data.maybeGet<String>(_pictureUri);
  if (timestamp == null || message == null || pictureUri == null) {
    return null;
  }

  return GuestbookEntry(
    id: doc.id,
    timestamp: timestamp,
    message: message,
    pictureUri: pictureUri,
  );
}

extension FirebaseFirestoreGuestbookEntryExtensions on GuestbookEntry {
  Map<String, dynamic> toFirestore() {
    return {
      _messageKey: message,
      _timestampKey: timestamp,
      _pictureUri: pictureUri,
    };
  }
}
