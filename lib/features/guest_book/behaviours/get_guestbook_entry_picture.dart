import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wedding_s_w/features/guest_book/firebase_storage_extensions.dart';

class GetGuestbookEntryPicture extends Behaviour<String, Uint8List?> {
  GetGuestbookEntryPicture({
    super.monitor,
    required this.storage,
  });

  final FirebaseStorage storage;

  @override
  Future<Uint8List?> action(
    String guestbookEntryId,
    BehaviourTrack? track,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final localFile = File('${directory.path}/$guestbookEntryId');
    if (await localFile.exists()) {
      return localFile.readAsBytes();
    }
    final picture = await storage.picture(guestbookEntryId).getData();
    if (picture != null) {
      localFile
          .create(recursive: true)
          .then((file) => file.writeAsBytes(picture));
    }
    return picture;
  }
}
