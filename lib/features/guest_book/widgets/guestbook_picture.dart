import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guestbook_entry_picture.dart';
import 'package:wedding_s_w/shared/get_it_provider.dart';

class GuestbookPicture extends StatefulWidget {
  const GuestbookPicture({
    super.key,
    required this.guestbookEntry,
    required this.canResize,
  });

  final GuestbookEntry guestbookEntry;
  final bool canResize;

  @override
  State<GuestbookPicture> createState() => _GuestbookPictureState();
}

class _GuestbookPictureState extends State<GuestbookPicture> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.guestbookEntry.picture == null) {
      getIt<GetGuestbookEntryPicture>()(widget.guestbookEntry.id)
          .thenWhenSuccess((picture) {
        if (mounted) {
          setState(() => widget.guestbookEntry.picture = picture);
        }
      });
    }
  }

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
          listenable: widget.guestbookEntry,
          builder: (context, _) {
            final picture = widget.guestbookEntry.picture;
            if (picture == null) {
              return const SizedBox();
            } else if (widget.canResize) {
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
