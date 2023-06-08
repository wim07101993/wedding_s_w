import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry_screen.dart';

class AddGuestbookEntryButton extends StatefulWidget {
  const AddGuestbookEntryButton({super.key});

  @override
  State<AddGuestbookEntryButton> createState() =>
      _AddGuestbookEntryButtonState();
}

class _AddGuestbookEntryButtonState extends State<AddGuestbookEntryButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: createGuestbookEntry,
      label: const Text('Iets in het gastenboek schrijven'),
    );
  }

  Future<void> createGuestbookEntry() async {
    final picker = ImagePicker();
    final picture = await picker.pickImage(source: ImageSource.camera);
    if (!mounted || picture == null) {
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewGuestbookEntryScreen(picture: picture),
      ),
    );
  }
}
