import 'package:flutter/material.dart';
import 'package:shared/src/guestbook/models/guestbook_entry.dart';

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
