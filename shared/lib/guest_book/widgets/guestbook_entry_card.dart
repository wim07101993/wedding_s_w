import 'package:flutter/material.dart';
import 'package:shared/guest_book/models/guest_book_entry.dart';
import 'package:shared/guest_book/widgets/guestbook_message.dart';
import 'package:shared/guest_book/widgets/guestbook_picture.dart';

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
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: buildDetailWidget)),
        child: SizedBox(
          height: 400,
          child: heroWidget(false),
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
      child: Material(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            GuestbookPicture(
              guestbookEntry: guestbookEntry,
              canResize: canResizeImage,
            ),
            if (guestbookEntry.message.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GuestbookMessage(guestbookEntry: guestbookEntry),
                ),
              )
          ],
        ),
      ),
    );
  }
}
