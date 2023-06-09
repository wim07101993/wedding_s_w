import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';

class GuestbookMessage extends StatelessWidget {
  const GuestbookMessage({
    super.key,
    required this.guestbookEntry,
  });

  final GuestbookEntry guestbookEntry;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        guestbookEntry.message,
        maxLines: 3,
        softWrap: true,
      ),
    );
  }
}
