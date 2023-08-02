import 'dart:typed_data';

import 'package:behaviour/behaviour.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/src/guestbook/models/guestbook_entry.dart';

class SharePictureParams {
  const SharePictureParams({
    required this.widgetPictureBytes,
    required this.guestbookEntry,
  });

  final Uint8List widgetPictureBytes;
  final GuestbookEntry guestbookEntry;
}

class SharePicture extends Behaviour<SharePictureParams, void> {
  SharePicture({
    super.monitor,
  });

  @override
  Future<void> action(SharePictureParams input, BehaviourTrack? track) {
    return Share.shareXFiles(
      [
        XFile.fromData(
          input.widgetPictureBytes,
          mimeType: 'image/png',
          name: 'foto',
        ),
      ],
      text: input.guestbookEntry.message,
    );
  }
}
