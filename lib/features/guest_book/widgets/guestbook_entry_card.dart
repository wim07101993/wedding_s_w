import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_picture.dart';

class GuestbookEntryCard extends StatelessWidget {
  const GuestbookEntryCard({
    super.key,
    required this.guestbookEntry,
  });

  final GuestbookEntry guestbookEntry;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 400,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            GuestbookPicture(guestbookEntryId: guestbookEntry.id),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Chip(
                  label: Text(guestbookEntry.message),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
