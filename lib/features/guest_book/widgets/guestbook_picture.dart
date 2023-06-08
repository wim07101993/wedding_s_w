import 'package:behaviour/behaviour.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guestbook_entry_picture.dart';
import 'package:wedding_s_w/shared/get_it_provider.dart';

class GuestbookPicture extends StatefulWidget {
  const GuestbookPicture({
    super.key,
    required this.guestbookEntryId,
  });

  final String guestbookEntryId;

  @override
  State<GuestbookPicture> createState() => _GuestbookPictureState();
}

class _GuestbookPictureState extends State<GuestbookPicture> {
  Uint8List? picture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIt<GetGuestbookEntryPicture>()(widget.guestbookEntryId).thenWhenSuccess(
      (picture) {
        if (mounted) {
          setState(() => this.picture = picture);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final picture = this.picture;
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
        if (picture != null) Image.memory(picture, fit: BoxFit.fitWidth),
      ],
    );
  }
}
