import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/save_guest_book_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/message_field.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class NewGuestbookEntryScreen extends StatefulWidget {
  const NewGuestbookEntryScreen({
    super.key,
    required this.picture,
  });

  final XFile picture;

  @override
  State<NewGuestbookEntryScreen> createState() =>
      _NewGuestbookScreenEntryState();
}

class _NewGuestbookScreenEntryState extends State<NewGuestbookEntryScreen> {
  late final messageController = TextEditingController();
  bool isSaving = false;

  Future<void> saveGuestbookEntry() async {
    try {
      setState(() => isSaving = true);

      final result = await getIt<SaveGuestbookEntry>()(
        NewGuestbookEntry(
          picture: widget.picture,
          message: messageController.text,
        ),
      );

      if (!mounted) {
        return;
      }

      result.whenSuccess((_) => Navigator.of(context).pop());
    } finally {
      setState(() => isSaving = false);
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
    return Image(
      image: FileImage(File(widget.picture.path)),
    );
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
