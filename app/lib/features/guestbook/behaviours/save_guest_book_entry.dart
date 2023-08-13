import 'dart:io';
import 'dart:typed_data';

import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/guestbook.dart';

class NewGuestbookEntry extends ChangeNotifier {
  NewGuestbookEntry({
    required this.pictureFile,
    required this.message,
  }) {
    pictureFile.readAsBytes().then((value) {
      picture = value;
      notifyListeners();
    });
  }

  final DateTime timestamp = DateTime.now().toUtc();
  final String message;
  final XFile pictureFile;
  Uint8List? picture;
}

class SaveGuestbookEntry extends Behaviour<NewGuestbookEntry, GuestbookEntry> {
  SaveGuestbookEntry({
    super.monitor,
    required this.storage,
    required this.firestore,
  });

  final FirebaseStorage storage;
  final FirebaseFirestore firestore;

  @override
  String get tag => 'save guestbook entry';

  @override
  Future<GuestbookEntry> action(
    NewGuestbookEntry input,
    BehaviourTrack? track,
  ) async {
    final reference = firestore.guestbookEntries.doc();

    final remotePicture = storage.picture(reference.id);
    await remotePicture.putFile(
      File(input.pictureFile.path),
      SettableMetadata(
        contentDisposition: input.pictureFile.name,
        contentEncoding: 'image',
        customMetadata: {
          'timestamp': input.timestamp.toIso8601String(),
          'message': input.message,
        },
      ),
    );

    final entry = GuestbookEntry(
      id: reference.id,
      timestamp: input.timestamp,
      message: input.message,
      pictureUri: await remotePicture.getDownloadURL(),
    );
    await reference.set(entry.toFirestore());

    return entry;
  }
}
