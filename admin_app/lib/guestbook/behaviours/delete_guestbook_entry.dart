import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/guestbook.dart';

class DeleteGuestbookEntry extends Behaviour<GuestbookEntry, void> {
  DeleteGuestbookEntry({
    super.monitor,
    required this.firestore,
    required this.storage,
    required this.guestbookPagingController,
  });

  final FirebaseStorage storage;
  final FirebaseFirestore firestore;
  final GuestbookPagingController guestbookPagingController;

  @override
  String get tag => 'delete guestbook entry';

  @override
  Future<void> action(GuestbookEntry input, BehaviourTrack? track) async {
    final picture = storage.picture(input.id);
    final pictureData = await picture.getData();
    if (pictureData == null) {
      return;
    }

    await storage.ref('deletedPictures').child(input.id).putData(pictureData);
    await firestore.collection('deletedEntries').add({
      'timestamp': input.timestamp,
      'message': input.message,
    });

    await firestore.guestbookEntries.doc(input.id).delete();
    await picture.delete();

    guestbookPagingController.itemList =
        guestbookPagingController.itemList?.toList()?..remove(input);
  }
}
