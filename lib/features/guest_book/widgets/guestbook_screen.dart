import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_s_w/features/guest_book/models/guest_book_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/add_guestbook_entry_button.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_entry_list.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';

@RoutePage()
class GuestbookScreen extends StatefulWidget {
  const GuestbookScreen({super.key});

  @override
  State<GuestbookScreen> createState() => _GuestbookScreenState();
}

class _GuestbookScreenState extends State<GuestbookScreen> {
  final pagingController = PagingController<DateTime?, GuestbookEntry>(
    firstPageKey: null,
  );

  Future<void> onAddGuestbookEntry() async {
    final entry =
        await AutoRouter.of(context).push(const NewGuestbookEntryRoute());
    if (entry is! GuestbookEntry) {
      return;
    }
    pagingController.itemList = [
      entry,
      ...pagingController.itemList ?? [],
    ];
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GuestbookEntryList(controller: pagingController),
      floatingActionButton: AddGuestbookEntryButton(
        onTap: onAddGuestbookEntry,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
