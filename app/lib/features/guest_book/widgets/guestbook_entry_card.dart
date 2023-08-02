import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/share_picture.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_picture.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class GuestbookEntryCard extends StatefulWidget {
  const GuestbookEntryCard({
    super.key,
    required this.guestbookEntry,
  });

  final GuestbookEntry guestbookEntry;

  @override
  State<GuestbookEntryCard> createState() => _GuestbookEntryCardState();
}

class _GuestbookEntryCardState extends State<GuestbookEntryCard> {
  final _repaintBoundaryKey = GlobalKey();

  Future<void> _sharePicture() async {
    final boundary = _repaintBoundaryKey.currentContext?.findRenderObject();
    if (boundary is! RenderRepaintBoundary) {
      return;
    }

    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    if (bytes == null) {
      return;
    }

    getIt<SharePicture>()(
      SharePictureParams(
        widgetPictureBytes: bytes.buffer.asUint8List(),
        guestbookEntry: widget.guestbookEntry,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          RepaintBoundary(
            key: _repaintBoundaryKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 400, maxHeight: 400),
                  child: heroWidget(false),
                ),
                if (widget.guestbookEntry.message.isNotEmpty) message(theme),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: _sharePicture,
                color: theme.colorScheme.onSecondary,
                icon: const Icon(Icons.share),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailWidget(BuildContext context) {
    return Material(child: heroWidget(true));
  }

  Widget heroWidget(bool canResizeImage) {
    return Hero(
      tag: 'guestbookentry_${widget.guestbookEntry.id}',
      child: GuestbookPicture(
        guestbookEntry: widget.guestbookEntry,
        canResize: canResizeImage,
      ),
    );
  }

  Widget message(ThemeData theme) {
    return Container(
      color: theme.colorScheme.secondary.withAlpha(180),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        widget.guestbookEntry.message,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: theme.colorScheme.onSecondary),
      ),
    );
  }
}
