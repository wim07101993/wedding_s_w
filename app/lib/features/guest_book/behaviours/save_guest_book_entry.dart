import 'dart:io';
import 'dart:typed_data';

import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wedding_s_w/features/guest_book/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/features/guest_book/firebase_storage_extensions.dart';
import 'package:wedding_s_w/features/guest_book/models/guest_book_entry.dart';

class NewGuestbookEntry extends ChangeNotifier implements GuestbookEntry {
  NewGuestbookEntry({
    required this.pictureFile,
    required this.message,
  }) {
    pictureFile.readAsBytes().then((value) {
      picture = value;
      notifyListeners();
    });
  }

  @override
  final String id = const Uuid().v1();
  @override
  final DateTime timestamp = DateTime.now().toUtc();
  @override
  Uint8List? picture;
  @override
  final String message;
  final XFile pictureFile;
}

class SaveGuestbookEntry extends Behaviour<NewGuestbookEntry, void> {
  SaveGuestbookEntry({
    super.monitor,
    required this.storage,
    required this.firestore,
  });

  final FirebaseStorage storage;
  final FirebaseFirestore firestore;

  @override
  Future<void> action(NewGuestbookEntry input, BehaviourTrack? track) async {
    await storage.picture(input.id).putFile(File(input.pictureFile.path));
    await firestore.guestbookEntries.add({
      'id': input.id,
      'timestamp': input.timestamp,
      'message': input.message,
    });
  }
}
