import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_message.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_picture.dart';
import 'package:wedding_s_w/features/routing/app_router.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

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
        // onTap: () => Navigator.of(context)
        //     .push(MaterialPageRoute(builder: buildDetailWidget)),
        onTap: () => getIt(context).get<AppRouter>().push(
              GuestbookEntryDetailRoute(guestbookEntryId: guestbookEntry.id),
            ),
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
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Hero(
          tag: 'guestbookentry_${guestbookEntry.id}',
          child: GuestbookPicture(
            guestbookEntry: guestbookEntry,
            canResize: canResizeImage,
          ),
        ),
        if (guestbookEntry.message.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GuestbookMessage(guestbookEntry: guestbookEntry),
            ),
          )
      ],
    );
  }
}
