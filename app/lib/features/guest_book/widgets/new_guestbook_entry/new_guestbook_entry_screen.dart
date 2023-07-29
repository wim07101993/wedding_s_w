import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/save_guest_book_entry.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/message_field.dart';
import 'package:wedding_s_w/features/routing/app_router.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

@RoutePage<GuestbookEntry?>()
class NewGuestbookEntryScreen extends StatefulWidget {
  const NewGuestbookEntryScreen({
    super.key,
    required this.picture,
  });

  final XFile picture;

  @override
  State<NewGuestbookEntryScreen> createState() =>
      _NewGuestbookEntryScreenState();
}

class _NewGuestbookEntryScreenState extends State<NewGuestbookEntryScreen> {
  late final messageController = TextEditingController();
  bool isSaving = false;
  bool closeButtonPressed = true;

  Future<void> saveGuestbookEntry() async {
    try {
      setState(() => isSaving = true);

      final result = await getIt<SaveGuestbookEntry>()(
        NewGuestbookEntry(
          pictureFile: widget.picture,
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (closeButtonPressed) {
          closeButtonPressed = false;
          return true;
        }
        getIt<AppRouter>().replace(const TakePictureRoute());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _backButton(),
            _closeButton(),
            if (kIsWeb)
              Center(child: Image.network(widget.picture.path))
            else
              Center(child: Image.file(File(widget.picture.path))),
            _message(),
            if (isSaving) _savingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BackButton(
          color: Colors.grey,
          onPressed: () {
            getIt<AppRouter>().replace(const TakePictureRoute());
          },
        ),
      ),
    );
  }

  Widget _closeButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CloseButton(
          color: Colors.grey,
          onPressed: () {
            closeButtonPressed = true;
            getIt<AppRouter>().pop();
          },
        ),
      ),
    );
  }

  Widget _message() {
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
              onPressed: saveGuestbookEntry,
              icon: const Icon(Icons.send, size: 32),
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
