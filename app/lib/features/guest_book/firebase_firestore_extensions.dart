import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wedding_s_w/features/guest_book/firebase_storage_extensions.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/shared/json_extensions.dart';

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

  final timestamp = data.maybeGet<DateTime>('timestamp');
  final message = data.maybeGet<String>('message');
  if (timestamp == null || message == null) {
    return null;
  }
  try {
    final pictureUri = await storage.picture(doc.id).getDownloadURL();

    return GuestbookEntry(
      id: doc.id,
      timestamp: timestamp,
      message: message,
      pictureUri: pictureUri,
    );
  } catch (e) {
    return null;
  }
}
