import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/save_guest_book_entry.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/take_picture.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/message_field.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';
import 'package:wedding_s_w/shared/logging/logging_feature.dart';

@RoutePage<GuestbookEntry?>()
class NewGuestbookEntryScreen extends StatefulWidget {
  const NewGuestbookEntryScreen({super.key});

  @override
  State<NewGuestbookEntryScreen> createState() =>
      _NewGuestbookEntryScreenState();
}

class _NewGuestbookEntryScreenState extends State<NewGuestbookEntryScreen> {
  late final messageController = TextEditingController();
  bool isSaving = false;
  XFile? picture;

  @override
  void initState() {
    super.initState();
    takePicture();
  }

  Future<void> saveGuestbookEntry() async {
    final picture = this.picture;
    if (picture == null) {
      getIt
          .logger<NewGuestbookEntryScreen>()
          .warning('picture is null when saving guestbook item!!');
      return;
    }

    try {
      setState(() => isSaving = true);

      final result = await getIt<SaveGuestbookEntry>()(
        NewGuestbookEntry(
          pictureFile: picture,
          message: messageController.text,
        ),
      );

      if (!mounted) {
        return;
      }

      result.whenSuccess((newEntry) => Navigator.of(context).pop(newEntry));
    } finally {
      setState(() => isSaving = false);
    }
  }

  Future<void> takePicture() async {
    final takePicture = getIt.get<TakePicture>()();
    final picture = await takePicture.thenWhen(
      (exception) => null,
      (picture) => picture,
    );

    if (!mounted) {
      return;
    }
    if (picture == null) {
      AutoRouter.of(context).pop(null);
    } else {
      setState(() => this.picture = picture);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: _picture()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _message(),
            ),
          ),
          if (isSaving) ...[
            const ColoredBox(color: Colors.black54),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 8),
                Text('Opslaan', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _picture() {
    final picture = this.picture;

    return picture == null
        ? const SizedBox()
        : Image(image: FileImage(File(picture.path)));
  }

  Widget _message() {
    return Row(
      children: [
        Expanded(
          child: MessageField(controller: messageController),
        ),
        const SizedBox(width: 16),
        IconButton.filled(
          onPressed: saveGuestbookEntry,
          icon: const Icon(Icons.send, size: 32),
        ),
      ],
    );
  }
}
