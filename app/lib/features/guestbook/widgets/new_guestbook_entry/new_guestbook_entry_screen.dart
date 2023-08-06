import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/guestbook.dart';
import 'package:wedding_s_w/features/guestbook/behaviours/save_guest_book_entry.dart';
import 'package:wedding_s_w/features/guestbook/widgets/new_guestbook_entry/message_field.dart';

class NewGuestbookEntryScreen extends StatefulWidget {
  const NewGuestbookEntryScreen({
    super.key,
    required this.picture,
    required this.entry,
  });

  final ValueListenable<XFile?> picture;
  final ValueNotifier<GuestbookEntry?> entry;

  @override
  State<NewGuestbookEntryScreen> createState() =>
      _NewGuestbookEntryScreenState();
}

class _NewGuestbookEntryScreenState extends State<NewGuestbookEntryScreen> {
  late final messageController = TextEditingController();
  bool isSaving = false;
  bool closeButtonPressed = true;

  Future<void> saveGuestbookEntry(XFile picture) async {
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

      result.whenSuccess((newEntry) => widget.entry.value = newEntry);
      Navigator.pop(context);
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: widget.picture,
        builder: (context, picture, child) => Stack(
          fit: StackFit.expand,
          children: [
            _closeButton(),
            if (picture != null) ...[
              if (kIsWeb)
                Center(child: Image.network(picture.path))
              else
                Center(child: Image.file(File(picture.path))),
              _message(picture),
            ],
            if (isSaving) _savingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _closeButton() {
    return const Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CloseButton(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _message(XFile picture) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: MessageField(controller: messageController),
            ),
            const SizedBox(width: 16),
            IconButton.filled(
              iconSize: 32,
              onPressed: () => saveGuestbookEntry(picture),
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  Widget _savingIndicator() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 8),
        Text('Opslaan', style: TextStyle(color: Colors.white70)),
      ],
    );
  }
}
