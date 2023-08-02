import 'package:admin_app/guestbook/behaviours/delete_guestbook_entry.dart';
import 'package:flutter/material.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/guestbook.dart';

class GuestbookEntryWithDeleteButton extends StatefulWidget {
  const GuestbookEntryWithDeleteButton({
    super.key,
    required this.entry,
  });

  final GuestbookEntry entry;

  @override
  State<GuestbookEntryWithDeleteButton> createState() =>
      _GuestbookEntryWithDeleteButtonState();
}

class _GuestbookEntryWithDeleteButtonState
    extends State<GuestbookEntryWithDeleteButton> {
  bool isDeletingEntry = false;

  Future<void> deleteEntry(GuestbookEntry entry) async {
    setState(() => isDeletingEntry = true);
    try {
      await getIt.get<DeleteGuestbookEntry>()(entry);
    } finally {
      setState(() => isDeletingEntry = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GuestbookEntryCard(
                key: Key(widget.entry.id),
                guestbookEntry: widget.entry,
              ),
              TextButton(
                onPressed: () => deleteEntry(widget.entry),
                child: const Text(
                  'Verijderen',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          if (isDeletingEntry)
            const Padding(
              padding: EdgeInsets.all(48),
              child: Center(
                child: CircularProgressIndicator(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
