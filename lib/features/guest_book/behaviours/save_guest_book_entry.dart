import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wedding_s_w/features/guest_book/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/features/guest_book/firebase_storage_extensions.dart';

class NewGuestbookEntry {
  NewGuestbookEntry({
    required this.picture,
    required this.message,
  });

  final String id = const Uuid().v1();
  final DateTime timestamp = DateTime.now().toUtc();
  final XFile picture;
  final String message;
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
    await storage.picture(input.id).putFile(File(input.picture.path));
    await firestore.guestbookEntries.add({
      'id': input.id,
      'timestamp': input.timestamp,
      'message': input.message,
    });
  }
}
