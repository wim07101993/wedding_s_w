import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

abstract class GuestbookEntry implements Listenable {
  String get id;
  DateTime get timestamp;
  String get message;
  Uint8List? get picture;
}
