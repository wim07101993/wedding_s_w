import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared/src/guestbook/models/guestbook_entry.dart';

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
    return canResize
        ? PhotoView(
            imageProvider: CachedNetworkImageProvider(uri),
            loadingBuilder: (context, e) => _loadingIndicator(),
          )
        : CachedNetworkImage(
            imageUrl: uri,
            fit: BoxFit.fitWidth,
            placeholder: (context, _) => _loadingIndicator(),
          );
  }

  Widget _loadingIndicator() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
