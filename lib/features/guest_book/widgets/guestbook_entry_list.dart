import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_entry_card.dart';
import 'package:wedding_s_w/shared/get_it_provider.dart';

class GuestbookEntryList extends StatefulWidget {
  const GuestbookEntryList({super.key});

  @override
  State<GuestbookEntryList> createState() => _GuestbookEntryListState();
}

class _GuestbookEntryListState extends State<GuestbookEntryList> {
  final pagingController = PagingController<DateTime, GuestbookEntry>(
      firstPageKey: DateTime.now().toUtc());
  late final getGuestbookEntries = getIt<GetGuestBookEntries>();

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener(fetchPage);
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchPage(DateTime lastEntryTimestamp) async {
    final response = await getGuestbookEntries(
      GuestbookPageQuery(lastItemTime: lastEntryTimestamp),
    );
    if (!mounted) {
      return;
    }
    response.when(
      (exception) => pagingController.error = exception,
      (value) => pagingController.appendPage(
        value,
        value.lastOrNull?.timestamp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<DateTime, GuestbookEntry>(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) {
          final itemCount = pagingController.value.itemList?.length ?? 0;
          EdgeInsets padding;
          if (index == 0) {
            padding = const EdgeInsets.fromLTRB(16, 16, 16, 8);
          } else if (index >= (itemCount - 1)) {
            padding = const EdgeInsets.fromLTRB(16, 8, 16, 92);
          } else {
            padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
          }
          return Padding(
            padding: padding,
            child: GuestbookEntryCard(key: Key(item.id), guestbookEntry: item),
          );
        },
      ),
    );
  }
}
