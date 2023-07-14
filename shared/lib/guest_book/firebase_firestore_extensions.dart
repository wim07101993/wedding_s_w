import 'package:cloud_firestore/cloud_firestore.dart';

extension GuestbookFirebaseFirestoreExtensions on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> get guestbookEntries =>
      collection('guestbook');
}
