import 'package:firebase_storage/firebase_storage.dart';

extension GuestbookFirebaseStorageExtensions on FirebaseStorage {
  Reference get pictures => ref('pictures');
  Reference picture(String id) => pictures.child(id);
}
