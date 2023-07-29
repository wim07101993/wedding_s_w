import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_message.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_picture.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class GuestbookEntryDetailScreen extends StatelessWidget {
  const GuestbookEntryDetailScreen({
    super.key,
    required this.guestbookEntryId,
  });

  final String guestbookEntryId;

  @override
  Widget build(BuildContext context) {
    final getIt = this.getIt(context);
    final guestbookEntry = getIt<GuestbookPagingController>()
        .itemList
        ?.where((element) => element.id == guestbookEntryId)
        .firstOrNull;

    return Material(
      child: guestbookEntry == null
          ? _futureDetail(getIt)
          : _detail(guestbookEntry),
    );
  }

  Widget _detail(GuestbookEntry guestbookEntry) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Hero(
          tag: 'guestbookentry_$guestbookEntryId',
          child: GuestbookPicture(
            guestbookEntry: guestbookEntry,
            canResize: true,
          ),
        ),
        if (guestbookEntry.message.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GuestbookMessage(guestbookEntry: guestbookEntry),
            ),
          ),
        const SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: BackButton(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _futureDetail(GetIt getIt) {
    return FutureBuilder<ExceptionOr<GuestbookEntry?>>(
      future: getIt<GetGuestbookEntry>()(guestbookEntryId),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return const CircularProgressIndicator();
        }
        return data.when(
          (exception) {
            return const Text('Er ging iets mis bij het ophalen van de foto');
          },
          (guestbookEntry) => guestbookEntry == null
              ? const Text('Er ging iets mis bij het ophalen van de foto')
              : _detail(guestbookEntry),
        );
      },
    );
  }
}
