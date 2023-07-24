import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';

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
    final uri = guestbookEntry.pictureUri;
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
        if (canResize)
          PhotoView(imageProvider: CachedNetworkImageProvider(uri))
        else
          CachedNetworkImage(imageUrl: uri, fit: BoxFit.fitWidth)
      ],
    );
  }
}
