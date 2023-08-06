import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/src/guestbook/firebase_firestore_extensions.dart';
import 'package:shared/src/guestbook/models/guestbook_entry.dart';

class GetGuestbookEntry extends Behaviour<String, GuestbookEntry?> {
  GetGuestbookEntry({
    super.monitor,
    required this.firestore,
    required this.storage,
  });

  @override
  String get tag => 'get guestbook entry';

  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  @override
  Future<GuestbookEntry?> action(String id, BehaviourTrack? track) async {
    final doc = await firestore.guestbookEntry(id).get();
    return firebaseDocToGuestbookEntry(doc, storage);
  }
}
