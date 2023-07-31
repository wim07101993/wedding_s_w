import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/geustbook_entry_detail_screen.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_picture.dart';

class GuestbookEntryCard extends StatelessWidget {
  const GuestbookEntryCard({
    super.key,
    required this.guestbookEntry,
  });

  final GuestbookEntry guestbookEntry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GuestbookEntryDetailScreen(
              guestbookEntryId: guestbookEntry.id,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
              child: heroWidget(false),
            ),
            if (guestbookEntry.message.isNotEmpty) message(theme),
          ],
        ),
      ),
    );
  }

  Widget buildDetailWidget(BuildContext context) {
    return Material(child: heroWidget(true));
  }

  Widget heroWidget(bool canResizeImage) {
    return Hero(
      tag: 'guestbookentry_${guestbookEntry.id}',
      child: GuestbookPicture(
        guestbookEntry: guestbookEntry,
        canResize: canResizeImage,
      ),
    );
  }

  Widget message(ThemeData theme) {
    return Container(
      color: theme.colorScheme.secondary.withAlpha(180),
      padding: const EdgeInsets.all(16),
      child: Text(
        guestbookEntry.message,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: theme.colorScheme.onSecondary),
      ),
    );
  }
}
