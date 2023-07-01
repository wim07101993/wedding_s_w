import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wedding_s_w/features/guest_book/models/guest_book_entry.dart';

class GuestbookPicture extends StatelessWidget {
  const GuestbookPicture({
    super.key,
    required this.guestbookEntry,
    required this.canResize,
  });

  final GuestbookEntry guestbookEntry;
  final bool canResize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        const Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(),
          ),
        ),
        ListenableBuilder(
          listenable: guestbookEntry,
          builder: (context, _) {
            final picture = guestbookEntry.picture;
            if (picture == null) {
              return const SizedBox();
            } else if (canResize) {
              return PhotoView(imageProvider: MemoryImage(picture));
            } else {
              return Image.memory(picture, fit: BoxFit.fitWidth);
            }
          },
        )
      ],
    );
  }
}
