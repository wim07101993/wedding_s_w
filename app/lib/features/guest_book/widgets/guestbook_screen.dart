import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/guestbook.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/take_picture.dart';
import 'package:wedding_s_w/features/guest_book/widgets/add_guestbook_entry_button.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/new_guestbook_entry_screen.dart';

class GuestbookScreen extends StatefulWidget {
  const GuestbookScreen({super.key});

  @override
  State<GuestbookScreen> createState() => _GuestbookScreenState();
}

class _GuestbookScreenState extends State<GuestbookScreen> {
  Future<void> onAddGuestbookEntry() async {
    final getIt = this.getIt;
    final pictureNotifier = ValueNotifier<XFile?>(null);
    final entryNotifier = ValueNotifier<GuestbookEntry?>(null);

    try {
      final futureEntry = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewGuestbookEntryScreen(
            picture: pictureNotifier,
            entry: entryNotifier,
          ),
        ),
      );
      await getIt<TakePicture>()().thenWhen(
        (e) => null,
        (picture) => pictureNotifier.value = picture,
      );
      if (!mounted) {
        return;
      }
      if (pictureNotifier.value == null) {
        Navigator.pop(context);
      }
      await futureEntry;

      final entry = entryNotifier.value;
      if (entry == null) {
        return;
      }

      final pagingController = getIt<GuestbookPagingController>();
      pagingController.itemList = [entry, ...pagingController.itemList ?? []];
    } finally {
      pictureNotifier.dispose();
      entryNotifier.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = getIt<GuestbookPagingController>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(controller.refresh),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              GuestbookHeader(),
              GuestbookEntryList(),
            ],
          ),
        ),
      ),
      floatingActionButton: AddGuestbookEntryButton(
        onTap: onAddGuestbookEntry,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
